import 'package:ausales_application/controller/order/order_vendor_assign_controller/order_vendor_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteVendorAssignPopup extends StatefulWidget {
  String itemIndex;
  DeleteVendorAssignPopup({super.key, required this.itemIndex});

  @override
  State<DeleteVendorAssignPopup> createState() => _DeleteVendorAssignPopupState();
}

class _DeleteVendorAssignPopupState extends State<DeleteVendorAssignPopup> {

  final OrderVendorFormController _orderVendorFormController =
      Get.put(OrderVendorFormController());
      
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Venor Assign Delete",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Text('Are you sure want to delete the vendor assign details?'),
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
                  _orderVendorFormController.deleteVendor(context, widget.itemIndex);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}