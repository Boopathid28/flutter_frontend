import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/billing_cr_dr_models.dart';
import 'package:ausales_application/model/reports/customer_cr_dr_report_models.dart';
import 'package:ausales_application/model/reports/daily_payment_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class BillingCrDrReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController fromDateController = TextEditingController();

  TextEditingController searchcustomerController = TextEditingController();

  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> customerFilterList = <DropdownModel>[].obs;

  RxList<BillingCRDRListData> tableData = <BillingCRDRListData>[].obs;

  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxDouble TotalCr = 0.0.obs;
  RxDouble TotalDr = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    DateTime today = DateTime.now();
    fromDateController.text =
        DateHelper.convertDateYearMonthDate(today.toString());
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

  Future getBillingCRDRReport() async {
    isTableLoading(true);


    String? customerFilter;

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchBillingCRDRListPayload payload = FetchBillingCRDRListPayload(
        page: page.value,
        fromDate: fromDateController.text.isEmpty ? null : fromDateController.text,
        customer: customerFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? billingcrdrList =
        await ReportsServices.fetchbillingCRDRReport(payload: payload);

    if (billingcrdrList != null) {
      tableData(billingcrdrList['list']);
      totalpages(billingcrdrList['data']['total_pages']);
      TotalCr(billingcrdrList['data']['total_cr']);
      TotalDr(billingcrdrList['data']['total_dr']);
    } else {
      tableData([]);
      totalpages(1);
      TotalCr(0.0);
      TotalDr(0.0);
    }

    isTableLoading(false);
  }



Future exportData(BuildContext context) async {
    isExportLoading(true);

 
    String? customerFilter;

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchBillingCRDRListPayload payload = FetchBillingCRDRListPayload(
        page: page.value,
        fromDate: fromDateController.text.isEmpty ? null : fromDateController.text,
        customer: customerFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportBillingcrdrListReport(payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

   
    String? customerFilter;

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchBillingCRDRListPayload payload = FetchBillingCRDRListPayload(
        page: page.value,
        fromDate: fromDateController.text.isEmpty ? null : fromDateController.text,
        customer: customerFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportBillingcrdrListReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }

}
