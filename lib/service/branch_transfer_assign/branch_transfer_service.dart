import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/branch_transfer_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/stock_assign_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/tag_details_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/branch_transfer/branch_transfer_models.dart';
import 'package:ausales_application/model/stock_assign/stock_assign_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchTransferService {
  static Future fetctBranchTransferList({
    FetchBranchTransferListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: branchtransferListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<BranchTransferListData> tempList = <BranchTransferListData>[];
        for (var item in response['data']['list']) {
          tempList.add(BranchTransferListData.fromJson(item));
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

  static Future fetchValidationListList({
    ValidationTagPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: stockassignValidationEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final ValidationAssignTagResponse validationAssignTagResponse =
            ValidationAssignTagResponse.fromJson(response['data']);
        // for (var item in response['data']['assigned_tags']) {
        // tempList.add(ValidationAssignTagResponse.fromJson( response['data']));
        // }
        return {
          "data": validationAssignTagResponse,
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  static Future createBranchTransfer(
      {CreateBranchTransferPayload? payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: branchtransferEndPoint, body: payload!.toJson());
        
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

  static Future getTagItemdetails(
      {String? tagnumber, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
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
