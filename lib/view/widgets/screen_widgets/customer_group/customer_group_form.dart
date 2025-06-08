import 'package:ausales_application/controller/customer_group/customer_group_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerGroupForm extends StatefulWidget {
  const CustomerGroupForm({super.key});

  @override
  State<CustomerGroupForm> createState() => _CustomerGroupFormState();
}

class _CustomerGroupFormState extends State<CustomerGroupForm> {
  final CustomerGroupFormController _customerGroupFormController = Get.put(CustomerGroupFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Form(
        key: _customerGroupFormController.customergroupFormKey,
        child: Responsive.isDesktop(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customergroupname(),
            SizedBox(
              width: 10.w,
            ),
            actions(context)
          ],
        ) : Responsive.isTablet(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                customergroupname(),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                actions(context)
              ],
            ),
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customergroupname(),
            SizedBox(
              height: 10.w,
            ),
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
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _customerGroupFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _customerGroupFormController.submitCustomergroupForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _customerGroupFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _customerGroupFormController.resetForm();
                  }))
        ],
      ),
    );
  }


  SizedBox customergroupname() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customergroupname"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerGroupFormController.customergroupcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Customergroupname",
          ),
        ],
      ),
    );
  }
}
