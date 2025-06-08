import 'dart:async';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/counter/counter_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CounterListController extends HeaderController {

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
    TextEditingController branchSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
    Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> activeStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Inactive', label: 'Inactive')].obs;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<CounterListData> tableData = <CounterListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBranchList();
    getIsBranchUser();
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

  Future getcounterList(BuildContext context) async {
    isTableLoading(true);

    bool? isActiveFilter;
        String? branchFilter;

    if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Inactive") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }

       if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }


    FetchCounterListPayload payload = FetchCounterListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        activeStatus: isActiveFilter,
        branch: branchFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? counterList =
        await CounterService.fetchCounterList(payload: payload);

    if (counterList != null) {

      tableData(counterList['data']);
      totalpages(counterList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
