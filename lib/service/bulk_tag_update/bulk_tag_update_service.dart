import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/bulk_tag_update.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/bulk_tag_update/bulk_tag_update_model.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class BulkTagUpdateService {
  static Future retrieveTagdetails(
      {required BulkTagListPayload payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: getBulkTagUpdateListEndPoint, body: payload);

    if (response != null) {
      if (response['status'] == 200) {
        List<BulkTagListData> tempList = <BulkTagListData>[];
        for (var item in response['data']['list']) {
          tempList.add(BulkTagListData.fromJson(item));
        }
        return {
          "data": tempList,
          "total_pages": response['data']['total_pages']
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
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

  static Future updateTagdetails(
      {
      required BulkTagUpdatePayload payload,
      required BuildContext context}) async {

    var response = await ApiCalls.putWithToken(
        url: bulkTagUpdateEndPoint,
        body: payload);
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
        return 'success';
      } else if (response['status'] == 401) {
        navLogin();
        return null;
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
