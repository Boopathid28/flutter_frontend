import 'dart:developer';

import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/service/payment/payment_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_chit_scheme_payment/order_chit_scheme_payement_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_chit_scheme_payment/order_chit_scheme_payment_tag_particulars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class OrderChitSchemePaymentController extends GetxController {
  final OrderFormController _orderFormController = Get.put(OrderFormController());

  RxBool isCitSchemeFetchLoading = false.obs;

  TextEditingController chitSchemeSearchController = TextEditingController();

  RxList<ChitSchemeListData> chitSchemeAllList = <ChitSchemeListData>[].obs;
  RxInt page = 1.obs;
  RxInt totalPages = 0.obs;

  RxBool isSchemesSelected = false.obs;
  // RxList<ChitSchemeListData> selectedChitSchemeList =
  //     <ChitSchemeListData>[].obs;
  RxList<int> selectedChitSchemeIdsList = <int>[].obs;

  // RxList<RetrieveParticularDetails> selectedTagItem = <RetrieveParticularDetails>[].obs;
  RxList<String> selectedTagItemIdsList = <String>[].obs;

  Future getChitSchemeDetails(BuildContext context, List<ChitSchemeListData> selectedChitSchemeList,
      List<ChitPaymentDenominationParticulars> chitPaymentDetailsList, List<OrderItemDetails> taggedItems, Function() onComplete, List<OrderItemDetails> selectedTagChitPaymentParticulars) async {
    if (chitSchemeSearchController.text.isNotEmpty) {
      if (!isCitSchemeFetchLoading.value) {
        isCitSchemeFetchLoading(true);
        selectedChitSchemeList=[];
        final Map<String, dynamic>? data =
            await PaymentService.fetchChitSchemeList(
                context: context,
                page: page.value,
                mobile: chitSchemeSearchController.text,
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
                                      selectedTagChitPaymentParticulars = [];
                                      selectedChitSchemeIdsList([]);
                                      selectedChitSchemeList = [];
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
                                    ? OrderChitSchemePayementParticulars(
                                      selectedChitSchemeList: selectedChitSchemeList,
                                        chitItemsList: chitPaymentDetailsList)
                                    : SizedBox(
                                        child: Column(
                                          children: [
                                            Wrap(
                                              spacing: 10.w,
                                              runSpacing: 5.h,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                      "${_orderFormController.totalPaidAmount.value}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                      "${_orderFormController.totalBonusAmount.value}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                      "${_orderFormController.totalPaidWeight.value ?? ""}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                      "${_orderFormController.balancePaidWeight.value ?? ""}",
                                                      style: TextPalette
                                                          .viewDetailsDataTextStyle,
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            OrderChitSchemePaymentTagParticulars(taggedItems: taggedItems, onComplete: onComplete, selectedTagChitPaymentParticulars: selectedTagChitPaymentParticulars)
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
                                    onComplete();
                                    isSchemesSelected(false);
                                    Get.back();
                                  } else {
                                    bool isNext = false;
                                    for (var i in selectedChitSchemeList) {
                                      if (weightSchemes.contains(i.schemeType)) {
                                        isNext = true;
                                        break;
                                      }
                                    }
                                    if (selectedChitSchemeList.length > 0 && isNext) {
                                      isSchemesSelected(true);
                                      calulateSelectedSchemes(
                                        selectedChitSchemeList,
                                          chitPaymentDetailsList);
                                    } else {
                                      isSchemesSelected(false);
                                      calulateSelectedSchemes(
                                        selectedChitSchemeList,
                                          chitPaymentDetailsList);
                                      onComplete();
                                      isSchemesSelected(false);
                                      Get.back();
                                    }
                                  }
                                }))
                          ],
                        ),
                      ),
                    ),
            )
          );
        }
      }
    }
  }

  void calulateSelectedSchemes(
    List<ChitSchemeListData> selectedChitSchemeList,
      List<ChitPaymentDenominationParticulars> chitPaymentDetailsList) {
    double totalBonus = 0.0;
    double totalPaid = 0.0;
    double totalWeight = 0.0;
    for (var i in selectedChitSchemeList) {
      if (weightSchemes.contains(i.schemeType)) {
        totalWeight += double.parse(i.totalMetalweight ?? "0.00");
      } else if (amountSchemes.contains(i.schemeType)) {
        totalPaid += double.parse(i.totalPaidAmount ?? "0.000");
      }
      ChitPaymentDenominationParticulars data = ChitPaymentDenominationParticulars(
        schemeAccountNumber: i.schemeAccNumber,
        schemeAmount: double.parse(i.totalPaidAmount ?? "0.00"),
        schemeWeight: double.parse(i.totalMetalweight ?? "0.000"),
        bonusAmount: double.parse(i.benefitBonus ?? "0.00"),
        schemeType: i.schemeType
      );
      chitPaymentDetailsList.add(data);
      totalBonus += double.parse(i.benefitBonus ?? "0.00");
    }

    _orderFormController.totalBonusAmount(double.parse(totalBonus.toStringAsFixed(2)));
    _orderFormController.totalPaidWeight(double.parse(totalWeight.toStringAsFixed(3)));
    _orderFormController.totalPaidAmount(double.parse(totalPaid.toStringAsFixed(2)));
    _orderFormController.balancePaidWeight(double.parse(totalWeight.toStringAsFixed(3)));
    _orderFormController.balancePaidAmount(double.parse(totalPaid.toStringAsFixed(2)));
  }

  void selecteTagItems(BuildContext context, OrderItemDetails tag, int index, List<OrderItemDetails> dataList, List<OrderItemDetails> selectedTagChitPaymentParticulars) {
    
      if (selectedTagItemIdsList.contains(tag.sNo!)) {
        selectedTagItemIdsList.removeWhere((item) => item.toString() == tag.sNo);

        var jsonData = selectedTagChitPaymentParticulars[index].toJson();
        _orderFormController.balancePaidWeight(jsonData['wastage_weight_reduced'] + _orderFormController.balancePaidWeight.value);
        jsonData['wastage_weight_reduced'] = 0.0;
        selectedTagChitPaymentParticulars[index] = OrderItemDetails.fromJson(jsonData);
        selectedTagChitPaymentParticulars.removeWhere((item) => item.sNo == tag.sNo);
      } else {
        if (_orderFormController.balancePaidWeight.value > 0) {
          selectedTagItemIdsList.add(tag.sNo!);
          selectedTagChitPaymentParticulars.add(tag);
          
          if (double.parse(tag.grossWeight??"0.0") > _orderFormController.balancePaidWeight.value) {
            var jsonData = selectedTagChitPaymentParticulars[index].toJson();
            jsonData['wastage_weight_reduced'] = _orderFormController.balancePaidWeight.value;
            selectedTagChitPaymentParticulars[index] = OrderItemDetails.fromJson(jsonData);
            _orderFormController.balancePaidWeight(0);
            _orderFormController.negativeBalancePaidWeight(_orderFormController.balancePaidWeight.value - double.parse(tag.grossWeight??"0.0"));
          } else if (double.parse(tag.grossWeight??"0.0") < _orderFormController.balancePaidWeight.value) {
            var jsonData = selectedTagChitPaymentParticulars[index].toJson();
            jsonData['wastage_weight_reduced'] = tag.grossWeight!;
            _orderFormController.balancePaidWeight(_orderFormController.balancePaidWeight.value - double.parse(tag.grossWeight??"0.0"));
            selectedTagChitPaymentParticulars[index] = OrderItemDetails.fromJson(jsonData);
            _orderFormController.negativeBalancePaidWeight(_orderFormController.balancePaidWeight.value - double.parse(tag.grossWeight??"0.0"));
          } else {
            var jsonData = selectedTagChitPaymentParticulars[index].toJson();
            jsonData['wastage_weight_reduced'] = _orderFormController.balancePaidWeight.value;
            selectedTagChitPaymentParticulars[index] = OrderItemDetails.fromJson(jsonData);
            _orderFormController.balancePaidWeight(0);
            _orderFormController.negativeBalancePaidWeight(_orderFormController.balancePaidWeight.value - double.parse(tag.grossWeight??"0.0"));
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

  void onSelectedValueChanged(ChitSchemeListData chitItem,
      List<ChitPaymentDenominationParticulars> chitPaymentDetailsList,
      List<ChitSchemeListData> selectedChitSchemeList) {
    if (selectedChitSchemeIdsList.value.contains(chitItem.id)) {
      selectedChitSchemeIdsList.removeWhere((item) => item == chitItem.id);
      selectedChitSchemeList.removeWhere((item) => item.id == chitItem.id);
    } else {
      selectedChitSchemeIdsList.add(chitItem.id!);
      selectedChitSchemeList.add(chitItem);
    }
  }
}
