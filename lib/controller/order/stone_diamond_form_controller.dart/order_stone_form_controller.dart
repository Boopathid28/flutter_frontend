import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OrderStoneFormController extends GetxController {

  final OrderItemFormController _orderItemFormController = Get.put(OrderItemFormController());

  final orderStoneDetailsFormKey = GlobalKey<FormState>();

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

  Future submitOrderStoneForm(BuildContext context) async {
    if (orderStoneDetailsFormKey.currentState!.validate()) {

      if (stoneFormMode.value == 'create') {
        var uuid = Uuid();
        final StoneDetails stoneDetails = StoneDetails(
          sNo: uuid.v4(),
          stone: int.parse(selectedStone.value!.value),
          stoneName: selectedStone.value?.label,
          rate: stoneRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0" : stonePiecesController.text),
          stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text),
          stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text)
        );

        _orderItemFormController.stonedetailsParticulars.insert(0,stoneDetails);
        resetStoneForm(context);
      } else {
        int index = _orderItemFormController.stonedetailsParticulars.indexWhere((item) => item.sNo == stoneFormUpdateId.value);
        final StoneDetails stoneDetails = StoneDetails(
          sNo: stoneFormUpdateId.value,
          stone: int.parse(selectedStone.value!.value),
          stoneName: selectedStone.value?.label,
          rate: stoneRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0" : stonePiecesController.text),
          stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text),
          stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text)
        );
        _orderItemFormController.stonedetailsParticulars[index] = stoneDetails;
        resetStoneForm(context);
      }
    }
  }
  
  void editOrderStone(BuildContext context, StoneDetails item) {
    stonePiecesController.text = item.stonePieces!.toString();
    stoneAmountController.text = item.stoneAmount!.toStringAsFixed(2);
    stoneWeightController.text = item.stoneWeight!.toStringAsFixed(3);
    selectedReduceWeight(item.reduceWeight! ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
    selectedStone(DropdownModel(value: item.stone.toString(), label: item.stoneName.toString()));
    stoneFormMode('update');
    stoneRate(item.rate);
    certRate(item.certificateAmount);
    stoneFormUpdateId(item.sNo);
  }

  void deleteOrderStone(BuildContext context, String index) {
    _orderItemFormController.stonedetailsParticulars.removeWhere((item) => item.sNo == index);
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
  }

  void stoneAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in _orderItemFormController.stonedetailsParticulars) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight +(( i.stoneWeight??0.0) / 5)).toString());
      }
      pieces = int.parse((pieces + i.stonePieces!).toString());
      weight = double.parse((weight + i.stoneWeight!).toString());
      amount = double.parse((amount + i.stoneAmount!).toString());
    }

    _orderItemFormController.totalStonePieces(pieces);
    _orderItemFormController.totalStoneWeight(weight);
    _orderItemFormController.stoneAmountController.text = amount.toStringAsFixed(2);

    _orderItemFormController.reduceStoneWeight(reduceWeight);

    _orderItemFormController.calculateItemValue();

    Get.back();
  }
}