import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/daily_sale_report_models.dart';
import 'package:ausales_application/model/reports/estimation_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_item_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class DailySaleReportListController extends HeaderController {
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
  RxString totalPieces = "0".obs;
  RxDouble totalGrossWeight = 0.0.obs;
  RxDouble totalcashAmount = 0.0.obs;
  RxDouble totalcardAmount = 0.0.obs;
  RxDouble totalbankAmount = 0.0.obs;
  RxDouble totalupiAmount = 0.0.obs;
  RxDouble totalpayableAmount = 0.0.obs;
  RxDouble totaloldAmount = 0.0.obs;
  RxDouble totaloldWeight = 0.0.obs;
  RxDouble totalsuspenseAmount = 0.0.obs;
  RxDouble totalchitAmount = 0.0.obs;
  RxDouble totalAdvanceAmount = 0.0.obs;

  RxBool isTableLoading = true.obs;

  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<DailySaleReportListData> tableData = <DailySaleReportListData>[].obs;

  @override
  Future<void> onInit() async {
    getmetalList();
  }

  Future getmetalList() async {
    metalFilterList([]);
    final List<MetalDropdownModel> templist =
        await DropdownService.metalDropDown();
    templist.forEach((item) {
      metalFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.metalName.toString()));
    });
  }

  Future getdailysalereport(BuildContext context) async {
    isTableLoading(true);

    String? fromDate;
    String? toDate;
    String? metalFilter;

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    if (selectedmetal.value != null) {
      metalFilter = selectedmetal.value!.value;
    } else {
      metalFilter = null;
    }

    FetchDailySaleReportListPayload payload = FetchDailySaleReportListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        itemsPerPage: itemsPerPage.value,
        metal: metalFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? dailysalereportList =
        await ReportsServices.fetchDailySaleReport(payload: payload);

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
    if (metalFilter == null) {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("Select Metal"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      var response =
          await ExportReportService.exportDailySaleReport(payload, context);
    }
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

    if (metalFilter == null) {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("Select Metal"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      var response =
          await ExportReportService.exportDailySalePdfReport(payload, context);
    }

    isExportPdfLoading(false);
  }
}
