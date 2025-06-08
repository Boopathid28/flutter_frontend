import 'dart:developer';

import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/itemtag/itemtag_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ItemtagDiamondFormController extends GetxController {

  final ItemtagFormController _itemtagFormController = Get.put(ItemtagFormController());

  final itemtagDiamondDetailsFormKey = GlobalKey<FormState>();

  TextEditingController diamondSearchController = TextEditingController();

  TextEditingController diamondPiecesController = TextEditingController();
  TextEditingController diamondWeightController = TextEditingController();
  TextEditingController diamondAmountController = TextEditingController();

  Rx<DropdownModel?> selectedDiamond = Rx<DropdownModel?>(null);
  Rx<DropdownModel> selectedReduceWeight = DropdownModel(value: "1", label: "Yes").obs;

  RxList<DropdownModel> diamondDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> reduceWeightDropDown = [DropdownModel(value: "1", label: "Yes"), DropdownModel(value: "0", label: "No")].obs;

  RxList<DiamondDropdownModel> diamondList = <DiamondDropdownModel>[].obs;

  RxString diamondFormMode = "create".obs;
  RxString diamondFormUpdateId = "".obs;

  RxDouble diamondRate = 0.0.obs;
  RxDouble certRate = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getDiamondList();
  }

  Future getDiamondList() async {
    diamondDropDown([]);
    final List<DiamondDropdownModel> tempList =
        await DropdownService.diamondDropDown();
    diamondList(tempList);

    tempList.forEach((item) {
      diamondDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.diamondName.toString()));
    });
  }

  void calculateTotalAmount() {
    double weight = double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text);
    double total = (weight * diamondRate.value) + (weight * certRate.value);
    diamondAmountController.text = total.toStringAsFixed(2);
  }

  Future submitItemtagStoneForm(BuildContext context) async {
    if (itemtagDiamondDetailsFormKey.currentState!.validate()) {

      if (diamondFormMode.value == 'create') {
        var uuid = Uuid();
        final DiamondDetails diamondDetails = DiamondDetails(
          sNo: uuid.v4(),
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: diamondPiecesController.text,
          diamondAmount: diamondAmountController.text,
          diamondWeight: diamondWeightController.text
        );

        _itemtagFormController.diamondParticularList.insert(0, diamondDetails);
        resetDiamondForm(context);
      } else {
        int index = _itemtagFormController.diamondParticularList.indexWhere((item) => item.sNo == diamondFormUpdateId.value);
        final DiamondDetails diamondDetails = DiamondDetails(
          sNo: diamondFormUpdateId.value,
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: diamondPiecesController.text,
          diamondAmount: diamondAmountController.text,
          diamondWeight: diamondWeightController.text
        );
        _itemtagFormController.diamondParticularList[index] = diamondDetails;
        resetDiamondForm(context);
      }
    }
  }
  
  void editItemtagDiamond(BuildContext context, DiamondDetails item) {
    diamondPiecesController.text = item.diamondPieces!;
    diamondAmountController.text = item.diamondAmount!;
    diamondWeightController.text = item.diamondWeight!;
    diamondRate(item.rate);
    certRate(item.certificateAmount);
    selectedReduceWeight(item.reduceWeight! ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
    selectedDiamond(DropdownModel(value: item.diamond.toString(), label: item.diamondName.toString()));
    diamondFormMode('update');
    diamondFormUpdateId(item.sNo);
  }

  void deleteItemtagDiamond(BuildContext context, String index) {
    _itemtagFormController.diamondParticularList.removeWhere((item) => item.sNo == index);
    Get.back();
  }

  void resetDiamondForm(BuildContext context) {
    diamondPiecesController.clear();
    diamondAmountController.clear();
    diamondWeightController.clear();
    diamondRate(0.0);
    certRate(0.0);
    selectedReduceWeight(DropdownModel(value: "1", label: "Yes"));
    selectedDiamond.value = null;
    diamondFormMode('create');
    diamondFormUpdateId("");
  }

  // void diamondAddCompleted(BuildContext context) {
  //   int pieces = 0;
  //   double weight = 0;
  //   double amount = 0;

  //   double reduceWeight = 0.0;

  //   for (var i in _itemtagFormController.diamondParticularList) {

  //     if (i.reduceWeight!) {
  //       reduceWeight = double.parse((reduceWeight + (double.parse(i.diamondWeight??"0.0") / 5)).toString());
  //     }
  //     pieces = int.parse((pieces + int.parse(i.diamondPieces??"0")).toString());
  //     weight = double.parse((weight + double.parse(i.diamondWeight??"0.0")).toString());
  //     amount = double.parse((amount + double.parse(i.diamondAmount??"0.0")).toString());
  //   }

  //   _itemtagFormController.totalDiamondPieces(pieces);
  //   _itemtagFormController.totalDiamondAmount(amount);
  //   _itemtagFormController.diamondWeightController.text = weight.toString();

  //   _itemtagFormController.reduceDiamondWeight(reduceWeight);

  //   _itemtagFormController.calcNetWeight(grossWeight: _itemtagFormController.grossWeightController.text, reduceWeight: _itemtagFormController.reduceWeightController.text,
  //   reduceStone: _itemtagFormController.reduceStoneWeight.value, reduceDiamond: reduceWeight);

  //   Get.back();
  // }
}