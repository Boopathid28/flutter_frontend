import 'package:ausales_application/controller/repair_creation/receive_item_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReceiveItemPopup extends StatefulWidget {
  final int index;
  final num id;
  const ReceiveItemPopup({super.key, required this.index, required this.id});

  @override
  State<ReceiveItemPopup> createState() => _ReceiveItemPopupState();
}

class _ReceiveItemPopupState extends State<ReceiveItemPopup> {
  final ReceiveItemController _receiveItemController =
      Get.put(ReceiveItemController());

  @override
  void initState() {
    super.initState();
    
    // _receiveItemController.customerChargesController.text=_receiveItemController.reveiveItemList[widget.index].customerCharges.toString();    
    // _receiveItemController.vendorChargesController.text=_receiveItemController.reveiveItemList[widget.index].vendorCharges.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: EdgeInsets.all(Responsive.isMobile(context)?8.w:0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Receive Item',
            style: Responsive.isMobile(context)
                ? TextPalette.tableDataTextStyle
                : TextPalette.screenTitle,
          ),
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
        ],
      ),
      content: Form(
        key: _receiveItemController.receiveItemFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabel(label: 'Customer charge'), SizedBox(height: 8.w,),
                customerChargesInput(),
              ],
            ),
            SizedBox(
              height: 15.w,
            ),
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabel(label: 'Vendor charge'), SizedBox(height: 8.w,),
                vendorChargesInput(),
              ],
            ),
            SizedBox(
              height: 15.w,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SecondaryButton(
                      btnWidth:Responsive.isMobile(context)?75.w: 150.w,
                      isLoading: false,
                      text: 'Clear',
                      onPressed: () {
                        _receiveItemController.resetVendorFrom();
                      },
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    PrimaryButton(
                      btnWidth:Responsive.isMobile(context)?75.w: 150.w,
                      isLoading: false,
                      text: 'Receive',
                      onPressed: () async {
                        _receiveItemController.addOrUpdateReceiveItem(id: widget.id, cusCharges: _receiveItemController.customerChargesController.text, vendorCharges: _receiveItemController.vendorChargesController.text);
                        _receiveItemController.resetVendorFrom();
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox vendorChargesInput() {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _receiveItemController.vendorChargesController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: "default",
        hintText: "Vendor Charges",
       
      ),
    );
  }

  SizedBox customerChargesInput() {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
        inputFormat:'double' ,
        controller: _receiveItemController.customerChargesController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: "default",
        hintText: "Customer Charges",
       
      ),
    );
  }
}
