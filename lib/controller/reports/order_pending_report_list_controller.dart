import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_pending_report_models.dart';
import 'package:ausales_application/model/reports/order_sub_item_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPendingReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<OrderPendingReportListData> tableData =
      <OrderPendingReportListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
  }

  Future getBranchList() async {
    branchFilterList([]);
    final List<BranchDropDownModel> templist =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      branchFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.branchName.toString()));
    });
    selectedbranch(DropdownModel(value: "0", label: "All"));
  }

 

 
  Future getorderpendingreport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

  

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchOrderPendingReportListDataPayload payload =
        FetchOrderPendingReportListDataPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? orderpendingreportList =
        await ReportsServices
            .fetchOrderPendingReport(payload: payload);

    if (orderpendingreportList != null) {

 tableData(orderpendingreportList['list']);
    totalpages(orderpendingreportList['data']['total_pages']);
      totalPieces(orderpendingreportList['data']['total_pieces'].toString());
      totalGrossWeight(orderpendingreportList['data']['total_gross_weight'].toString());
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

   
    String? branchFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

  

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchOrderPendingReportListDataPayload(
        page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportorderpendingListReport(payload, context, "excel");
    
    isExportLoading(false);
  }





   Future exportPdfData(BuildContext context) async {
    isExportPdfLoading(true);

   
    String? branchFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

  

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchOrderPendingReportListDataPayload(
        page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportorderpendingListReport(payload, context, "pdf");
    
    isExportPdfLoading(false);
  }







}
