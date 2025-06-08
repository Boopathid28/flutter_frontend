import 'package:ausales_application/controller/payment_controllers/denomination_payment_controller.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DenominationPaymentItemForm extends StatefulWidget {
  List<PaymentDenominationItemModel> particularList;
  DenominationPaymentItemForm(
      {super.key, required this.particularList});

  @override
  State<DenominationPaymentItemForm> createState() => _DenominationPaymentItemFormState();
}

class _DenominationPaymentItemFormState extends State<DenominationPaymentItemForm> {

  final DenominationPaymentController _denominationPaymentController = Get.put(DenominationPaymentController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _denominationPaymentController.denominationPaymentFormKey,
      child: Wrap(
      spacing: 20.w,
      runSpacing: 15.h,
      children: [
        paymentMethods(),
        Obx(() => _denominationPaymentController.selectedPaymentMethod.value?.value != 'cash' ? paymentProviders() : SizedBox()),
        amount(),
        remarks(),
        actions(context)
      ],
    ));
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
                PrimaryButton(btnWidth: 95.w, isLoading: false, text: 'Add', onPressed: () {
                  _denominationPaymentController.addItemInList(widget.particularList);
                }),
                SecondaryButton(btnWidth: 95.w, isLoading: false, text: 'Clear', onPressed: () {
                  _denominationPaymentController.resetForm();
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
            controller: _denominationPaymentController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox amount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _denominationPaymentController.paidAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Amount",
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox paymentProviders() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Provider"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _denominationPaymentController.selectedPaymentProvider.value,
                options:
                    _denominationPaymentController.paymentProviderDropDown.value,
                onChanged: (value) {
                  _denominationPaymentController.selectedPaymentProvider(value);
                },
                hintText: "Provider",
              ))
        ],
      ),
    );
  }

  SizedBox paymentMethods() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Methods"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _denominationPaymentController.selectedPaymentMethod.value,
                options:
                    _denominationPaymentController.paymentMethodDropDown.value,
                onChanged: (value) {
                  _denominationPaymentController.selectedPaymentMethod(value);
                  _denominationPaymentController.getPaymentProvidersList(
                      method: value!.value);
                },
                hintText: "Payment Methods",
              ))
        ],
      ),
    );
  }
}