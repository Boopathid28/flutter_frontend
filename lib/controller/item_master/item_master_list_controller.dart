import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_master/item_master_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/item_master/item_master_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ItemMasterListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController metalSearchFilterController = TextEditingController();
  TextEditingController puritySearchFilterController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);

  RxList<DropdownModel> activeStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Inactive', label: 'Inactive')].obs;
  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> purityFilterList = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<ItemListData> tableData = <ItemListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
    getPurityList();
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

  Future getPurityList() async {
    purityFilterList([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    purityFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      purityFilterList
          .add(DropdownModel(label: item.purityName!, value: item.id.toString()));
    });
    selectedPurity(DropdownModel(value: "0", label: "All"));
  }

  FutureOr getItemList(BuildContext context) async {
    isTableLoading(true);

    bool? isActiveFilter;
    String? metalFilter;
    String? purityFilter;

    if (selectedActiveStatus.value == "Active") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value == "Inactive") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }

    if (selectedMetal.value != null && selectedMetal.value?.value != "0") {
      metalFilter = selectedMetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (selectedPurity.value != null && selectedPurity.value?.value != "0") {
      purityFilter = selectedPurity.value?.value.toString();
    } else {
      purityFilter = null;
    }

    FetchItemListPayload payload = FetchItemListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        activeStatus: isActiveFilter,
        metal: metalFilter,
        purity: purityFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? itemList =
        await ProductItemService.fetchItemList(payload: payload);

    if (itemList != null) {
      tableData(itemList['data']);
      totalpages(itemList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }
}
