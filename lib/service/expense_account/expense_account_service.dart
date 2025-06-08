import 'package:ausales_application/core/api_endpoints/expense_account_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/metal_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/expense/expense_models.dart';
import 'package:ausales_application/model/metal_master/metal_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseAccountService {

  static Future fetchExpenseAccountList({
    FetchExpenseAccoutListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: expenseaccountListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<ExpenseAccoutListData> tempList = <ExpenseAccoutListData>[];
        for (var item in response['data']['list']) {
          tempList.add(ExpenseAccoutListData.fromJson(item));
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

  static Future createExpenseAccount(
      {CreateExpenseAccountPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: expenseaccountEndPoint, body: payload!.toJson());

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

  static Future updateExpenseAccount(
      {UpdateExpenseAccountpayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: expenseaccountEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CreateExpenseAccountResponse createExpenseAccountResponse =
          CreateExpenseAccountResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return createExpenseAccountResponse;
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

  static Future deleteExpense(
      {required String menuId,
      required String expenseId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$expenseaccountEndPoint?id=$expenseId&menu_id=$menuId");
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



  
  static Future updateExpenseaccountStatus(
      {required String menuId,
      required String expenseId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$expenseaccountStatusEndPoint?id=$expenseId&menu_id=$menuId");

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
