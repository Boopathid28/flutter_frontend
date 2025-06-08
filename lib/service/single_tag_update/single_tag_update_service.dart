import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/single_tag_update_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/single_tag_update/single_tag_update_model.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SingleTagUpdateService {

  static Future retrieveTagdetails(
      {required String menuId,
      required String tagNumber,
      required BuildContext context}) async {
        
    var  response = await ApiCalls.getWithToken(
        url: "$singleTagRetrieveDetailsEndPoint?tag_number=$tagNumber&menu_id=$menuId");

    if (response != null) {
      if (response['status'] == 200) {
        RetrieveTagDetails data = RetrieveTagDetails.fromJson(response['data']);
        return data;
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }

      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false
      );
    }

    return null;
  }

  static Future updateTagdetails(
      {
      required SingleTagUpdatePayload payload,
      required BuildContext context}) async {
        
    var  response = await ApiCalls.putWithToken(
        url: singleTagUpdateEndPoint,
        body: payload);


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
        return 'success';
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }

      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.error,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false
      );
    }

    return null;
  }
}