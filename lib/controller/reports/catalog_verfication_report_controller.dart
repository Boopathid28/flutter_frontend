import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/catalog_verification_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogVerficationReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchcatalogverificationController =
      TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedcatalogverification = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> catalogverificationFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;
  RxString totalBalanceWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<CatalogVerificationReportListData> tableData =
      <CatalogVerificationReportListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getCatalogverificationList();
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

  Future getCatalogverificationList() async {
    catalogverificationFilterList([]);
    final List<CatalogVerificationTypeDropdown> templist =
        await DropdownService.catalogverificationTypeDropDown();
    catalogverificationFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      catalogverificationFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
    selectedcatalogverification(DropdownModel(value: "0", label: "All"));
  }

  Future getcatalogverificationListreport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? catalogFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedcatalogverification.value != null &&
        selectedcatalogverification.value?.value != "0") {
      catalogFilter = selectedcatalogverification.value?.value.toString();
    } else {
      catalogFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchCatalogVerificationReportListPayload payload =
        FetchCatalogVerificationReportListPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            catalogType: catalogFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    var response =
        await ReportsServices.fetchCatalogVerificationReport(payload);
    if (response != null) {
      log("response$response");
      tableData(response['list']);
      totalpages(response['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  // void onbalanceChange(String value, String? id) {

  //   final double weight =
  //       double.parse(value.isEmpty ? "0.0" : value);
  //   for (var i in tableData.value) {

  //     if(i.id.toString() == id) {

  //       log("Id${i.id} Idsdd$id");
  //       final balanceweight = num.parse(i.totalWeight!) - weight ;
  //       totalBalanceWeight(balanceweight.toString());
  //     }
  //   }
  //   log("totalBalanceWeight${totalBalanceWeight}");
  // }

 void onBalanceChange(String? value, String? id) {
  int itemIndex = tableData.indexWhere((item) => item.id.toString() == id);

  var dataList = [...tableData.value];
  
  CatalogVerificationReportListData item = dataList[itemIndex];

  var jsonObjectItem = item.toJson();

  double balanceWeightValue = (value == null || value.isEmpty) 
      ? 0.0 
      : double.tryParse(value) ?? 0.0;

 balanceWeightValue = (num.parse(item.totalWeight!) - balanceWeightValue ).abs();

  jsonObjectItem['balance_weight'] = balanceWeightValue;

  CatalogVerificationReportListData updatedItem =
      CatalogVerificationReportListData.fromJson(jsonObjectItem);

  tableData[itemIndex] = updatedItem;
}




Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? branchFilter;
    String? catalogFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedcatalogverification.value != null &&
        selectedcatalogverification.value?.value != "0") {
      catalogFilter = selectedcatalogverification.value?.value.toString();
    } else {
      catalogFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchCatalogVerificationReportListPayload(
       page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            catalogType: catalogFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu()
    );
    var response =
        await ExportReportService.exportCataglogverficationReport(payload, context);
    
    isExportLoading(false);
  }

}
