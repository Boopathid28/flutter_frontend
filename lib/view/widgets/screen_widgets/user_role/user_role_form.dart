import 'package:ausales_application/controller/user_role/userrole_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserRoleForm extends StatefulWidget {
  const UserRoleForm({super.key});

  @override
  State<UserRoleForm> createState() => _UserRoleFormState();
}

class _UserRoleFormState extends State<UserRoleForm> {
  final UserroleFormController _userroleFormController = Get.put(UserroleFormController());

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
        key: _userroleFormController.userroleFormKey,
        child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rolename(),
            SizedBox(
              width: 10.w,
            ),
            actions(context)
          ],
        ): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rolename(),
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
                  isLoading: _userroleFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _userroleFormController.submitUserRoleForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _userroleFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _userroleFormController.resetForm();
                  }))
        ],
      ),
    );
  }


  SizedBox rolename() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "UserRole"),
          SizedBox(height: 7.h),
          CustomTextInput(
             controller: _userroleFormController.roleNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "userrole",
          ),
        ],
      ),
    );
  }
}