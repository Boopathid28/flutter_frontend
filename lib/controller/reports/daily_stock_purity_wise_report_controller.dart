import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/daily_stock_purity_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyStockPurityWiseReportController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  RxList<DropdownModel> purityDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);
  TextEditingController fromDateController = TextEditingController();

  RxString totalOutPieces = "0".obs;
  RxString totalInPieces = "0".obs;
  RxString totalOutWeight = "0".obs;
  RxString totalInWeight = "0".obs;
  RxString totalOpenPieces = "0".obs;
  RxString totalClosePieces = "0".obs;
  RxString totalOpenWeight = "0".obs;
  RxString totalCloseWeight = "0".obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;

  RxList<DailyStockPurityWiseReportList> tableData =
      <DailyStockPurityWiseReportList>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (isBranchuser.value) {
      getBranchList();
    }
    getPurityList();
    getDailyStockPurityWiseReport();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    }
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }

  Future getPurityList() async {
    purityDropDown([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    purityDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      purityDropDown
          .add(DropdownModel(label: item.purityName!, value: item.id.toString()));
    }
    selectedPurity(DropdownModel(value: "0", label: "All"));
  }

  Future getDailyStockPurityWiseReport() async {
    isTableLoading(true);

    String? branchFilter;
    String? purityFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedPurity.value != null && selectedPurity.value?.value != '0') {
      purityFilter = selectedPurity.value?.value;
    } else {
      purityFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = DailyStockPurityWiseReportPayload(
      branch: branchFilter,
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      purity: purityFilter,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId.toString(),
      page: page.value,
    );
    var response = await ReportsServices.fetchDailyStockPurityWiseReport(payload);
    if (response != null) {
      tableData(response.list);
      totalpages(response.totalPages);
      totalOutPieces(response.totalOutPieces.toString());
      totalInPieces(response.totalInPieces.toString());
      totalOutWeight(response.totalOutWeight.toString());
      totalInWeight(response.totalInWeight.toString());
      totalOpenPieces(response.totalOpenPieces.toString());
      totalClosePieces(response.totalClosePieces.toString());
      totalOpenWeight(response.totalOpenWeight.toString());
      totalCloseWeight(response.totalCloseWeight.toString());
    }else{
      tableData([]);
      totalpages(1);
      totalOutPieces("0");
      totalInPieces("0");
      totalOutWeight("0");
      totalInWeight("0");
      totalOpenPieces("0");
      totalClosePieces("0");
      totalOpenWeight("0");
      totalCloseWeight("0");
    }
    isTableLoading(false);
  }

  Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? branchFilter;
    String? purityFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedPurity.value != null && selectedPurity.value?.value != '0') {
      purityFilter = selectedPurity.value?.value;
    } else {
      purityFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = DailyStockPurityWiseReportPayload(
      branch: branchFilter,
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      purity: purityFilter,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId.toString(),
      page: page.value,
    );
    var response =
        await ExportReportService.exportDailyStockPurityWiseReport(payload, context);
    
    isExportLoading(false);
  }
}
