import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/customer_summary_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSummaryReportController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchcustomerController =
      TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> customerFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<CustomerSummaryListData> tableData =
      <CustomerSummaryListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCustomerList();
  }

  Future getCustomerList() async {
    customerFilterList([]);
    final List<CustomerDropDownModel> templist =
        await DropdownService.customerDropDown();
    customerFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      customerFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.customerName.toString()));
    });
    selectedCustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getcustomersummaryreport(BuildContext context) async {
    isTableLoading(true);

    String? customerFilter;
    String? fromDate;
    String? toDate;


    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchCustomerSummaryListPayload payload =
        FetchCustomerSummaryListPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            customer: customerFilter,
            itemsPerPage: itemsPerPage.value,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? customersummaryList =
        await ReportsServices.fetchCustomerSummaryReportList(payload: payload);

    if (customersummaryList != null) {
      tableData(customersummaryList['list']);
      totalpages(customersummaryList['data']['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }



  
  Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? customerFilter;
    String? fromDate;
    String? toDate;

    if (selectedCustomer.value != null && selectedCustomer.value?.value != '0') {
      customerFilter = selectedCustomer.value?.value;
    } else {
      customerFilter = null;
    }


       if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchCustomerSummaryListPayload(
      fromDate: fromDate,
      toDate: toDate,
      customer: customerFilter,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );
    var response =
        await ExportReportService.exportCustomerSummaryReport(payload, context);
    
    isExportLoading(false);
  }
}
