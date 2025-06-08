import 'package:ausales_application/controller/repair_creation/repair_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/advance_payment/advance_payment.dart';
import 'package:ausales_application/view/widgets/payment_widgets/denomination_payment/denomination_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RepairMakePayment extends StatefulWidget {
  String branch;
  String customer;
  String? repairId;
  String? totalAmount;
  String? totalPayment;
  String? balanceAmount;
  RepairMakePayment({
    super.key,
    required this.branch,
    required this.customer,
    required this.repairId,
    required this.balanceAmount,
    required this.totalAmount,
    required this.totalPayment,
  });

  @override
  State<RepairMakePayment> createState() => _RepairMakePaymentState();
}

class _RepairMakePaymentState extends State<RepairMakePayment> {
  final RepairMakePaymentController _repairMakePaymentController =
      Get.put(RepairMakePaymentController());

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
                _repairMakePaymentController.resetForm();
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 10.w,
            runSpacing: 5.h,
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
                  Text(
                    "${widget.totalAmount ?? ""}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total Payment: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${widget.totalPayment ?? ""}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
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
                  Text(
                    "${widget.balanceAmount ?? ""}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: Responsive.isDesktop(context)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DenominationPayment(
                            totalPaymentController: _repairMakePaymentController
                                .paidAmountController,
                            paymentDenominationList:
                                _repairMakePaymentController
                                    .denominationPaymentParticulars,
                            onCompleted: _repairMakePaymentController
                                .calculateDenominationPayments,
                          ),
                          AdvancePayment(
                            advanceParticulars:
                                _repairMakePaymentController.advanceParticulars,
                            branch: widget.branch,
                            customer: widget.customer,
                            onCompleted: _repairMakePaymentController
                                .calculateAdvanceValues,
                          )
                        ],
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DenominationPayment(
                          totalPaymentController:
                              _repairMakePaymentController.paidAmountController,
                          paymentDenominationList: _repairMakePaymentController
                              .denominationPaymentParticulars,
                          onCompleted: _repairMakePaymentController
                              .calculateDenominationPayments,
                        ),
                        AdvancePayment(
                          advanceParticulars:
                              _repairMakePaymentController.advanceParticulars,
                          branch: widget.branch,
                          customer: widget.customer,
                          onCompleted: _repairMakePaymentController
                              .calculateAdvanceValues,
                        )
                      ],
                    ),
                  ),
          ),
          Wrap(
                  spacing: 10.w,
                  runSpacing: 5.h,
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
                          "${_repairMakePaymentController.advanceAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Denomination Amount: ",
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                         Obx(() => Text(
                          "${_repairMakePaymentController.denominationAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total Payment Amount: ",
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Obx(() => Text(
                          "${_repairMakePaymentController.newPaymentAmount.value ?? "0.00"}",
                          style: TextPalette.viewDetailsDataTextStyle,
                        )),
                      ],
                    ),
                  ],
                ),
        ],
      ),
      actions: [
        PrimaryButton(
            isLoading: _repairMakePaymentController.isSubmitLoading.value,
            text: 'Pay',
            onPressed: () {
              _repairMakePaymentController.submitRepairForm(
                  context, widget.repairId, widget.branch);
            })
      ],
    );
  }
}
