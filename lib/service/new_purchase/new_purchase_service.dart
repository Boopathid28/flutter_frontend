import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/new_purchase_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/old_purchase_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/value_addition_designer_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/new_purchase/new_purchase_model.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPurchaseService {
  static Future fetchNewPurchaseList({
    FetchNewPurchaseListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: newPurchaseListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<FetchNewPurchaseListResponse> tempList = <FetchNewPurchaseListResponse>[];
        for (var item in response['data']['list']) {
          tempList.add(FetchNewPurchaseListResponse.fromJson(item));
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

  static Future retrieveNewPurchase(
      {String? newPurdchaseId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$newPurchaseEndPoint?menu_id=$menuId&id=$newPurdchaseId");

    if (response != null) {
      if (response['status'] == 200) {
        final NewPurchaseRetrieveResponse newPurchaseRetrieveResponse =
            NewPurchaseRetrieveResponse.fromJson(response['data']);

        return newPurchaseRetrieveResponse;
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

  static Future createNewPurchase(
      {NewPurchasePayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: newPurchaseEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return "success";
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

  static Future cancelNewPurchase(
      {required String menuId,
      required String newPurchaseId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$newPurchaseEndPoint?id=$newPurchaseId&menu_id=$menuId");
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

  static Future getSubitemVendorCalculationDetails(
      {required String subItemId,
      required BuildContext context,
      required String vendorId}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url:
            "$valueadditiondesignerPurchaseValueEndPoint?sub_item=$subItemId&vendor=$vendorId&menu_id=$menuId");
    if (response != null) {
      if (response['status'] == 200) {
        return response['data'];
      } else if (response['status'] == 401) {
        navLogin();
        return null;
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
