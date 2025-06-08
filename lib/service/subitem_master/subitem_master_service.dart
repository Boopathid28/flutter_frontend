import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/subitem_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubitemMasterService {
  static Future fetchSubItemList({
    FetchSubItemListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: subItemListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<SubItemListData> tempList = <SubItemListData>[];
        for (var item in response['data']['list']) {
          tempList.add(SubItemListData.fromJson(item));
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

  static Future retrieveSubItem(
      {String? subItemId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$subItemEndPoint?menu_id=$menuId&id=$subItemId");

    if (response != null) {
      if (response['status'] == 200) {
        SubItemDetailsData subItemDetailsData =
            SubItemDetailsData.fromJson(response['data']);

        return subItemDetailsData;
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
  }

  static Future createSubItem(
      {CreateSubItemPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: subItemEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final SubItemCreateResponse subItemCreateResponse =
            SubItemCreateResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return subItemCreateResponse;
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

  static Future updateSubItem(
      {UpdateSubItemPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: subItemEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final SubItemCreateResponse subItemCreateResponse =
            SubItemCreateResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return subItemCreateResponse;
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

  static Future deleteSubItem(
      {required String menuId,
      required String subItemId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$subItemEndPoint?id=$subItemId&menu_id=$menuId");
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

  static Future updateSubItemStatus(
      {required String menuId,
      required String subItemId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$subItemStatusEndPoint?id=$subItemId&menu_id=$menuId");

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

  static Future getItemsDetailsBySubItem(
      {required BuildContext context,
      required String subItemId,
      required String search,
      required String page,
      required String itemsPerPage}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url:
            "$tagItemsBasedOnSubItemEndPoint?menu_id=$menuId&id=$subItemId&search=$search&page=$page&items_per_page=$itemsPerPage");

    if (response != null) {
      if (response['status'] == 200) {
        List<SubItemTaggedDetailsData> tempList = <SubItemTaggedDetailsData>[];
        for (var item in response['data']['list']) {
          tempList.add(SubItemTaggedDetailsData.fromJson(item));
        }
        return {
          "data": tempList,
          "total_pages": response['data']['total_pages']
        };
      } else if (response['status'] == 401) {
        navLogin();
      }
    }

    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message'].toString()),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);
    return null;
  }
}
