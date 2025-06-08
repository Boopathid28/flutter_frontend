import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/order_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/order/order_assign_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class OrderAssignService {
  static Future fetchOrderAssignList({
    OrderItemtableList? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: orderassignListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<OrderItemtableListData> tempList = <OrderItemtableListData>[];
        for (var item in response['data']['list']) {
          tempList.add(OrderItemtableListData.fromJson(item));
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

  static Future createVendorAssign(
      {AssignVendorPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: ordervendorassignEndPoint, body: payload!.toJson());
  
    if (response != null) {
      if (response['status'] == 200) {
        final AssignVendorResponse assignVendorResponse =
            AssignVendorResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return assignVendorResponse;
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
