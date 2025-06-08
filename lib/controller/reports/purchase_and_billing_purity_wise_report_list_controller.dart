import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/purchase_and_billing_purity_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseAndBillingPurityWiseReportListController
    extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchpurityController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedpurity = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> purityFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totaloverallpurchasePieces = "0".obs;
  RxDouble totaloverallpurchaseGrossWeight = 0.0.obs;
  RxDouble totaloverallpurchaseamount = 0.0.obs;
  RxString totaloverallsalesPieces = "0".obs;
  RxDouble totaloverallsalesGrossWeight = 0.0.obs;
  RxDouble totaloverallsalesamount = 0.0.obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<PurchaseandbillingPurityReportResponse> tableData =
      <PurchaseandbillingPurityReportResponse>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getpurityList();
  }

  Future getBranchList() async {
    branchFilterList([]);
    final List<BranchDropDownModel> templist =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      branchFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.branchName.toString()));
    });
    selectedbranch(DropdownModel(value: "0", label: "All"));
  }

  Future getpurityList() async {
    purityFilterList([]);
    final List<PurityDropdownModel> templist =
        await DropdownService.purityDropDown(null);
    purityFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      purityFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.purityName.toString()));
    });
    selectedpurity(DropdownModel(value: "0", label: "All"));
  }

  Future getpurchaseandbillingpuritywisereport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? purityFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedpurity.value != null && selectedpurity.value?.value != "0") {
      purityFilter = selectedpurity.value?.value.toString();
    } else {
      purityFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchPurchaseandbillingPurityReportPayload payload =
        FetchPurchaseandbillingPurityReportPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            purity: purityFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? purchaseandbillingpuritywisereportList =
        await ReportsServices.fetchPurchaseandbillingPurityWiseReport(
            payload: payload);

    if (purchaseandbillingpuritywisereportList != null) {
      tableData(purchaseandbillingpuritywisereportList['list']);
      totalpages(purchaseandbillingpuritywisereportList['data']['total_pages']);
      totaloverallpurchasePieces(purchaseandbillingpuritywisereportList['data']
          ['total_overall_purchase_pieces'].toString());
      totaloverallpurchaseGrossWeight(
          double.parse(purchaseandbillingpuritywisereportList['data']
              ['total_overall_purchase_gross_weight'].toString()));
      totaloverallpurchaseamount(double.parse(purchaseandbillingpuritywisereportList['data']
          ['total_overall_purchase_amount'].toString()));
      totaloverallsalesPieces(purchaseandbillingpuritywisereportList['data']
          ['total_overall_sale_pieces'].toString());
      totaloverallsalesGrossWeight(
          double.parse(purchaseandbillingpuritywisereportList['data']
              ['total_overall_sale_gross_weight'].toString()));
      totaloverallsalesamount(double.parse(purchaseandbillingpuritywisereportList['data']
          ['total_overall_sale_amount'].toString()));
    } else {
      tableData([]);
      totalpages(1);
      totaloverallpurchasePieces("0");
      totaloverallpurchaseGrossWeight(0.0);
      totaloverallpurchaseamount(0.0);
      totaloverallsalesPieces("0");
      totaloverallsalesGrossWeight(0.0);
      totaloverallsalesamount(0.0);
    }

    isTableLoading(false);
  }



  Future exportData(BuildContext context) async {
    isExportLoading(true);

   String? branchFilter;
    String? purityFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedpurity.value != null && selectedpurity.value?.value != "0") {
      purityFilter = selectedpurity.value?.value.toString();
    } else {
      purityFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchPurchaseandbillingPurityReportPayload(
      page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            purity: purityFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu()
    );
    var response =
        await ExportReportService.exportPurchaseandBillingpurityReport(payload, context);
    
    isExportLoading(false);
  }
}
