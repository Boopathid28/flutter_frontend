import 'package:ausales_application/controller/user/password_change.dart';
import 'package:ausales_application/controller/user/user_form_controller.dart';
import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class PasswordPopup extends StatelessWidget {
  String? userId; 
  PasswordPopup({super.key,required this.userId});

  final PasswordChangeController _passwordChangeController = Get.put(PasswordChangeController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 130.h,
        child: Form(
          key: _passwordChangeController.passwordFormKey,
          child: Column(
            children: [
              Text("Change Password",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w800),),
              SizedBox(
                height: 10.h,
              ),
              CustomTextInput(
                controller: _passwordChangeController.passwordChangeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: "password",
                hintText: "Password",
              )
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 200.w,
              child: CancelButton(
                  isLoading: false,
                  text: "Close",
                  onPressed: () {
                    _passwordChangeController.resetForm();
                    Get.back();
                  }),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              width: 200.w,
              child: Obx(() => PrimaryButton(
                  isLoading: _passwordChangeController.isChangePasswordLoading.value,
                  text: "Change Password",
                  onPressed: () async {
                    _passwordChangeController.ChangePassword(context, userId!);
                  })),
            )
          ],
        )
      ],
    );
  }
}
