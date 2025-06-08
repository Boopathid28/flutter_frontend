import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/tag_details_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ItemTagDetailsService  {



 static Future getTagItemdetails(
   {String? tagnumber , required BuildContext context}) async {
        var menuId = await HomeSharedPrefs.getCurrentMenu();
    var  response = await ApiCalls.getWithToken(
        url: "$tagitemdetailsEndPoint?menu_id=$menuId&&tag_number=$tagnumber");

    if (response != null) {
      if (response['status'] == 200) {
        return response;
      } else if (response['status'] == 401) {
        navLogin();
      }
    }
    
    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.info,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);

    return null;
  }

}