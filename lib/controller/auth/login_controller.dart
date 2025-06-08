import 'dart:developer';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/model/auth_models/login_model.dart';
import 'package:ausales_application/service/auth_service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  // final loginFormKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = true.obs;
  RxBool isLoading = false.obs;

  Future submitLogin(BuildContext context) async {
    // if (loginFormKey.currentState!.validate()) {
      isLoading(true);
      
      final LoginPayload payload = LoginPayload(
        username: usernameController.text.trim(), 
        password: passwordController.text.trim()
      );
      
      final LoginData? data = await LoginService.loginUser(payload: payload, context: context);

      isLoading(false);
      if (data != null) {
        AuthSharedPrefs.setLoginData(data);
        AuthSharedPrefs.setBranch(data.branch!);
        AuthSharedPrefs.setToken(data.token??"");
        AuthSharedPrefs.setSessionKey(data.sessionKey??"");
        navHome();
      } else {
        AuthSharedPrefs.setLoginData(null);
        AuthSharedPrefs.setBranch(false);
        AuthSharedPrefs.setToken("");
        AuthSharedPrefs.setSessionKey("");
      }
    // }
  }
}