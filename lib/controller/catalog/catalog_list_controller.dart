import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/catalog/catalog_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/catalog/catalog_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogListController extends GetxController {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  TextEditingController searchCounterController = TextEditingController();
  TextEditingController searchFloorController = TextEditingController();

  Rx<DropdownModel?> selectedCounter = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFloor = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
  Rx<DropdownModel?> selectedCatalogType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> activeStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Inactive', label: 'Inactive')].obs;


  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<CatalogListData> tableData = <CatalogListData>[].obs;

  RxList<DropdownModel> counterDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> floorDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> catalogTypeDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCounterList();
    getFloorList();
    getCatalogTypeList();
  }

  Future getCounterList() async {
    counterDropDown([]);
    final List<CounterDropdownModel> tempList =
        await DropdownService.counterDropDown();
    counterDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      counterDropDown.add(
          DropdownModel(label: item.counterName!, value: item.id.toString()));
    });
    selectedCounter(DropdownModel(value: "0", label: "All"));
  }


  Future getFloorList() async {
    floorDropDown([]);
    final List<FloorDropdownModel> tempList =
        await DropdownService.floorDropdown();
    floorDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      floorDropDown.add(
          DropdownModel(label: item.floorName!, value: item.id.toString()));
    });
    selectedFloor(DropdownModel(value: "0", label: "All"));
  }

  Future getCatalogTypeList() async {
    catalogTypeDropDown([]);
    final List<CatalogTypeDropdownModel> tempList =
        await DropdownService.catalogTypeDropDown();
    catalogTypeDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      catalogTypeDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedCatalogType(DropdownModel(value: "0", label: "All"));
  }


  Future getCatalogList(BuildContext context) async {
    isTableLoading(true);
      String? floorFilter;
      String? counterFilter;

  if (selectedCounter.value != null && selectedCounter.value?.value != "0") {
      counterFilter = selectedCounter.value?.value.toString();
    } else {
      counterFilter = null;
    }

      if (selectedFloor.value != null && selectedFloor.value?.value != "0") {
      floorFilter = selectedFloor.value?.value.toString();
    } else {
      floorFilter = null;
    }

    FetchCatalogListPayload payload = FetchCatalogListPayload(
        search: searchController.text,
        page: page.value,
        counter: counterFilter,
        floor: floorFilter,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? cataloglist =
        await CatalogService.fetchCatalogList(payload: payload);

    if (cataloglist != null) {

      tableData(cataloglist['data']);
      totalpages(cataloglist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
