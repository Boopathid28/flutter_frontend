import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/designer_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/lot_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/designer/designer_model.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LotService {
  static Future fetchLotList({
    FetchLotListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: lotListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<LotListData> tempList = <LotListData>[];
        for (var item in response['data']['list']) {
          tempList.add(LotListData.fromJson(item));
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

  static Future retrieveLot(
      {String? lotId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$lotEndPoint?menu_id=$menuId&id=$lotId");

    if (response != null) {
      if (response['status'] == 200) {
        final LotDetailsData lotDetailsData =
            LotDetailsData.fromJson(response['data']);

        return lotDetailsData;
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

  static Future createLot(
      {CreateLotDetailsPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: lotEndPoint, body: payload!.toJson());
log("response   ${response}");
log("payload!.toJson()   ${payload!.toJson()}");
    if (response != null) {
      if (response['status'] == 200) {
        final CreateLotDetailsResponse createLotDetailsResponse =
            CreateLotDetailsResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createLotDetailsResponse;
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

  static Future updateLot(
      {UpdateLotPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: lotEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateLotDetailsResponse createLotDetailsResponse =
            CreateLotDetailsResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createLotDetailsResponse;
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

  static Future deleteLot(
      {required String menuId,
      required String lotId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$lotEndPoint?id=$lotId&menu_id=$menuId");
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
      required String lotId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$designerStatusEndPoint?id=$lotId&menu_id=$menuId");

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
