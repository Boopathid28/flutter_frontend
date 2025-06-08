import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/order_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/order/order_receive_item_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class OrderReceiveItemService {

  static Future fetchOrderReceiveItemList({
    OrderReceiveItemPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: orderReceiveItemListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<OrderReceiveItemResponse> tempList = <OrderReceiveItemResponse>[];
        for (var item in response['data']['list']) {
          tempList.add(OrderReceiveItemResponse.fromJson(item));
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

  static Future createreceiveItem(
      {ReceiveOrderItemPaylaod? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: orderreceiveitemEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final ReceiveOrderItemResponse receiveOrderItemResponse =
          ReceiveOrderItemResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return receiveOrderItemResponse;
      } else if (response['status'] == 400) {

        response['data'].forEach((final String key, final value) {
          toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(value[0].toString()),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false
          );
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
          pauseOnHover: false
        );

    return null;
  }

}
