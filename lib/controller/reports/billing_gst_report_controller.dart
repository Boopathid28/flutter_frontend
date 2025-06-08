import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/billing_gst_report_models.dart';
import 'package:ausales_application/model/reports/pending_bill_payment_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class BillingGstReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchController = TextEditingController();
  TextEditingController dateFilterController = TextEditingController();
  TextEditingController branchSearchFilterController = TextEditingController();
  TextEditingController customerSearchFilterController = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> gstTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedGstType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<BillingGstReportListData> tableData = <BillingGstReportListData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }
    getCustomerList();
    getGstTypeList();
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

  Future getGstTypeList() async {
    gstTypeDropDown([]);
    final List<GstTypeDropdownModel> tempList =
        await DropdownService.gstTypeDropDown();
    gstTypeDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      gstTypeDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    }
    selectedGstType(DropdownModel(value: "0", label: "All"));
  }

  Future getBillingGstReportList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? customerFilter;
    String? gstTypeFilter;
    String? fromDate;
    String? toDate;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedCustomer.value != null && selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (selectedGstType.value != null && selectedGstType.value?.value != "0") {
      gstTypeFilter = selectedGstType.value?.value.toString();
    } else {
      gstTypeFilter = null;
    }

    if (dateFilterController.text.isNotEmpty) {
      fromDate = dateFilterController.text.split(' to ')[0];
      toDate = dateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    BillingGstReportPayload payload = BillingGstReportPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        customerDetails: customerFilter,
        gstType: gstTypeFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? itemList =
        await ReportsServices.fetchBillingGstReport(payload: payload);

    if (itemList != null) {
      tableData(itemList['data']);
      totalpages(itemList['total_pages']);
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
    String? gstTypeFilter;
    String? fromDate;
    String? toDate;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedCustomer.value != null && selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (selectedGstType.value != null && selectedGstType.value?.value != "0") {
      gstTypeFilter = selectedGstType.value?.value.toString();
    } else {
      gstTypeFilter = null;
    }

    if (dateFilterController.text.isNotEmpty) {
      fromDate = dateFilterController.text.split(' to ')[0];
      toDate = dateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }


    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = BillingGstReportPayload(
       search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        customerDetails: customerFilter,
        gstType: gstTypeFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu()
    );
    var response =
        await ExportReportService.exportBillinggstReport(payload, context);
    
    isExportLoading(false);
  }
}