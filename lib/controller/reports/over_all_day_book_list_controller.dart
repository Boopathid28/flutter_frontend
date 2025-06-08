import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/day_book_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverAllDayBookListController extends GetxController {
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
  RxBool isExportPdfLoading = false.obs;
  RxBool isViewPdfLoading = false.obs;
  RxBool isViewingPdf = false.obs;

  @override
  Future<void> onInit() async {
  }

   Future exportData(BuildContext context) async {
    isExportLoading(true);

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchDayBookListPayload(
      page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportdayReport(payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchDayBookListPayload(
      page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportdayReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }
}
