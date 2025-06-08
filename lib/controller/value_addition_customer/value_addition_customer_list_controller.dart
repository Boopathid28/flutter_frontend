import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/value_addition_customer/value_addition_customer_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/value_addition_customer/value_addition_customer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueAdditionCustomerListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController customerSearchFilterController =
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

  RxList<ValueAdditionCustomerData> tableData =
      <ValueAdditionCustomerData>[].obs;

  get context => null;

  get tableDataList => null;

  @override
  void onInit() {
    super.onInit();
    getSubItemList();
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

  Future getValueAdditionCustomerlist(BuildContext context) async {
    isTableLoading(true);
    String? subitemfilter;

    if (selectedSubitem.value != null && selectedSubitem.value?.value != "0") {
      subitemfilter = selectedSubitem.value?.value.toString();
    } else {
      subitemfilter = null;
    }

    FetchValueAdditionCustomerListPayload payload =
        FetchValueAdditionCustomerListPayload(
            subItem: subitemfilter,
            page: page.value,
            itemsPerPage: itemsPerPage.value,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? valueadditioncustomer =
        await ValueAdditionCustomerService.fetchValueAdditionCustomerList(
            payload: payload);

    if (valueadditioncustomer != null) {
      tableData(valueadditioncustomer['data']);
      totalpages(valueadditioncustomer['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  
}
