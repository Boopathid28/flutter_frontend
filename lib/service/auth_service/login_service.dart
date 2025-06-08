import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/auth_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/model/auth_models/login_model.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class LoginService {

  static Future loginUser({ LoginPayload? payload, required BuildContext context }) async {
    var response = await ApiCalls.post(url: loginEndPoint, body: payload!.toJson());

    final LoginResponse loginResponse = LoginResponse.fromJson(response);
    if (response != null) {
      if (loginResponse.status == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(loginResponse.message!),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return loginResponse.data;
      } else if (loginResponse.status == 401) {
        navLogin();
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(loginResponse.message!),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return null;
      }
    } 

    toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(loginResponse.message!),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);

    return null;
  }

  static Future logoutUser({ LoginPayload? payload, required BuildContext context }) async {
    var response = await ApiCalls.getWithToken(url: logoutEndPoint);
    if (response != null) {
      final LogoutResponse logoutResponse = LogoutResponse.fromJson(response);
      
      if (logoutResponse.status == 200) {
        AuthSharedPrefs.setLoginData(null);
        AuthSharedPrefs.setToken("");
        AuthSharedPrefs.setSessionKey("");
        navLogin();
      }
    } 
  }
}