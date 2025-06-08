import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/bill_repayment_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class BillRepaymentReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController fromDateController = TextEditingController();

  RxList<BillRepaymentReportListData> tableData =
      <BillRepaymentReportListData>[].obs;

  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxDouble totalCashAmount = 0.0.obs;
  RxDouble totalCardAmount = 0.0.obs;
  RxDouble totalBankAmount = 0.0.obs;
  RxDouble totalUPIAmount = 0.0.obs;
  RxDouble totalOgWeight = 0.0.obs;
  RxDouble totalSuspenseAmount = 0.0.obs;
  RxDouble totalChitAmount = 0.0.obs;
  RxDouble totalAdvanceAmount = 0.0.obs;
  RxDouble totalChequeAmount = 0.0.obs;
  RxDouble totalOgAmount = 0.0.obs;
  RxDouble totalPaidAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    DateTime today = DateTime.now();
    fromDateController.text = DateHelper.convertDateYearMonthDate(today.toString());
    getBillRepaymentReport();
  }

  Future getBillRepaymentReport() async {
    isTableLoading(true);

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchBillRepaymentReportListPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );

    var response =
        await ReportsServices.fetchBillRepaymentReport(payload: payload);
    if (response != null) {
      tableData(response['list']);
      totalpages(response['total_pages']);

      totalPaidAmount(double.parse(response['data']['total_paid_amount'].toString()));
      totalOgWeight(double.parse(response['data']['total_og_weight'].toString()));
      totalOgAmount(double.parse(response['data']['total_og_amount'].toString()));
      totalCashAmount(double.parse(response['data']['total_cash_amount'].toString()));
      totalCardAmount(double.parse(response['data']['total_card_amount'].toString()));
      totalBankAmount(double.parse(response['data']['total_bank_amount'].toString()));
      totalUPIAmount(double.parse(response['data']['total_upi_amount'].toString()));
      totalChequeAmount(double.parse(response['data']['total_cheque_amount'].toString()));
      totalAdvanceAmount(double.parse(response['data']['total_advance_amount'].toString()));
      totalChitAmount(double.parse(response['data']['total_chit_amount'].toString()));
      totalSuspenseAmount(double.parse(response['data']['total_suspense_amount'].toString()));
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }



  
Future exportData(BuildContext context) async {
    isExportLoading(true);

 
   final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchBillRepaymentReportListPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );

    var response =
        await ExportReportService.exportbillrepaymentReport(payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

   
   final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchBillRepaymentReportListPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );
    var response =
        await ExportReportService.exportbillrepaymentReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }

}
