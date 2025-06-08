import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/purity_wise_purchase_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/purity_wise_purchase_report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurityWisePurchaseReportListController extends HeaderController {
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
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;
  RxString totalAmount = "0".obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<PurityWisePurchaseReportListData> tableData =
      <PurityWisePurchaseReportListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getPurityList();
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

  Future getPurityList() async {
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

  Future getpuritywisepurchasereportList(BuildContext context) async {
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

    FetchPurityWisePurchaseReportListPayload payload =
        FetchPurityWisePurchaseReportListPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            purity: purityFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? puritywisepurchasereportList =
        await PurityWisePurchaseReportService.fetchPurityWisePurchaseReportList(
            payload: payload);

    if (puritywisepurchasereportList != null) {
      tableData(puritywisepurchasereportList['list']);
      totalpages(puritywisepurchasereportList['data']['total_pages']);
      totalPieces(
          puritywisepurchasereportList['data']['total_pieces'].toString());
      totalGrossWeight(puritywisepurchasereportList['data']
              ['total_gross_weight']
          .toString());
      totalNetWeight(
          puritywisepurchasereportList['data']['total_net_weight'].toString());
      totalAmount(
          puritywisepurchasereportList['data']['total_amount'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalPieces("0");
      totalNetWeight("0");
      totalGrossWeight("0");
      totalAmount("0");
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
    final payload = FetchPurityWisePurchaseReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        purity: purityFilter,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportPurchasePuritywiseListReport(
        payload, context);

    isExportLoading(false);
  }
}
