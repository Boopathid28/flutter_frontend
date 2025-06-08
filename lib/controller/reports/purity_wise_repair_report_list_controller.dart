import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_purity_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_sub_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/purity_wise_repair_report_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurityWiseRepairReportListController extends HeaderController {
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

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<PurityWiseRepairReportListData> tableData =
      <PurityWiseRepairReportListData>[].obs;

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

 
  Future getpuritywiserepairreport(BuildContext context) async {
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

    FetchPurityWiseRepairReportListPayload payload =
        FetchPurityWiseRepairReportListPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            purity: purityFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? puritywiserepairreportList =
        await ReportsServices
            .fetchpurityWiseRepairReport(payload: payload);

    if (puritywiserepairreportList != null) {

 tableData(puritywiserepairreportList['list']);
    totalpages(puritywiserepairreportList['data']['total_pages']);
      totalPieces(puritywiserepairreportList['data']['total_pieces'].toString());
      totalGrossWeight(puritywiserepairreportList['data']['total_gross_weight'].toString());
      totalNetWeight(puritywiserepairreportList['data']['total_net_weight'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalPieces("0");
      totalGrossWeight("0");
      totalNetWeight("0");
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
    final payload = FetchPurityWiseRepairReportListPayload(
      page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            purity: purityFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu()
    );
    var response =
        await ExportReportService.exportrepairpurityReport(payload, context);
    
    isExportLoading(false);
  }
}
