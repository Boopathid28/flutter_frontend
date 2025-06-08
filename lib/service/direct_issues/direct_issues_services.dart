import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/approval_issues_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/direct_issues_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/approval_issues/approval_issues_models.dart';
import 'package:ausales_application/model/direct_issues/direct_issues_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class DirectIssuesServices {
  static Future fetchDirectIssuesList({
    FetchDirectIssuesListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: directissuesListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<DirectIssuesListData> tempList = <DirectIssuesListData>[];
        for (var item in response['data']['list']) {
          tempList.add(DirectIssuesListData.fromJson(item));
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

  static Future retrieveDirectItem(
      {String? directId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$directissuesEndPoint?menu_id=$menuId&id=$directId");

    if (response != null) {
      if (response['status'] == 200) {
        final RetriveDirectIssuesDetails retriveDirectIssuesDetails =
            RetriveDirectIssuesDetails.fromJson(response['data']);


        return retriveDirectIssuesDetails;
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

  static Future createDirectIssues(
      {CreateDirectIssuesPayload? payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: directissuesEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateDirectIssuesResponse createDirectIssuesResponse =
            CreateDirectIssuesResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createDirectIssuesResponse;
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
