import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/view/screens/splash_screen.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/api_endpoints/user_endpoints.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/user/user_model.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserService {

  static Future fetchUserList({
    FetchUserListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: userListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<UserListData> tempList = <UserListData>[];
        for (var item in response['data']['list']) {
          tempList.add(UserListData.fromJson(item));
        }
        return {
          "data": tempList,
          "total_pages": response['data']['total_pages']
        };
      } else if (response['status'] == 401) {
        
      }
    }

    return null;
  }

  static Future changepassword ({ FetchPasswordPayload? payload , required BuildContext context } ) async {
    var response = await ApiCalls.postWithToken(url: changePasswordEndPoint, body: payload!.toJson());

    if (response != null) {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return null;
    }
  }

  static Future createUser(
      {CreateUserPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: userEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final UserCreateResponse userCreateResponse =
          UserCreateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return userCreateResponse;
      } else if (response['status'] == 400) {

        response['data'].forEach((final String key, final value) {
          toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(value[0].toString()),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false
          );
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
          pauseOnHover: false
        );

    return null;
  }

  static Future updateUser(
      {UpdateUserPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: userEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final UserCreateResponse userCreateResponse =
          UserCreateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return userCreateResponse;
      } else if (response['status'] == 400) {
        response['data'].forEach((final String key, final value) {
          toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(value[0].toString()),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false
          );
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
          pauseOnHover: false
        );

    return null;
  }

  static Future deleteUser(
      {required String menuId,
      required String userId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$userEndPoint?id=$userId&menu_id=$menuId");
    Get.back();

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

  static Future updateUserStatus(
      {required String menuId,
      required String userId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$userStatusEndPoint?id=$userId&menu_id=$menuId");

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

  static Future updateUserLoginStatus(
      {required String menuId,
      required String userId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$userLoginStatusEndPoint?id=$userId&menu_id=$menuId");

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

  static Future updateUserAdminStatus(
      {required String menuId,
      required String userId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$userAdminStatusEndPoint?id=$userId&menu_id=$menuId");

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

  static Future updateUserPassword(
      {ChangePasswordPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: changePasswordEndPoint, body: payload!.toJson());

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
        return "";
      } else if (response['status'] == 400) {
        response['data'].forEach((final String key, final value) {
          toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(value[0].toString()),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false
          );
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
          pauseOnHover: false
        );

    return null;
  }

  
}
