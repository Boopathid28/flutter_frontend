import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/invoice_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/old_purchase_endpoints.dart';
import 'package:ausales_application/core/api_endpoints/suspense_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/invoice/invoice_history_models.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/model/invoice/invoice_view_payment_details_models.dart';
import 'package:ausales_application/model/manual_invoice/manual_invoice_models.dart';
import 'package:toastification/toastification.dart';

import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';

class ManualInvoiceService {
  static Future fetchManualInvoiceList({
    FetchBillingHistoryPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: invoiceListEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        List<BillingHistoryListData> tempList = <BillingHistoryListData>[];
        for (var item in response['data']['list']) {
          tempList.add(BillingHistoryListData.fromJson(item));
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

  static Future createManualInvoice(
      {ManualInvoicePaylaod? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: createBillingEndPoint, body: payload!.toJson());
log("response  ${response}");
log("payload!.toJson()  ${payload!.toJson()}");
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return response['data']['id'].toString();
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

  static Future getManualTagItemdetails(
      {String? tagnumber, required BuildContext context, String? metal}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url:
            "$invoiceTagDetailsRetrieveEndPoint?menu_id=$menuId&&tag_number=$tagnumber&&metal=$metal");
log("response   ${response}");
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

  static Future createManualSuspense(
      {ManualCreateSuspensePayload? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: suspenseEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final ManualInvoiceCreateSuspenseResponse createSuspenseResponse =
            ManualInvoiceCreateSuspenseResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return createSuspenseResponse;
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

  static Future retrieveManualSuspenseDetail(
      {String? suspenseId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$invoiceSuspenseSearchEndPoint?menu_id=$menuId&id=$suspenseId");

    if (response != null) {
      if (response['status'] == 200) {
        final ManualInvoiceSuspenseRetrieveDetails suspenseDetailsData =
            ManualInvoiceSuspenseRetrieveDetails.fromJson(response['data']);
        return suspenseDetailsData;
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

  static Future retrieveManualBillingDetail(
      {String? billId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();

    var response = await ApiCalls.getWithToken(
        url: "$createBillingEndPoint?menu_id=$menuId&id=$billId");
    if (response != null) {
      if (response['status'] == 200) {
        final RetrieveBillingDetails retrieveBillingDetails =
            RetrieveBillingDetails.fromJson(response['data']);

        return retrieveBillingDetails;
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

  static Future createManualOldPurchase(
      {ManualInvoiceOldPurchasePayload? payload,
      required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: oldPurchaseEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final ManualInvoiceOldPurchaseCreateResponse resData =
            ManualInvoiceOldPurchaseCreateResponse.fromJson(response['data']);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return resData;
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

  static Future makeManualBillPayment(
      {BillPaymentModel? payload, required BuildContext context}) async {
    var response = await ApiCalls.postWithToken(
        url: makeBillPaymentEndPoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text(response['message']),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        return 'success';
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

  static Future getManualOrderdetails(
      {String? ordernumber, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url: "$orderDetailsEndPoint?menu_id=$menuId&order_id=$ordernumber");
    log("response  ${response}");
    log("$orderDetailsEndPoint?menu_id=$menuId&order_id=$ordernumber");
    if (response != null) {
      if (response['status'] == 200) {
        toastification.show(
        context: context, // optional if you use ToastificationWrapper
        type: ToastificationType.success,
        title: Text(response['message']),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);
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


  static Future retrieveManualBillingPaymentDetail(
      {String? billId, required BuildContext context}) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
 
    var response = await ApiCalls.getWithToken(
        url: "$invoicePaymentDetailsEndPoint?menu_id=$menuId&id=$billId");
 
    if (response != null) {
      if (response['status'] == 200) {
        final List<RetrievePaymentDetailListData> retrieveBillingPaymentDetails = [];
 
        response['data']['list'].forEach((item) {
            retrieveBillingPaymentDetails.add(RetrievePaymentDetailListData.fromJson(item));
        });
 
        return {
          "list": retrieveBillingPaymentDetails,
          "data": response['data']
        };
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




  
  static Future getSubitemCalculationDetails(
      {required String subItemId,
      required BuildContext context,
 
      }) async {
    var menuId = await HomeSharedPrefs.getCurrentMenu();
    var response = await ApiCalls.getWithToken(
        url:
            "$invoiceSubItemDetailsEndPoint?id=$subItemId&menu_id=$menuId");
log("response   ${response}");
    if (response != null) {
      if (response['status'] == 200) {
 
       final SubItemGetDataListMannualEstimation subItemGetDataListMannualEstimation = SubItemGetDataListMannualEstimation.fromJson(response['data']);
        return subItemGetDataListMannualEstimation;
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
