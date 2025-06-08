import 'dart:developer';

import 'package:ausales_application/controller/order/order_receive_item_controller/order_receive_item_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReceiveItemForm extends StatefulWidget {
  const ReceiveItemForm({super.key});

  @override
  State<ReceiveItemForm> createState() => _ReceiveItemFormState();
}

class _ReceiveItemFormState extends State<ReceiveItemForm> {
  final OrderReceiveItemController _orderReceiveItemController = Get.put(OrderReceiveItemController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Receive Items",
            style: TextStyle(fontSize: 16.sp),
          ),
          IconButton(
              onPressed: () {
                Get.back();
                _orderReceiveItemController.resetreceiveitem(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width:300.w ,
        child: SingleChildScrollView(
          child: Form(
            key: _orderReceiveItemController.orderReceiveItemFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 20.h,
              children: [
               vendor(),
              ],
            ),
          ),
        ),
      ),
      actions: [actions(context)],
    );
  }


 SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 115.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _orderReceiveItemController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _orderReceiveItemController.submitForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _orderReceiveItemController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _orderReceiveItemController.resetreceiveitem(context);
                  }))
        ],
      ),
    );
  }

    SizedBox vendor() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _orderReceiveItemController.vendorSearchController,
                selectedValue: _orderReceiveItemController.selectedVendor.value,
                options: _orderReceiveItemController.vendorDropDown.value,
                onChanged: (value) {
                  _orderReceiveItemController.selectedVendor(value);
                },
                hintText: "Vendor",
                isValidate: true,
              ))
        ],
      ),
    );
  }

}
