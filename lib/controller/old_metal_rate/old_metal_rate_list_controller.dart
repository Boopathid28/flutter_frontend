import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/old_metal_rate/old_metal_rate_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/old_metal_rate/old_metal_rate_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OldMetalRateListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchMetalController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedMetalTypeFilter =
      DropdownModel(value: '0', label: 'All').obs;

  RxList<DropdownModel> oldMetalDropDown = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<OldMetalRateListData> tableData = <OldMetalRateListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  Future getMetalList() async {
    oldMetalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    oldMetalDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      oldMetalDropDown.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
    }
    selectedMetalTypeFilter(DropdownModel(value: "0", label: "All"));
  }

  Future getOldMetalRateList(BuildContext context) async {
    isTableLoading(true);

    String? metalFilter;

    if (selectedMetalTypeFilter.value!.value == "Gold") {
      metalFilter = '1';
    } else if (selectedMetalTypeFilter.value!.value == "Silver") {
      metalFilter = '2';
    } else if (selectedMetalTypeFilter.value!.value == "Diamond") {
      metalFilter = '3';
    } else {}
    if (selectedMetalTypeFilter.value != null &&
        selectedMetalTypeFilter.value?.value != "0") {
      metalFilter = selectedMetalTypeFilter.value?.value.toString();
    } else {
      metalFilter = null;
    }

    FetchOldMetalRatePayload payload = FetchOldMetalRatePayload(
        metal: metalFilter,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? oldMetalRateList =
        await OldMetalRateService.fetchOldMetalRateList(payload: payload);

    if (oldMetalRateList != null) {
      tableData(oldMetalRateList['data']);
      totalpages(oldMetalRateList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
