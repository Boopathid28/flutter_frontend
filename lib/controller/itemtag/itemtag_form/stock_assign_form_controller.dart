import 'dart:developer';

import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_assign_models.dart';
import 'package:ausales_application/model/stock_assign/stock_assign_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/stock_assign/stock_assign_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockAssignFormListController extends GetxController {
  final stockassignDetailsFormKey = GlobalKey<FormState>();

  RxList<String> currenttagnumber = <String>[].obs;

  RxList<DropdownModel> catalogDropdown = <DropdownModel>[].obs;
  RxList<DropdownModel> catalogTypeDropDown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedCatalog = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCatalogType = Rx<DropdownModel?>(null);

  RxList<OrderItemDetails> orderItem = <OrderItemDetails>[].obs;
  RxString vendorassignFormMode = "create".obs;
  RxString vendorFormUpdateId = "".obs;

  RxList id = [].obs;

  RxBool isFormSubmit = false.obs;
  RxBool isForm = false.obs;
  RxBool isIcon = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCatalogTypeList();
  }

  Future getCatalogTypeList() async {
    catalogTypeDropDown([]);
    final List<CatalogTypeDropdownModel> tempList =
        await DropdownService.catalogTypeDropDown();
    tempList.forEach((item) {
      catalogTypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getCatalogdropdownList(String? catalogType) async {
    selectedCatalog.value = null;
    catalogDropdown([]);
    final List<CatalogDropdownModel> tempList =
        await DropdownService.catalogDropDown(catalogType: catalogType);
    tempList.forEach((item) {
      catalogDropdown.add(
          DropdownModel(label: item.catalogNumber!, value: item.id.toString()));
    });
  }

  Future submitStockAssignForm(BuildContext context) async {
    if (stockassignDetailsFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        final CreateStockAssignPayload createStockAssignPayload =
            CreateStockAssignPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                catalogDetails: selectedCatalog.value!.value,
                tagDetails: currenttagnumber);

        final data = await StockAssignService.createStockList(
            payload: createStockAssignPayload, context: context);

        resetForm();
        Get.back();
      }
    }
  }

  resetForm() {
    isFormSubmit(false);
    selectedCatalog.value = null;
    selectedCatalogType.value = null;
    currenttagnumber([]);
  }
}
