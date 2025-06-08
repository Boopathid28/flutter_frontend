import 'package:ausales_application/controller/tax_master/tax_list_controller.dart';
import 'package:ausales_application/core/api_endpoints/tax_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/tax/tax_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxService {
  final TaxListController _taxListController = Get.put(TaxListController());

  static Future fetchTaxList({
    FetchTaxListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: taxMasterListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<TaxListData> tempList = <TaxListData>[];
        for (var item in response['data']['list']) {
          tempList.add(TaxListData.fromJson(item));
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

  static Future createTax(
      {CreateTaxPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: taxMasterEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final TaxCreateResponse taxCreateResponse =
          TaxCreateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return taxCreateResponse;
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

  static Future updateTax(
      {UpdateTaxPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: taxMasterEndPoint, body: payload!.toJson());
    if (response != null) {      

      if (response['status'] == 200) {
        final TaxCreateResponse taxCreateResponse =
          TaxCreateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return taxCreateResponse;
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

  static Future deleteTax(
      {required String menuId,
      required String taxId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$taxMasterEndPoint?id=$taxId&menu_id=$menuId");
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

 static Future getTaxdetails(
      {required String menuId,
      required String taxId,
      required BuildContext context}) async {
    var  response = await ApiCalls.getWithToken(
        url: "$taxMasterEndPoint?id=$taxId&menu_id=$menuId");

    if (response != null) {
      if (response['status'] == 200) {
        return response;
      } else if (response['status'] == 401) {
        navLogin();
      }
    }

    return null;
  }

}
