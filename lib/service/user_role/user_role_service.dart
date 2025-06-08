import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/home_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/userrole_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/home_model.dart';
import 'package:ausales_application/model/user_role/user_role_models.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class UserRoleService {
  static Future getUserRole() async {
    var response = await ApiCalls.getWithToken(url: "$userroleListEndPoint?is_filter=$isFilter");

    if (response != null) {
      final UserRoleResponse userRoleResponse =
          UserRoleResponse.fromJson(response['data']);

      return userRoleResponse.list;
    }

    return <UserRoleListData>[];
  }

  static Future createUserRole(
      {CreateUserRolePayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: userroleEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateUserRoleResponse userRoleResponse =
            CreateUserRoleResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return userRoleResponse;
      } else if (response['status'] == 400) {
        response['data'].forEach((final String key, final value) {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.error,
              title: Text(value[0].toString()),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        });
        return null;
      } else if (response['status'] == 401) {
        navLogin();
      }
    }

    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);

    return null;
  }

  static Future updateUserRole(
      {UpdateUserRolePayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: userroleEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateUserRoleResponse createUserRoleResponse =
            CreateUserRoleResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createUserRoleResponse;
      } else if (response['status'] == 400) {
        response['data'].forEach((final String key, final value) {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.error,
              title: Text(value[0].toString()),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        });
        return null;
      } else if (response['status'] == 401) {
        navLogin();
      }
    }

    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);

    return null;
  }

  static Future deleteUserRole(
      {required String menuId,
      required String userroleId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$userroleEndPoint?id=$userroleId&menu_id=$menuId");
    Get.back();

    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
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
          pauseOnHover: false);
    }

    return null;
  }



  static Future updateUserRoleStatus(
      {required String menuId,
      required String userRoleId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$userroleStatusEndPoint?id=$userRoleId&menu_id=$menuId");

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
