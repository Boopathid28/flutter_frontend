import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/company_ledger_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/counter_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_models.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_print_models.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toastification/toastification.dart';

class CompanyLedgerService {

  static Future fetchCompanyLedgerList({
    FetchCompanyLedgerListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: companyledgerListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<CompanyLedgerListData> tempList = <CompanyLedgerListData>[];
        for (var item in response['data']['list']) {
          tempList.add(CompanyLedgerListData.fromJson(item));
        }
        return {
            "list": tempList,
          "data": response['data']
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }





  static Future createCompanyLedger(
      {CreateCompanyLedgerPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: companyledgerEndPoint, body: payload!.toJson());
    if (response != null) {      

      if (response['status'] == 200) {
        final CreateCompanyLedgerResponse companyLedgerResponse =
          CreateCompanyLedgerResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return companyLedgerResponse;
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

  static Future updateCompanyLedger(
      {UpdateCounterPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: counterEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CounterCreateResponse counterCreateResponse =
          CounterCreateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return counterCreateResponse;
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



  static Future deleteCompanyLedger(
      {required String menuId,
      required String companyId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$companyledgerEndPoint?id=$companyId&menu_id=$menuId");
    Get.back();

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
        pauseOnHover: false
      );
    }

    return null;
  }


  static Future printCompanyLedger(
      {required String menuId,
      required String companyId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$companyledgerEndPoint?id=$companyId&menu_id=$menuId");
 
    if (response != null) {
      if (response['status'] == 200) {
        PrintCompanyLedgerDetails data = PrintCompanyLedgerDetails.fromJson(response['data']);
        return data;
      } else if (response['status'] == 401) {
        navLogin();
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
