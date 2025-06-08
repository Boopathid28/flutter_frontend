import 'dart:developer';

import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/service/payment/payment_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_chit_scheme/invocie_chit_scheme_payment_tag_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_chit_scheme/invoice_chit_scheme_payement_particulars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class InvoiceChitSchemeController extends GetxController {
  final InvoiceController _invoiceController = Get.put(InvoiceController());

  RxBool isCitSchemeFetchLoading = false.obs;

  RxList<ChitSchemeListData> chitSchemeAllList = <ChitSchemeListData>[].obs;
  RxInt page = 1.obs;
  RxInt totalPages = 0.obs;

  RxBool isSchemesSelected = false.obs;
  // RxList<ChitSchemeListData> selectedChitSchemeList =
  //     <ChitSchemeListData>[].obs;
  RxList<int> selectedChitSchemeIdsList = <int>[].obs;

  RxList<ParticularDetails> sortedTagItem = <ParticularDetails>[].obs;
  RxList<String> selectedTagItemIdsList = <String>[].obs;

  Future getChitSchemeDetails(BuildContext context) async {
    if (_invoiceController.chitController.text.isNotEmpty) {
      if (!isCitSchemeFetchLoading.value) {
        isCitSchemeFetchLoading(true);

        final Map<String, dynamic>? data =
            await PaymentService.fetchChitSchemeList(
                context: context,
                page: page.value,
                mobile: _invoiceController.chitController.text,
                metal: "1");

        if (data != null) {
          isCitSchemeFetchLoading(false);
          chitSchemeAllList(data['data']);
          totalPages(data['total_pages']);

          await Get.bottomSheet(
              isDismissible: false,
              Container(
                height: 700,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chit Details',
                              style: TextPalette.screenTitle,
                            ),
                            SecondaryButton(
                                btnWidth: 100,
                                isLoading: false,
                                text: "Close",
                                onPressed: () {
                                  isSchemesSelected(false);
                                  selectedTagItemIdsList([]);
                                  _invoiceController
                                      .selectedTagChitPaymentParticulars([]);
                                  selectedChitSchemeIdsList([]);
                                  _invoiceController.selectedChitSchemeList([]);
                                  Get.back();
                                })
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(() => SizedBox(
                            width: double.infinity,
                            child: !isSchemesSelected.value
                                ? InvoiceChitSchemePayementParticulars(
                                    selectedChitSchemeList: _invoiceController
                                        .selectedChitSchemeList,
                                    chitItemsList: _invoiceController
                                        .chitPaymentParticulars)
                                : SizedBox(
                                    child: Column(
                                      children: [
                                        Wrap(
                                          spacing: 10.w,
                                          runSpacing: 5.h,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Scheme Amount: ",
                                                  style: TextPalette
                                                      .tableHeaderTextStyle,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Obx(() => Text(
                                                      "${_invoiceController.totalPaidAmount.value}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Bonus Amount: ",
                                                  style: TextPalette
                                                      .tableHeaderTextStyle,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Obx(() => Text(
                                                      "${_invoiceController.totalBonusAmount.value}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Scheme Weight: ",
                                                  style: TextPalette
                                                      .tableHeaderTextStyle,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Obx(() => Text(
                                                      "${_invoiceController.totalPaidWeight.value ?? ""}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Balance Weight: ",
                                                  style: TextPalette
                                                      .tableHeaderTextStyle,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Obx(() => Text(
                                                      "${_invoiceController.balancePaidWeight.value ?? ""}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        InvocieChitSchemePaymentTagParticulars(
                                            taggedItems: sortedTagItem,
                                            selectedTagChitPaymentParticulars:
                                                _invoiceController
                                                    .selectedTagChitPaymentParticulars)
                                      ],
                                    ),
                                  ))),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(() => PrimaryButton(
                            btnWidth: 100,
                            isLoading: false,
                            text: isSchemesSelected.value ? "Done" : "Next",
                            onPressed: () {
                              if (isSchemesSelected.value) {
                                isSchemesSelected(false);
                                calculateChitPayableValues();
                                Get.back();
                              } else {
                                isSchemesSelected(true);
                                calulateSelectedSchemes();
                              }
                            }))
                      ],
                    ),
                  ),
                ),
              ));
        }
      }
    }
  }

  void calculateChitPayableValues() {
    double totalWastagePercentAmount = 0.0;
    double totalFlatWastageAmount = 0.0;
    double totalMakingChargePerGram = 0.0;
    double totalFlatMakingCharge = 0.0;
    double totalMetalValue = 0.0;

    for (var i in _invoiceController.selectedTagChitPaymentParticulars.value) {
      if (i.grossWeight == i.wastageWeightReduced) {
        totalMetalValue += ((i.rate ?? 0.0) * ((i.netWeight ?? 0.0)));
      } else {
        totalMetalValue +=
            ((i.rate ?? 0.0) * ((i.wastageWeightReduced ?? 0.0)));
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
    for (var i in _invoiceController.chitPaymentParticulars.value) {
      if (amountSchemes.contains(i.schemeType)) {
        totalSchemeValue += (i.schemeAmount! + i.bonusAmount!);
      }
    }

    String chitRedeemValue =
        (double.parse(totalWastagePercentAmount.toStringAsFixed(2)) +
                double.parse(totalFlatWastageAmount.toStringAsFixed(2)) +
                double.parse(totalMakingChargePerGram.toStringAsFixed(2)) +
                double.parse(totalFlatMakingCharge.toStringAsFixed(2)) +
                double.parse(totalMetalValue.toStringAsFixed(2)) +
                double.parse(totalSchemeValue.toStringAsFixed(2)))
            .toStringAsFixed(2);
    _invoiceController.chitAmount(double.parse(chitRedeemValue));
    String chitBenifitValue =
        (double.parse(totalWastagePercentAmount.toStringAsFixed(2)) +
                double.parse(totalFlatWastageAmount.toStringAsFixed(2)) +
                double.parse(totalMakingChargePerGram.toStringAsFixed(2)) +
                double.parse(totalFlatMakingCharge.toStringAsFixed(2)))
            .toStringAsFixed(2);
    _invoiceController.chitSchemeBenifitAmount(double.parse(chitBenifitValue));
    _invoiceController.calculateBilling();
  }

  void chitSchemeReset() {
    _invoiceController.selectedTagChitPaymentParticulars([]);
    _invoiceController.selectedChitSchemeList([]);
    _invoiceController.chitPaymentParticulars([]);
    _invoiceController.chitAmount(0.0);
    _invoiceController.calculateBilling();
  }

  void selecteTagItems(BuildContext context, ParticularDetails tag) {
    if (selectedTagItemIdsList.contains(tag.sNo)) {
      selectedTagItemIdsList.removeWhere((item) => item == tag.sNo);

      int findIndex = _invoiceController.selectedTagChitPaymentParticulars
          .indexWhere((item) => item.tag == tag.tag);

      var jsonData = _invoiceController
          .selectedTagChitPaymentParticulars[findIndex]
          .toJson();
      _invoiceController.balancePaidWeight(jsonData['wastage_weight_reduced'] +
          _invoiceController.balancePaidWeight.value);
      jsonData['wastage_weight_reduced'] = 0.0;
      _invoiceController.selectedTagChitPaymentParticulars[findIndex] =
          ParticularDetails.fromJson(jsonData);
      _invoiceController.selectedTagChitPaymentParticulars
          .removeWhere((item) => item.sNo == tag.sNo);
    } else {
      if (_invoiceController.balancePaidWeight.value > 0) {
        selectedTagItemIdsList.add(tag.sNo!);
        _invoiceController.selectedTagChitPaymentParticulars.add(tag);

        int findIndex = _invoiceController.selectedTagChitPaymentParticulars
            .indexWhere((item) => item.tag == tag.tag);

        if (tag.grossWeight! > _invoiceController.balancePaidWeight.value) {
          var jsonData = _invoiceController
              .selectedTagChitPaymentParticulars[findIndex]
              .toJson();
          jsonData['wastage_weight_reduced'] =
              _invoiceController.balancePaidWeight.value;
          _invoiceController.selectedTagChitPaymentParticulars[findIndex] =
              ParticularDetails.fromJson(jsonData);
          _invoiceController.balancePaidWeight(0);
          _invoiceController.negativeBalancePaidWeight(
              _invoiceController.balancePaidWeight.value -
                  (tag.grossWeight ?? 0.0));
        } else if (tag.grossWeight! <
            _invoiceController.balancePaidWeight.value) {
          var jsonData = _invoiceController
              .selectedTagChitPaymentParticulars[findIndex]
              .toJson();
          jsonData['wastage_weight_reduced'] = tag.grossWeight!;
          _invoiceController.balancePaidWeight(
              _invoiceController.balancePaidWeight.value - tag.grossWeight!);
          _invoiceController.selectedTagChitPaymentParticulars[findIndex] =
              ParticularDetails.fromJson(jsonData);
          _invoiceController.negativeBalancePaidWeight(
              _invoiceController.balancePaidWeight.value -
                  (tag.grossWeight ?? 0.0));
        } else {
          var jsonData = _invoiceController
              .selectedTagChitPaymentParticulars[findIndex]
              .toJson();
          jsonData['wastage_weight_reduced'] =
              _invoiceController.balancePaidWeight.value;
          _invoiceController.selectedTagChitPaymentParticulars[findIndex] =
              ParticularDetails.fromJson(jsonData);
          _invoiceController.balancePaidWeight(0);
          _invoiceController.negativeBalancePaidWeight(
              _invoiceController.balancePaidWeight.value -
                  (tag.grossWeight ?? 0.0));
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("Balance weight 0, you cann't select anything"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }

  void calulateSelectedSchemes() {
    double totalBonus = 0.0;
    double totalPaid = 0.0;
    double totalWeight = 0.0;
    for (var i in _invoiceController.selectedChitSchemeList) {
      if (weightSchemes.contains(i.schemeType)) {
        totalWeight += double.parse(i.totalMetalweight ?? "0.00");
      } else if (amountSchemes.contains(i.schemeType)) {
        totalPaid += double.parse(i.totalPaidAmount ?? "0.000");
      }
      ChitPaymentDenominationParticulars data =
          ChitPaymentDenominationParticulars(
              schemeAccountNumber: i.schemeAccNumber,
              schemeAmount: double.parse(i.totalPaidAmount ?? "0.00"),
              schemeWeight: double.parse(i.totalMetalweight ?? "0.000"),
              bonusAmount: double.parse(i.benefitBonus ?? "0.00"),
              schemeType: i.schemeType);
      _invoiceController.chitPaymentParticulars.add(data);
      totalBonus += double.parse(i.benefitBonus ?? "0.00");
    }

    _invoiceController
        .totalBonusAmount(double.parse(totalBonus.toStringAsFixed(2)));
    _invoiceController
        .totalPaidWeight(double.parse(totalWeight.toStringAsFixed(3)));
    _invoiceController
        .totalPaidAmount(double.parse(totalPaid.toStringAsFixed(2)));
    _invoiceController
        .balancePaidWeight(double.parse(totalWeight.toStringAsFixed(3)));
    _invoiceController
        .balancePaidAmount(double.parse(totalPaid.toStringAsFixed(2)));
  }

  void onSelectedValueChanged(ChitSchemeListData chitItem) {
    if (selectedChitSchemeIdsList.value.contains(chitItem.id)) {
      selectedChitSchemeIdsList.removeWhere((item) => item == chitItem.id);
      _invoiceController.selectedChitSchemeList
          .removeWhere((item) => item.id == chitItem.id);
    } else {
      selectedChitSchemeIdsList.add(chitItem.id!);
      _invoiceController.selectedChitSchemeList.add(chitItem);
    }

    List<ParticularDetails> dataList = [
      ..._invoiceController.particulars.value
    ];
    dataList.sort((a, b) => b.wastagePercent!.compareTo(a.wastagePercent!));
    sortedTagItem(dataList);
  }
}
