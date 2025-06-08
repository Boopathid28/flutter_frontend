import 'package:ausales_application/controller/payment_controllers/advance_payment_controller.dart';
import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/advance_payment/advance_payment_form.dart';
import 'package:ausales_application/view/widgets/payment_widgets/advance_payment/selected_advance_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvancePayment extends StatefulWidget {
  RxList<AdvancePaymentItemModel> advanceParticulars;
  String branch;
  String customer;
  Function() onCompleted;
  AdvancePayment({super.key, required this.advanceParticulars, required this.branch, required this.customer, required this.onCompleted});

  @override
  State<AdvancePayment> createState() => _AdvancePaymentState();
}

class _AdvancePaymentState extends State<AdvancePayment> {

  final AdvancePaymentController _advancePaymentController = Get.put(AdvancePaymentController());

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
              CustomLabel(label: "Advance"),
              SizedBox(
                height: 7.w,
              ),
              BillingTextInput(
                width: 300.w,
                height: 45,
                filled: true,
                filledColor: Colors.white,
                controller: _advancePaymentController.advanceSearchController,
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
                  isLoading: _advancePaymentController.isAdvanceFetchLoading.value,
                  text: 'Fetch Details',
                  onPressed: () {
                    _advancePaymentController.getAdvanceDetails(context, widget.advanceParticulars, widget.onCompleted);
                  })),
              SizedBox(
                width: 10.w,
              ),
              SecondaryButton(
                  btnWidth: Responsive.isMobile(context) ? 125 : 125.w,
                  isLoading: false,
                  text: 'Add',
                  onPressed: () async {
                    await Get.dialog(barrierDismissible: false,AdvancePaymentForm(branch: widget.branch, customer: widget.customer));
                  }),
            ],
          ),
          SizedBox(
            height: 7.w,
          ),
          PrimaryButton(
              btnWidth: 300.w,
              isLoading: false,
              text: 'View Advance Details',
              onPressed: () async {
                await Get.dialog(SelectedAdvanceList(
                  onCompleted: () {
                    widget.advanceParticulars([]);
                    widget.onCompleted();
                  },
                  advanceItemsList: widget.advanceParticulars,
                ));
              }),
        ],
      ),
    );
  }
}