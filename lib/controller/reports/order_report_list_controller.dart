import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/reports/billing_cr_dr_models.dart';
import 'package:ausales_application/model/reports/customer_cr_dr_report_models.dart';
import 'package:ausales_application/model/reports/daily_payment_report_models.dart';
import 'package:ausales_application/model/reports/order_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OrderReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController fromDateController = TextEditingController();

  TextEditingController searchcustomerController = TextEditingController();

  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> customerFilterList = <DropdownModel>[].obs;

  RxList<OrderReportListData> tableData = <OrderReportListData>[].obs;

  RxBool isTableLoading = false.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxDouble totalWeight = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble totalAdvanceCashAmount = 0.0.obs;
  RxDouble totalAdvanceCardAmount = 0.0.obs;
  RxDouble totalAdvanceBankAmount = 0.0.obs;
  RxDouble totalAdvanceUpiAmount = 0.0.obs;
  RxDouble totalAdvancetotalAmount = 0.0.obs;
  RxDouble totalOldAmount = 0.0.obs;
  RxDouble totalOldWeight = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    DateTime today = DateTime.now();
    fromDateController.text =
        DateHelper.convertDateYearMonthDate(today.toString());
    getCustomerList();
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
    selectedCustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getOrderReport() async {
    isTableLoading(true);

    String? customerFilter;

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchOrderReportListPayload payload = FetchOrderReportListPayload(
        page: page.value,
        fromDate:
            fromDateController.text.isEmpty ? null : fromDateController.text,
        customer: customerFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? orderreportList =
        await ReportsServices.fetchOrderReport(payload: payload);

    if (orderreportList != null) {
      tableData(orderreportList['list']);
      totalpages(orderreportList['data']['total_pages']);
      totalOldWeight(double.parse(orderreportList['data']['total_old_weight'].toString()));
      totalOldAmount(double.parse(orderreportList['data']['total_old_amount'].toString()));
      totalAmount(double.parse(orderreportList['data']['total_amount'].toString()));
      totalWeight(double.parse(orderreportList['data']['total_weight'].toString()));
      totalAdvanceBankAmount(double.parse(orderreportList['data']['total_advance_bank_amount'].toString()));
      totalAdvanceCardAmount(double.parse(orderreportList['data']['total_advance_card_amount'].toString()));
      totalAdvanceCashAmount(double.parse(orderreportList['data']['total_advance_cash_amount'].toString()));
      totalAdvanceUpiAmount(double.parse(orderreportList['data']['total_advance_upi_amount'].toString()));
      totalAdvancetotalAmount(double.parse(orderreportList['data']['total_advance_total_amount'].toString()));
    } else {
      tableData([]);
      totalpages(1);
      totalOldWeight(0.0);
      totalOldAmount(0.0);
      totalAmount(0.0);
      totalWeight(0.0);
      totalAdvanceBankAmount(0.0);
      totalAdvanceCardAmount(0.0);
      totalAdvanceCashAmount(0.0);
      totalAdvanceUpiAmount(0.0);
      totalAdvancetotalAmount(0.0);
    }

    isTableLoading(false);
  }

  Future exportData(BuildContext context) async {
    isExportLoading(true);

   String? customerFilter;

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchOrderReportListPayload payload = FetchOrderReportListPayload(
        page: page.value,
        fromDate:
            fromDateController.text.isEmpty ? null : fromDateController.text,
        customer: customerFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportOrderReport(
        payload, context, "excel");

    isExportLoading(false);
  }

  Future exportDataPdf(BuildContext context) async {
    isExportPdfLoading(true);

   String? customerFilter;

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchOrderReportListPayload payload = FetchOrderReportListPayload(
        page: page.value,
        fromDate:
            fromDateController.text.isEmpty ? null : fromDateController.text,
        customer: customerFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportOrderReport(
        payload, context, "pdf");

    isExportPdfLoading(false);
  }
}
