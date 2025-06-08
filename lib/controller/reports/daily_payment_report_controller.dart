import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/daily_payment_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class DailyPaymentReportController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController fromDateController = TextEditingController();

  RxList<DailyPaymentReportListData> tableData =
      <DailyPaymentReportListData>[].obs;

  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxString openCashAmount = "0.0".obs;
  RxString openCardAmount = "0.0".obs;
  RxString openBankAmount = "0.0".obs;
  RxString openUPIAmount = "0.0".obs;
  RxString openTotalAmount = "0.0".obs;
  RxString closeCashAmount = "0.0".obs;
  RxString closeCardAmount = "0.0".obs;
  RxString closeBankAmount = "0.0".obs;
  RxString closeUPIAmount = "0.0".obs;
  RxString closeTotalAmount = "0.0".obs;

  @override
  void onInit() {
    super.onInit();
    DateTime today = DateTime.now();
    fromDateController.text = DateHelper.convertDateYearMonthDate(today.toString());
    getDailyPaymentReport();
  }

  Future getDailyPaymentReport() async {
    isTableLoading(true);

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = DailyPaymentReportPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );

    var response =
        await ReportsServices.fetchDailyPaymentReport(payload: payload);
    if (response != null) {
      tableData(response['list']);
      totalpages(response['total_pages']);

      openCashAmount(response['data']['total_opencash_amount'].toString());
      openCardAmount(response['data']['total_opencard_amount'].toString());
      openBankAmount(response['data']['total_openbank_amount'].toString());
      openUPIAmount(response['data']['total_openupi_amount'].toString());
      openTotalAmount(response['data']['total_opentotal_amount'].toString());
      closeCashAmount(response['data']['total_closecash_amount'].toString());
      closeCardAmount(response['data']['total_closecard_amount'].toString());
      closeBankAmount(response['data']['total_closebank_amount'].toString());
      closeUPIAmount(response['data']['total_closeupi_amount'].toString());
      closeTotalAmount(response['data']['total_closetotal_amount'].toString());
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }



  
  Future exportData(BuildContext context) async {
    isExportLoading(true);

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = DailyPaymentReportPayload(
      fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
      itemsPerPage: itemsPerPage.value,
      menuId: menuId,
      page: page.value,
    );
    var response =
        await ExportReportService.exportDailypaymentReport(payload, context);
    
    isExportLoading(false);
  }
}
