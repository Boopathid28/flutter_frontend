import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/daily_report_models.dart';
import 'package:ausales_application/model/reports/order_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/overall_daily_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyReportControllers extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fromDateController = TextEditingController();


  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  
  RxBool isExportLoading = false.obs;

  RxList<DailyReportListData> tableData =
      <DailyReportListData>[].obs;

  Future getDailyreport(BuildContext context) async {
    isTableLoading(true);

    FetchDailyReportListPayload payload = FetchDailyReportListPayload(
        page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? dailyreportList =
        await ReportsServices.fetchDailyReportReport(payload: payload);

    if (dailyreportList != null) {
      tableData(dailyreportList['list']);
      totalpages(dailyreportList['data']['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }



   Future exportData(BuildContext context) async {
    isExportLoading(true);

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchDailyReportListPayload(
      page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportDailyReport(payload, context);
    
    isExportLoading(false);
  }
}
