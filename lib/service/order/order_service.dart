import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/order_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/order/order_view_details_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderService {
  static Future fetchOrderList({
    FetchOrderListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: orderListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<OrderListData> tempList = <OrderListData>[];
        for (var item in response['data']['list']) {
          tempList.add(OrderListData.fromJson(item));
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

  static Future createOrder(
      {CreateOrderPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: orderEndPoint, body: payload!.toJson());
  log("response   ${response}");
  log("payload!.toJson()   ${payload!.toJson()}");
    if (response != null) {
      if (response['status'] == 200) {
        final CreateOrderResponse orderResponse =
            CreateOrderResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return orderResponse;
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

  static Future deleteOrder(
      {required String menuId,
      required String orderId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$orderEndPoint?id=$orderId&menu_id=$menuId");
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




  static Future retrieveOrder(
      {String? orderId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$orderEndPoint?menu_id=$menuId&id=$orderId");

    if (response != null) {
      if (response['status'] == 200) {
        final OrderGetResponse orderGetResponse =
            OrderGetResponse.fromJson(response['data']);

        return orderGetResponse;
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

  static Future retrieveOrderDetails(
      {String? orderId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$orderEndPoint?menu_id=$menuId&id=$orderId");
    if (response != null) {
      if (response['status'] == 200) {
        final RetrieveOrderDetails orderGetResponse =
            RetrieveOrderDetails.fromJson(response['data']);

        return orderGetResponse;
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



  static Future assignVendorOrderItems(
      {AssignOrderItems? payload, required BuildContext context}) async {
        log(payload!.toJson().toString());
    var response = await ApiCalls.putWithToken(
        url: ordervendorassignEndPoint, body: payload!.toJson());
log(response.toString());
    if (response != null) {
      if (response['status'] == 200) {
        
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return "success";
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
 
  static Future recievedOrderItems(
      {RecieveOrderItems? payload, required BuildContext context}) async {
        log(payload!.toJson().toString());
    var response = await ApiCalls.putWithToken(
        url: orderreceiveitemEndPoint, body: payload!.toJson());
log(response.toString());
    if (response != null) {
      if (response['status'] == 200) {
        
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return "success";
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
