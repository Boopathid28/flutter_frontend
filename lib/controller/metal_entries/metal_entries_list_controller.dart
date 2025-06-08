import 'dart:async';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/metal_entries/metal_entries_model.dart';
import 'package:ausales_application/model/purity_master/purity_master_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/metal_entries/metal_entries_service.dart';
import 'package:ausales_application/service/purity_master/purity_master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MetalEntriesListController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();
  TextEditingController metalSearchFilterController = TextEditingController();
  TextEditingController branchSearchFilterController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<MetalEntriesListData> tableData = <MetalEntriesListData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool value = await getIsBranchUser();
    if (value == true) {
      getBranchList();
    }
    getMetalList();
  }

  Future getBranchList() async {
    branchFilterList([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      branchFilterList
          .add(DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }

  Future getMetalList() async {
    metalFilterList([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    metalFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      metalFilterList
          .add(DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
    selectedMetal(DropdownModel(value: "0", label: "All"));
  }

  FutureOr getMetalEntriesList(BuildContext context) async {
    isTableLoading(true);

    String? metalFilter;
    String? branchFilter;

    if (selectedMetal.value != null && selectedMetal.value?.value != "0") {
      metalFilter = selectedMetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    FetchMetalEntriesPayload payload = FetchMetalEntriesPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        metal: metalFilter,
        branch: isBranchuser.value ? branchFilter : null,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? userList =
        await MetalEntriesService.fetchMetalEntriesList(payload: payload);

    if (userList != null) {

      tableData(userList['data']);
      totalpages(userList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }
}
