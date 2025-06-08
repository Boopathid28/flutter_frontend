import 'package:ausales_application/controller/suspense/suspense_item_form_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeletePaymentPopup extends StatefulWidget {
  String itemIndex;
  DeletePaymentPopup({super.key, required this.itemIndex});

  @override
  State<DeletePaymentPopup> createState() => _DeletePaymentPopupState();
}

class _DeletePaymentPopupState extends State<DeletePaymentPopup> {

  final SuspensePaymentFormController _suspensePaymentFormController =
      Get.put(SuspensePaymentFormController());
      
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Payment Delete",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Text('Are you sure want to delete the payment details?'),
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
                }
              ),
            ),
            SizedBox(width: 15.w,),
            SizedBox(
              width: 200.w,
              child: PrimaryButton(
                isLoading: false, 
                text: "Yes", 
                onPressed: () async {
                  _suspensePaymentFormController.deletePayment(context, widget.itemIndex);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}