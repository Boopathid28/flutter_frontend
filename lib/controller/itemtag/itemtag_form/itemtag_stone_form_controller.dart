import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/itemtag/itemtag_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ItemtagStoneFormController extends GetxController {

  final ItemtagFormController _itemtagFormController = Get.put(ItemtagFormController());

  final itemtagStoneDetailsFormKey = GlobalKey<FormState>();

  TextEditingController stoneSearchController = TextEditingController();

  TextEditingController stonePiecesController = TextEditingController();
  TextEditingController stoneWeightController = TextEditingController();
  TextEditingController stoneAmountController = TextEditingController();

  Rx<DropdownModel?> selectedStone = Rx<DropdownModel?>(null);
  Rx<DropdownModel> selectedReduceWeight = DropdownModel(value: "1", label: "Yes").obs;

  RxList<DropdownModel> stoneDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> reduceWeightDropDown = [DropdownModel(value: "1", label: "Yes"), DropdownModel(value: "0", label: "No")].obs;

  RxList<StoneDropdownModel> stoneList = <StoneDropdownModel>[].obs;

  RxString stoneFormMode = "create".obs;
  RxString stoneFormUpdateId = "".obs;

  RxDouble stoneRate = 0.0.obs;
  RxDouble certRate = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getStoneList();
  }

  Future getStoneList() async {
    stoneDropDown([]);
    final List<StoneDropdownModel> tempList =
        await DropdownService.stoneDropDown();
    stoneList(tempList);

    tempList.forEach((item) {
      stoneDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.stoneName.toString()));
    });
  }

  void calculateTotalAmount() {
    double weight = double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text);
    double total = (weight * stoneRate.value) + (weight * certRate.value);
    stoneAmountController.text = total.toStringAsFixed(2);
  }

  Future submitItemtagStoneForm(BuildContext context) async {
    if (itemtagStoneDetailsFormKey.currentState!.validate()) {

      if (stoneFormMode.value == 'create') {
        var uuid = Uuid();
        final StoneDetails stoneDetails = StoneDetails(
          sNo: uuid.v4(),
          stone: int.parse(selectedStone.value!.value),
          stoneName: selectedStone.value?.label,
          rate: stoneRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          stonePieces: stonePiecesController.text,
          stoneAmount: stoneAmountController.text,
          stoneWeight: stoneWeightController.text
        );

        _itemtagFormController.stoneParticularList.insert(0,stoneDetails);
        resetStoneForm(context);
      } else {
        int index = _itemtagFormController.stoneParticularList.indexWhere((item) => item.sNo == stoneFormUpdateId.value);
        final StoneDetails stoneDetails = StoneDetails(
          sNo: stoneFormUpdateId.value,
          stone: int.parse(selectedStone.value!.value),
          stoneName: selectedStone.value?.label,
          rate: stoneRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          stonePieces: stonePiecesController.text,
          stoneAmount: stoneAmountController.text,
          stoneWeight: stoneWeightController.text
        );
        _itemtagFormController.stoneParticularList[index] = stoneDetails;
        resetStoneForm(context);
      }
    }
  }
  
  void editItemtagStone(BuildContext context, StoneDetails item) {
    stonePiecesController.text = item.stonePieces!;
    stoneAmountController.text = item.stoneAmount!;
    stoneWeightController.text = item.stoneWeight!;
    stoneRate(item.rate);
    certRate(item.certificateAmount);
    selectedReduceWeight(item.reduceWeight! ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
    selectedStone(DropdownModel(value: item.stone.toString(), label: item.stoneName.toString()));
    stoneFormMode('update');
    stoneFormUpdateId(item.sNo);
  }

  void deleteItemtagStone(BuildContext context, String index) {
    _itemtagFormController.stoneParticularList.removeWhere((item) => item.sNo == index);
    Get.back();
  }

  void resetStoneForm(BuildContext context) {
    stonePiecesController.clear();
    stoneAmountController.clear();
    stoneWeightController.clear();
    selectedReduceWeight(DropdownModel(value: "1", label: "Yes"));
    selectedStone.value = null;
    stoneFormMode('create');
    stoneRate(0.0);
    certRate(0.0);
    stoneFormUpdateId("");
  }

  // void stoneAddCompleted(BuildContext context) {
  //   int pieces = 0;
  //   double weight = 0;
  //   double amount = 0;

  //   double reduceWeight = 0.0;

  //   for (var i in _itemtagFormController.stoneParticularList) {

  //     if (i.reduceWeight!) {
  //       reduceWeight = double.parse((reduceWeight + (double.parse(i.stoneWeight??"0.0") / 5)).toString());
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