import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/new_purchase_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/new_purchase/new_pharchase_item_list.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class NewPharchaseToLotService {

  static Future fetchConvertLotItemList({
    NewPurchaseItemListPaylaod? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: newPurchaseconvertlotListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<NewPurchaseItemListData> tempList = <NewPurchaseItemListData>[];
        for (var item in response['data']['list']) {
          tempList.add(NewPurchaseItemListData.fromJson(item));
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

  static Future retrievePurchaseDetails(
      {String? PoId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$newPurchaseItemListEndPoint?menu_id=$menuId&id=$PoId");

        print("response1234 ${response}");

    if (response != null) {
      if (response['status'] == 200) {
        final NewPurchaseItemDetails newPurchaseItemDetails =
            NewPurchaseItemDetails.fromJson(response['data']['list']);
        return newPurchaseItemDetails;
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
