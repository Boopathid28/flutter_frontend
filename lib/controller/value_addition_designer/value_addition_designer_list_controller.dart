import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/value_addition_designer/value_addition_designer_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/value_addition_designer/value_addition_designer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueAdditionDesignerListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController designerSearchFilterController =
      TextEditingController();
  TextEditingController subitemSearchFilterController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  Rx<DropdownModel?> selectedDesigner = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubitem = Rx<DropdownModel?>(null);

  RxList<DropdownModel> designerFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> subitemFilterList = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<ValueAdditionListData> tableData = <ValueAdditionListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDesignerList();
    getSubItemList();
  }

  Future getDesignerList() async {
    designerFilterList([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    designerFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      designerFilterList.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
    selectedDesigner(DropdownModel(value: "0", label: "All"));
  }

  Future getSubItemList() async {
    subitemFilterList([]);
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: null);
    subitemFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      subitemFilterList.add(
          DropdownModel(label: item.subItemName!, value: item.id.toString()));
    });
    selectedSubitem(DropdownModel(value: "0", label: "All"));
  }

  Future getValueAdditionDesignerlist(BuildContext context) async {
    isTableLoading(true);
    String? designerfilter;
    String? subitemfilter;

    if (selectedDesigner.value != null &&
        selectedDesigner.value?.value != "0") {
      designerfilter = selectedDesigner.value?.value.toString();
    } else {
      designerfilter = null;
    }

    if (selectedSubitem.value != null && selectedSubitem.value?.value != "0") {
      subitemfilter = selectedSubitem.value?.value.toString();
    } else {
      subitemfilter = null;
    }

    FetchValueAdditionListPayload payload = FetchValueAdditionListPayload(
        designer: designerfilter,
        subItem: subitemfilter,
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? valueadditionList =
        await ValueAdditionDesignerService.fetchValueAdditionDesignerList(
            payload: payload);

    if (valueadditionList != null) {
      tableData(valueadditionList['data']);
      totalpages(valueadditionList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
