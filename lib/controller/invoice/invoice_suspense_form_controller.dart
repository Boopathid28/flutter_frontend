import 'dart:developer';

import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class InvoiceSuspenseFormController extends GetxController {
  final InvoiceController _invoiceController =
      Get.put(InvoiceController());

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
  RxList<ItemDropdownModel> itemList = <ItemDropdownModel>[].obs;
  RxList<SubItemDropdownModel> subItemList = <SubItemDropdownModel>[].obs;

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
    itemList(tempList);

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
    subItemList(tempList);

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
        final InvoiceSuspenseItemDetails itemDetails = InvoiceSuspenseItemDetails(
            sNo: uuid.v4(),
            metalDetails: int.parse(selectedMetal.value!.value),
            metalName: selectedMetal.value!.label,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            metalAmount: double.parse(metalAmountController.text),
            metalWeight: double.parse(metalWeightController.text),
            totalAmount: double.parse(totalAmountController.text));

        _invoiceController.suspenseParticulars
            .insert(0, itemDetails);


        resetItemForm(context);
      } else {
        int index = _invoiceController.suspenseParticulars
            .indexWhere((item) => item.sNo == itemdetailFormUpdateId.value);
        final InvoiceSuspenseItemDetails itemDetails = InvoiceSuspenseItemDetails(
            sNo: itemdetailFormUpdateId.value,
            metalDetails: int.parse(selectedMetal.value!.value),
            metalName: selectedMetal.value!.label,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            metalAmount: double.parse(metalAmountController.text),
            metalWeight: double.parse(metalWeightController.text),
            totalAmount: double.parse(totalAmountController.text));
        _invoiceController.suspenseParticulars[index] = itemDetails;
        resetItemForm(context);
      }
    }
  }

  void editItem(BuildContext context, InvoiceSuspenseItemDetails item) {
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
    _invoiceController.suspenseParticulars
        .removeWhere((item) => item.sNo == index);
    Get.back();
  }

  void resetItemForm(BuildContext context) {
    metalAmountController.clear();
    metalWeightController.clear();
    totalAmountController.clear();
    selectedMetal.value = null;
    selectedItem.value = null;
    itemDropDown([]);
    itemdetailsFormMode('create');
    itemdetailFormUpdateId("");
  }
}
