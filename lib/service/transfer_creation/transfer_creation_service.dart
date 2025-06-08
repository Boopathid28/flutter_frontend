import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/transfer_creation_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/transfer_creation/transfer_creation_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransfercreationService {
  static Future fetchTransfercreationList({
    FetchTransferCreationListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: transfercreationListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<TransferCreationListData> tempList = <TransferCreationListData>[];
        for (var item in response['data']['list']) {
          tempList.add(TransferCreationListData.fromJson(item));
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

  static Future fetchTransfercreationDataList({
    TransferCreationDataListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: transfercreationDataListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<TransferCreationDataListData> tempList =
            <TransferCreationDataListData>[];
        for (var item in response['data']['list']) {
          tempList.add(TransferCreationDataListData.fromJson(item));
        }

        return {
          "data": tempList,
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  static Future createtransferCreation(
      {TransferCreationPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: transfercreationEndPoint, body: payload!.toJson());
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

  static Future retrieveTransferCreation(
      {String? transferId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$transfercreationEndPoint?menu_id=$menuId&id=$transferId");


    if (response != null) {
      if (response['status'] == 200) {
        final TransferCreationDetailsData transferCreationDetailsData =
            TransferCreationDetailsData.fromJson(response['data']);

        return transferCreationDetailsData;
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

  static Future updateTransferCreation(
      {UpdateTransferCreationPayload? payload,
      required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: transfercreationEndPoint, body: payload!.toJson());
        
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

  static Future deleteTransferCreation(
      {required String menuId,
      required String transferId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$transfercreationEndPoint?id=$transferId&menu_id=$menuId");
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
