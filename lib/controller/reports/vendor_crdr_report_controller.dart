import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/vendor_crdr_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorCrdrReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController datefilterController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;

  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<VendorCRDRReportListData> tableData = <VendorCRDRReportListData>[].obs;
  RxObjectMixin<VendorCRDRReportOverview> overview = VendorCRDRReportOverview().obs;

  Future getVendorCrdrReport(BuildContext context) async {
    isTableLoading(true);

    FetchVendorCRDRReportListPayload payload = FetchVendorCRDRReportListPayload(
        page: page.value,
        fromDate: datefilterController.text.isEmpty ? null : datefilterController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? data =
        await ReportsServices.fetchVendorCrdrReport(payload: payload);

    if (data != null) {
      tableData(data['list']);
      overview(VendorCRDRReportOverview.fromJson(data['data']));
    }

    isTableLoading(false);
  }

  Future exportData(BuildContext context) async {
    isExportLoading(true);

    FetchVendorCRDRReportListPayload payload = FetchVendorCRDRReportListPayload(
        page: page.value,
        fromDate: datefilterController.text.isEmpty ? null : datefilterController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportVendorCrDrReport(
        payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

    FetchVendorCRDRReportListPayload payload = FetchVendorCRDRReportListPayload(
        page: page.value,
        fromDate: datefilterController.text.isEmpty ? null : datefilterController.text,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportVendorCrDrReport(
        payload, context, "pdf");

    isExportPdfLoading(false);
  }
}
