import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OrderDiamondFormController extends GetxController {

  final OrderItemFormController _orderItemFormController = Get.put(OrderItemFormController());

  final orderDiamondDetailsFormKey = GlobalKey<FormState>();

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

  Future submitOrderDiamondForm(BuildContext context) async {
    if (orderDiamondDetailsFormKey.currentState!.validate()) {

      if (diamondFormMode.value == 'create') {
        var uuid = Uuid();
        final DiamondDetails diamondDetails = DiamondDetails(
          sNo: uuid.v4(),
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0" : diamondPiecesController.text),
          diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
          diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text)
        );

        _orderItemFormController.diamonddetailsParticulars.insert(0, diamondDetails);
        resetDiamondForm(context);
      } else {
        int index = _orderItemFormController.diamonddetailsParticulars.indexWhere((item) => item.sNo == diamondFormUpdateId.value);
        final DiamondDetails diamondDetails = DiamondDetails(
          sNo: diamondFormUpdateId.value,
          diamond: int.parse(selectedDiamond.value!.value),
          diamondName: selectedDiamond.value?.label,
          rate: diamondRate.value,
          certificateAmount: certRate.value,
          reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
          diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0" : diamondPiecesController.text),
          diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
          diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text)
        );
        _orderItemFormController.diamonddetailsParticulars[index] = diamondDetails;
        resetDiamondForm(context);
      }
    }
  }
  
  void editOrderDiamond(BuildContext context, DiamondDetails item) {
    diamondPiecesController.text = item.diamondPieces.toString();
    diamondAmountController.text = item.diamondAmount!.toStringAsFixed(2);
    diamondWeightController.text = item.diamondWeight!.toStringAsFixed(3);
    selectedReduceWeight(item.reduceWeight! ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
    selectedDiamond(DropdownModel(value: item.diamond.toString(), label: item.diamondName.toString()));
    diamondFormMode('update');
    diamondRate(item.rate);
    certRate(item.certificateAmount);
    diamondFormUpdateId(item.sNo);
  }

  void deleteOrderDiamond(BuildContext context, String index) {
    _orderItemFormController.diamonddetailsParticulars.removeWhere((item) => item.sNo == index);
    Get.back();
  }

  void resetDiamondForm(BuildContext context) {
    diamondPiecesController.clear();
    diamondAmountController.clear();
    diamondWeightController.clear();
    selectedReduceWeight(DropdownModel(value: "1", label: "Yes"));
    selectedDiamond.value = null;
    diamondFormMode('create');
    diamondRate(0.0);
    certRate(0.0);
    diamondFormUpdateId("");
  }

  void diamondAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in _orderItemFormController.diamonddetailsParticulars) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + ((i.diamondWeight??0.0) / 5)).toString());
      }
      pieces = int.parse((pieces + i.diamondPieces!).toString());
      weight = double.parse((weight + i.diamondWeight!).toString());
      amount = double.parse((amount + i.diamondAmount!).toString());
    }

    _orderItemFormController.totalDiamondPieces(pieces);
    _orderItemFormController.totalDiamondWeight(weight);
    _orderItemFormController.diamondAmountController.text = amount.toStringAsFixed(2);

    _orderItemFormController.reduceDiamondWeight(reduceWeight);

    _orderItemFormController.calculateItemValue();

    Get.back();
  }
}