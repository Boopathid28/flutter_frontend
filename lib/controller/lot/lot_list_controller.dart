import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/lot/lot_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LotListController extends HeaderController {

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController searchController = TextEditingController();
  TextEditingController entryDateRangeController = TextEditingController();
  TextEditingController designerController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedEntryType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedDesigner = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedLotStatus = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> entryTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> designerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> lotStatusDropDown = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<LotListData> tableData = <LotListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBranchList();
    getIsBranchUser();
    getEntryTypeList();
    getDesignerList();
    getLotStatusList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      branchDropDown
          .add(DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }

  Future getEntryTypeList() async {
    entryTypeDropDown([]);
    final List<EntryTypeDropdownModel> tempList =
        await DropdownService.entryTypeDropDown();
    entryTypeDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      entryTypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedEntryType(DropdownModel(value: "0", label: "All"));
  }

  Future getDesignerList() async {
    designerDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    designerDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      designerDropDown
          .add(DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
    selectedDesigner(DropdownModel(value: "0", label: "All"));
  }

  Future getLotStatusList() async {
    lotStatusDropDown([]);
    final List<LotStatusDropdownModel> tempList =
        await DropdownService.lotStatusDropDown();
    lotStatusDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      lotStatusDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedLotStatus(DropdownModel(value: "0", label: "All"));
  }
  
  Future getLotList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? designerFilter;
    String? entryTypeFilter;
    String? lotStatusFilter;
    String? fromDate;
    String? toDate;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (entryDateRangeController.text.isNotEmpty) {
      fromDate = entryDateRangeController.text.split(' to ')[0];
      toDate = entryDateRangeController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    if (selectedEntryType.value != null && selectedEntryType.value?.value != "0") {
      entryTypeFilter = selectedEntryType.value?.value.toString();
    } else {
      entryTypeFilter = null;
    }

    if (selectedDesigner.value != null && selectedDesigner.value?.value != "0") {
      designerFilter = selectedDesigner.value?.value.toString();
    } else {
      designerFilter = null;
    }

    if (selectedLotStatus.value != null && selectedLotStatus.value?.value != "0") {
      lotStatusFilter = selectedLotStatus.value?.value.toString();
    } else {
      lotStatusFilter = null;
    }
    
    FetchLotListPayload payload = FetchLotListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        entryDateFromRange: fromDate,
        entryDateToRange: toDate,
        entryType: entryTypeFilter,
        designer: designerFilter,
        lotStatus: lotStatusFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? lotList =
        await LotService.fetchLotList(payload: payload);

    if (lotList != null) {

      tableData(lotList['data']);
      totalpages(lotList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}