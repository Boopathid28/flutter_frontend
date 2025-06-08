import 'package:ausales_application/core/api_endpoints/metal_entries_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/metal_entries/metal_entries_model.dart';
import 'package:ausales_application/model/purity_master/purity_master_model.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class MetalEntriesService {
  static Future fetchMetalEntriesList({
    FetchMetalEntriesPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: metalEntriesListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<MetalEntriesListData> tempList = <MetalEntriesListData>[];
        for (var item in response['data']['list']) {
          tempList.add(MetalEntriesListData.fromJson(item));
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

  static Future createMetalEntry(
      {CreateMetalEntriesPayload? payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: metalEntriesEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final MetalEntriesCreateResponse metalEntriesCreateResponse =
            MetalEntriesCreateResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return metalEntriesCreateResponse;
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
