import 'package:ausales_application/controller/estimation/estimation_item_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_item_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/estimation/estimation_model.dart';
import 'package:ausales_application/model/mannual_estimation/mannual_estimation_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MannualEstimationDiamondFormController extends GetxController {

  final MannualEstimationItemController _mannualEstimationItemController = Get.put(MannualEstimationItemController());

  final estimationDiamondDetailsFormKey = GlobalKey<FormState>();

  TextEditingController diamondSearchController = TextEditingController();

  TextEditingController diamondPiecesController = TextEditingController();
  TextEditingController diamondWeightController = TextEditingController();
  TextEditingController diamondAmountController = TextEditingController();
  TextEditingController certAmountController = TextEditingController();

  Rx<DropdownModel?> selectedDiamond = Rx<DropdownModel?>(null);
  Rx<DropdownModel> selectedReduceWeight = DropdownModel(value: "1", label: "Yes").obs;

  RxList<DropdownModel> diamondDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> reduceWeightDropDown = [DropdownModel(value: "1", label: "Yes"), DropdownModel(value: "0", label: "No")].obs;

  RxList<DiamondDropdownModel> diamondList = <DiamondDropdownModel>[].obs;

  RxString diamondFormMode = "create".obs;
  RxString diamondFormUpdateId = "".obs;

  RxDouble diamondRate = 0.0.obs;

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
    double certAmount = double.parse(certAmountController.text.isEmpty ? "0.0" : certAmountController.text);
    double total = (weight * diamondRate.value) + (weight * certAmount);
    diamondAmountController.text = total.toStringAsFixed(2);
  }

  Future submitItemtagStoneForm(BuildContext context) async {
    if (estimationDiamondDetailsFormKey.currentState!.validate()) {

      if (diamondFormMode.value == 'create') {
        var uuid = Uuid();
        final MannualTagDetailDiamondDetails diamondDetails = MannualTagDetailDiamondDetails(
          id: uuid.v4(),
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: double.parse(certAmountController.text.isEmpty ? "0" : certAmountController.text),
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0" : diamondPiecesController.text),
          diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
          diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text)
        );

        _mannualEstimationItemController.diamondParticularList.insert(0, diamondDetails);
        resetDiamondForm(context);
      } else {
        int index = _mannualEstimationItemController.diamondParticularList.indexWhere((item) => item.id == diamondFormUpdateId.value);
        final MannualTagDetailDiamondDetails diamondDetails = MannualTagDetailDiamondDetails(
          id: diamondFormUpdateId.value,
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: double.parse(certAmountController.text.isEmpty ? "0" : certAmountController.text),
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0" : diamondPiecesController.text),
          diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
          diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text)
        );
        _mannualEstimationItemController.diamondParticularList[index] = diamondDetails;
        resetDiamondForm(context);
      }
    }
  }
  
  void editItemtagDiamond(BuildContext context, MannualTagDetailDiamondDetails item) {
    diamondPiecesController.text = item.diamondPieces.toString();
    diamondAmountController.text = item.diamondAmount!.toStringAsFixed(2);
    diamondWeightController.text = item.diamondWeight!.toStringAsFixed(3);
    selectedReduceWeight(item.reduceWeight! ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
    selectedDiamond(DropdownModel(value: item.diamond.toString(), label: item.diamondName.toString()));
    diamondFormMode('update');
    diamondRate(item.rate);
    certAmountController.text = item.certificateAmount!.toStringAsFixed(2);
    diamondFormUpdateId(item.id);
  }

  void deleteItemtagDiamond(BuildContext context, String index) {
    _mannualEstimationItemController.diamondParticularList.removeWhere((item) => item.id == index);
    Get.back();
  }

  void resetDiamondForm(BuildContext context) {
    diamondPiecesController.clear();
    diamondAmountController.clear();
    diamondWeightController.clear();
    selectedReduceWeight(DropdownModel(value: "1", label: "Yes"));
    selectedDiamond.value = null;
    diamondRate(0.0);
    certAmountController.clear();
    diamondFormMode('create');
    diamondFormUpdateId("");
  }

  void diamondAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in _mannualEstimationItemController.diamondParticularList) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + ((i.diamondWeight??0.0) / 5)).toString());
      }
      pieces = int.parse((pieces + i.diamondPieces!).toString());
      weight = double.parse((weight + i.diamondWeight!).toString());
      amount = double.parse((amount + i.diamondAmount!).toString());
    }

    _mannualEstimationItemController.totalDiamondPieces(pieces);
    _mannualEstimationItemController.totalDiamondWeight(amount);
    _mannualEstimationItemController.diamondAmountController.text = amount.toStringAsFixed(2);

    _mannualEstimationItemController.reduceDiamondWeight(reduceWeight);

    _mannualEstimationItemController.calculationItemValues();

    Get.back();
  }
}