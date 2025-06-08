import 'package:ausales_application/controller/advance/advance_form_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/order/order_advance/order_advance_payment_controller.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AdvanceDenomiationForm extends HeaderController {

  final OrderAdvancePaymentController _orderAdvancePaymentController =
      Get.put(OrderAdvancePaymentController());

  @override
  RxBool get isBranchuser => super.isBranchuser; 

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final advancePaymentFormKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  Rx<DropdownModel?> selectedPaymentMethod = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentProvider = Rx<DropdownModel?>(null);

  RxList<DropdownModel> paymentMethodDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentProviderDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString formMode = "create".obs;

  @override
  void onInit() async {
    super.onInit();
    getPaymentMethodList();
  }
  

  Future getPaymentMethodList() async {
    paymentMethodDropDown([]);
    final List<PaymentMethodDropDown> tempList =
        await DropdownService.paymentMethodDropDown();
    tempList.forEach((item) {
      paymentMethodDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getPaymentProviderList({required String method}) async {
    paymentProviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentProviderDropDown> tempList =
        await DropdownService.paymentProviderDropDown(paymentMethod: method);
    tempList.forEach((item) {
      paymentProviderDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  void deleteParticulars(String id) {
    _orderAdvancePaymentController.paymentParticulars.removeWhere((item) => item.sNo == id);
  }

  void submitPaymentForm(BuildContext context) {
    if (advancePaymentFormKey.currentState!.validate()) {
      if (formMode.value == "create") {
        var uuid = Uuid();
        DenominationDetails data = DenominationDetails(
          sNo: uuid.v4(),
          paymentMethod: selectedPaymentMethod.value?.value,
          paymentMethodName: selectedPaymentMethod.value?.label,
          paymentProvider: selectedPaymentProvider.value?.value,
          paymentProviderName: selectedPaymentProvider.value?.value,
          paidAmount: double.parse(amountController.text.isEmpty ? "0" : amountController.text),
          remark: remarksController.text
        );
        _orderAdvancePaymentController.paymentParticulars.add(data);
      }
      resetForm();
    }
  }

   void calculateAdvance() {
    double totalAmount = 0.0;
    for (var item in _orderAdvancePaymentController.paymentParticulars) {
      totalAmount += item.paidAmount!;
    }
    _orderAdvancePaymentController.advanceAmountController.text = totalAmount.toString();
  }

  resetForm() {
    amountController.clear();
    remarksController.clear();

    selectedPaymentMethod.value = null;
    selectedPaymentProvider.value = null;

    formMode('create');
  }

}