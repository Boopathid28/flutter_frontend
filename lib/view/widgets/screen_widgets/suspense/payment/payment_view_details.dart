import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentViewDetails extends StatefulWidget {
  const PaymentViewDetails({super.key});

  @override
  State<PaymentViewDetails> createState() => _PaymentViewDetailsState();
}

class _PaymentViewDetailsState extends State<PaymentViewDetails> {
  final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Container(
        width: double.infinity,
        child: Obx(() => Wrap(
                      runSpacing: 20.h,
                      spacing: 20.w,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Suspense Amount: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_suspensePaymentController.currentPayment.value!.suspenseAmount ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Suspense Weight: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_suspensePaymentController.currentPayment.value!.suspenseWeight  ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Total Paid Amount: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_suspensePaymentController.currentPayment.value!.totalPaidAmount  ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Remaining Amount: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_suspensePaymentController.currentPayment.value!.remainingAmount  ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                      ],
                    )),
      ),
    );
  }

}
