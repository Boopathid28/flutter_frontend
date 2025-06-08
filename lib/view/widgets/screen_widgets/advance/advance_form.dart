import 'dart:developer';

import 'package:ausales_application/controller/advance/advance_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/advance/advance_denomiation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvanceForm extends StatefulWidget {
  const AdvanceForm({super.key});

  @override
  State<AdvanceForm> createState() => _AdvanceFormState();
}

class _AdvanceFormState extends State<AdvanceForm> {
  final AdvanceFormController _advanceFormController =
      Get.put(AdvanceFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Advance",
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
                _advanceFormController.resetForm();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Form(
            key: _advanceFormController.advanceFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                Obx(() => _advanceFormController.isBranchuser.value
                    ? Branch()
                    : SizedBox()),
                customer(),
                advancepupose(),
                totaladvanceweight(),
                purity(),
                totaladvanceamount(),
                remark(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: PrimaryButton(
                    btnWidth: 300,
                    isLoading: false,
                    text: "Add Payment",
                    onPressed: () async {
                      await Get.dialog(
                          barrierDismissible: false,
                                AdvanceDenomiation(),
                              );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
            width: Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? 115.w
                : double.infinity,
            child: Obx(() => PrimaryButton(
                btnHeight: 46.h,
                isLoading: _advanceFormController.isFormSubmit.value,
                text: "Save",
                onPressed: () {
                  _advanceFormController.CreateAdvance(context);
                })))
      ],
    );
  }

  SizedBox purity() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Advance Weight Purity"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _advanceFormController.searchpuritycontroller,
                selectedValue: _advanceFormController.selectedPurity.value,
                options: _advanceFormController.puritydropdown.value,
                onChanged: (value) {
                  _advanceFormController.selectedPurity(value);
                },
                hintText: "Advance Weight Purity",
                isValidate:
                    _advanceFormController.totalweight.value ? true : false,
              ))
        ],
      ),
    );
  }

  SizedBox customer() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _advanceFormController.customerSearchController,
                selectedValue: _advanceFormController.selectedCustomer.value,
                options: _advanceFormController.customerDropDown.value,
                onChanged: (value) {
                  _advanceFormController.selectedCustomer(value);
                },
                hintText: "Customer",
                isValidate: true,
              ))
        ],
      ),
    );
  }

  SizedBox Branch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _advanceFormController.branchSearchController,
                selectedValue: _advanceFormController.selectedBranch.value,
                options: _advanceFormController.branchDropDown.value,
                onChanged: (value) {
                  _advanceFormController.selectedBranch(value);
                },
                hintText: "Branch",
                isValidate: true,
              ))
        ],
      ),
    );
  }

  SizedBox totaladvanceamount() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Advance Amount"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _advanceFormController.advanceamountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "no_validation",
            readOnly: true,
            hintText: "Total Advance Amount",
          ),
        ],
      ),
    );
  }

  SizedBox totaladvanceweight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Advance Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _advanceFormController.advanceweightcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "no_validation",
            hintText: "Total Advance Weight",
            onChanged: (value) {
              if (value.length > 0) {
                _advanceFormController.totalweight(true);
              } else {
                _advanceFormController.totalweight(false);
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox remark() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remark"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _advanceFormController.remarkcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remark",
          ),
        ],
      ),
    );
  }

  SizedBox advancepupose() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Advance Purpose"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _advanceFormController.searchadvancepurposecontroller,
                selectedValue:
                    _advanceFormController.selectedAdvancePurpose.value,
                options: _advanceFormController.advancedropdown.value,
                onChanged: (value) {
                  _advanceFormController.selectedAdvancePurpose(value);
                },
                hintText: "Advance Purpose",
                isValidate: true,
              ))
        ],
      ),
    );
  }
}
