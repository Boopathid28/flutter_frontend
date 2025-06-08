import 'dart:core';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/repair_type/repair_type_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/repair_type/repair_type_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RepairTypeController extends GetxController {
  final createFormKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();
  RxList<GetAllRepairTypes> tableData = <GetAllRepairTypes>[].obs;
  TextEditingController repairController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxObjectMixin<DropdownModel?> selectedActiveStatus =
      DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
  RxList<DropdownModel> activeStatusFilterList = [
    DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Inactive', label: 'Inactive')
  ].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString fromMode = "create".obs;
  RxBool isTableLoading = false.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isSubmitLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllRepairTypes();
  }

  Future getAllRepairTypes() async {
    isTableLoading(true);

    bool? isActiveFilter;

    if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Inactive") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = GetAllRepairTypesPayload(
        activeStatus: isActiveFilter,
        menuId: menuId,
        search: searchController.text);
    var response =
        await RepairTypeService.fetchAllRepairTypes(payload: payload);

    if (response != null) {
      tableData(response['data']);
      totalpages(response['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }

  Future submitRepairType(BuildContext context, int? id) async {
    final menuId = await HomeSharedPrefs.getCurrentMenu();

    if (fromMode.value == 'create') {
      if (createFormKey.currentState!.validate()) {
        final payload = CreateRepairTypePayload(
            menuId: menuId, repairType: repairController.text);
        await RepairTypeService.createRepairType(payload, context);
        Get.back();
        await getAllRepairTypes();
      }
    } else if (fromMode.value == 'update') {
      if (updateFormKey.currentState!.validate()) {
        final payload = UpdateRepairTypePayload(
            id: id, menuId: menuId, repairType: repairController.text);
        await RepairTypeService.updateRepairType(payload, context);
        Get.back();
        await getAllRepairTypes();
      }
    } else {
      await RepairTypeService.deleteRepairType(
        context,
        id: id.toString(),
        menuId: menuId.toString(),
      );
      Get.back();
      await getAllRepairTypes();
    }
  }

  Future changeRepairTypeStatus(BuildContext context, String id) async {
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await RepairTypeService.changeRepairTypeStatus(context,
        id: id, menuId: menuId.toString());

    await getAllRepairTypes();
  }

  void resetForm() {
    repairController.clear();
    fromMode('create');
    isSubmitLoading(false);
    // searchController.clear();
  }
}
