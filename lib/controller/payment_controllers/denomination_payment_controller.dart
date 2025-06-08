import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DenominationPaymentController extends GetxController {
  final denominationPaymentFormKey = GlobalKey<FormState>();

  TextEditingController paidAmountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  Rx<DropdownModel?> selectedPaymentMethod = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentProvider = Rx<DropdownModel?>(null);

  RxList<DropdownModel> paymentMethodDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentProviderDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPaymentMethodList();
  }

  Future getPaymentMethodList() async {
    paymentMethodDropDown([]);
    selectedPaymentMethod.value = null;
    paymentProviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentMethodDropDown>? data =
        await DropdownService.paymentMethodDropDown();

    if (data != null) {
      for (var i in data) {
        paymentMethodDropDown.add(DropdownModel(
            value: i.value.toString(), label: i.lable.toString()));
      }
    }
  }

  Future getPaymentProvidersList({required String method}) async {
    paymentProviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentProviderDropDown>? data =
        await DropdownService.paymentProviderDropDown(paymentMethod: method);

    if (data != null) {
      for (var i in data) {
        paymentProviderDropDown.add(DropdownModel(
            value: i.value.toString(), label: i.lable.toString()));
      }
    }
  }

  addItemInList(List<PaymentDenominationItemModel> itemList) {
    if (denominationPaymentFormKey.currentState!.validate()) {
      var id = Uuid();
      PaymentDenominationItemModel data = PaymentDenominationItemModel(
          paidAmount: double.parse(paidAmountController.text.isEmpty
              ? "0"
              : paidAmountController.text),
          id: id.v4(),
          paymentMethod: selectedPaymentMethod.value?.value,
          paymentMethodName: selectedPaymentMethod.value?.label,
          paymentProvider: selectedPaymentProvider.value?.value,
          remarks: remarksController.text,
          paymentProviderName: selectedPaymentProvider.value?.label);

      itemList.insert(0, data);
      resetForm();
    }
  }

  deleteItemInList(List<PaymentDenominationItemModel> itemList, String id) {
    itemList.removeWhere((item) => item.id == id);
  }

  resetForm() {
    paidAmountController.clear();
    selectedPaymentMethod.value = null;
    selectedPaymentProvider.value = null;
    remarksController.clear();
    paymentProviderDropDown([]);
  }
}
