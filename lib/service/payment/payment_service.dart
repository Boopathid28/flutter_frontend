import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/estimation_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/invoice_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/old_purchase_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/suspense_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/model/payment/old_gold_payment_model.dart';
import 'package:ausales_application/model/payment/suspense_payment_model.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class PaymentService {
  static Future createSuspensePayment(
      {required SuspensePaymentCreatePayloadModel payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: suspenseEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final CreateSuspensePaymentResponse createSuspensePaymentResponse =
            CreateSuspensePaymentResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createSuspensePaymentResponse;
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
  }

  static Future retrieveSuspenseDetail(
      {String? SuspenseId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$invoiceSuspenseSearchEndPoint?menu_id=$menuId&id=$SuspenseId");

    if (response != null) {
      if (response['status'] == 200) {
        final SuspenseRetrieveDetails suspenseRetrieveDetails =
            SuspenseRetrieveDetails.fromJson(response['data']);

        return suspenseRetrieveDetails;
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

  static Future createOldPurchasePayment(
      {required OldPurchasePaymentPayload payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: oldPurchaseEndPoint, body: payload.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final OldPurchasePaymentCreateResponse oldPurchasePaymentCreateResponse =
            OldPurchasePaymentCreateResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return oldPurchasePaymentCreateResponse;
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
  }

  static Future retrieveOldPurchaseByNumber(
      {String? oldPurdchaseNumber, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$oldPurchaseByNumberEndPoint?menu_id=$menuId&id=$oldPurdchaseNumber");

    if (response != null) {
      if (response['status'] == 200) {
        final OldPurchasePaymentRetrieveResponse oldPurchasePaymentRetrieveResponse =
            OldPurchasePaymentRetrieveResponse.fromJson(response['data']);

        return oldPurchasePaymentRetrieveResponse;
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

  static Future fetchChitSchemeList({
    required int page, required String mobile, required String metal, required BuildContext context
  }) async {
    var response = await ApiCalls.getWithToken(
        url: "$estimationChitSchemeListEndPoint?mobile=$mobile&page=$page&metal=$metal");

    if (response != null) {
      if (response['status'] == 200) {
        List<ChitSchemeListData> tempList = <ChitSchemeListData>[];
        for (var item in response['data']['list']) {
          tempList.add(ChitSchemeListData.fromJson(item));
        }
        return {
          "data": tempList,
          "total_pages": int.parse((response['data']['total_pages']??"0").toString())
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }
}
