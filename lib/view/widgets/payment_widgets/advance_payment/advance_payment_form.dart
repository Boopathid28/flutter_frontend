import 'package:ausales_application/controller/payment_controllers/advance_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/advance_payment/advance_denomiation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvancePaymentForm extends StatefulWidget {
  String branch;
  String customer;
  AdvancePaymentForm({super.key, required this.branch, required this.customer});

  @override
  State<AdvancePaymentForm> createState() => _AdvancePaymentFormState();
}

class _AdvancePaymentFormState extends State<AdvancePaymentForm> {

  final AdvancePaymentController _advancePaymentController = Get.put(AdvancePaymentController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Advance', style: TextPalette.screenTitle),
          IconButton(
            onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: double.infinity,
        child: Form(
          key: _advancePaymentController.advancePaymentFormKey,
          child: Wrap(
            spacing: 20.w,
            runSpacing: 15.h,
            children: [
              advancePurpose(),
              totalAdvanceAmount(),
              totalAdvanceWeight(),
              purity(),
              remarks(),

              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: PrimaryButton(
                    btnWidth: 300,
                    isLoading: false,
                    text: "Add Payment",
                    onPressed: () async {
                      await Get.dialog(
                          barrierDismissible: false,
                                AdvanceDenomiationCommon(),
                              );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [actions(context)],
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 200.w,
      height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => PrimaryButton(btnWidth: 95.w, isLoading: _advancePaymentController.isFormSubmit.value, text: 'Add', onPressed: () {
                  _advancePaymentController.createAdvance(context, widget.branch, widget.customer);
                })),
                SecondaryButton(btnWidth: 95.w, isLoading: false, text: 'Clear', onPressed: () {
                  _advancePaymentController.resetAdvancePaymentForm();
                })
              ],
            ),
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _advancePaymentController.remarksController,
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

  SizedBox purity() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purity"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                isValidate: _advancePaymentController.validatePurity.value,
                selectedValue:
                    _advancePaymentController.selectedPurity.value,
                options:
                    _advancePaymentController.purityDropDown.value,
                onChanged: (value) {
                  _advancePaymentController.selectedPurity(value);
                },
                hintText: "Purity",
              ))
        ],
      ),
    );
  }

  SizedBox totalAdvanceWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _advancePaymentController.advanceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Weight",
            onChanged: (value) {
              if (value.length > 0) {
                _advancePaymentController.validatePurity(true);
              } else {
                _advancePaymentController.validatePurity(false);
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox totalAdvanceAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Advance Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _advancePaymentController.advanceAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Advance Amount",
            readOnly: true,
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox advancePurpose() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Advance Purpose"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _advancePaymentController.selectedAdvancePurpose.value,
                options:
                    _advancePaymentController.advancePurposeDropDown.value,
                onChanged: (value) {
                  _advancePaymentController.selectedAdvancePurpose(value);
                },
                hintText: "Advance Purpose",
              ))
        ],
      ),
    );
  }
}