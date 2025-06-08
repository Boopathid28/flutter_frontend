import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/catalog_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/vendor_payment_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/catalog/catalog_models.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_view_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPaymentService {

  static Future fetchVendorPaymentList({
    FetchVendorPaymentListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: vendorPaymentListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<VendorPaymentListData> tempList = <VendorPaymentListData>[];
        for (var item in response['data']['list']) {
          tempList.add(VendorPaymentListData.fromJson(item));
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

  static Future retrieveVendorPayment(
      {required String menuId,
      required String id,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$vendorPaymentEndPoint?id=$id&menu_id=$menuId");

    if (response != null) {
      if (response['status'] == 200) {
        VendorPaymentListDataDetailsResponse data = VendorPaymentListDataDetailsResponse.fromJson(response['data']);
        return data;
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

  static Future retrieveVendorPaymentDetails(
      {required String menuId,
      required String vendorId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$vendorPaymentDetailsEndPoint?vendor=$vendorId&menu_id=$menuId");

    if (response != null) {
      if (response['status'] == 200) {
        VendorPaymentRetrieveData data = VendorPaymentRetrieveData.fromJson(response['data']);
        return data;
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

  static Future createVendorPayment(
      {VendorMakePaymentPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: vendorPaymentEndPoint, body: payload!.toJson());

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
        return "success";
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
        return null;
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

  static Future cancelVendorPayment(
      {required String menuId,
      required String vendorPaymentId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$vendorPaymentEndPoint?id=$vendorPaymentId&menu_id=$menuId");
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
