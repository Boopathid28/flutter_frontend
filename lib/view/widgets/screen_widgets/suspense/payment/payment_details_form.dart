import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentDetailsForm extends StatefulWidget {
  const PaymentDetailsForm({super.key});

  @override
  State<PaymentDetailsForm> createState() => _PaymentDetailsFormState();
}

class _PaymentDetailsFormState extends State<PaymentDetailsForm> {
  final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _suspensePaymentController.suspensepaymentformkey,
        child: Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: [
               Obx(() => _suspensePaymentController.isBranchuser.value
                      ? branch()
                      : SizedBox()),
          ],
        ));
  }

  SizedBox branch() {
    return SizedBox(
      width: 200.w,
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
}
