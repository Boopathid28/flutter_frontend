import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_advance_payment/order_advance_payment.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_chit_scheme_payment/order_chit_scheme_payment.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_old_gold_payment/order_old_metal_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderMakePayment extends StatefulWidget {
  const OrderMakePayment({super.key});

  @override
  State<OrderMakePayment> createState() => _OrderMakePaymentState();
}

class _OrderMakePaymentState extends State<OrderMakePayment> {
  final OrderFormController _orderFormController =
      Get.put(OrderFormController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Make Payment',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        child: Column(
          children: [
            Wrap(
              spacing: 15.w,
              runSpacing: 15.h,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Text(
                          "${_orderFormController.orderItemsAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "GST Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Text(
                          "${_orderFormController.orderItemsGstAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Payable Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Text(
                          "${_orderFormController.orderItemsPayableAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Balance Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Text(
                          "${_orderFormController.balanceAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                  ],
                ),
              ],
            ),
            OrderAdvancePayment(
              advanceParticulars: _orderFormController.advanceParticulars,
              onCompleted: _orderFormController.calculateAdvancePayment,
            ),
            OrderOldMetalPayment(oldMetalFetchParticulars: _orderFormController.oldPurchaseFetchParticulars, oldMetalParticulars: _orderFormController.oldPurchaseParticulars, onCompleted: _orderFormController.calculateOldPurchasePayment,),
            OrderChitSchemePayment(mobileNo: _orderFormController.customerDetails.value.mobileNumber!, selectedChitSchemeList: _orderFormController.selectedChitSchemeList, selectedTagChitPaymentParticulars: _orderFormController.selectedTagChitPaymentParticulars,chitPaymentList: _orderFormController.chitPaymentParticulars, taggedItems: _orderFormController.orderitemdetailsParticularList, onClear: _orderFormController.chitSchemeReset, onCompleted: _orderFormController.calculateChitPayableValues),
            Wrap(
              spacing: 15.w,
              runSpacing: 15.h,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Advance Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Text(
                          "${_orderFormController.advanceAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Old Purchase Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Text(
                          "${_orderFormController.oldPurchaseAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Chit Scheme Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Text(
                          "${_orderFormController.chitSchemeRedeemAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
