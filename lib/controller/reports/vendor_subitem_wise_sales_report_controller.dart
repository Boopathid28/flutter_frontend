import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/vendor_subitem_wise_sales_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';


class VendorSubitemWiseSalesReportController  extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;

  RxList<VendorSubitemWiseSalesReport> tableData = <VendorSubitemWiseSalesReport>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (isBranchuser.value) {
      getBranchList();
    }
    getVendorList();
    getVendorSubitemWiseSalesReport();
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

  Future getVendorSubitemWiseSalesReport() async {
    isTableLoading(true);

    String? branchFilter;
    String? vendorFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedVendor.value != null && selectedVendor.value?.value != '0') {
      vendorFilter = selectedVendor.value?.value;
    } else {
      vendorFilter = null;
    }
      final menuId = await HomeSharedPrefs.getCurrentMenu();
      final payload = VendorSubitemWiseSalesReportPayload(
          branch: branchFilter,
          fromDate:
              fromDateController.text.isEmpty ? null : fromDateController.text,
          itemsPerPage: itemsPerPage.value,
          menuId: menuId.toString(),
          page: page.value,
          toDate: toDateController.text.isEmpty?null:toDateController.text,
          search:searchController.text ,
          vendor: vendorFilter);
      var response =
          await ReportsServices.fetchVendorSubitemWiseSalesReport(payload);
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
    String? vendorFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedVendor.value != null && selectedVendor.value?.value != '0') {
      vendorFilter = selectedVendor.value?.value;
    } else {
      vendorFilter = null;
    }
      final menuId = await HomeSharedPrefs.getCurrentMenu();
      final payload = VendorSubitemWiseSalesReportPayload(
          branch: branchFilter,
          fromDate:
              fromDateController.text.isEmpty ? null : fromDateController.text,
          itemsPerPage: itemsPerPage.value,
          menuId: menuId.toString(),
          page: page.value,
          toDate: toDateController.text.isEmpty?null:toDateController.text,
          search:searchController.text ,
          vendor: vendorFilter);
    var response = await ExportReportService.exportVendorSubItemWiseSalesReport(
        payload, context);

    isExportLoading(false);
  }
  }

