import 'package:ausales_application/core/api_endpoints/designer_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/designer/designer_model.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerService {
  static Future fetchDesignerList({
    FetchDesignerListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: designerListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<DesignerListData> tempList = <DesignerListData>[];
        for (var item in response['data']['list']) {
          tempList.add(DesignerListData.fromJson(item));
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

  static Future retrieveDesigner(
      {String? designerId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$designerEndPoint?menu_id=$menuId&id=$designerId");

    if (response != null) {
      if (response['status'] == 200) {
        final DesignerDetailsData designerDetailsData =
            DesignerDetailsData.fromJson(response['data']);

        return designerDetailsData;
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

  static Future createDesigner(
      {CreateDesignerPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: designerEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final DesignerCreateResponse designerCreateResponse =
            DesignerCreateResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return designerCreateResponse;
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

  static Future updateDesigner(
      {UpdateDesignerPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: designerEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final DesignerCreateResponse designerCreateResponse =
            DesignerCreateResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return designerCreateResponse;
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

  static Future deleteDesigner(
      {required String menuId,
      required String designerId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$designerEndPoint?id=$designerId&menu_id=$menuId");
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

  static Future updateDesignerStatus(
      {required String menuId,
      required String designerId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$designerStatusEndPoint?id=$designerId&menu_id=$menuId");

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
