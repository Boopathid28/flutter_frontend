import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/stone_master/stone_master_model.dart';
import 'package:ausales_application/service/stone_master/stone_master_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StoneMasterListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
  RxObjectMixin<DropdownModel?> selectedReduceWeight = DropdownModel(value: 'Yes/No', label: 'Yes/No').obs;

  RxList<DropdownModel> activeStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Inactive', label: 'Inactive')].obs;

  RxList<DropdownModel> reduceWeightFilterList =
      [DropdownModel(value: 'Yes/No', label: 'Yes/No'), DropdownModel(value: 'Yes', label: 'Yes'), DropdownModel(value: 'No', label: 'No')].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<StoneMasterListData> tableData = <StoneMasterListData>[].obs;

  FutureOr getStoneMasterList(BuildContext context) async {
    isTableLoading(true);

    bool? isActiveFilter;
    bool? isReduecWgtFilter;

    if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Inactive") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }

    if (selectedReduceWeight.value!.value == "Yes") {
      isReduecWgtFilter = true;
    } else if (selectedReduceWeight.value!.value == "No") {
      isReduecWgtFilter = false;
    } else {
      isReduecWgtFilter = null;
    }

    FetchStoneMasterListPayload payload = FetchStoneMasterListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        activeStatus: isActiveFilter,
        reduceWeight: isReduecWgtFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? userList =
        await StoneMasterService.fetchStoneMasterList(payload: payload);

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
