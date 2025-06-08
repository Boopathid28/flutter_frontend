import 'package:ausales_application/controller/invoice/invocie_payment_form_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoicePaymentPopup extends StatefulWidget {
  const InvoicePaymentPopup({super.key});

  @override
  State<InvoicePaymentPopup> createState() => _InvoicePaymentPopupState();
}

class _InvoicePaymentPopupState extends State<InvoicePaymentPopup> {
  final InvociePaymentFormController _invociePaymentFormController =
      Get.put(InvociePaymentFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(15.w),
        child: Form(
          key: _invociePaymentFormController.invoicePaymentFormKey,
          child: Wrap(
            spacing: 20.w,
            runSpacing: 15.h,
            children: [
              paymentMethods(),
              SizedBox(
                height: 10.w,
              ),
              Obx(() => _invociePaymentFormController.selectedPaymentMethod.value?.value != 'cash' ? paymentProviders() : SizedBox(),),
              SizedBox(
                height: 10.w,
              ),
              amount(),
              remarks(),
              actions(context)
                
            ],
          ),
        ),
      );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _invociePaymentFormController.resetForm();
                  })),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _invociePaymentFormController.isFormSubmit.value,
                  text: "Add",
                  onPressed: () {
                    _invociePaymentFormController.submitPaymentForm(context);
                  }))),
          
        ],
      ),
    );
  }

  SizedBox amount() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _invociePaymentFormController.amountController,
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


   SizedBox remarks() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'text',
            controller: _invociePaymentFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox paymentProviders() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Provider"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _invociePaymentFormController.selectedPaymentProvider.value,
                options:
                    _invociePaymentFormController.paymentProviderDropDown.value,
                onChanged: (value) {
                  _invociePaymentFormController.selectedPaymentProvider(value);
                },
                hintText: "Provider",
              ))
        ],
      ),
    );
  }

  SizedBox paymentMethods() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Methods"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _invociePaymentFormController.selectedPaymentMethod.value,
                options:
                    _invociePaymentFormController.paymentMethodDropDown.value,
                onChanged: (value) {
                  _invociePaymentFormController.selectedPaymentMethod(value);
                  _invociePaymentFormController.getPaymentProviderList(
                      method: value!.value);
                },
                hintText: "Payment Methods",
              ))
        ],
      ),
    );
  }
}
