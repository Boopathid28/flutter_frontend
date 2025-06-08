import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/cash_purchase_report_models..dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashPurchaseReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController datarangefilterController = TextEditingController();
  TextEditingController searchmetalController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;

  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<CashPurchaseReportListData> tableData = <CashPurchaseReportListData>[].obs;
  RxObjectMixin<CashPurchaseReportOverview> overview = CashPurchaseReportOverview().obs;


  Future getCashPurchaseReport(BuildContext context) async {
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


    FetchCashPurchaseReportListPayload payload = FetchCashPurchaseReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? data =
        await ReportsServices.fetchCashPurchaseReport(payload: payload);
    
    if (data != null) {
      tableData(data['list']);
      overview(CashPurchaseReportOverview.fromJson(data['data']));
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

    final payload = FetchCashPurchaseReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportCashPurchaseReport(payload, context, "excel");

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

    final payload = FetchCashPurchaseReportListPayload(
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportCashPurchaseReport(payload, context, "pdf");

    isExportPdfLoading(false);
  }
}
