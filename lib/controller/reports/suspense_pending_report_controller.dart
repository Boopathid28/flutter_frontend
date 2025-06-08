import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/daily_stock_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/suspense_pending_report_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuspensePendingReportController extends HeaderController {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  TextEditingController reportDateFilterController = TextEditingController();

  TextEditingController searchBranchController = TextEditingController();
  TextEditingController searchCustomerController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;

  RxList<SuspensePendingReportListData> tableData =
      <SuspensePendingReportListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (isBranchuser.value) {
      getBranchList();
    }
    getCustomerList();
    getSuspensePendingReport();
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

  Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    customerDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      customerDropDown.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    }
    selectedCustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getSuspensePendingReport() async {
    isTableLoading(true);

    String? branchFilter;
    String? customerFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != '0') {
      customerFilter = selectedCustomer.value?.value;
    } else {
      customerFilter = null;
    }

    String? fromDate;
    String? toDate;

    if (reportDateFilterController.text.isNotEmpty) {
      fromDate = reportDateFilterController.text.split(' to ')[0];
      toDate = reportDateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final SuspensePendingReportPayload payload = SuspensePendingReportPayload(
      branch: branchFilter,
      fromDate: fromDate,
      toDate: toDate,
      customer: customerFilter,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );
    var response = await ReportsServices.fetchSuspensePendingReportReport(payload);
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
    String? customerFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }
    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != '0') {
      customerFilter = selectedCustomer.value?.value;
    } else {
      customerFilter = null;
    }

    String? fromDate;
    String? toDate;

    if (reportDateFilterController.text.isNotEmpty) {
      fromDate = reportDateFilterController.text.split(' to ')[0];
      toDate = reportDateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final SuspensePendingReportPayload payload = SuspensePendingReportPayload(
      branch: branchFilter,
      fromDate: fromDate,
      toDate: toDate,
      customer: customerFilter,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );
    var response = await ExportReportService.exportSuspensePendingReport(
        payload, context);

    isExportLoading(false);
  }
}
