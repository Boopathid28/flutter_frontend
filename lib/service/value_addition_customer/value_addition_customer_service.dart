import 'package:ausales_application/core/api_endpoints/value_addition_customer_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/value_addition_customer/value_addition_customer_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueAdditionCustomerService {
  static Future fetchValueAdditionCustomerList({
    FetchValueAdditionCustomerListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: valueadditioncustomerListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<ValueAdditionCustomerData> tempList = <ValueAdditionCustomerData>[];
        for (var item in response['data']['list']) {
          tempList.add(ValueAdditionCustomerData.fromJson(item));
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

  static Future retrieveValueAdditionCustomer(
      {String? valueadditioncustomerId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$valueadditioncustomerEndPoint?menu_id=$menuId&id=$valueadditioncustomerId");


    if (response != null) {
      if (response['status'] == 200) {
        final ValueAdditionCustomerDetailsData valueAdditionCustomerDetailsData =
            ValueAdditionCustomerDetailsData.fromJson(response['data']);

        return valueAdditionCustomerDetailsData;
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



 static Future retrieveValueAdditionTagList(
      {String? subItem, String? fromweight , String? toweight , required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$valueadditioncustomerTagListEndPoint?menu_id=$menuId&sub_item=$subItem&from_weight=$fromweight&to_weight=$toweight");


   if (response != null) {
      if (response['status'] == 200) {
        List<ValueAdditionGetTagDetails> tempList = <ValueAdditionGetTagDetails>[];
        for (var item in response['data']['list']) {
          tempList.add(ValueAdditionGetTagDetails.fromJson(item));
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

    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);

    return null;
  }



  static Future createValueadditioncustomer(
      {CreateValueAdditionCustomerPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: valueadditioncustomerEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateValueAdditionCustomerresponse createValueAdditionCustomerresponse =
            CreateValueAdditionCustomerresponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createValueAdditionCustomerresponse;
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

  static Future updateValueAdditionCustomer(
      {UpdateValueAdditionCustomerPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: valueadditioncustomerEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateValueAdditionCustomerresponse createValueAdditionCustomerresponse =
            CreateValueAdditionCustomerresponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createValueAdditionCustomerresponse;
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

  static Future deleteValueAdditionCustomer(
      {required String menuId,
      required String valueadditioncustomerId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$valueadditioncustomerEndPoint?id=$valueadditioncustomerId&menu_id=$menuId");
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
