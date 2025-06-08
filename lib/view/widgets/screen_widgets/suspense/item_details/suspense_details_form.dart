import 'dart:developer';

import 'package:ausales_application/controller/suspense/suspense_form_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseDetailsForm extends StatefulWidget {
  const SuspenseDetailsForm({super.key});

  @override
  State<SuspenseDetailsForm> createState() => _SuspenseDetailsFormState();
}

class _SuspenseDetailsFormState extends State<SuspenseDetailsForm> {
  final SuspenseFormController _suspenseFormController =
      Get.put(SuspenseFormController());

  final SuspenseItemFormController _suspenseItemFormController = Get.put(SuspenseItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _suspenseFormController.suspenseformkey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: size.width * 0.98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Details",
                style: TextPalette.tableHeaderTextStyle,
              ),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              Wrap(
                spacing: 20.w,
                runSpacing: 10.h,
                children: [
                  Obx(() => _suspenseFormController.isBranchuser.value
                      ? branch()
                      : SizedBox()),
                      customer(),
                      remarks()
                ],
              ),
            ],
          ),
        ));
  }

  SizedBox remarks() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _suspenseFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _suspenseFormController.branchSearchController,
                selectedValue: _suspenseFormController.selectedBranch.value,
                options: _suspenseFormController.branchDropDown.value,
                onChanged: (value) {
                  _suspenseFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox customer() {
    return SizedBox(
      width: 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _suspenseFormController.customerSearchController,
                selectedValue: _suspenseFormController.selectedCustomer.value,
                options: _suspenseFormController.customerDropDown.value,
                onChanged: (value) {
                  _suspenseFormController.selectedCustomer(value);
                },
                hintText: "Customer",
              ))
        ],
      ),
    );
  }
}
