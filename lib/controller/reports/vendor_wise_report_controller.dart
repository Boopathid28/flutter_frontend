import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/vendor_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VendorWiseReportController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  RxList<DropdownModel> subItemDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);
  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  RxList<DropdownModel> purityDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);
  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;

  RxList<VendorWiseReport> tableData = <VendorWiseReport>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (isBranchuser.value) {
      getBranchList();
    }
    getItemList();
    getMetalList();
    getPurityList();
    getVendorList();
    getVendorWiseReport();
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

  Future getVendorList() async {
    vendorDropDown([]);
    vendorDropDown.add(DropdownModel(value: '0', label: 'All'));
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    for (var item in tempList) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    }
    selectedVendor(DropdownModel(value: '0', label: 'All'));
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

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    metalDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      metalDropDown.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
    }
    selectedMetal(DropdownModel(value: "0", label: "All"));
  }

  Future getPurityList() async {
    purityDropDown([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    purityDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      purityDropDown.add(
          DropdownModel(label: item.purityName!, value: item.id.toString()));
    }
    selectedPurity(DropdownModel(value: "0", label: "All"));
  }

  Future getVendorWiseReport() async {
    isTableLoading(true);

    String? branchFilter;
    String? itemFilter;
    String? subitemFilter;
    String? metalFilter;
    String? vendorFilter;
    String? purityFilter;
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
    if (selectedMetal.value != null && selectedMetal.value?.value != '0') {
      metalFilter = selectedMetal.value?.value;
    } else {
      metalFilter = null;
    }
    if (selectedVendor.value != null && selectedVendor.value?.value != '0') {
      vendorFilter = selectedVendor.value?.value;
    } else {
      vendorFilter = null;
    }
    if (selectedPurity.value != null && selectedPurity.value?.value != '0') {
      purityFilter = selectedPurity.value?.value;
    } else {
      purityFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = VendorWiseReportPayload(
        branch: branchFilter,
        fromDate:
            fromDateController.text.isEmpty ? null : fromDateController.text,
        item: itemFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: menuId.toString(),
        page: page.value,
        subItem: subitemFilter,
        metal: metalFilter,
        purity: purityFilter,
        toDate: toDateController.text,
        vendor: vendorFilter);
    var response = await ReportsServices.fetchVendorWiseReport(payload);
    if (response != null) {
      tableData(response['data']);
      totalpages(response['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }

  Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? branchFilter;
    String? itemFilter;
    String? subitemFilter;
    String? metalFilter;
    String? vendorFilter;
    String? purityFilter;
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
    if (selectedMetal.value != null && selectedMetal.value?.value != '0') {
      metalFilter = selectedMetal.value?.value;
    } else {
      metalFilter = null;
    }
    if (selectedVendor.value != null && selectedVendor.value?.value != '0') {
      vendorFilter = selectedVendor.value?.value;
    } else {
      vendorFilter = null;
    }
    if (selectedPurity.value != null && selectedPurity.value?.value != '0') {
      purityFilter = selectedPurity.value?.value;
    } else {
      purityFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = VendorWiseReportPayload(
        branch: branchFilter,
        fromDate:
            fromDateController.text.isEmpty ? null : fromDateController.text,
        item: itemFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: menuId.toString(),
        page: page.value,
        subItem: subitemFilter,
        metal: metalFilter,
        purity: purityFilter,
        toDate: toDateController.text,
        vendor: vendorFilter);
    var response = await ExportReportService.exportVendorWiseSalesReport(
        payload, context);

    isExportLoading(false);
  }
}
