import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/user/user_model.dart';
import 'package:ausales_application/service/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangeController extends GetxController {
final passwordFormKey = GlobalKey<FormState>();
  TextEditingController passwordChangeController = TextEditingController();
  RxBool isChangePasswordLoading = false.obs;

  final UserListController _userListController = Get.put(UserListController());

  
  Future ChangePassword(BuildContext context, String User) async {
    if (passwordFormKey.currentState!.validate()) {
        isChangePasswordLoading(true);
      FetchPasswordPayload payload = FetchPasswordPayload(
        id: int.parse(User),
        menuId: await HomeSharedPrefs.getCurrentMenu(),
        password: passwordChangeController.text,
      );

      await UserService.changepassword(payload: payload, context: context);
      _userListController.getUserList(context);
      
      isChangePasswordLoading(false);
    resetForm();
    Get.back();
    }
  }


    resetForm() {
    passwordFormKey.currentState!.reset();
    passwordChangeController.clear();
  }
}