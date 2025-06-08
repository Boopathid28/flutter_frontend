import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/all_metal_daily_sale_report_models.dart';
import 'package:ausales_application/model/reports/daily_sale_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllMetalDailySaleReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController datarangefilterController = TextEditingController();
  TextEditingController searchmetalController = TextEditingController();

  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedmetal = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;

  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<AllMetalDailySaleReportListData> tableData = <AllMetalDailySaleReportListData>[].obs;


  Future getAllMetalDailySaleReport(BuildContext context) async {
    isTableLoading(true);

    String? fromDate;
    String? toDate;

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }


    FetchAllMetalDailySaleReportListPayload payload = FetchAllMetalDailySaleReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? dailysalereportList =
        await ReportsServices.fetchAllMetalDailySaleReport(payload: payload);
    
    if (dailysalereportList != null) {
      tableData(dailysalereportList['list']);
    }

    isTableLoading(false);
  }

  Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? metalFilter;
    String? fromDate;
    String? toDate;

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    if (selectedmetal.value != null && selectedmetal.value?.value != '0') {
      metalFilter = selectedmetal.value?.value;
    } else {
      metalFilter = null;
    }

    final payload = FetchDailySaleReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        metal: metalFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportAllMetalDailySaleReport(payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

    String? metalFilter;
    String? fromDate;
    String? toDate;

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    if (selectedmetal.value != null && selectedmetal.value?.value != '0') {
      metalFilter = selectedmetal.value?.value;
    } else {
      metalFilter = null;
    }

    final payload = FetchDailySaleReportListPayload(
        fromDate: fromDate,
        toDate: toDate,
        metal: metalFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportAllMetalDailySaleReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }
}
