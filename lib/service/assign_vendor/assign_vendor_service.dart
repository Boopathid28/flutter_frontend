import 'package:ausales_application/core/api_endpoints/assign_vendor_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/assign_vendor/assign_vendor_models.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class AssignVendorService {
  static Future fetchNotIssuedTableList(
      NotIssuesRepairItemTableListPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: notIssuedRepairItemTableListEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <NotIssuesRepairItemTableList>[];
        for (var item in response['data']['list']) {
          data.add(NotIssuesRepairItemTableList.fromJson(item));
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
  }

  static Future assignVendor(AssignVendorPayload payload) async {
    var response = await ApiCalls.putWithToken(
        url: assignVendorEndpoint, body: payload.toJson());
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
}
