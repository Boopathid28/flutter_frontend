import 'dart:developer';

import 'package:ausales_application/controller/customer/customer_creation_common_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerCreationCommonPopup extends StatefulWidget {
  void Function(BuildContext context) onSubmit;

  CustomerCreationCommonPopup({super.key, required this.onSubmit});

  @override
  State<CustomerCreationCommonPopup> createState() =>
      _CustomerCreationCommonPopupState();
}

class _CustomerCreationCommonPopupState
    extends State<CustomerCreationCommonPopup> {
  final CustomerCreationCommonController _customerCreationCommonController =
      Get.put(CustomerCreationCommonController());

  // @override
  // void initState() {
  //   super.initState();
  //   _customerCreationCommonController.mobilenumbercontroller.text = widget.initialMobile;
  //   _customerCreationCommonController.selectedBranch(widget.initialBranch);
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_customerCreationCommonController.fromMode.value.capitalize} Customer',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              iconSize: 25.sp,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 300.w,
        child: SingleChildScrollView(
          child: Form(
            key: _customerCreationCommonController.customerCommonFormKey,
            child: Column(
              children: [
                CustomerName(),
                Mobilenumber(),
                customergroup(),
                Address()
              ],
            ),
          ),
        ),
      ),
      actions: [actions(context)],
    );
  }

  IconButton closeicon() {
    return IconButton(
        onPressed: () {
          _customerCreationCommonController.resetForm();
          Get.back();
        },
        icon: Icon(Icons.close));
  }

  SizedBox customergroup() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer Group"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _customerCreationCommonController
                    .searchCustomerGroupController,
                selectedValue: _customerCreationCommonController
                    .selectedCustomergroup.value,
                options: _customerCreationCommonController
                    .customergroupDropDown.value,
                onChanged: (value) {
                  _customerCreationCommonController
                      .selectedCustomergroup(value);
                },
                hintText: "Customergroup name",
              ))
        ],
      ),
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
                  isLoading:
                      _customerCreationCommonController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    widget.onSubmit(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading:
                      _customerCreationCommonController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _customerCreationCommonController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox Mobilenumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Mobile Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller:
                _customerCreationCommonController.mobilenumbercontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "phone",
            hintText: "Mobile Number",
            inputFormat: "integer",
            maxLength: 10,
          ),
        ],
      ),
    );
  }

  SizedBox CustomerName() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller:
                _customerCreationCommonController.customerNamecontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Customer Name",
          ),
        ],
      ),
    );
  }

   SizedBox Address() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Address"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerCreationCommonController.addresscontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Address",
          ),
        ],
      ),
    );
  }
}
