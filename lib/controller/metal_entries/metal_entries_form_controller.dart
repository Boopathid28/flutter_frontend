import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/metal_entries/metal_entries_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/metal_entries/metal_entries_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/metal_entries/metal_entries_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MetalEntriesFormController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final MetalEntriesListController _metalEntriesListController = Get.put(MetalEntriesListController());

  final metalEntriesFormKey = GlobalKey<FormState>();

  TextEditingController touchController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  TextEditingController searchBranchController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }
    getMetalList();
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    tempList.forEach((item) {
      metalDropDown
          .add(DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    tempList.forEach((item) {
      branchDropDown
          .add(DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future submitMetalEntriesForm(BuildContext context) async {
    if (metalEntriesFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateMetalEntriesPayload payload = CreateMetalEntriesPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              metalDetails: selectedMetal.value?.value,
              branch: isBranchuser.value ? selectedBranch.value?.value : null,
              touch: double.parse(touchController.text.isEmpty ? "0" : touchController.text),
              weight: double.parse(weightController.text.isEmpty ? "0" : weightController.text),);

          await MetalEntriesService.createMetalEntry(context: context, payload: payload);
          _metalEntriesListController.getMetalEntriesList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    metalEntriesFormKey.currentState!.reset();
    selectedMetal.value = null;
    if (isBranchuser.value) {
      selectedBranch.value = null;
    }
    fromMode("create");
  }
}
