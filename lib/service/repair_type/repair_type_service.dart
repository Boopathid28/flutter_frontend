import 'package:ausales_application/core/api_endpoints/repair_type_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/repair_type/repair_type_models.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class RepairTypeService {
  static Future fetchAllRepairTypes(
      {
      required GetAllRepairTypesPayload payload,
      r}) async {
    var response = await ApiCalls.postWithToken(
        url: repairTypeListEndpoint, body: payload.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final data = <GetAllRepairTypes>[];
        for(var item in response['data']['list']){
          data.add(GetAllRepairTypes.fromJson(item));
        }
        return {
          'data':data,
          'total_pages':response['data']['total_pages']
        };
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }

      toastification.show(
          type: ToastificationType.error,
          title: Text(response['message']),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }

    return null;
  }

  static Future createRepairType(
      CreateRepairTypePayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: repairTypeCrudEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }

  static Future updateRepairType(
      UpdateRepairTypePayload payload, BuildContext context) async {
    var response = await ApiCalls.putWithToken(
        url: repairTypeCrudEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }

  static Future deleteRepairType(BuildContext context,
      {required String id, required String menuId}) async {
    var response = await ApiCalls.deleteWithToken(
      url: '$repairTypeCrudEndpoint?id=$id&menu_id=$menuId',
    );
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }


   static Future changeRepairTypeStatus(BuildContext context,
      {required String id, required String menuId}) async {
    var response = await ApiCalls.getWithToken(
      url: '$repairTypeStatusChangeEndpoint?id=$id&menu_id=$menuId',
    );
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      return null;
    }
  }
}
