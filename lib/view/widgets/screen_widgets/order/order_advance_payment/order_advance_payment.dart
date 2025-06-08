import 'package:ausales_application/controller/order/order_advance/order_advance_payment_controller.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_advance_payment/order_advance_payment_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_advance_payment/order_selected_advance_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderAdvancePayment extends StatefulWidget {
  RxList<AdvanceDetails> advanceParticulars;
  Function() onCompleted;
  OrderAdvancePayment({super.key, required this.advanceParticulars, required this.onCompleted});

  @override
  State<OrderAdvancePayment> createState() => _OrderAdvancePaymentState();
}

class _OrderAdvancePaymentState extends State<OrderAdvancePayment> {

  final OrderAdvancePaymentController _orderAdvancePaymentController = Get.put(OrderAdvancePaymentController());

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
                controller: _orderAdvancePaymentController.advanceSearchController,
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
                  isLoading: _orderAdvancePaymentController.isAdvanceFetchLoading.value,
                  text: 'Fetch Details',
                  onPressed: () {
                    _orderAdvancePaymentController.getAdvanceDetails(context, widget.advanceParticulars, widget.onCompleted);
                  })),
              SizedBox(
                width: 10.w,
              ),
              SecondaryButton(
                  btnWidth: Responsive.isMobile(context) ? 125 : 125.w,
                  isLoading: false,
                  text: 'Add',
                  onPressed: () async {
                    await Get.dialog(barrierDismissible: false,OrderAdvancePaymentForm());
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
                await Get.dialog(OrderSelectedAdvanceList(
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