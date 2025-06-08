import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/bill_repayment_report_models.dart';
import 'package:ausales_application/model/reports/payment_flow_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PaymentFlowReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController fromDateController = TextEditingController();

  RxList<PaymentFlowReportListData> tableData =
      <PaymentFlowReportListData>[].obs;

  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    DateTime today = DateTime.now();
    fromDateController.text = DateHelper.convertDateYearMonthDate(today.toString());
    getPaymentFlowReport();
  }

  Future getPaymentFlowReport() async {
    isTableLoading(true);

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = PepaymentFlowReportListPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );

    var response =
        await ReportsServices.fetchPaymentFlowReport(payload: payload);
    if (response != null) {
      tableData(response['list']);
      totalpages(response['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }



  
Future exportData(BuildContext context) async {
    isExportLoading(true);

 
   final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = PepaymentFlowReportListPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );

    var response =
        await ExportReportService.exportpaymentflowReport(payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

   
   final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = PepaymentFlowReportListPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );
    var response =
        await ExportReportService.exportpaymentflowReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }

}
