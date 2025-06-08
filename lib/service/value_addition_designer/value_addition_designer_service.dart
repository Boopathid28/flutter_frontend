import 'package:ausales_application/core/api_endpoints/designer_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/value_addition_designer_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/designer/designer_model.dart';
import 'package:ausales_application/model/value_addition_designer/value_addition_designer_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueAdditionDesignerService {
  static Future fetchValueAdditionDesignerList({
    FetchValueAdditionListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: valueadditiondesignerListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<ValueAdditionListData> tempList = <ValueAdditionListData>[];
        for (var item in response['data']['list']) {
          tempList.add(ValueAdditionListData.fromJson(item));
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

  static Future retrieveValueAdditionDesigner(
      {String? valueadditionId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$valueadditiondesignerEndPoint?menu_id=$menuId&id=$valueadditionId");


    if (response != null) {
      if (response['status'] == 200) {
        final ValueAdditionDesignerDetailsData valueAdditionDesignerDetailsData =
            ValueAdditionDesignerDetailsData.fromJson(response['data']);

        return valueAdditionDesignerDetailsData;
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

  static Future createValueadditiondesigner(
      {CreateValueAdditionDesignerPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: valueadditiondesignerEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateValueAdditionDesignerresponse createValueAdditionDesignerresponse =
            CreateValueAdditionDesignerresponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createValueAdditionDesignerresponse;
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

  static Future updateValueAdditionDesigner(
      {UpdateValueAdditionDesignerPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: valueadditiondesignerEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateValueAdditionDesignerresponse createValueAdditionDesignerresponse =
            CreateValueAdditionDesignerresponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createValueAdditionDesignerresponse;
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

  static Future deleteValueAdditionDesigner(
      {required String menuId,
      required String valueadditiondesignerId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$valueadditiondesignerEndPoint?id=$valueadditiondesignerId&menu_id=$menuId");
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
}
