import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/old_purchase_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OldPurchaseService {
  static Future fetchOldPurchaseList({
    FetchOldPurchaseListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: oldPurchaseListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<FetchOldPurchaseListResponse> tempList = <FetchOldPurchaseListResponse>[];
        for (var item in response['data']['list']) {
          tempList.add(FetchOldPurchaseListResponse.fromJson(item));
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

  static Future retrieveOldPurchase(
      {String? oldPurdchaseId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$oldPurchaseEndPoint?menu_id=$menuId&id=$oldPurdchaseId");
    if (response != null) {
      if (response['status'] == 200) {
        final OldPurchaseRetrieveResponse oldPurchaseRetrieveResponse =
            OldPurchaseRetrieveResponse.fromJson(response['data']);

        return oldPurchaseRetrieveResponse;
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

  static Future createOldPurchase(
      {OldPurchasePayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: oldPurchaseEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
         return response['data']['id'].toString();
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

  static Future cancelOldPurchase(
      {required String menuId,
      required String oldPurchaseId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$oldPurchaseEndPoint?id=$oldPurchaseId&menu_id=$menuId");
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

  static Future retrieveOldPurchaseByNumber(
      {String? oldPurdchaseNumber, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$oldPurchaseByNumberEndPoint?menu_id=$menuId&id=$oldPurdchaseNumber");

    if (response != null) {
      if (response['status'] == 200) {
        final OldPurchaseRetrieveResponse oldPurchaseRetrieveResponse =
            OldPurchaseRetrieveResponse.fromJson(response['data']);

        return oldPurchaseRetrieveResponse;
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

}
