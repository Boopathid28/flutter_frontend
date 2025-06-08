import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/repair_creation_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/model/repair_creation/repair_payment_models.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class RepairCreationService {
  static Future fetchRepairTableList(RepairTableListPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: repairTableListndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <RepairTableList>[];
        for (var item in response['data']['list']) {
          data.add(RepairTableList.fromJson(item));
        }
        return {'data': data, 'total_pages': response['data']['total_pages']};
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }

      toastification.show(
          type: ToastificationType.error,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
    return null;
  }

  static Future createRepair(CreateRepairPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: repairCreateEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        Get.back();
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }

  static Future deleteRepair(String id, String menuId) async {
    var response = await ApiCalls.deleteWithToken(
        url: '$repairCreateEndpoint?id=$id&menu_id=$menuId');
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }

  static Future getRepairById(String id, String menuId) async {
    var response = await ApiCalls.getWithToken(
        url: '$repairCreateEndpoint?id=$id&menu_id=$menuId');
    if (response != null) {
      if (response['status'] == 200) {
        final data = GetRepairById.fromJson(response['data']);
        return {'data': data, 'total_pages': response['data']['total_pages']};
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }





  
  static Future createRepairPayment(FetchRepairPaymentPayload? payload) async {
    var response = await ApiCalls.postWithToken(
        url: repairPaymentEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        Get.back();
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }



static Future getRepairGetData(
      {String? repairId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$repairCreateEndpoint?menu_id=$menuId&id=$repairId");
    if (response != null) {
      if (response['status'] == 200) {
        final RepairGetbyData repairGetbyData =
            RepairGetbyData.fromJson(response['data']);

        return repairGetbyData;
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
