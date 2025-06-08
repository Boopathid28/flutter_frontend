import 'package:ausales_application/controller/invoice_history/invoice_make_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/invoice/invoice_history_models.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/advance_payment/advance_payment.dart';
import 'package:ausales_application/view/widgets/payment_widgets/chit_scheme_payment/chit_scheme_payment.dart';
import 'package:ausales_application/view/widgets/payment_widgets/denomination_payment/denomination_payment.dart';
import 'package:ausales_application/view/widgets/payment_widgets/old_gold_payment/old_metal_payment.dart';
import 'package:ausales_application/view/widgets/payment_widgets/suspense_payment/suspense_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceMakePayment extends StatefulWidget {
  String branch;
  String customer;
  String customerMobile;
  String gstType;
  double totalAmount;
  double gstAmount;
  double payableAmount;
  double paidAmount;
  double balanceAmount;
  String billId;
  List<RetrieveParticularDetails> tagItems;
  InvoiceMakePayment({super.key, required this.branch, required this.customer, required this.customerMobile, required this.gstType, required this.balanceAmount,
  required this.totalAmount, required this.gstAmount, required this.payableAmount, required this.paidAmount, required this.billId, required this.tagItems});

  @override
  State<InvoiceMakePayment> createState() => _InvoiceMakePaymentState();
}

class _InvoiceMakePaymentState extends State<InvoiceMakePayment> {
  final InvoiceMakePaymentController _invoiceMakePaymentController =
      Get.put(InvoiceMakePaymentController());

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

          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
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
                        "GST Amount: ",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "${widget.gstAmount ?? ""}",
                        style: TextPalette.viewDetailsDataTextStyle,
                      ),
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
                      Text(
                        "${widget.payableAmount ?? ""}",
                        style: TextPalette.viewDetailsDataTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Paid Amount: ",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "${widget.paidAmount ?? ""}",
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
              Responsive.isDesktop(context) ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                      OldMetalPayment(branch: widget.branch, customer: widget.customer, oldMetalParticulars: _invoiceMakePaymentController.oldPurchaseParticulars, oldMetalFetchParticulars: _invoiceMakePaymentController.oldPurchaseFetchParticulars, onCompleted: _invoiceMakePaymentController.calculateOldPurchaseValues, gstType: widget.gstType,),
                      ChitSchemePayment(selectedChitSchemeList: _invoiceMakePaymentController.selectedChitSchemeList.value, mobileNo: widget.customerMobile, onClear: _invoiceMakePaymentController.chitSchemeReset, onCompleted: _invoiceMakePaymentController.calculateChitPayableValues, taggedItems: widget.tagItems, chitPaymentList: _invoiceMakePaymentController.chitPaymentParticulars, selectedTagChitPaymentParticulars: _invoiceMakePaymentController.selectedTagChitPaymentParticulars,),
                        ],
                      ),
                      Column(
                        children: [
                          AdvancePayment(advanceParticulars: _invoiceMakePaymentController.advanceParticulars, branch: widget.branch, customer: widget.customer, onCompleted: _invoiceMakePaymentController.calculateAdvanceValues,),
                          SuspensePayment(branch: widget.branch, customer: widget.customer, suspenseParticulars: _invoiceMakePaymentController.suspenseParticulars, suspenseFetchParticulars: _invoiceMakePaymentController.suspenseFetchParticulars, onCompleted: _invoiceMakePaymentController.calculateSuspenseValues,),
                        ],
                      ),
                        DenominationPayment(
                          totalPaymentController:
                              _invoiceMakePaymentController.paidAmountController,
                          paymentDenominationList: _invoiceMakePaymentController.denominationPaymentParticulars,
                          onCompleted: _invoiceMakePaymentController.calculateDenominationPayments,
                        ),
                    ],
                  ),
                ],
              ) : SingleChildScrollView(
                child: Column(
                  children: [
                    DenominationPayment(
                      totalPaymentController:
                          _invoiceMakePaymentController.paidAmountController,
                      paymentDenominationList: _invoiceMakePaymentController.denominationPaymentParticulars,
                      onCompleted: _invoiceMakePaymentController.calculateDenominationPayments,
                    ),
                    ChitSchemePayment(selectedChitSchemeList: _invoiceMakePaymentController.selectedChitSchemeList.value, mobileNo: widget.customerMobile, onClear: _invoiceMakePaymentController.chitSchemeReset,  onCompleted: _invoiceMakePaymentController.calculateChitPayableValues, taggedItems: widget.tagItems, chitPaymentList: _invoiceMakePaymentController.chitPaymentParticulars, selectedTagChitPaymentParticulars: _invoiceMakePaymentController.selectedTagChitPaymentParticulars,),
                    AdvancePayment(advanceParticulars: _invoiceMakePaymentController.advanceParticulars, branch: widget.branch, customer: widget.customer, onCompleted: _invoiceMakePaymentController.calculateAdvanceValues,),
                    SuspensePayment(branch: widget.branch, customer: widget.customer, suspenseParticulars: _invoiceMakePaymentController.suspenseParticulars, suspenseFetchParticulars: _invoiceMakePaymentController.suspenseFetchParticulars, onCompleted: _invoiceMakePaymentController.calculateSuspenseValues,),
                    OldMetalPayment(branch: widget.branch, customer: widget.customer, oldMetalParticulars: _invoiceMakePaymentController.oldPurchaseParticulars, oldMetalFetchParticulars: _invoiceMakePaymentController.oldPurchaseFetchParticulars, onCompleted: _invoiceMakePaymentController.calculateOldPurchaseValues, gstType: widget.gstType,)
                  ],
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
                        "Suspense Amount: ",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Obx(() => Text(
                        "${_invoiceMakePaymentController.suspenseAmount.value ?? "0.00"}",
                        style: TextPalette.viewDetailsDataTextStyle,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Scheme Amount: ",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Obx(() => Text(
                        "${_invoiceMakePaymentController.chitSchemeRedeemAmount.value ?? "0.00"}",
                        style: TextPalette.viewDetailsDataTextStyle,
                      )),
                    ],
                  ),
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
                        "${_invoiceMakePaymentController.advanceAmount.value ?? "0.00"}",
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
                        "${_invoiceMakePaymentController.oldPurchaseAmount.value ?? "0.00"}",
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
                      Text(
                        "${_invoiceMakePaymentController.paidAmountController.text}",
                        style: TextPalette.viewDetailsDataTextStyle,
                      ),
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
                        "${_invoiceMakePaymentController.newPaymentAmount.value ?? "0.00"}",
                        style: TextPalette.viewDetailsDataTextStyle,
                      )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Obx(() => PrimaryButton(isLoading: _invoiceMakePaymentController.isPayLoading.value, text: 'Pay', onPressed: _invoiceMakePaymentController.isPayLoading.value ? null : () {
          _invoiceMakePaymentController.makePayment(context, widget.branch, widget.billId, widget.balanceAmount);
        }))
      ],
    );
  }
}
