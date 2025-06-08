import 'package:ausales_application/controller/order/order_advance/order_advance_payment_controller.dart';
import 'package:ausales_application/controller/payment_controllers/advance_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_advance_payment/order_advance_denomiation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderAdvancePaymentForm extends StatefulWidget {
  OrderAdvancePaymentForm({super.key});

  @override
  State<OrderAdvancePaymentForm> createState() => _OrderAdvancePaymentFormState();
}

class _OrderAdvancePaymentFormState extends State<OrderAdvancePaymentForm> {

  final OrderAdvancePaymentController _orderAdvancePaymentController = Get.put(OrderAdvancePaymentController());

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
          key: _orderAdvancePaymentController.advancePaymentFormKey,
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
                    btnWidth: 250,
                    isLoading: false,
                    text: "Add Payment",
                    onPressed: () async {
                      await Get.dialog(
                          barrierDismissible: false,
                                OrderAdvanceDenomiation(),
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
                Obx(() => PrimaryButton(btnWidth: 95.w, isLoading: _orderAdvancePaymentController.isFormSubmit.value, text: 'Add', onPressed: () {
                  _orderAdvancePaymentController.createAdvance(context);
                })),
                SecondaryButton(btnWidth: 95.w, isLoading: false, text: 'Clear', onPressed: () {
                  _orderAdvancePaymentController.resetAdvancePaymentForm();
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
            inputFormat: 'text',
            controller: _orderAdvancePaymentController.remarksController,
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
                isValidate: _orderAdvancePaymentController.validatePurity.value,
                selectedValue:
                    _orderAdvancePaymentController.selectedPurity.value,
                options:
                    _orderAdvancePaymentController.purityDropDown.value,
                onChanged: (value) {
                  _orderAdvancePaymentController.selectedPurity(value);
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
            controller: _orderAdvancePaymentController.advanceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Weight",
            onChanged: (value) {
              if (value.length > 0) {
                _orderAdvancePaymentController.validatePurity(true);
              } else {
                _orderAdvancePaymentController.validatePurity(false);
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
            controller: _orderAdvancePaymentController.advanceAmountController,
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
                    _orderAdvancePaymentController.selectedAdvancePurpose.value,
                options:
                    _orderAdvancePaymentController.advancePurposeDropDown.value,
                onChanged: (value) {
                  _orderAdvancePaymentController.selectedAdvancePurpose(value);
                },
                hintText: "Advance Purpose",
              ))
        ],
      ),
    );
  }
}