import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/item_wise_sale_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ItemWiseSalesReportController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;

  RxList<ItemWiseSaleReport> tableData = <ItemWiseSaleReport>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (isBranchuser.value) {
      getBranchList();
    }
    getItemWiseSalesReport();
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

  Future getItemWiseSalesReport() async {
    isTableLoading(true);

    String? branchFilter;
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = ItemWiseSaleReportPayload(
      branch: branchFilter,
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId.toString(),
      page: page.value,
      toDate: toDateController.text.isEmpty?null:toDateController.text,
      search: searchController.text
    );
    var response = await ReportsServices.fetchItemWiseSalesReport(payload);
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
    if (selectedBranch.value != null && selectedBranch.value?.value != '0') {
      branchFilter = selectedBranch.value?.value;
    } else {
      branchFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = ItemWiseSaleReportPayload(
      branch: branchFilter,
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId.toString(),
      page: page.value,
      toDate: toDateController.text.isEmpty?null:toDateController.text,
      search: searchController.text
    );
    var response =
        await ExportReportService.exportItemWiseSalesReport(payload, context);
    
    isExportLoading(false);
  }
}
