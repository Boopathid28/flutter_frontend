import 'dart:developer';

import 'package:ausales_application/controller/single_tag_update/single_tag_update_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/single_tag_update/single_tag_update_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SingleTagUdpdateStoneFormController extends GetxController {
  final SingleTagUpdateController _singleTagUpdateController =
      Get.put(SingleTagUpdateController());

  final singleTagUpdateStoneDetailsFormKey = GlobalKey<FormState>();

  TextEditingController stoneSearchController = TextEditingController();

  TextEditingController stonePiecesController = TextEditingController();
  TextEditingController stoneWeightController = TextEditingController();
  TextEditingController stoneAmountController = TextEditingController();

  Rx<DropdownModel?> selectedStone = Rx<DropdownModel?>(null);
  Rx<DropdownModel> selectedReduceWeight =
      DropdownModel(value: "1", label: "Yes").obs;

  RxList<DropdownModel> stoneDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> reduceWeightDropDown = [
    DropdownModel(value: "1", label: "Yes"),
    DropdownModel(value: "0", label: "No")
  ].obs;

  RxList<StoneDropdownModel> stoneList = <StoneDropdownModel>[].obs;

  RxString stoneFormMode = "create".obs;
  RxString stoneFormUpdateId = "".obs;
  RxBool stoneFormUpdateIsDb = false.obs;

  RxDouble stoneRate = 0.0.obs;
  RxDouble certRate = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getStoneList();
  }

  Future getStoneList() async {
    final List<StoneDropdownModel> tempList =
        await DropdownService.stoneDropDown();
    stoneDropDown([]);
    stoneList(tempList);

    tempList.forEach((item) {
      stoneDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.stoneName.toString()));
    });
  }

  void calculateTotalAmount() {
    double weight = double.parse(stoneWeightController.text.isEmpty
        ? "0.0"
        : stoneWeightController.text);
    double total = (weight * stoneRate.value) + (weight * certRate.value);
    stoneAmountController.text = total.toStringAsFixed(2);
  }

  Future submitUpdatetagStoneForm(BuildContext context) async {
    if (singleTagUpdateStoneDetailsFormKey.currentState!.validate()) {
      if (stoneFormMode.value == 'create') {
        var uuid = Uuid();
        final TagStoneDetails stoneDetails = TagStoneDetails(
            id: uuid.v4(),
            stone: int.parse(selectedStone.value!.value),
            stoneName: selectedStone.value?.label,
            rate: stoneRate.value,
            certificateAmount: certRate.value,
            reduceWeight:
                selectedReduceWeight.value.value == "1" ? true : false,
            stonePieces: int.parse(stonePiecesController.text.isEmpty
                ? "0"
                : stonePiecesController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty
                ? "0"
                : stoneAmountController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty
                ? "0"
                : stoneWeightController.text),
            isDb: stoneFormUpdateIsDb.value);

        _singleTagUpdateController.stoneDetailsList.insert(0, stoneDetails);
        resetStoneForm(context);
      } else {
        int index = _singleTagUpdateController.stoneDetailsList
            .indexWhere((item) => item.id == stoneFormUpdateId.value);
        final TagStoneDetails stoneDetails = TagStoneDetails(
            id: stoneFormUpdateId.value,
            stone: int.parse(selectedStone.value!.value),
            stoneName: selectedStone.value?.label,
            rate: stoneRate.value,
            certificateAmount: certRate.value,
            reduceWeight:
                selectedReduceWeight.value.value == "1" ? true : false,
            stonePieces: int.parse(stonePiecesController.text.isEmpty
                ? "0"
                : stonePiecesController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty
                ? "0"
                : stoneAmountController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty
                ? "0"
                : stoneWeightController.text),
            isDb: stoneFormUpdateIsDb.value);
        _singleTagUpdateController.stoneDetailsList[index] = stoneDetails;
        resetStoneForm(context);
      }
    }
  }

  void editUpdatetagStone(BuildContext context, TagStoneDetails item) {
    if (item.isDb != null && item.isDb == true) {
      stoneFormUpdateIsDb(true);
    } else {
      stoneFormUpdateIsDb(false);
    }
    stoneFormUpdateId(item.id);
    stonePiecesController.text = item.stonePieces!.toString();
    stoneAmountController.text = item.stoneAmount!.toStringAsFixed(3);
    stoneWeightController.text = item.stoneWeight!.toStringAsFixed(3);
    stoneRate(item.rate);
    certRate(item.certificateAmount);
    selectedReduceWeight(item.reduceWeight!
        ? DropdownModel(value: "1", label: "Yes")
        : DropdownModel(value: "0", label: "No"));
    selectedStone(DropdownModel(
        value: item.stone.toString(), label: item.stoneName.toString()));
    stoneFormMode('update');
  }

  void deleteUpdatetagStone(
      BuildContext context, String index, TagStoneDetails item) {
    if (item.isDb != null && item.isDb == true) {
      _singleTagUpdateController.deletedStoneDetailsList
          .add(item.id.toString());
    }
    _singleTagUpdateController.stoneDetailsList
        .removeWhere((item) => item.id == index);
    Get.back();
  }

  void resetStoneForm(BuildContext context) {
    stonePiecesController.clear();
    stoneAmountController.clear();
    stoneWeightController.clear();
    selectedReduceWeight(DropdownModel(value: "1", label: "Yes"));
    selectedStone.value = null;
    stoneRate(0.0);
    certRate(0.0);
    stoneFormMode('create');
    stoneFormUpdateId("");
    stoneFormUpdateIsDb(false);
  }

  void stoneAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in _singleTagUpdateController.stoneDetailsList) {
      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight +
                (double.parse(i.stoneWeight.toString() ?? "0.0") / 5))
            .toString());
      }
      pieces = int.parse(
          (pieces + int.parse(i.stonePieces.toString() ?? "0")).toString());
      weight = double.parse(
          (weight + double.parse(i.stoneWeight.toString() ?? "0.0"))
              .toString());
      amount = double.parse(
          (amount + double.parse(i.stoneAmount.toString() ?? "0.0"))
              .toString());
    }

    _singleTagUpdateController.totalStonePieces(pieces);
    _singleTagUpdateController.totalStoneAmount(amount);
    _singleTagUpdateController.stoneWeightController.text = weight.toString();

    _singleTagUpdateController.reduceStoneWeight(reduceWeight);

    _singleTagUpdateController.calcNetWeight(
        grossWeight: _singleTagUpdateController
            .tagDetailsData.value.grossWeight!
            .toStringAsFixed(3),
        reduceWeight: _singleTagUpdateController.reduceWeightController.text,
        reduceStone: reduceWeight,
        reduceDiamond: _singleTagUpdateController.reduceDiamondWeight.value);

    Get.back();
  }
}
