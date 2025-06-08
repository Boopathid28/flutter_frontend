import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/approval_issues_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/counter_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/approval_issues/approval_issues_models.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovalIssuesServices {
  static Future fetchApprovalIssuesList({
    FetchApprovalIssuesListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: approvalissuesListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<ApprovalIssuesListData> tempList = <ApprovalIssuesListData>[];
        for (var item in response['data']['list']) {
          tempList.add(ApprovalIssuesListData.fromJson(item));
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

  static Future retrieveReceiveItem(
      {String? receiveId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$approvalissuesReceiptListEndPoint?menu_id=$menuId&id=$receiveId");

    if (response != null) {
      if (response['status'] == 200) {
        final ApprovalIssuesReciptResponse approvalIssuesReciptResponse =
            ApprovalIssuesReciptResponse.fromJson(response['data']);


        return approvalIssuesReciptResponse;
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

  static Future createApprovalIssues(
      {CreateApprovalIssuesPaylaod? payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: approvalissuesEndPoint, body: payload!.toJson());
  
    if (response != null) {
      if (response['status'] == 200) {
        final CreateApprovalIssuesResponse createApprovalIssuesResponse =
            CreateApprovalIssuesResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createApprovalIssuesResponse;
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






  static Future createApprovalIssuesReceipt(
      {CreateApprovalIssuesReciptPayload? payload,
      required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: approvalissuesreceiptEndPoint, body: payload!.toJson());
  
    if (response != null) {
      if (response['status'] == 200) {
        final CreateReceiptResponse createReceiptResponse =
            CreateReceiptResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createReceiptResponse;
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
