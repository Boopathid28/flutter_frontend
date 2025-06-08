import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/menu_permission_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/menu_permission/menu_permission_model.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class MenuPermissionService {

  static Future getRoleBasedPermisionList(String? userRole) async {

    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(url: "$getUserRoleMenuPermissionListEndPoint?menu_id=$menuId&role_id=$userRole");

    if (response != null) {

      if (response['status'] == 200) {

        return MenuPermissionDataResponse.fromJson(response['data']);
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  static Future updateMenuPermissionStatus(
      {required ChangeMenuPermissionPayload payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: "$updateMenuPermissionEndPoint", body: payload.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return null;
      } else if (response['status'] == 401) {
        navLogin();
      }
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false
      );
    }

    return null;
  }

  static Future updateMenuAllPermissionStatus(
      {required MenuAllPermissionPayload payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: "$updateMenuAllPermissionEndPoint", body: payload.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return null;
      } else if (response['status'] == 401) {
        navLogin();
      }
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false
      );
    }

    return null;
  }
}