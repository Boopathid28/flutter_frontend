import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/reports/vendor_outwards_report_models.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorOutwardsReportController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fromDateController = TextEditingController();


  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<VendorOutwardReportListData> tableData =
      <VendorOutwardReportListData>[].obs;

  @override
  Future<void> onInit() async {
    
  }




 


  Future getVendorOutwardsListreport(BuildContext context) async {
    isTableLoading(true);



    FetchVendorOutwardReportListDataPayload payload = FetchVendorOutwardReportListDataPayload(
        page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
     
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? vendoroutwardsreportList =
          await ReportsServices.fetchVendorOutwardsReport(payload: payload);

    if (vendoroutwardsreportList != null) {
      tableData(vendoroutwardsreportList['list']);
      totalpages(vendoroutwardsreportList['data']['total_pages']);
      totalPieces(vendoroutwardsreportList['data']['total_pieces'].toString());
      totalGrossWeight(vendoroutwardsreportList['data']['total_gross_weight'].toString());
    } else {
      tableData([]);
      totalpages(1);
        totalPieces("0");
      totalGrossWeight("0");
    }

    isTableLoading(false);
  }



   Future exportData(BuildContext context) async {
    isExportLoading(true);



    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchVendorOutwardReportListDataPayload(
      page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
       
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportVendorOutwardsListReport(payload, context);
    
    isExportLoading(false);
  }
   Future exportPdfData(BuildContext context) async {
    isExportPdfLoading(true);



    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchVendorOutwardReportListDataPayload(
      page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
       
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportVendorOutwardsListPdfReport(payload, context);
    
    isExportPdfLoading(false);
  }
}
