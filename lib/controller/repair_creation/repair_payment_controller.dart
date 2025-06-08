import 'dart:developer';

import 'package:ausales_application/controller/repair_creation/repair_creation_table_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';
import 'package:ausales_application/model/repair_creation/repair_payment_models.dart';
import 'package:ausales_application/service/repair_creation/repair_creation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class RepairMakePaymentController extends GetxController {
  TextEditingController paidAmountController = TextEditingController();

  final RepairCreationTableListController _repairCreationTableListController = Get.put(RepairCreationTableListController());

  RxList<PaymentDenominationItemModel> denominationPaymentParticulars =
      <PaymentDenominationItemModel>[].obs;

  RxList<AdvancePaymentItemModel> advanceParticulars =
      <AdvancePaymentItemModel>[].obs;

  RxDouble advanceAmount = 0.0.obs;
  RxDouble denominationAmount = 0.0.obs;
  RxDouble newPaymentAmount = 0.0.obs;
  RxBool isSubmitLoading = false.obs;

  void calculateDenominationPayments() {
    double totalPaid = 0.0;
    for (var i in denominationPaymentParticulars.value) {
      totalPaid += i.paidAmount!;
    }
    paidAmountController.text = totalPaid.toStringAsFixed(2);
    denominationAmount(totalPaid);
    calculateNewPaymentValue();
    Get.back();
  }

  void calculateAdvanceValues() {
    double totalValue = 0.0;
    for (var i in advanceParticulars) {
      totalValue += i.totalAmount!;
    }
    advanceAmount(totalValue);
    calculateNewPaymentValue();
  }


   void calculateNewPaymentValue() {
    double totalValue = advanceAmount.value + denominationAmount.value;
    newPaymentAmount(totalValue);
  }

  Future submitRepairForm(
      BuildContext context, String? repairId, String? branch) async {
    if (denominationPaymentParticulars.isNotEmpty ||
        advanceParticulars.isNotEmpty) {
      isSubmitLoading(true);
      final FetchRepairPaymentPayload payload = FetchRepairPaymentPayload(
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          paymentDenominationDetails: denominationPaymentParticulars.value,
          advanceDetails: advanceParticulars.value,
          id: repairId,
          branch: branch);

      await RepairCreationService.createRepairPayment(payload);
      _repairCreationTableListController.getRepairCreationTableList();
      resetForm();
    } else {
      toastification.show(
          type: ToastificationType.success,
          title: Text("Atleast one Payment Methoad"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  resetForm() {
    paidAmountController.clear();
    advanceParticulars([]);
    denominationPaymentParticulars([]);
     isSubmitLoading(false);
     denominationAmount(0.0);
     newPaymentAmount(0.0);
     advanceAmount(0.0);
  }
}
