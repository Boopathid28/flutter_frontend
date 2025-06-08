import 'dart:developer';

import 'package:ausales_application/controller/single_tag_update/single_tag_update_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/single_tag_update/single_tag_update_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SingleTagUpdateDiamondFormController extends GetxController {

  final SingleTagUpdateController _singleTagUpdateController = Get.put(SingleTagUpdateController());

  final singleTagUpdateDiamondDetailsFormKey = GlobalKey<FormState>();

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

  RxBool diamondFormUpdateIsDb = false.obs;

  RxDouble diamondRate = 0.0.obs;
  RxDouble certRate = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getDiamondList();
  }

  Future getDiamondList() async {
    final List<DiamondDropdownModel> tempList =
        await DropdownService.diamondDropDown();
    diamondDropDown([]);
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

  Future submitUpdatetagStoneForm(BuildContext context) async {
    if (singleTagUpdateDiamondDetailsFormKey.currentState!.validate()) {

      if (diamondFormMode.value == 'create') {
        var uuid = Uuid();
        final TagDiamondDetails diamondDetails = TagDiamondDetails(
          id: uuid.v4(),
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0" : diamondPiecesController.text),
          diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
          diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text),
          isDb: diamondFormUpdateIsDb.value
        );

        _singleTagUpdateController.diamondDetailsList.insert(0, diamondDetails);
        resetDiamondForm(context);
      } else {
        int index = _singleTagUpdateController.diamondDetailsList.indexWhere((item) => item.id == diamondFormUpdateId.value);
        final TagDiamondDetails diamondDetails = TagDiamondDetails(
          id: diamondFormUpdateId.value,
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0" : diamondPiecesController.text),
          diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
          diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text),
          isDb: diamondFormUpdateIsDb.value
        );
        _singleTagUpdateController.diamondDetailsList[index] = diamondDetails;
        resetDiamondForm(context);
      }
    }
  }
  
  void editUpdatetagDiamond(BuildContext context, TagDiamondDetails item) {
    if (item.isDb != null && item.isDb == true) {
      diamondFormUpdateIsDb(true);
    } else {
      diamondFormUpdateIsDb(false);
    }
    diamondRate(item.rate);
    diamondPiecesController.text = item.diamondPieces.toString();
    diamondAmountController.text = item.diamondAmount!.toStringAsFixed(2);
    diamondWeightController.text = item.diamondWeight!.toStringAsFixed(3);
    
    certRate(item.certificateAmount);
    selectedReduceWeight(item.reduceWeight! ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
    selectedDiamond(DropdownModel(value: item.diamond.toString(), label: item.diamondName.toString()));
    diamondFormMode('update');
    diamondFormUpdateId(item.id);
  }

  void deleteUpdatetagDiamond(BuildContext context, String index, TagDiamondDetails item) {
    if (item.isDb != null && item.isDb == true) {
      final TagDiamondDetails diamondDetails = TagDiamondDetails(
          id: item.id,
          diamond: item.diamond,
          diamondName: item.diamondName,
          reduceWeight: item.reduceWeight,
          diamondPieces: item.diamondPieces,
          diamondAmount: item.diamondAmount,
          diamondWeight: item.diamondWeight,
          isDb: item.isDb,
        );
        _singleTagUpdateController.deletedDiamondDetailsList.add(item.id.toString());
    }
    _singleTagUpdateController.diamondDetailsList.removeWhere((item) => item.id == index);
    Get.back();
  }

  void resetDiamondForm(BuildContext context) {
    diamondPiecesController.clear();
    diamondAmountController.clear();
    diamondWeightController.clear();
    selectedReduceWeight(DropdownModel(value: "1", label: "Yes"));
    selectedDiamond.value = null;
    diamondRate(0.0);
    certRate(0.0);
    diamondFormMode('create');
    diamondFormUpdateId("");
    diamondFormUpdateIsDb(false);
  }

  void diamondAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in _singleTagUpdateController.diamondDetailsList) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + (double.parse(i.diamondWeight.toString()??"0.0") / 5)).toString());
      }
      pieces = int.parse((pieces + int.parse(i.diamondPieces.toString()??"0")).toString());
      weight = double.parse((weight + double.parse(i.diamondWeight.toString()??"0.0")).toString());
      amount = double.parse((amount + double.parse(i.diamondAmount.toString()??"0.0")).toString());
    }

    _singleTagUpdateController.totalDiamondPieces(pieces);
    _singleTagUpdateController.totalDiamondAmount(amount);
    _singleTagUpdateController.diamondWeightController.text = weight.toString();

    _singleTagUpdateController.reduceDiamondWeight(reduceWeight);

    _singleTagUpdateController.calcNetWeight(grossWeight: _singleTagUpdateController.tagDetailsData.value.grossWeight.toString(), reduceWeight: _singleTagUpdateController.reduceWeightController.text,
    reduceStone: _singleTagUpdateController.reduceStoneWeight.value, reduceDiamond: reduceWeight);

    Get.back();
  }

  
}