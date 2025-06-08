import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/order_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/order/order_receive_item_convert_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class OrderConvertReceiveItemService {

  static Future fetchConvertOrderReceiveItemList({
    OrderConvertReceiveItemPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: orderRecievItemtconvertlistEndPoint, body: payload!.toJson());

 
    if (response != null) {
      if (response['status'] == 200) {
        List<OrderConvertReceiveItemResponse> tempList = <OrderConvertReceiveItemResponse>[];
        for (var item in response['data']['list']) {
          tempList.add(OrderConvertReceiveItemResponse.fromJson(item));
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

  static Future retrieveOrderDetails(
      {String? OrderId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$orderRecievItemtconvertEndPoint?menu_id=$menuId&id=$OrderId");

        print("response1234 ${response}");

    if (response != null) {
      if (response['status'] == 200) {
        final OrderConvertReceiveItemIdResponse orderConvertReceiveItemIdResponse =
            OrderConvertReceiveItemIdResponse.fromJson(response['data']['list']);
        return orderConvertReceiveItemIdResponse;
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
