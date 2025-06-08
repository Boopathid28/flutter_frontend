import 'package:ausales_application/controller/order/stone_diamond_form_controller.dart/order_diamond_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteDiamondPopup extends StatefulWidget {
  String itemIndex;
  DeleteDiamondPopup({super.key, required this.itemIndex});

  @override
  State<DeleteDiamondPopup> createState() => _DeleteDiamondPopupState();
}

class _DeleteDiamondPopupState extends State<DeleteDiamondPopup> {

  final OrderDiamondFormController _orderDiamondFormController =
      Get.put(OrderDiamondFormController());
      
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Diamond Delete",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Text('Are you sure want to delete the diamond details?'),
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
                  _orderDiamondFormController.deleteOrderDiamond(context, widget.itemIndex);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}