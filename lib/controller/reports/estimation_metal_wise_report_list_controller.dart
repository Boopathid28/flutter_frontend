import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/estimation_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimationMetalWiseReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchMetalController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedmetal = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;
  RxString totalAmount = "0".obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<EstimationMetalWiseReportListData> tableData =
      <EstimationMetalWiseReportListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getMetalList();
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

 
  Future getestimationmetalwisereport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? metalFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedmetal.value != null && selectedmetal.value?.value != "0") {
      metalFilter = selectedmetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchEstimationMetalWiseReportListPayload payload =
        FetchEstimationMetalWiseReportListPayload (
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            metal: metalFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? estimationmetalwisereportList =
        await ReportsServices
            .fetchEstimationMetalWiseReport(payload: payload);

    if (estimationmetalwisereportList != null) {
 tableData(estimationmetalwisereportList['list']);
    totalpages(estimationmetalwisereportList['data']['total_pages']);
      totalPieces(estimationmetalwisereportList['data']['total_pieces'].toString());
      totalGrossWeight(estimationmetalwisereportList['data']['total_gross_weight'].toString());
      totalNetWeight(estimationmetalwisereportList['data']['total_net_weight'].toString());
      totalAmount(estimationmetalwisereportList['data']['total_amount'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalPieces("0");
      totalGrossWeight("0");
      totalNetWeight("0");
      totalAmount("0");
    }

    isTableLoading(false);
  }




   Future exportData(BuildContext context) async {
    isExportLoading(true);

   
    String? branchFilter;
    String? metalFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedmetal.value != null && selectedmetal.value?.value != "0") {
      metalFilter = selectedmetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchEstimationMetalWiseReportListPayload(
        page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            metal: metalFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportEstimationMetalwiseReport(payload, context);
    
    isExportLoading(false);
  }
}
