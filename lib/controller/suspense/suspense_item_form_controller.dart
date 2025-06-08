import 'dart:developer';

import 'package:ausales_application/controller/suspense/suspense_form_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SuspenseItemFormController extends GetxController {
  final SuspenseFormController _suspenseFormController =
      Get.put(SuspenseFormController());

  final itemDetailsFormKey = GlobalKey<FormState>();

  TextEditingController metalSearchController = TextEditingController();
  TextEditingController itemSearchController = TextEditingController();
  TextEditingController subItemSearchController = TextEditingController();

  TextEditingController metalWeightController = TextEditingController();
  TextEditingController metalAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subItemDropDown = <DropdownModel>[].obs;

  RxList<MetalDropdownModel> metalList = <MetalDropdownModel>[].obs;

  RxString itemdetailsFormMode = "create".obs;
  RxString itemdetailFormUpdateId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    metalList(tempList);

    tempList.forEach((item) {
      metalDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.metalName.toString()));
    });
  }

  Future getItemList(String? metal, DropdownModel? selected) async {
    itemDropDown([]);
    selectedItem.value = null;
    selectedSubItem.value = null;
    subItemDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown(metal: metal);
    tempList.forEach((item) {
      itemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.itemName.toString()));
    });

    if (selected != null && tempList.isNotEmpty) {
      selectedItem(selected);
    }
  }

  Future getSubItemList(String? metal, String? item, DropdownModel? selected) async {
    subItemDropDown([]);
    selectedSubItem.value = null;
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(metal: metal, item: item);
    tempList.forEach((item) {
      subItemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.subItemName.toString()));
    });

    if (selected != null && tempList.isNotEmpty) {
      selectedSubItem(selected);
    }
  }

  void calculateTotalAmount(
      {required String metalweight, required String metalAmount}) {
    final double metalWeight =
        double.parse(metalweight.isEmpty ? "0.0" : metalweight);
    final double metalamount =
        double.parse(metalAmount.isEmpty ? "0.0" : metalAmount);

    final totalamount = metalWeight * metalamount;

    totalAmountController.text = totalamount.toString();
  }

  Future submitItemdetailsForm(BuildContext context) async {
    if (itemDetailsFormKey.currentState!.validate()) {
      if (itemdetailsFormMode.value == 'create') {
        var uuid = Uuid();
        final ItemDetails itemDetails = ItemDetails(
            sNo: uuid.v4(),
            metalDetails: int.parse(selectedMetal.value!.value),
            metalName: selectedMetal.value!.label,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            metalAmount: int.parse(metalAmountController.text),
            metalWeight: int.parse(metalWeightController.text),
            totalAmount: double.parse(totalAmountController.text));

        _suspenseFormController.itemdetailsParticularList
            .insert(0, itemDetails);

        resetItemForm(context);
      } else {
        int index = _suspenseFormController.itemdetailsParticularList
            .indexWhere((item) => item.sNo == itemdetailFormUpdateId.value);
        final ItemDetails itemDetails = ItemDetails(
            sNo: itemdetailFormUpdateId.value,
            metalDetails: int.parse(selectedMetal.value!.value),
            metalName: selectedMetal.value!.label,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            metalAmount: int.parse(metalAmountController.text),
            metalWeight: int.parse(metalWeightController.text),
            totalAmount: double.parse(totalAmountController.text));
        _suspenseFormController.itemdetailsParticularList[index] = itemDetails;
        resetItemForm(context);
      }
    }
  }

  void editItem(BuildContext context, ItemDetails item) {
    metalAmountController.text = item.metalAmount!.toString();
    metalWeightController.text = item.metalWeight!.toString();
    totalAmountController.text = item.totalAmount!.toString();
    selectedMetal(DropdownModel(
        value: item.metalDetails.toString(), label: item.metalName.toString()));
    itemdetailsFormMode('update');
    itemdetailFormUpdateId(item.sNo);
    getItemList(item.metalDetails.toString(), DropdownModel(
        value: item.itemDetails.toString(), label: item.itemDetailsName.toString()));

    getSubItemList(item.metalDetails.toString(), item.itemDetails, DropdownModel(
        value: item.subItemDetails.toString(), label: item.subItemDetailsName.toString()));
  }

  void deleteItem(BuildContext context, String index) {
    _suspenseFormController.itemdetailsParticularList
        .removeWhere((item) => item.sNo == index);
    Get.back();
  }

  void resetItemForm(BuildContext context) {
    metalAmountController.clear();
    metalWeightController.clear();
    totalAmountController.clear();
    selectedMetal.value = null;
    itemdetailsFormMode('create');
    itemdetailFormUpdateId("");
    selectedItem.value =null;
    selectedSubItem.value =null;

    itemDropDown([]);
    subItemDropDown([]);
  }

  // void stoneAddCompleted(BuildContext context) {
  //   int pieces = 0;
  //   double weight = 0;
  //   double amount = 0;

  //   double reduceWeight = 0.0;

  //   for (var i in _itemtagFormController.stoneParticularList) {

  //     if (i.reduceWeight!) {
  //       reduceWeight = double.parse((weight + double.parse(i.stoneWeight??"0.0")).toString());
  //     }
  //     pieces = int.parse((pieces + int.parse(i.stonePieces??"0")).toString());
  //     weight = double.parse((weight + double.parse(i.stoneWeight??"0.0")).toString());
  //     amount = double.parse((amount + double.parse(i.stoneAmount??"0.0")).toString());
  //   }

  //   _itemtagFormController.totalStonePieces(pieces);
  //   _itemtagFormController.totalStoneAmount(amount);
  //   _itemtagFormController.stoneWeightController.text = weight.toString();

  //   _itemtagFormController.reduceStoneWeight(reduceWeight);

  //   _itemtagFormController.calcNetWeight(grossWeight: _itemtagFormController.grossWeightController.text, reduceWeight: _itemtagFormController.reduceWeightController.text,
  //   reduceStone: reduceWeight, reduceDiamond: _itemtagFormController.reduceDiamondWeight.value);

  //   Get.back();
  // }
}
