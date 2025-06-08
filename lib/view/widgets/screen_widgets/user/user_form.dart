import 'package:ausales_application/controller/user/user_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  
  final UserFormController _userFormController = Get.put(UserFormController());

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
        key: _userFormController.userFormKey,
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            runSpacing: 10.h,
            spacing: 10.w,
            children: [
              username(),
              SizedBox(
                height: 10.w,
              ),
              password(),
              SizedBox(
                height: 10.w,
              ),
              userrole(),
              SizedBox(
                height: 10.w,
              ),
              Obx(() => _userFormController.isBranchuser.value ? branch() : SizedBox(),),
              SizedBox(
                height: 10.w,
              ),
              sessionCount(),
              SizedBox(
                height: 10.w,
              ),
              sessionTimeOut(),
              SizedBox(
                width: 10.w,
              ),
              actions(context)
            ],
          ),
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
                  isLoading: _userFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _userFormController.submitUserForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _userFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _userFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox sessionTimeOut() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Session Timeout(Min)"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _userFormController.sessionTimeOutController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormat: 'integer',
            validator: "default",
            hintText: "Minutes",
          ),
        ],
      ),
    );
  }

  SizedBox sessionCount() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Session Count"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _userFormController.sessionCountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormat: 'integer',
            validator: "default",
            hintText: "Session Count",
          ),
        ],
      ),
    );
  }

  SizedBox branch() {
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
                controller: _userFormController.branchSearchController,
                selectedValue: _userFormController.selectedBranch.value,
                options: _userFormController.branchDropDown.value,
                onChanged: (value) {
                  _userFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox userrole() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "User Role"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _userFormController.searchRoleController,
                selectedValue: _userFormController.selectedUserRole.value,
                options: _userFormController.userRoleDropDown.value,
                onChanged: (value) {
                  _userFormController.selectedUserRole(value);
                },
                hintText: "User role",
              ))
        ],
      ),
    );
  }

  Obx password() {
    return Obx(() => Visibility(
          visible:
              _userFormController.fromMode.value == "create" ? true : false,
          child: SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabel(label: "Password"),
                SizedBox(height: 7.h),
                CustomTextInput(
                  hideText: _userFormController.isPasswordVisible.value,
                  controller: _userFormController.passwordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: "password",
                  hintText: "Password",
                  suffixIcon: _userFormController.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                  hasSuffixIcon: true,
                  suffixClicked: () {
                    _userFormController.isPasswordVisible(!_userFormController.isPasswordVisible.value);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  SizedBox username() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Username"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _userFormController.usernameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "username",
            hintText: "Username",
          ),
        ],
      ),
    );
  }
}
