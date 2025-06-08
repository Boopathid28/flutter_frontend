import 'package:ausales_application/controller/vendor_payment/vendor_payment_form/vendor_payment_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorAddPaymentPopup extends StatelessWidget {
  VendorAddPaymentPopup({super.key});

  final VendorPaymentFormController _vendorPaymentFormController =
      Get.put(VendorPaymentFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Confirmation", style: TextPalette.screenTitle,),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${_vendorPaymentFormController.totalPaidAmount.value > _vendorPaymentFormController.vendorPaymentDetails.value.balanceAmount! ? "Total amount is greater than the balance amount" : ""}"),
              SizedBox(
                height: 5.h,
              ),
              Text("${_vendorPaymentFormController.totalPaidWeight.value > _vendorPaymentFormController.vendorPaymentDetails.value.balanceWeight! ? "Total weight is greater than the balance weight" : ""}"),
            ],
          ),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 200.w,
              child: CancelButton(
                  isLoading: false,
                  text: "No",
                  onPressed: () {
                    Get.back();
                  }),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              width: 200.w,
              child: PrimaryButton(
                  isLoading: false,
                  text: "Yes",
                  onPressed: () async {
                    Get.back();
                    _vendorPaymentFormController.addPayment(context);
                  }),
            )
          ],
        )
      ],
    );
  }
}
