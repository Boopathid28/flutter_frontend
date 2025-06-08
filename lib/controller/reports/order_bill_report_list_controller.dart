import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/order_bill_report_models.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_sub_item_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderBillReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchCustomerController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedcustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> customerFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<OrderBillReportListData> tableData =
      <OrderBillReportListData>[].obs;

  @override
  Future<void> onInit() async {
        DateTime today = DateTime.now();
        fromDateController.text = DateHelper.convertDateYearMonthDate(today.toString());
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getCustomerList();
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

  Future getCustomerList() async {
    customerFilterList([]);
    final List<CustomerDropDownModel> templist =
        await DropdownService.customerDropDown();
    customerFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      customerFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.customerName.toString()));
    });
    selectedcustomer(DropdownModel(value: "0", label: "All"));
  }

 
  Future getorderbillreport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? customerFilter;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedcustomer.value != null && selectedcustomer.value?.value != "0") {
      customerFilter = selectedcustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchOrderBillReportListDataPayload payload =
        FetchOrderBillReportListDataPayload(
            page: page.value,
            fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
            customer: customerFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? oredrbillreportList =
        await ReportsServices
            .fetchOrderBillReport(payload: payload);

    if (oredrbillreportList != null) {

 tableData(oredrbillreportList['list']);
    totalpages(oredrbillreportList['data']['total_pages']);
      totalPieces(oredrbillreportList['data']['total_pieces'].toString());
      totalGrossWeight(oredrbillreportList['data']['total_gross_weight'].toString());
      totalNetWeight(oredrbillreportList['data']['total_net_weight'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalPieces("0");
      totalGrossWeight("0");
      totalNetWeight("0");
    }

    isTableLoading(false);
  }



   Future exportData(BuildContext context) async {
    isExportLoading(true);

   
    String? branchFilter;
    String? customerFilter;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedcustomer.value != null && selectedcustomer.value?.value != "0") {
      customerFilter = selectedcustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

 

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchOrderBillReportListDataPayload(
        page: page.value,
            fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
            customer: customerFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportOrderBillListReport(payload, context);
    
    isExportLoading(false);
  }


  Future exportPdfData(BuildContext context) async {
    isExportPdfLoading(true);

   
    String? branchFilter;
    String? customerFilter;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedcustomer.value != null && selectedcustomer.value?.value != "0") {
      customerFilter = selectedcustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

 

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchOrderBillReportListDataPayload(
        page: page.value,
            fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
            customer: customerFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportOrderBillListPdfReport(payload, context);
    
    isExportPdfLoading(false);
  }




}
