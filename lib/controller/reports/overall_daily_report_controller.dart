import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/order_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/overall_daily_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverallDailyReportController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchmetalController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();

  Rx<DropdownModel?> selectedmetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentMethod = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentProvider = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentMethodDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentProviderDropDown = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  
  RxBool isExportLoading = false.obs;

  RxList<OverallDailyReportResponse> tableData =
      <OverallDailyReportResponse>[].obs;

  @override
  Future<void> onInit() async {
    getMetalList();
    getPaymentMethodList();
  }

  Future getMetalList() async {
    metalFilterList([]);
    final List<MetalDropdownModel> templist =
        await DropdownService.metalDropDown();
    metalFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      metalFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.metalName.toString()));
    });
    selectedmetal(DropdownModel(value: "0", label: "All"));
  }


   Future getPaymentMethodList() async {
    paymentMethodDropDown([]);
    selectedPaymentMethod.value = null;
    paymentProviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentMethodDropDown>? data = await DropdownService.paymentMethodDropDown();

    paymentMethodDropDown.add(DropdownModel(value: "0", label: "All"));
    if (data != null) {
      for (var i in data) {
        paymentMethodDropDown.add(DropdownModel(value: i.value.toString(), label: i.lable.toString()));
      }
    }
    selectedPaymentMethod(DropdownModel(value: "0", label: "All"));
  }

  Future getPaymentProvidersList({ required String method }) async {
    paymentProviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentProviderDropDown>? data = await DropdownService.paymentProviderDropDown(paymentMethod: method);

    paymentProviderDropDown.add(DropdownModel(value: "0", label: "All"));
    if (data != null) {
      for (var i in data) {
        paymentProviderDropDown.add(DropdownModel(value: i.value.toString(), label: i.lable.toString()));
      }
    }
    selectedPaymentProvider(DropdownModel(value: "0", label: "All"));
  }

  Future getoverallDailyreport(BuildContext context) async {
    isTableLoading(true);

    String? metalFilter;
    String? paymentMethoadFilter;
    String? paymentProviderFilter;

    if (selectedmetal.value != null && selectedmetal.value?.value != "0") {
      metalFilter = selectedmetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

     if (selectedPaymentMethod.value != null && selectedPaymentMethod.value?.value != "0") {
      paymentMethoadFilter = selectedPaymentMethod.value?.value.toString();
    } else {
      paymentMethoadFilter = null;
    }

     if (selectedPaymentProvider.value != null && selectedPaymentProvider.value?.value != "0") {
      paymentProviderFilter = selectedPaymentProvider.value?.value.toString();
    } else {
      paymentProviderFilter = null;
    }

    FetchOverallDailyReportPayload payload = FetchOverallDailyReportPayload(
        page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
        metal: metalFilter,
        paymentMethod: paymentMethoadFilter,
        paymentProvider: paymentProviderFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? overalldailyreportList =
        await ReportsServices.fetchOverallDailyReport(payload: payload);

    if (overalldailyreportList != null) {
      tableData(overalldailyreportList['list']);
      totalpages(overalldailyreportList['data']['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }



   Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? metalFilter;
    String? paymentMethoadFilter;
    String? paymentProviderFilter;

    if (selectedmetal.value != null && selectedmetal.value?.value != "0") {
      metalFilter = selectedmetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

     if (selectedPaymentMethod.value != null && selectedPaymentMethod.value?.value != "0") {
      paymentMethoadFilter = selectedPaymentMethod.value?.value.toString();
    } else {
      paymentMethoadFilter = null;
    }

     if (selectedPaymentProvider.value != null && selectedPaymentProvider.value?.value != "0") {
      paymentProviderFilter = selectedPaymentProvider.value?.value.toString();
    } else {
      paymentProviderFilter = null;
    }


    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchOverallDailyReportPayload(
      page: page.value,
        fromDate:
          fromDateController.text.isEmpty ? null : fromDateController.text,
        metal: metalFilter,
        paymentMethod: paymentMethoadFilter,
        paymentProvider: paymentProviderFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportOverallDailyReport(payload, context);
    
    isExportLoading(false);
  }
}
