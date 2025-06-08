import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/metal_rate_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/layout_model.dart';
import 'package:ausales_application/model/metal_rates/metal_rate_master.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class MetalRateMasterService {

  static Future fetchMetalRateMasterList({
    FetchMetalRateMasterListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: metalRatesMasterListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<MetalRateMasterListData> tempList = <MetalRateMasterListData>[];
        for (var item in response['data']['list']) {
          tempList.add(MetalRateMasterListData.fromJson(item));
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

  static Future createMetalRateMaster(
      {CreateMetalRateMasterPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: metalRatesMasterEndPoint, body: payload!.toJson());

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
        return ;
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


  static Future retrieveDisplayMetalRates() async {

    var response = await ApiCalls.getWithToken(
        url: displayMetalRatesEndPoint);

    if (response != null) {
      if (response['status'] == 200) {
        return response['data'];
      } else if (response['status'] == 401) {
        navLogin();
      }
    }

    return null;
  }
}
