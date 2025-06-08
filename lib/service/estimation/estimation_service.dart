import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/diamond_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/estimation_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/estimation/estimation_history_models.dart';
import 'package:ausales_application/model/estimation/estimation_model.dart';
import 'package:ausales_application/model/estimation/estimation_print_out_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class EstimationService {

  static Future fetchEstimationList({
    FetchEstimationHistoryPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: estimationListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<EstimationHistoryListData> tempList = <EstimationHistoryListData>[];
        for (var item in response['data']['list']) {
          tempList.add(EstimationHistoryListData.fromJson(item));
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

  static Future createEstimtaion(
      {EstimationPayload? payload, required BuildContext context}) async {

    var response = await ApiCalls.postWithToken(
        url: createEstimationEndPoint, body: payload!.toJson());

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
        return response['data']['id'].toString();
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
  
  static Future retrieveEstimationDetail(
      {String? estimationId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$createEstimationEndPoint?menu_id=$menuId&id=$estimationId");

    if (response != null) {
      if (response['status'] == 200) {
        final RetrieveEstimationDetails retrieveEstimationDetails =
            RetrieveEstimationDetails.fromJson(response['data']);

        return retrieveEstimationDetails;
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


  static Future printRetrieveEstimationDetail(
      {String? estimationId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
 
    var response = await ApiCalls.getWithToken(
        url: "$estimationPrintOutEndPoint?menu_id=$menuId&id=$estimationId");
 
    if (response != null) {
      if (response['status'] == 200) {
        final PrintEstimationDetails retrieveEstimationDetails =
            PrintEstimationDetails.fromJson(response['data']);
 
        return retrieveEstimationDetails;
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
