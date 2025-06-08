import 'package:ausales_application/core/api_endpoints/sub_expense_account_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/expense/expense_models.dart';
import 'package:ausales_application/model/sub_expense_account/sub_expense_account_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubExpenseAccountService {

  static Future fetchSubExpenseAccountList({
    FetchSubExpenseAccountListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: subexpenseaccountListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<SubExpenseAccountListData> tempList = <SubExpenseAccountListData>[];
        for (var item in response['data']['list']) {
          tempList.add(SubExpenseAccountListData.fromJson(item));
        }
        return {
          "data": tempList,
          "total_pages": response['data']['total_pages']
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  static Future createSubExpenseAccount(
      {CreateSubExpenseAccountPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: subexpenseaccountEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CreateExpenseAccountResponse expenseAccountResponse =
          CreateExpenseAccountResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return expenseAccountResponse;
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

  static Future updateSubExpenseAccount(
      {UpdateSubExpenseAccountPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: subexpenseaccountEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CreateSubExpenseAccountResponse createSubExpenseAccountResponse =
          CreateSubExpenseAccountResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return createSubExpenseAccountResponse;
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

  static Future deleteSubExpenseAccount(
      {required String menuId,
      required String subexpenseId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$subexpenseaccountEndPoint?id=$subexpenseId&menu_id=$menuId");
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



  
  static Future updateSubExpenseAccountStatus(
      {required String menuId,
      required String subexpenseId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$subexpenseaccountStatusEndPoint?id=$subexpenseId&menu_id=$menuId");

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
