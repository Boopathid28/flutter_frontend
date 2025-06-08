import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/daily_sale_report_models.dart';
import 'package:ausales_application/model/reports/direct_issue_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectIssueReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController datarangefilterController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;

  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<DirectIssueReportListData> tableData = <DirectIssueReportListData>[].obs;


  Future getDirectissueReport(BuildContext context) async {
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


    FetchDirectIssueReportListPayload payload = FetchDirectIssueReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        search: searchController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());


    final Map<String, dynamic>? directIssueReportList =
        await ReportsServices.fetchDirectIssueReport(payload: payload);
    
    if (directIssueReportList != null) {
      tableData(directIssueReportList['list']);
    }

    isTableLoading(false);
  }

  Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? fromDate;
    String? toDate;

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final payload = FetchDirectIssueReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        search: searchController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportDirectIssueReport(payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

    String? fromDate;
    String? toDate;

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final payload = FetchDirectIssueReportListPayload(
        fromDate: fromDate,
        toDate: toDate,
        search: searchController.text,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportDirectIssueReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }
}
