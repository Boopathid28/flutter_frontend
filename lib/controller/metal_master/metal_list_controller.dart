import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/metal_master/metal_models.dart';
import 'package:ausales_application/service/metal_master/metal_service.dart';
import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MetalListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;

  RxList<DropdownModel> activeStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Inactive', label: 'Inactive')].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<MetalListData> tableData = <MetalListData>[].obs;

  Future getMetalList(BuildContext context) async {
    bool? isActiveFilter;
    isTableLoading(true);
    

    if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Inactive") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }
    FetchMetalListPayload payload = FetchMetalListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        activeStatus: isActiveFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? userList =
        await MetalService.fetchMetalList(payload: payload);

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
