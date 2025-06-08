import 'package:ausales_application/controller/payment_controllers/old_metal_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/old_gold_payment_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/old_gold_payment/old_metal_payment_item_form.dart';
import 'package:ausales_application/view/widgets/payment_widgets/old_gold_payment/old_metal_payment_particulars_table.dart';
import 'package:ausales_application/view/widgets/payment_widgets/old_gold_payment/selected_old_metal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldMetalPayment extends StatefulWidget {
  RxList<OldPurchasePaymentParticularsDetails> oldMetalFetchParticulars;
  RxList<OldItemPaymentDetails> oldMetalParticulars;
  String branch;
  String customer;
  String gstType;
  Function() onCompleted;
  OldMetalPayment(
      {super.key,
      required this.oldMetalFetchParticulars,
      required this.oldMetalParticulars,
      required this.branch,
      required this.customer,
      required this.onCompleted,
      required this.gstType});

  @override
  State<OldMetalPayment> createState() => _OldMetalPaymentState();
}

class _OldMetalPaymentState extends State<OldMetalPayment> {
  final OldMetalPaymentController _oldMetalPaymentController =
      Get.put(OldMetalPaymentController());

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
              CustomLabel(label: "Old Metals"),
              SizedBox(
                height: 7.w,
              ),
              BillingTextInput(
                width: 300.w,
                height: 45,
                filled: true,
                filledColor: Colors.white,
                controller: _oldMetalPaymentController.oldMetalSearchController,
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
                      _oldMetalPaymentController.isOldMetalFetchLoading.value,
                  text: 'Fetch Details',
                  onPressed: () {
                    _oldMetalPaymentController.getOldMetalDetails(context,
                        widget.oldMetalFetchParticulars, widget.onCompleted);
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
                                        'Old Metal Details',
                                        style: TextPalette.screenTitle,
                                      ),
                                      Row(
                                        children: [
                                          Obx(() => PrimaryButton(
                                              btnWidth: 100.w,
                                              isLoading:
                                                  _oldMetalPaymentController
                                                      .isFormSubmit.value,
                                              text: "Create",
                                              onPressed: () {
                                                _oldMetalPaymentController
                                                    .createOldPurchase(
                                                        context,
                                                        widget
                                                            .oldMetalParticulars,
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
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  OldMetalPaymentItemForm(
                                      branch: widget.branch,
                                      customer: widget.customer,
                                      gstType: widget.gstType,
                                      itemsList: widget.oldMetalParticulars),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  OldMetalPaymentParticularsTable(
                                    particularList: widget.oldMetalParticulars,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
            ],
          ),
          SizedBox(
            height: 7.w,
          ),
          PrimaryButton(
              btnWidth: 300.w,
              isLoading: false,
              text: 'View Old Purchase Details',
              onPressed: () async {
                await Get.dialog(
                    SelectedOldMetalList(
                          onCompleted: () {
                            widget.oldMetalFetchParticulars([]);
                            widget.onCompleted();
                          },
                          oldMetalItemsList: widget.oldMetalFetchParticulars,
                        ));
              }),
        ],
      ),
    );
  }
}
