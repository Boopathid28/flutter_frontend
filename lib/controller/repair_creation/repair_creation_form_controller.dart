import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/repair_creation/repair_creation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairCreationFormController extends HeaderController {

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final newRepairFormKey = GlobalKey<FormState>();
  final newRepairItemFormKey = GlobalKey<FormState>();

  RxString formMode = 'create'.obs;
  RxString itemFormMode = 'create'.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isSubmitLoading = false.obs;

  Rx<Null> repairIndex = null.obs;

  RxList<RepairItemDetails> repairItemDetails = <RepairItemDetails>[].obs;

  TextEditingController repairSearchController = TextEditingController();
  TextEditingController itemSearchController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> itemsDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> repairTypesDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedCustomerDetails = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedRepairType = Rx<DropdownModel?>(null);

  @override
  void onInit()async {
    super.onInit();
    final bool branch =await getIsBranchUser();
    if(branch){

    getBranchList();
    }
    getCustomerList();
    getItemList();
    getrepairTypeList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    for (var item in tempList) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    }
  }

  Future getCustomerList() async {
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    customerDropDown([]);
    for (var item in tempList) {
      customerDropDown.add(
          DropdownModel(label:"${item.customerName!} (${item.mobileNumber})", value: item.id.toString()));
    }
  }

  Future getItemList() async {
    itemsDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    for (var item in tempList) {
      itemsDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.itemName.toString()));
    }
  }

  Future getrepairTypeList() async {
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    repairTypesDropDown([]);
    final List<RepairTypeDropDown> tempList =
        await DropdownService.repairTypeDropDown(menuId.toString());
    for (var item in tempList) {
      repairTypesDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.repairType.toString()));
    }
  }

  Future editRepairItem(int index) async {
    for (var i = 0; i < repairItemDetails.value.length; i++) {
      if (i == index) {
        repairItemDetails.value[i] = RepairItemDetails(
          grossWeight: double.parse(grossWeightController.text),
          itemDetails: int.parse(selectedItem.value!.value),
          pieces: int.parse(piecesController.text),
          repairType: int.parse(selectedRepairType.value!.value),
          remarks: remarksController.text,
        );

        // repairItemDetails.value[i].itemDetails=int.parse(selectedItem.value!.value);
        // repairItemDetails.value[i].grossWeight=double.parse(grossWeightController.text);
        // repairItemDetails.value[i].pieces=int.parse(piecesController.text);
        // repairItemDetails.value[i].repairType=int.parse(selectedRepairType.value!.value);
        // repairItemDetails.value[i].remarks=remarksController.text;
        break;
      }
    }
    repairItemDetails.refresh();
  }

  Future deleteRepairItem(int index) async {
    for (var i = 0; i < repairItemDetails.value.length; i++) {
      if (i == index) {
        repairItemDetails.value.removeAt(i);
        break;
      }
    }
    repairItemDetails.refresh();
  }

  Future addRepairItemsDetails() async {
    repairItemDetails.add(RepairItemDetails(
        grossWeight: double.parse(grossWeightController.text),
        itemDetails: int.parse(selectedItem.value!.value),
        pieces: int.parse(piecesController.text),
        repairType: int.parse(selectedRepairType.value!.value),
        remarks: remarksController.text));
  }

  Future submitRepairCreation(String? id) async {
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    if (formMode.value == 'create') {
      final payload = CreateRepairPayload(
          branch:isBranchuser.value? int.parse(selectedBranch.value!.value):null,
          customerDetails: int.parse(selectedCustomerDetails.value!.value),
          menuId: menuId,
          repairItemDetails: repairItemDetails);
      var response = await RepairCreationService.createRepair(payload);
      repairItemDetails([]);
    } else {
      var response =
          await RepairCreationService.deleteRepair(id!, menuId.toString());
    }
  }

  void resteItemForm() {
    itemFormMode('create');
    selectedItem.value = null;
    grossWeightController.clear();
    piecesController.clear();
    selectedRepairType.value = null;
    remarksController.clear();
  }

  void resetForm() {
    formMode('create');
    itemFormMode('create');
    isDeleteLoading(false);
    isSubmitLoading(false);
    branchSearchController.clear();
    selectedCustomerDetails.value = null;
    selectedBranch.value = null;
    repairIndex.value = null;
    selectedItem.value = null;
    grossWeightController.clear();
    piecesController.clear();
    selectedRepairType.value = null;
    remarksController.clear();
  }
}
