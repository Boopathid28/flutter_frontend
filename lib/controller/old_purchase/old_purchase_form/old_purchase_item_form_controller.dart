import 'dart:async';
import 'dart:math';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OldPurchaseItemFormController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final oldPurchaseItemFormDetailsFormKey = GlobalKey<FormState>();

  TextEditingController touchWeightController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController purityPercentController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController metalRateController = TextEditingController();
  TextEditingController dustWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController oldAmountController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

  TextEditingController metalSearchController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedGstType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;

  RxList<OldMetalDropdownModel> metalList = <OldMetalDropdownModel>[].obs;

  RxList<OldItemDetails> particulars = <OldItemDetails>[].obs;

  RxBool isDeleteLoading = false.obs;

  RxString updatingItem = "".obs;
  RxString itemFormMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<OldMetalDropdownModel> tempList =
        await DropdownService.oldMetalDropDown();
    metalList(tempList);
    tempList.forEach((item) {
      metalDropDown.add(DropdownModel(
          label: item.metalDetailsName!, value: item.id.toString()));
    });
  }

  void onMetalChange(DropdownModel metal) {
    selectedMetal(metal);
    metalRateController.clear();
    for (var i in metalList) {
      if (i.id.toString() == metal.value) {
        metalRateController.text = i.oldRate.toString();
        break;
      }
    }
    if (selectedMetal.value != null) {
      calculateTotalAmount(
        dustWeight: dustWeightController.text.isEmpty
            ? "0.0"
            : dustWeightController.text,
        metal: metal.value,
        // gstType: selectedGstType.value!.value,
        oldRate:
            oldAmountController.text.isEmpty ? "0" : oldAmountController.text,
        metalRate:
            metalRateController.text.isEmpty ? "0" : metalRateController.text,
        metalWeight: grossWeightController.text.isEmpty
            ? "0"
            : grossWeightController.text,
      );
    }
  }

  void calculateTotalAmount({
    required String oldRate,
    required String metalRate,
    required String metalWeight,
    // required String gstType,
    required String metal,
    required String dustWeight,
  }) {
    final double oldMetalRate = double.parse(oldRate.isEmpty ? "0.0" : oldRate);
    final double oldMetalAmount =
        double.parse(metalRate.isEmpty ? "0.0" : metalRate);
    final double grossWeight =
        double.parse(metalWeight.isEmpty ? "0.0" : metalWeight);
    final double dustweight =
        double.parse(dustWeight.isEmpty ? "0.0" : dustWeight);


    final netWeight = grossWeight - dustweight;

    final predictTotal = oldMetalAmount * netWeight;

    var gstAmount = 0.0;
    // if (gstType == interGstType) {
    //   for (var i in metalList) {
    //     if (i.id.toString() == metal) {
    //       gstAmount = predictTotal * (double.parse(i.interGst ?? "0") / 100);
    //       log(gstAmount);
    //       break;
    //     }
    //   }
    // } else if (gstType == intraGstType) {
    //   for (var i in metalList) {
    //     if (i.id.toString() == metal) {
    //       gstAmount = predictTotal * (double.parse(i.intraGst ?? "0") / 100);
    //       break;
    //     }
    //   }
    // }

    gstAmountController.text = gstAmount.toStringAsFixed(3);
    totalAmountController.text = (predictTotal + gstAmount).toStringAsFixed(2);
    netWeightController.text =
        netWeight.isNaN ? "0" : netWeight.toStringAsFixed(3);
  }

  editItem(OldItemDetails item) {
    itemFormMode("update");
    selectedMetal(DropdownModel(
        value: item.oldMetal.toString(), label: item.oldMetalName!));
    updatingItem(item.id);
    grossWeightController.text = item.oldWeight!.toStringAsFixed(3);
    itemNameController.text = item.oldItemName.toString();
    purityPercentController.text = item.purityPercent.toString();
    metalRateController.text = item.oldRate!.toStringAsFixed(2);
    dustWeightController.text = item.oldDustWeight!.toStringAsFixed(3);
    gstAmountController.text = item.gstAmount!.toStringAsFixed(3);
    netWeightController.text = item.oldNetWeight!.toStringAsFixed(3);
    totalAmountController.text = item.totalAmount!.toStringAsFixed(2);
  }

  deleteItem(OldItemDetails oldItem) {
    particulars.removeWhere((item) => item.id == oldItem.id);
  }

  Future submitForm(BuildContext context) async {
    if (oldPurchaseItemFormDetailsFormKey.currentState!.validate()) {
      if (itemFormMode.value == "create") {
        var uuid = Uuid();
        OldItemDetails oldItemDetails = OldItemDetails(
          id: uuid.v4(),
          oldMetal: selectedMetal.value?.value,
          oldMetalName: selectedMetal.value?.label,
          oldWeight: double.parse(grossWeightController.text),
          oldItemName: itemNameController.text,
          purityPercent: purityPercentController.text,
          oldRate: double.parse(metalRateController.text),
          grossWeight: double.parse(grossWeightController.text),
          oldDustWeight: double.parse(dustWeightController.text),
          oldNetWeight: double.parse(netWeightController.text),
          gstAmount: double.parse(gstAmountController.text),
          totalAmount: double.parse(totalAmountController.text),
        );
        particulars.insert(0, oldItemDetails);
      } else {
        int index =
            particulars.indexWhere((item) => item.id == updatingItem.value);

        OldItemDetails oldItemDetails = OldItemDetails(
          id: updatingItem.value,
          oldMetal: selectedMetal.value?.value,
          oldMetalName: selectedMetal.value?.label,
          oldWeight: double.parse(grossWeightController.text),
          oldItemName: itemNameController.text,
          oldRate: double.parse(metalRateController.text),
          purityPercent: purityPercentController.text,
          oldDustWeight: double.parse(dustWeightController.text),
          oldNetWeight: double.parse(netWeightController.text),
          grossWeight: double.parse(grossWeightController.text),
          gstAmount: double.parse(gstAmountController.text),
          totalAmount: double.parse(totalAmountController.text),
        );
        particulars[index] = oldItemDetails;
      }

      resetForm(context);
    }
  }

  Future resetForm(BuildContext context) async {
    grossWeightController.clear();
    metalRateController.clear();
    dustWeightController.clear();
    netWeightController.clear();
    oldAmountController.clear();
    purityPercentController.clear();
    itemNameController.clear();
    gstAmountController.clear();
    totalAmountController.clear();
    // selectedGstType.value = null ;
    selectedMetal.value = null;
    itemFormMode('create');
  }
}
