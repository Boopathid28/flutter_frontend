import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SuspensePaymentFormController extends HeaderController {

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

  final paymentDetailsFormKey = GlobalKey<FormState>();

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();

  Rx<DropdownModel?> selectedPaymentMethoad = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentProvider = Rx<DropdownModel?>(null);

  RxList<DropdownModel> paymentmethodDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentproviderDropDown = <DropdownModel>[].obs;

    Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  RxList<PaymentMethodDropDown> paymentmethoadList = <PaymentMethodDropDown>[].obs;
  RxList<PaymentProviderDropDown> paymentproviderList = <PaymentProviderDropDown>[].obs;

  RxString paymentdetailsFormMode = "create".obs;
  RxString paymentFormUpdateId = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
     final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getPaymentMethoadList();
  }


   Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getPaymentMethoadList() async {
    paymentmethodDropDown([]);
    final List<PaymentMethodDropDown> tempList =
        await DropdownService.paymentMethodDropDown();
    paymentmethoadList(tempList);

    tempList.forEach((item) {
      paymentmethodDropDown.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

   Future getPaymentProviderList({required String method}) async {
    paymentproviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentProviderDropDown> tempList =
        await DropdownService.paymentProviderDropDown(paymentMethod: method);
    paymentproviderList(tempList);

    tempList.forEach((item) {
      paymentproviderDropDown.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future submitPaymentdetailsForm(BuildContext context) async {
    if (paymentDetailsFormKey.currentState!.validate()) {
      if (paymentdetailsFormMode.value == 'create') {
        var uuid = Uuid();
        final DenominationDetails denominationDetails = DenominationDetails(
            sNo: uuid.v4(),
            paymentMethod: selectedPaymentMethoad.value!.value,
            paymentProvider:selectedPaymentProvider.value?.value != null ? selectedPaymentProvider.value?.value : null,
            paidAmount: double.parse(paidAmountController.text));

        _suspensePaymentController.denominationDetailsParticulars
            .insert(0, denominationDetails);

        resetPayment(context);
      } else {
        int index = _suspensePaymentController.denominationDetailsParticulars
            .indexWhere((item) => item.sNo == paymentFormUpdateId.value);
        final DenominationDetails denominationDetails = DenominationDetails(
            sNo: paymentFormUpdateId.value,
              paymentMethod: selectedPaymentMethoad.value!.value,
            paymentProvider: selectedPaymentProvider.value!.value,
            paidAmount: double.parse(paidAmountController.text));
        _suspensePaymentController.denominationDetailsParticulars[index] = denominationDetails;
        resetPayment(context);
      }
    }
  }

  void editPayment(BuildContext context, DenominationDetails item) {
    paidAmountController.text = item.paidAmount!.toString();
    selectedPaymentMethoad(DropdownModel(
        value: item.paymentMethod.toString(), label: item.paymentMethod.toString()));
    getPaymentProviderList(method: item.paymentMethod!);
    selectedPaymentProvider(DropdownModel(
        value: item.paymentProvider.toString(), label: item.paymentProvider.toString()));
    paymentdetailsFormMode('update');
    paymentFormUpdateId(item.sNo);
  }

  void deletePayment(BuildContext context, String index) {
    _suspensePaymentController.denominationDetailsParticulars
        .removeWhere((item) => item.sNo == index);
    Get.back();
  }

  void resetPayment(BuildContext context) {
    paidAmountController.clear();
    selectedPaymentMethoad.value = null;
    selectedPaymentProvider.value = null;
    paymentdetailsFormMode('create');
    paymentFormUpdateId("");
  }

}
