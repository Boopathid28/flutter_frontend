import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/itemtag_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/itemtag/itemtag_model.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

class ItemtagFormService {
  static Future createTagEntry({String? branch, required String lotId, required BuildContext context}) async {
    CreateTagEntryPayload payload = CreateTagEntryPayload(
        lotDetails: lotId,
        branch: branch,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    var response = await ApiCalls.postWithToken(
        url: createTagEntryEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        CreateTagEntryResponse data =
            CreateTagEntryResponse.fromJson(response['data']);
        return data.id;
      } else if (response['status'] == 401) {
        navLogin();
        return null;
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

  static Future createTagItem(
      {required Object payload, required BuildContext context}) async {
    var response =
        await ApiCalls.postWithToken(url: createTagItemEndPoint, body: payload);
log("response  ${response}");
log("payload  ${payload}");
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
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
        pauseOnHover: false);

    return null;
  }

  static Future getTagEntryDetailsById(
      {required String tagEntryId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url: "$createTagEntryEndPoint?menu_id=$menuId&id=$tagEntryId");

    if (response != null) {
      if (response['status'] == 200) {
        List<TagItemDetailsResponse> tempList = <TagItemDetailsResponse>[];

        response['data']['tag_details'].forEach(
            (item) {
              var dictValue = item;
              dictValue['is_editable'] = false;
              tempList.add(TagItemDetailsResponse.fromJson(dictValue));
            });
        return response['data'];
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

  static Future getSubitemCalculationDetails(
      {required String subItemId,
      required BuildContext context,
      required String calcTypeId,
      required String grossWeight,
      required String lotItemId}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url:
            "$getSubitemCalculationDetailsEndPoint?sub_item=$subItemId&gross_weight=$grossWeight&calculation_type=$calcTypeId&lot_item_id=$lotItemId");
log("response   ${response}");
    if (response != null) {
      if (response['status'] == 200) {
        return response['data'];
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

  static Future submitItemTagDetails(
      {required Object payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: updateTagItemDetailsEndPoint, body: payload);
        log("response   ${response}");
        log("payload   ${payload}");
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return "success";
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

  static Future deleteItemTagDetails(
      {required String tagNumber, required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$deleteTagItemDetailsEndPoint?tag_number=$tagNumber");
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return "success";
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




   static Future getStoneDiamondDetailsById(
      {required String lotItemIdId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url: "$stoneanddiamondDetailsEndPoint?lot_item_id=$lotItemIdId");

    if (response != null) {
      if (response['status'] == 200) {
          final StoneAndDiamondDetailsResponse stoneAndDiamondDetailsResponse =
          StoneAndDiamondDetailsResponse.fromJson(response['data']);
        log("response  ${response}");
        return stoneAndDiamondDetailsResponse;
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

}
