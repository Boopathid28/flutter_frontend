import 'package:ausales_application/controller/order/order_receive_item_controller/order_receive_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteReceiveItemPopup extends StatefulWidget {
  String itemIndex;
  DeleteReceiveItemPopup({super.key, required this.itemIndex});

  @override
  State<DeleteReceiveItemPopup> createState() => _DeleteReceiveItemPopupState();
}

class _DeleteReceiveItemPopupState extends State<DeleteReceiveItemPopup> {

  final OrderReceiveItemFormController _orderReceiveItemFormController =
      Get.put(OrderReceiveItemFormController());
      
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Receive Item Delete",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Text('Are you sure want to delete the Receive Item details?'),
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
                  _orderReceiveItemFormController.deleteReceive(context, widget.itemIndex);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}