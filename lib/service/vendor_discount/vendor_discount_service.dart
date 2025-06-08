import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/stone_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/vendor_discount_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/stone_master/stone_master_model.dart';
import 'package:ausales_application/model/vendor_discount/vendor_discount_model.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorDiscountService {

  static Future fetchVendorDiscountList({
    FetchVendorDiscountListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: vendorDiscountListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<VendorDiscountListData> tempList = <VendorDiscountListData>[];
        for (var item in response['data']['list']) {
          tempList.add(VendorDiscountListData.fromJson(item));
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

  static Future cancelVendorDiscount(
      {required String menuId,
      required String vendorDiscountId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$vendorDiscountEndPoint?id=$vendorDiscountId&menu_id=$menuId");
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

  static Future createVendorDiscount(
      {CreateVendorDiscountPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: vendorDiscountEndPoint, body: payload!.toJson());

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
