import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_form_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final SuspensePaymentFormController _suspensePaymentFormController =
      Get.put(SuspensePaymentFormController());

        final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _suspensePaymentFormController.paymentDetailsFormKey,
            child: Wrap(
              spacing: 15.w,
              runSpacing: 15.h,
              children: [
                paymentMethods(),
                 Obx(() => _suspensePaymentFormController.selectedPaymentMethoad.value?.value != 'cash' ? paymentProviders() : SizedBox(),),
                paidAmount(),
                addButton(context),
                clearButton(context)
              ],
            )),
      ],
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
                controller: _suspensePaymentController.branchSearchController,
                selectedValue: _suspensePaymentController.selectedBranch.value,
                options: _suspensePaymentController.branchDropDown.value,
                onChanged: (value) {
                  _suspensePaymentController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
  SizedBox clearButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: SecondaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: "Clear",
            onPressed: () {
              _suspensePaymentFormController.resetPayment(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _suspensePaymentFormController.paymentdetailsFormMode.value,
            onPressed: () {
              _suspensePaymentFormController.submitPaymentdetailsForm(context);
            })));
  }

  SizedBox paidAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Paid Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _suspensePaymentFormController.paidAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Paid Amount",
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
                    _suspensePaymentFormController.selectedPaymentProvider.value,
                options:
                    _suspensePaymentFormController.paymentproviderDropDown.value,
                onChanged: (value) {
                  _suspensePaymentFormController.selectedPaymentProvider(value);
                },
                hintText: "Payment Provider",
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
                    _suspensePaymentFormController.selectedPaymentMethoad.value,
                options:
                    _suspensePaymentFormController.paymentmethodDropDown.value,
                onChanged: (value) {
                  _suspensePaymentFormController.selectedPaymentMethoad(value);
                  _suspensePaymentFormController.getPaymentProviderList(
                      method: value!.value);
                },
                hintText: "Payment Methods",
              ))
        ],
      ),
    );
  }
}
