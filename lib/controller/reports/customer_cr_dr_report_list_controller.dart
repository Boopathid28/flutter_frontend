import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/customer_cr_dr_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CustomerCrDrReportListController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController fromDateController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<CustomerCRDRListData> tableData = <CustomerCRDRListData>[].obs;

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
    getCustomerCRDRReport();
  }

  Future getCustomerCRDRReport() async {
    isTableLoading(true);

    FetchCustomerCRDRListPayload payload = FetchCustomerCRDRListPayload(
        page: page.value,
        fromDate: fromDateController.text.isEmpty ? null : fromDateController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? customercrdrList =
        await ReportsServices.fetchCustomerCRDRReport(payload: payload);

    if (customercrdrList != null) {
      tableData(customercrdrList['list']);
      totalpages(customercrdrList['data']['total_pages']);
      TotalCr(customercrdrList['data']['total_cr']);
      TotalDr(customercrdrList['data']['total_dr']);
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

 
     FetchCustomerCRDRListPayload payload = FetchCustomerCRDRListPayload(
        page: page.value,
        fromDate: fromDateController.text.isEmpty ? null : fromDateController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportCustomercrdrListReport(payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

   
     FetchCustomerCRDRListPayload payload = FetchCustomerCRDRListPayload(
        page: page.value,
        fromDate: fromDateController.text.isEmpty ? null : fromDateController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportCustomercrdrListReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }

}
