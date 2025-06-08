import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/daily_stock_subitem_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class DailyStockSubitemItemWiseReportController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  RxList<DropdownModel> subItemDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);
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

  RxList<DailyStockSubitemItemWiseReportList> tableData =
      <DailyStockSubitemItemWiseReportList>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (isBranchuser.value) {
      getBranchList();
    }
    getItemList();
    getDailyStockSubitemItemWiseReport();
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

  Future getItemList() async {
    itemDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    itemDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      itemDropDown
          .add(DropdownModel(label: item.itemName!, value: item.id.toString()));
    }
    selectedItem(DropdownModel(value: "0", label: "All"));
  }

  Future getSubItemList() async {
    subItemDropDown([]);
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: selectedItem.value?.value);
    for (var item in tempList) {
      subItemDropDown.add(
          DropdownModel(label: item.subItemName!, value: item.id.toString()));
    }
  }

  Future getDailyStockSubitemItemWiseReport() async {
    isTableLoading(true);

    String? branchFilter;
    String? itemFilter;
    String? subitemFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedItem.value != null && selectedItem.value?.value != '0') {
      itemFilter = selectedItem.value?.value;
    } else {
      itemFilter = null;
    }
    if (selectedSubItem.value != null && selectedSubItem.value?.value != '0') {
      subitemFilter = selectedSubItem.value?.value;
    } else {
      subitemFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = DailyStockSubitemItemWiseReportPayload(
        branch: branchFilter,
        fromDate:
            fromDateController.text.isEmpty ? null : fromDateController.text,
        item: itemFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: menuId.toString(),
        page: page.value,
        subItem: subitemFilter);
    var response =
        await ReportsServices.fetchDailyStockSubItemWiseReport(payload);
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
    } else {
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
    String? itemFilter;
    String? subitemFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedItem.value != null && selectedItem.value?.value != '0') {
      itemFilter = selectedItem.value?.value;
    } else {
      itemFilter = null;
    }
    if (selectedSubItem.value != null && selectedSubItem.value?.value != '0') {
      subitemFilter = selectedSubItem.value?.value;
    } else {
      subitemFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = DailyStockSubitemItemWiseReportPayload(
        branch: branchFilter,
        fromDate:
            fromDateController.text.isEmpty ? null : fromDateController.text,
        item: itemFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: menuId.toString(),
        page: page.value,
        subItem: subitemFilter);
    var response =
        await ExportReportService.exportDailyStockSubItemWiseReport(payload, context);
    
    isExportLoading(false);
  }
}
