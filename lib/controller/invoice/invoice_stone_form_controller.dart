import 'package:ausales_application/controller/invoice/invoice_item_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class InvoiceStoneFormController extends GetxController {

  final InvoiceItemController _invoiceItemController = Get.put(InvoiceItemController());

  final invoiceStoneDetailsFormKey = GlobalKey<FormState>();

  TextEditingController stoneSearchController = TextEditingController();

  TextEditingController stonePiecesController = TextEditingController();
  TextEditingController stoneWeightController = TextEditingController();
  TextEditingController stoneAmountController = TextEditingController();
  TextEditingController certAmountController = TextEditingController();

  Rx<DropdownModel?> selectedStone = Rx<DropdownModel?>(null);
  Rx<DropdownModel> selectedReduceWeight = DropdownModel(value: "1", label: "Yes").obs;

  RxList<DropdownModel> stoneDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> reduceWeightDropDown = [DropdownModel(value: "1", label: "Yes"), DropdownModel(value: "0", label: "No")].obs;

  RxList<StoneDropdownModel> stoneList = <StoneDropdownModel>[].obs;

  RxString stoneFormMode = "create".obs;
  RxString stoneFormUpdateId = "".obs;

  RxDouble stoneRate = 0.0.obs;

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
    double certAmount = double.parse(certAmountController.text.isEmpty ? "0.0" : certAmountController.text);
    double total = (weight * stoneRate.value) + (weight * certAmount);
    stoneAmountController.text = total.toStringAsFixed(2);
  }

  Future submitInvoiceStoneForm(BuildContext context) async {
    if (invoiceStoneDetailsFormKey.currentState!.validate()) {

      if (stoneFormMode.value == 'create') {
        var uuid = Uuid();
        final TagDetailStoneDetails stoneDetails = TagDetailStoneDetails(
          id: uuid.v4(),
          stone: int.parse(selectedStone.value!.value),
          stoneName: selectedStone.value?.label,
          rate: stoneRate.value,
          certificateAmount: double.parse(certAmountController.text.isEmpty ? "0" : certAmountController.text),
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0" : stonePiecesController.text),
          stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text),
          stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text)
        );

        _invoiceItemController.stoneParticularList.insert(0,stoneDetails);
        resetStoneForm(context);
      } else {
        int index = _invoiceItemController.stoneParticularList.indexWhere((item) => item.id == stoneFormUpdateId.value);
        final TagDetailStoneDetails stoneDetails = TagDetailStoneDetails(
          id: stoneFormUpdateId.value,
          stone: int.parse(selectedStone.value!.value),
          stoneName: selectedStone.value?.label,
          rate: stoneRate.value,
          certificateAmount: double.parse(certAmountController.text.isEmpty ? "0" : certAmountController.text),
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0" : stonePiecesController.text),
          stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text),
          stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text)
        );
        _invoiceItemController.stoneParticularList[index] = stoneDetails;
        resetStoneForm(context);
      }
    }
  }
  
  void editItemtagStone(BuildContext context, TagDetailStoneDetails item) {
    stonePiecesController.text = item.stonePieces!.toString();
    stoneAmountController.text = item.stoneAmount!.toStringAsFixed(2);
    stoneWeightController.text = item.stoneWeight!.toStringAsFixed(3);
    selectedReduceWeight(item.reduceWeight! ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
    selectedStone(DropdownModel(value: item.stone.toString(), label: item.stoneName.toString()));
    stoneFormMode('update');
    stoneFormUpdateId(item.id);
    certAmountController.text = item.certificateAmount!.toStringAsFixed(2);
    stoneRate(item.rate);
  }

  void deleteItemtagStone(BuildContext context, String index) {
    _invoiceItemController.stoneParticularList.removeWhere((item) => item.id == index);
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
    certAmountController.clear();
    stoneFormUpdateId("");
  }

  void stoneAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in _invoiceItemController.stoneParticularList) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + ((i.stoneWeight??0.0) / 5)).toString());
      }
      pieces = int.parse((pieces + i.stonePieces!).toString());
      weight = double.parse((weight + i.stoneWeight!).toString());
      amount = double.parse((amount + i.stoneAmount!).toString());
    }

    _invoiceItemController.totalStonePieces(pieces);
    _invoiceItemController.totalStoneWeight(amount);
    _invoiceItemController.stoneAmountController.text = amount.toStringAsFixed(2);

    _invoiceItemController.reduceStoneWeight(reduceWeight);

    _invoiceItemController.calculationItemValues();

    Get.back();
  }
}