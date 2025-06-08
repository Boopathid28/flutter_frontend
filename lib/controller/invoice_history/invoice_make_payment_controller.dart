import 'dart:developer';

import 'package:ausales_application/controller/invoice_history/invoice_history_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/invoice/invoice_history_models.dart';
import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';
import 'package:ausales_application/model/payment/old_gold_payment_model.dart';
import 'package:ausales_application/model/payment/suspense_payment_model.dart';
import 'package:ausales_application/service/invoice/invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceMakePaymentController extends GetxController {
  final InvoiceHistoryListController _invoiceHistoryListController =
      Get.put(InvoiceHistoryListController());

  TextEditingController paidAmountController = TextEditingController();

  RxList<PaymentDenominationItemModel> denominationPaymentParticulars =
      <PaymentDenominationItemModel>[].obs;

  RxList<AdvancePaymentItemModel> advanceParticulars =
      <AdvancePaymentItemModel>[].obs;

  RxList<SuspensePaymentItemModel> suspenseParticulars =
      <SuspensePaymentItemModel>[].obs;

  RxList<SuspenseFetchParticularsDetails> suspenseFetchParticulars =
      <SuspenseFetchParticularsDetails>[].obs;

  RxList<OldItemPaymentDetails> oldPurchaseParticulars =
      <OldItemPaymentDetails>[].obs;

  RxList<OldPurchasePaymentParticularsDetails> oldPurchaseFetchParticulars =
      <OldPurchasePaymentParticularsDetails>[].obs;

  RxList<ChitPaymentDenominationParticulars> chitPaymentParticulars =
      <ChitPaymentDenominationParticulars>[].obs;
  RxList<ChitSchemeListData> selectedChitSchemeList =
      <ChitSchemeListData>[].obs;
  RxList<RetrieveParticularDetails> selectedTagChitPaymentParticulars =
      <RetrieveParticularDetails>[].obs;

  RxDouble totalBonusAmount = 0.0.obs;
  RxDouble totalPaidAmount = 0.0.obs;
  RxDouble totalPaidWeight = 0.0.obs;
  RxDouble balancePaidAmount = 0.0.obs;
  RxDouble balancePaidWeight = 0.0.obs;
  RxDouble negativeBalancePaidWeight = 0.0.obs;

  RxDouble advanceAmount = 0.0.obs;
  RxDouble suspenseAmount = 0.0.obs;
  RxDouble oldPurchaseAmount = 0.0.obs;
  RxDouble denominationAmount = 0.0.obs;
  RxDouble chitSchemeRedeemAmount = 0.0.obs;
  RxDouble chitSchemeBenifitAmount = 0.0.obs;
  RxDouble newPaymentAmount = 0.0.obs;

  RxBool isPayLoading = false.obs;

  void calculateDenominationPayments() {
    double totalPaid = 0.0;
    for (var i in denominationPaymentParticulars.value) {
      totalPaid += i.paidAmount!;
    }
    paidAmountController.text = totalPaid.toStringAsFixed(2);
    denominationAmount(double.parse(totalPaid.toStringAsFixed(2)));
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

  void calculateSuspenseValues() {
    double totalValue = 0.0;
    for (var i in suspenseFetchParticulars) {
      totalValue += double.parse(i.totalAmount!);
    }
    suspenseAmount(totalValue);
    calculateNewPaymentValue();
  }

  void calculateOldPurchaseValues() {
    double totalValue = 0.0;
    for (var i in oldPurchaseFetchParticulars) {
      totalValue += double.parse(i.totalAmount!);
    }
    oldPurchaseAmount(totalValue);
    calculateNewPaymentValue();
  }

  void calculateChitPayableValues() {
    double totalWastagePercentAmount = 0.0;
    double totalFlatWastageAmount = 0.0;
    double totalMakingChargePerGram = 0.0;
    double totalFlatMakingCharge = 0.0;
    double totalMetalValue = 0.0;

    for (var i in selectedTagChitPaymentParticulars.value) {

      if (i.grossWeight == i.wastageWeightReduced) {
        totalMetalValue += ((i.rate ?? 0.0) * ((i.netWeight ?? 0.0)));
      } else {
        totalMetalValue += ((i.rate ?? 0.0) * ((i.wastageWeightReduced ?? 0.0)));
      }

      if (i.wastageWeightReduced == i.grossWeight) {
        if (i.flatWastageType == flatWastageRupeeType) {
          totalFlatWastageAmount += i.flatWastage!;
        } else {
          totalFlatWastageAmount += ((i.flatWastage ?? 0.0) * (i.rate ?? 0.0));
        }
      } else {
        if (i.flatWastageType == flatWastageRupeeType) {
          double perGramFlatWastageValue =
              (i.flatWastage ?? 0.0) / (i.grossWeight ?? 0.0);
          totalFlatWastageAmount +=
              (perGramFlatWastageValue * (i.wastageWeightReduced ?? 0.0));
        } else {
          double perGramFlatWastageValue =
              (i.flatWastage ?? 0.0) / (i.grossWeight ?? 0.0);
          totalFlatWastageAmount +=
              ((perGramFlatWastageValue * (i.wastageWeightReduced ?? 0.0)) *
                  (i.rate ?? 0.0));
        }
      }

      totalMakingChargePerGram +=
            ((i.makingChargePerGram ?? 0.0) * (i.wastageWeightReduced ?? 0.0));

      if (i.wastageWeightReduced == i.grossWeight) {
        totalFlatMakingCharge += i.flatMakingCharge ?? 0.0;
      } else {
        double flatMakingChargePerGramValue =
            (i.flatMakingCharge ?? 0.0) / (i.grossWeight ?? 0.0);
        totalFlatMakingCharge +=
            (flatMakingChargePerGramValue * (i.wastageWeightReduced ?? 0.0));
      }

      double wastageAmount = ((i.wastageWeightReduced ?? 0.0) *
              ((i.wastagePercent ?? 0.0) / 100)) *
          (i.rate ?? 0.0);

      totalWastagePercentAmount += wastageAmount;
    }

    double totalSchemeValue = 0.0;
    for (var i in chitPaymentParticulars.value) {
      if (amountSchemes.contains(i.schemeType)) {
        totalSchemeValue += (i.schemeAmount! + i.bonusAmount!);
      }
    }

    String chitRedeemValue = (double.parse(totalWastagePercentAmount.toStringAsFixed(2)) + 
      double.parse(totalFlatWastageAmount.toStringAsFixed(2)) +
      double.parse(totalMakingChargePerGram.toStringAsFixed(2)) + 
      double.parse(totalFlatMakingCharge.toStringAsFixed(2)) +
      double.parse(totalMetalValue.toStringAsFixed(2)) +
      double.parse(totalSchemeValue.toStringAsFixed(2))).toStringAsFixed(2);
    chitSchemeRedeemAmount(double.parse(chitRedeemValue));
    String chitBenifitValue = (double.parse(totalWastagePercentAmount.toStringAsFixed(2)) + 
      double.parse(totalFlatWastageAmount.toStringAsFixed(2)) +
      double.parse(totalMakingChargePerGram.toStringAsFixed(2)) + 
      double.parse(totalFlatMakingCharge.toStringAsFixed(2))).toStringAsFixed(2);
    chitSchemeBenifitAmount(double.parse(chitBenifitValue));
    calculateNewPaymentValue();
  }

  void chitSchemeReset() {
    selectedTagChitPaymentParticulars([]);
    selectedChitSchemeList([]);
    chitPaymentParticulars([]);
    chitSchemeRedeemAmount(0.0);
    calculateNewPaymentValue();
  }

  void calculateNewPaymentValue() {
    double totalValue = oldPurchaseAmount.value +
        suspenseAmount.value +
        advanceAmount.value +
        chitSchemeRedeemAmount.value +
        denominationAmount.value;

    newPaymentAmount(totalValue);
  }

  Future makePayment(BuildContext context, String branch, String billId,
      double balanceValue) async {
    if (!isPayLoading.value) {
      isPayLoading(true);

      if (newPaymentAmount.value != 0 &&
          newPaymentAmount.value <= balanceValue) {
        List<int> suspenseList = [];
        for (var i in suspenseFetchParticulars.value) {
          suspenseList.add(int.parse(i.id!));
        }

        List<int> oldList = [];
        for (var i in oldPurchaseFetchParticulars.value) {
          oldList.add(int.parse(i.id!));
        }

        ChitPaymentDetails chitValues = ChitPaymentDetails(
          totalAmount: chitSchemeRedeemAmount.value,
          benefitAmount: chitSchemeBenifitAmount.value,
          schemeWeight: totalPaidWeight.value,
          balanceWeight: negativeBalancePaidWeight.value,
          denominationDetails: chitPaymentParticulars.value,
        );

        BillPaymentModel payload = BillPaymentModel(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            branch: branch,
            id: billId,
            paymentDenominationDetails: denominationPaymentParticulars.value,
            advanceDetails: advanceParticulars.value,
            suspenseDetails: suspenseList,
            chitDetails: [chitValues],
            exchangeDetails: oldList);

        final String? data = await InvoiceService.makeBillPayment(
            context: context, payload: payload);

        if (data != null) {
          _invoiceHistoryListController.getInvoiceList(context);
          Get.back();
        }
      }
      isPayLoading(false);
    }
  }

  resetValues() {
    denominationAmount(0.0);
    advanceAmount(0.0);
    suspenseAmount(0.0);
    oldPurchaseAmount(0.0);
    paidAmountController.clear();
    denominationPaymentParticulars([]);
    advanceParticulars([]);
    suspenseFetchParticulars([]);
    suspenseParticulars([]);
    oldPurchaseFetchParticulars([]);
    oldPurchaseParticulars([]);
  }
}
