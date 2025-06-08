import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/denomination_payment/denomination_payment_item_form.dart';
import 'package:ausales_application/view/widgets/payment_widgets/denomination_payment/denomination_payment_particulars_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DenominationPayment extends StatefulWidget {
  TextEditingController totalPaymentController;
  List<PaymentDenominationItemModel> paymentDenominationList;
  Function() onCompleted;
  DenominationPayment(
      {super.key,
      required this.totalPaymentController,
      required this.paymentDenominationList,
      required this.onCompleted});

  @override
  State<DenominationPayment> createState() => _DenominationPaymentState();
}

class _DenominationPaymentState extends State<DenominationPayment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(label: "Payment"),
              SizedBox(
                height: 7.w,
              ),
              BillingTextInput(
                width: 300.w,
                height: 45,
                filled: true,
                filledColor: Colors.white,
                controller: widget.totalPaymentController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: 'no_validation',
                readOnly: true,
                onChanged: (value) {},
              ),
            ],
          ),
          SizedBox(
            height: 7.w,
          ),
          PrimaryButton(
              btnWidth: 300.w,
              isLoading: false,
              text: 'Add Payment Details',
              onPressed: () async {
                await Get.bottomSheet(
                    isDismissible: false,
                    Container(
                      height: 700,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Responsive.isMobile(context)
                                        ? 100
                                        : 200,
                                    child: Text(
                                      "Add Payment",
                                      style: Responsive.isDesktop(context)
                                          ? TextPalette.screenTitle
                                          : TextPalette.tableHeaderTextStyle,
                                    ),
                                  ),
                                  PrimaryButton(
                                      btnWidth: 100.w,
                                      isLoading: false,
                                      text: 'Done',
                                      onPressed: widget.onCompleted)
                                ],
                              ),
                            ),
                            DenominationPaymentItemForm(
                                particularList: widget.paymentDenominationList),
                            SizedBox(
                              height: 15.h,
                            ),
                            DenominationPaymentParticularsTable(
                              particularList: widget.paymentDenominationList,
                            )
                          ],
                        ),
                      ),
                    ));
              }),
        ],
      ),
    );
  }
}
