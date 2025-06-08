import 'package:ausales_application/controller/payment_controllers/suspense_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/suspense_payment_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/suspense_payment/selected_suspense_list.dart';
import 'package:ausales_application/view/widgets/payment_widgets/suspense_payment/suspense_payment_item_form.dart';
import 'package:ausales_application/view/widgets/payment_widgets/suspense_payment/suspense_payment_particulars_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspensePayment extends StatefulWidget {
  String branch;
  String customer;
  RxList<SuspensePaymentItemModel> suspenseParticulars;
  RxList<SuspenseFetchParticularsDetails> suspenseFetchParticulars;
  Function() onCompleted;
  SuspensePayment(
      {super.key,
      required this.branch,
      required this.customer,
      required this.suspenseParticulars,
      required this.suspenseFetchParticulars,
      required this.onCompleted});

  @override
  State<SuspensePayment> createState() => _SuspensePaymentState();
}

class _SuspensePaymentState extends State<SuspensePayment> {
  final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

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
              CustomLabel(label: "Suspense"),
              SizedBox(
                height: 7.w,
              ),
              BillingTextInput(
                width: 300.w,
                height: 45,
                filled: true,
                filledColor: Colors.white,
                controller: _suspensePaymentController.suspenseSearchController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: 'no_validation',
                onChanged: (value) {},
              ),
            ],
          ),
          SizedBox(
            height: 7.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(() => PrimaryButton(
                  btnWidth: Responsive.isMobile(context) ? 125 : 125.w,
                  isLoading:
                      _suspensePaymentController.isSuspenseFetchLoading.value,
                  text: 'Fetch Details',
                  onPressed: () {
                    _suspensePaymentController.getSuspenseDetails(context, widget.suspenseFetchParticulars, widget.onCompleted);
                  })),
              SizedBox(
                width: 10.w,
              ),
              SecondaryButton(
                  btnWidth: Responsive.isMobile(context) ? 125 : 125.w,
                  isLoading: false,
                  text: 'Add',
                  onPressed: () async {
                    await Get.bottomSheet(
                                isDismissible: false,
                                Container(
                                  height: 700,
                                  color: Colors.white,
                                  child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Suspense Details',
                                          style: TextPalette.screenTitle,
                                        ),
                                        Row(
                                          children: [
                                            Obx(() => PrimaryButton(
                                                btnWidth: 100.w,
                                                isLoading:
                                                    _suspensePaymentController
                                                        .isFormSubmit.value,
                                                text: "Create",
                                                onPressed: () {
                                                  _suspensePaymentController
                                                      .createSuspense(
                                                          context,
                                                          widget
                                                              .suspenseParticulars,
                                                          widget.branch,
                                                          widget.customer);
                                                })),
                                            SizedBox(
                                              height: 5.w,
                                            ),
                                            SecondaryButton(
                                                btnWidth: 100.w,
                                                isLoading: false,
                                                text: "Close",
                                                onPressed: () {
                                                  Get.back();
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                    SuspensePaymentItemForm(
                                        branch: widget.branch,
                                        customer: widget.customer,
                                        itemsList: widget.suspenseParticulars),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    SuspensePaymentParticularsTable(
                                      particularList:
                                          widget.suspenseParticulars,
                                    )
                                  ],
                                ),
                              ),
                            ),
                                )
                              );
                  }),
            ],
          ),
          SizedBox(
            height: 7.w,
          ),
          PrimaryButton(
              btnWidth: 300.w,
              isLoading: false,
              text: 'View Suspense Details',
              onPressed: () async {
                await Get.dialog(SelectedSuspenseList(
                  onCompleted: () {
                    widget.suspenseFetchParticulars([]);
                    widget.onCompleted();
                  },
                  suspenseItemsList: widget.suspenseFetchParticulars,
                ));
              }),
        ],
      ),
    );
  }
}
