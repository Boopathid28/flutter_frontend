import 'package:ausales_application/core/api_endpoints/old_metal_rate_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/old_metal_rate/old_metal_rate_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OldMetalRateService {

  static Future fetchOldMetalRateList({
    FetchOldMetalRatePayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: oldMetalRateListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<OldMetalRateListData> tempList = <OldMetalRateListData>[];
        for (var item in response['data']['list']) {
          tempList.add(OldMetalRateListData.fromJson(item));
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

  static Future createOldMetalRate(
      {CreateOldMetalRatePayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: oldMetalRateEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CreateOldMetalRateResponse createOldMetalRateResponse =
          CreateOldMetalRateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return createOldMetalRateResponse;
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

  static Future updateOldMetalRate(
      {UpdateOldMetalRatePayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: oldMetalRateEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CreateOldMetalRateResponse createOldMetalRateResponse =
          CreateOldMetalRateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return createOldMetalRateResponse;
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

  static Future deleteOldMetalRate(
      {required String menuId,
      required String metalId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$oldMetalRateEndPoint?id=$metalId&menu_id=$menuId");
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

 
}
