import 'dart:math';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/purification/purification_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/purification/purification_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/purification/purification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurificationFormController extends HeaderController {
  final PurificationListController _purificationListController =
      Get.put(PurificationListController());
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final purificationFormKey = GlobalKey<FormState>();

  TextEditingController searchVendorDesignerController =
      TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController meltingSearchController = TextEditingController();
  TextEditingController metalSearchController = TextEditingController();

  TextEditingController issuedweightController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController duedateController = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> meltingDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> vendordesignerdropdown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMelting = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedvendorDesiner = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxList<MeltingDropDownModel> meltingList = <MeltingDropDownModel>[].obs;

  @override
  void onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getVendorDesignerList();
    getMetalList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getVendorDesignerList() async {
    vendordesignerdropdown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      vendordesignerdropdown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    tempList.forEach((item) {
      metalDropDown.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
  }

  Future getMeltingList(String? branch, String? metal) async {
    meltingList([]);
    selectedMelting.value = null;
    meltingDropDown([]);
    final List<MeltingDropDownModel> tempList =
        await DropdownService.meltingDropDown(branch, metal);
    meltingList(tempList);
    tempList.forEach((item) {
      meltingDropDown.add(
          DropdownModel(label: item.meltingId.toString(), value: item.id.toString()));
    });
  }

  Future CreatePurification(BuildContext context) async {
    if (purificationFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        CreatePurificationPayload payload = CreatePurificationPayload(
            vendorDetails: selectedvendorDesiner.value?.value,
            branch: selectedBranch.value?.value,
            meltingDetails: selectedMelting.value?.value,
            metalDetails: selectedMetal.value?.value,
            issuedWeight: double.parse(issuedweightController.text),
            dueDate:
                duedateController.text.isEmpty ? null : duedateController.text,
            remark: remarkController.text,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final Map<String, dynamic>? CreatePurification =
            await PurificationService.createPurification(
                payload: payload, context: context);
        _purificationListController.getPurificationList(context);
        resetForm();
        Get.back();
        isFormSubmit(false);
      }
    }
  }

  resetForm() {
    selectedBranch.value = null;
    selectedMetal.value = null;
    issuedweightController.clear();
    duedateController.clear();
    remarkController.clear();
    selectedvendorDesiner.value = null;
    meltingList([]);
    selectedMelting.value = null;
    meltingDropDown([]);
  }
}
