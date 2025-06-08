import 'package:ausales_application/controller/metal_master/metal_form_controller.dart';
import 'package:ausales_application/controller/user/user_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalForm extends StatefulWidget {
  const MetalForm({super.key});

  @override
  State<MetalForm> createState() => _MetalFormState();
}

class _MetalFormState extends State<MetalForm> {
  final MetalFormController _metalFormController = Get.put(MetalFormController());

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
        key: _metalFormController.metalFormKey,
        child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            metalname(),
            SizedBox(
              width: 10.w,
            ),
            metalcode(),
            SizedBox(
              width: 10.w,
            ),
            actions(context)
          ],
        ): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            metalname(),
            SizedBox(
              height: 10.w,
            ),
            metalcode(),
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
      height: 73.h ,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _metalFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _metalFormController.submitMetalForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _metalFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _metalFormController.resetForm();
                  }))
        ],
      ),
    );
  }



  SizedBox metalcode() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metalcode"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _metalFormController.metalCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "metalcode",
          ),
        ],
      ),
    );
  }


  SizedBox metalname() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metalname"),
          SizedBox(height: 7.h),
          CustomTextInput(
             controller: _metalFormController.metalNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "metalname",
          ),
        ],
      ),
    );
  }
}