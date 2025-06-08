import 'package:ausales_application/controller/customer_group/customer_group_list_controller.dart';
import 'package:ausales_application/core/api_endpoints/customer_group_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/customer_group/customer_group_models.dart';
import 'package:toastification/toastification.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerGroupService {
  final CustomerGroupListController _customerGroupListController = Get.put(CustomerGroupListController());

  static Future fetchCustomerGroupList({
    FetchCustmergroupListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: customergroupListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<CustomergroupListData> tempList = <CustomergroupListData>[];
        for (var item in response['data']['list']) {
          tempList.add(CustomergroupListData.fromJson(item));
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

  static Future createCustomerGroup(
      {CreateCustomerGroupPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: customergroupEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CustomerGroupCreateResponse customerGroupCreateResponse =
          CustomerGroupCreateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return customerGroupCreateResponse;
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

  static Future updateCustomerGroup(
      {UpdateCustomerGroupPayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.putWithToken(
        url: customergroupEndPoint, body: payload!.toJson());

    if (response != null) {      

      if (response['status'] == 200) {
        final CustomerGroupCreateResponse customerGroupCreateResponse =
          CustomerGroupCreateResponse.fromJson(response['data']);
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
        return customerGroupCreateResponse;
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

  static Future deleteCustomerGroup(
      {required String menuId,
      required String customergroupId,
      required BuildContext context}) async {
    var response = await ApiCalls.deleteWithToken(
        url: "$customergroupEndPoint?id=$customergroupId&menu_id=$menuId");
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

  static Future updateCustomerGroupStatus(
      {required String menuId,
      required String customergroupId,
      required BuildContext context}) async {
    var response = await ApiCalls.getWithToken(
        url: "$customergroupStatusEndPoint?id=$customergroupId&menu_id=$menuId");

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
}
