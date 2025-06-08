import 'dart:developer';

import 'package:ausales_application/core/api_endpoints/reports/reports_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/model/reports/all_metal_daily_sale_report_models.dart';
import 'package:ausales_application/model/reports/approval_issue_report_models.dart';
import 'package:ausales_application/model/reports/approval_pending_report_models.dart';
import 'package:ausales_application/model/reports/approval_received_report_models.dart';
import 'package:ausales_application/model/reports/bill_repayment_report_models.dart';
import 'package:ausales_application/model/reports/billing_cr_dr_models.dart';
import 'package:ausales_application/model/reports/billing_gst_report_models.dart';
import 'package:ausales_application/model/reports/cash_purchase_report_models..dart';
import 'package:ausales_application/model/reports/catalog_verification_report_models.dart';
import 'package:ausales_application/model/reports/customer_cr_dr_report_models.dart';
import 'package:ausales_application/model/reports/customer_summary_models.dart';
import 'package:ausales_application/model/reports/daily_payment_report_models.dart';
import 'package:ausales_application/model/reports/daily_report_models.dart';
import 'package:ausales_application/model/reports/daily_sale_report_models.dart';
import 'package:ausales_application/model/reports/daily_stock_designer_wise_report_models.dart';
import 'package:ausales_application/model/reports/daily_stock_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/daily_stock_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/daily_stock_purity_wise_report_models.dart';
import 'package:ausales_application/model/reports/daily_stock_subitem_wise_report_models.dart';
import 'package:ausales_application/model/reports/direct_issue_report_models.dart';
import 'package:ausales_application/model/reports/estimation_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/estimation_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/estimation_purity_wise_report_models.dart';
import 'package:ausales_application/model/reports/estimation_sub_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/estimation_vendor_wise_report_models.dart';
import 'package:ausales_application/model/reports/item_closing_report_models.dart';
import 'package:ausales_application/model/reports/item_wise_repair_report_model.dart';
import 'package:ausales_application/model/reports/item_wise_sale_report_models.dart';
import 'package:ausales_application/model/reports/live_stock_report_models.dart';
import 'package:ausales_application/model/reports/manual_estimation_billing_report_models.dart';
import 'package:ausales_application/model/reports/metal_wise_repair_report_model.dart';
import 'package:ausales_application/model/reports/metal_wise_sale_report_models.dart';
import 'package:ausales_application/model/reports/order_bill_report_models.dart';
import 'package:ausales_application/model/reports/order_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_pending_report_models.dart';
import 'package:ausales_application/model/reports/order_purity_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_report_models.dart';
import 'package:ausales_application/model/reports/order_sub_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_vendor_wise_report_models.dart';
import 'package:ausales_application/model/reports/overall_daily_report_models.dart';
import 'package:ausales_application/model/reports/payment_flow_report_models.dart';
import 'package:ausales_application/model/reports/pending_bill_payment_report_models.dart';
import 'package:ausales_application/model/reports/purchase_and_billing_item_report_models.dart';
import 'package:ausales_application/model/reports/purchase_and_billing_metal_report_models.dart';
import 'package:ausales_application/model/reports/purchase_and_billing_purity_report_models.dart';
import 'package:ausales_application/model/reports/purchase_and_billing_sub_item_report_models.dart';
import 'package:ausales_application/model/reports/purchase_and_billing_vendor_report_models.dart';
import 'package:ausales_application/model/reports/purchase_item_report_models.dart';
import 'package:ausales_application/model/reports/purchase_sub_item_report_models.dart';
import 'package:ausales_application/model/reports/purchase_wise_metal_report_models.dart';
import 'package:ausales_application/model/reports/purchase_wise_vendor_report_model.dart';
import 'package:ausales_application/model/reports/purity_wise_repair_report_model.dart';
import 'package:ausales_application/model/reports/purity_wise_sale_report_models.dart';
import 'package:ausales_application/model/reports/repair_report_models.dart';
import 'package:ausales_application/model/reports/size_based_report_models.dart';
import 'package:ausales_application/model/reports/stock_outward_report_models.dart';
import 'package:ausales_application/model/reports/subitem_wise_sale_report_models.dart';
import 'package:ausales_application/model/reports/suspense_pending_report_model.dart';
import 'package:ausales_application/model/reports/suspense_redeem_report_models.dart';
import 'package:ausales_application/model/reports/suspense_repayment_report_models.dart';
import 'package:ausales_application/model/reports/tds_deduction_report_models.dart';
import 'package:ausales_application/model/reports/vendor_crdr_report_models.dart';
import 'package:ausales_application/model/reports/vendor_inward_report_models.dart';
import 'package:ausales_application/model/reports/vendor_item_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_metal_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_outwards_report_models.dart';
import 'package:ausales_application/model/reports/vendor_purity_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_subitem_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_wise_repair_report_model.dart';
import 'package:ausales_application/model/reports/vendor_wise_report_models.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ReportsServices {
  /////////////////fetchDailyStockSubItemWiseReport
  static Future fetchDailyStockSubItemWiseReport(
      DailyStockSubitemItemWiseReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: dailyStockSubItemWiseReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = DailyStockSubitemItemWiseReport.fromJson(response['data']);

        return data;
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
  ///////////////////

/////////////////////fetchDailyStockItemWiseReport
  static Future fetchDailyStockItemWiseReport(
      DailyStockItemWiseReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: dailyStockItemWiseReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = DailyStockItemWiseReport.fromJson(response['data']);

        return data;
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
  //////////////////////

  //////////////fetchDailyStockMetalWiseReport
  static Future fetchDailyStockMetalWiseReport(
      DailyStockMetalWiseReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: dailyStockMetalWiseReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = DailyStockMetalWiseReport.fromJson(response['data']);

        return data;
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
  //////////////////

/////////////////fetchDailyStockPurityWiseReport
  static Future fetchDailyStockPurityWiseReport(
      DailyStockPurityWiseReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: dailyStockPurityWiseReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = DailyStockPurityWiseReport.fromJson(response['data']);

        return data;
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
  ////////////////

///////////////////////fetchDailyStockDesignerWiseReport
  static Future fetchDailyStockDesignerWiseReport(
      DailyStockDesignerWiseReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: dailyStockDesignerWiseReportEndpoint, body: payload.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = DailyStockDesignerWiseReport.fromJson(response['data']);

        return data;
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
  /////////////////

  //////////fetchVendorWiseReport
  static Future fetchVendorWiseReport(VendorWiseReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: vendorWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorWiseReport>[];
        for (var item in response['data']['list']) {
          data.add(VendorWiseReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////

///////////////fetchVendorMetalWiseSalesReport
  static Future fetchVendorMetalWiseSalesReport(
      VendorMetalWiseSalesReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: vendorMetalWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorMetalWiseSalesReport>[];
        for (var item in response['data']['list']) {
          data.add(VendorMetalWiseSalesReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  ///////////////fetchVendorPurityWiseSalesReport
  static Future fetchVendorPurityWiseSalesReport(
      VendorPurityWiseSalesReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: vendorPurityWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorPurityWiseSalesReport>[];
        for (var item in response['data']['list']) {
          data.add(VendorPurityWiseSalesReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  ///////////////fetchVendorSubitemWiseSalesReport
  static Future fetchVendorSubitemWiseSalesReport(
      VendorSubitemWiseSalesReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: vendorSubItemWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorSubitemWiseSalesReport>[];
        for (var item in response['data']['list']) {
          data.add(VendorSubitemWiseSalesReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  ///////////////fetchVendorItemWiseSalesReport
  static Future fetchVendorItemWiseSalesReport(
      VendorItemWiseSalesReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: vendorItemWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorItemWiseSalesReport>[];
        for (var item in response['data']['list']) {
          data.add(VendorItemWiseSalesReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  ///////////////fetchMetalWiseSalesReport
  static Future fetchMetalWiseSalesReport(
      MetalWiseSaleReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: metalWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <MetalWiseSaleReport>[];
        for (var item in response['data']['list']) {
          data.add(MetalWiseSaleReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  ///////////////fetchPurityWiseSalesReport
  static Future fetchPurityWiseSalesReport(
      PurityWiseSaleReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: purityWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurityWiseSaleReport>[];
        for (var item in response['data']['list']) {
          data.add(PurityWiseSaleReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  ///////////////fetchItemWiseSalesReport
  static Future fetchItemWiseSalesReport(
      ItemWiseSaleReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: itemWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <ItemWiseSaleReport>[];
        for (var item in response['data']['list']) {
          data.add(ItemWiseSaleReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  ///////////////fetchItemWiseSalesReport
  static Future fetchSubitemWiseSalesReport(
      SubitemWiseSaleReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: subItemWiseSalesReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <SubitemWiseSaleReport>[];
        for (var item in response['data']['list']) {
          data.add(SubitemWiseSaleReport.fromJson(item));
        }

        return {'data': data, 'total_pages': response['total_pages']};
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
  ////////////////////////////

  //////////////////fetchItemWiseSalesReport
  static Future fetchSuspensePendingReportReport(
      SuspensePendingReportPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: suspensePendingReportEndPoint, body: payload.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final List<SuspensePendingReportListData> data =
            <SuspensePendingReportListData>[];
        for (var item in response['data']['list']) {
          data.add(SuspensePendingReportListData.fromJson(item));
        }

        return {'data': data, 'total_pages': response['data']['total_pages']};
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
  ////////////////////////////

  //////////////////fetchCatalogVerificationWiseReport
  static Future fetchCatalogVerificationReport(
      FetchCatalogVerificationReportListPayload payload) async {
    var response = await ApiCalls.postWithToken(
        url: catalogverficationReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <CatalogVerificationReportListData>[];
        for (var item in response['data']['list']) {
          data.add(CatalogVerificationReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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

  ////////////////////////////
  ///
  //////////////////fetchOrderItemWiseReport
  static Future fetchOrderItemWiseReport(
      {FetchOrderItemWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderItemWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderItemWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderItemWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  ///////////////fetchOrderSubItemWiseReport
  static Future fetchOrderSubItemWiseReport(
      {FetchOrderSubItemWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderSubItemWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderSubItemWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderSubItemWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  ///////////////fetchOrderMetalWiseReport
  static Future fetchOrderMetalWiseReport(
      {FetchOrderMetalWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderMetalWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderMetalWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderMetalWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  ///////////////fetchOrderVendorWiseReport
  static Future fetchOrderVendorWiseReport(
      {FetchOrderVendorWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderVendorWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderVendorWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderVendorWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  ///////////////fetchOrderVendorWiseReport
  static Future fetchOrderPurityWiseReport(
      {FetchOrderPurityWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderPurityWiseReportEndpoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderPurityWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderPurityWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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

  ////////////////////////////
  ///
  /// ///////////////fetchEstimationMetalWiseReport
  static Future fetchEstimationMetalWiseReport(
      {FetchEstimationMetalWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: estimationmetalWiseReportEndpoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final data = <EstimationMetalWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(EstimationMetalWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationPurityWiseReport
  static Future fetchEstimationPurityWiseReport(
      {FetchEstimationPurityWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: estimationpurityWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <EstimationPurityWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(EstimationPurityWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationItemWiseReport
  static Future fetchEstimationItemWiseReport(
      {FetchEstimationItemWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: estimationitemWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <EstimationItemWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(EstimationItemWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationSubItemWiseReport
  static Future fetchEstimationSubItemWiseReport(
      {FetchEstimationSubItemWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: estimationsubitemWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <EstimationSubItemWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(EstimationSubItemWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationVendorWiseReport
  static Future fetchEstimationVendorWiseReport(
      {FetchEstimationVendorDesignerWiseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: estimationvendorWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <EstimationVendorWiseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(EstimationVendorWiseReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  ///////////////fetchPendingBillPaymentReport
  static Future fetchPendingBillPaymentReport(
      {PendingBillPaymentReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: pendingBillPaymentReportEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PendingBillPaymentReportListData>[];
        for (var item in response['data']['list']) {
          data.add(PendingBillPaymentReportListData.fromJson(item));
        }

        return {"total_pages": response['total_pages'], "data": data};
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
  ////////////////////////////

  //////////////////fetchSizeBasedReport
  static Future fetchSizeBasedReport({SizeBasedReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: sizeBasedReportEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <SizeBasedReportListData>[];
        for (var item in response['data']['list']) {
          data.add(SizeBasedReportListData.fromJson(item));
        }

        return {"total_pages": response['total_pages'], "data": data};
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
  ////////////////////////////

///////////////fetchEstimationSubItemWiseReport
  static Future fetchOverallDailyReport(
      {FetchOverallDailyReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: overalldailyReportEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OverallDailyReportResponse>[];
        for (var item in response['data']['list']) {
          data.add(OverallDailyReportResponse.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  //////////////////fetchSizeBasedReport
  static Future fetchBillingGstReport(
      {BillingGstReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: billingGstReportEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <BillingGstReportListData>[];
        for (var item in response['data']['list']) {
          data.add(BillingGstReportListData.fromJson(item));
        }

        return {"total_pages": response['total_pages'], "data": data};
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
  ////////////////////////////

  static Future fetchSuspenseRedeemReportList({
    FetchSuspenseRedeemReportListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: suspenseredeemreportListEndPoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        List<SuspenseRedeemReportListData> tempList =
            <SuspenseRedeemReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(SuspenseRedeemReportListData.fromJson(item));
        }
        return {"list": tempList, "data": response['data']};
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  static Future fetchSuspenseRepaymentReportList({
    FetchSuspenseRepaymentReportListPaylaod? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: suspenserepaymentreportListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<SuspenseRepaymentReportListData> tempList =
            <SuspenseRepaymentReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(SuspenseRepaymentReportListData.fromJson(item));
        }
        return {"list": tempList, "data": response['data']};
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  static Future fetchTdsDeductionReportList({
    FetchTdsDeductionReportListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: tdsdeductionreportListEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        List<TdsDeductionReportListData> tempList =
            <TdsDeductionReportListData>[];
        for (var item in response['data']['list']) {
          tempList.add(TdsDeductionReportListData.fromJson(item));
        }
        return {"list": tempList, "data": response['data']};
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

  ///////////////fetchDailyPaymentReport
  static Future fetchDailyPaymentReport(
      {DailyPaymentReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: dailyPaymentReportEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <DailyPaymentReportListData>[];
        for (var item in response['data']['list']) {
          data.add(DailyPaymentReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchCustomerSummaryReportList({
    FetchCustomerSummaryListPayload? payload,
  }) async {
    var response = await ApiCalls.postWithToken(
        url: customersummaryreportListEndPoint, body: payload!.toJson());

    
    if (response != null) {
      if (response['status'] == 200) {
        List<CustomerSummaryListData> tempList = <CustomerSummaryListData>[];
        for (var item in response['data']['list']) {
          tempList.add(CustomerSummaryListData.fromJson(item));
        }
        return {"list": tempList, "data": response['data']};
      } else if (response['status'] == 401) {
        navLogin();
        return null;
      }
    }

    return null;
  }

///////////////fetchMetalWiseRepairReport
  static Future fetchMetalWiseRepairReport(
      {FetchMetalWiseRepairListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: metalWiserepairReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <MetalWiseRepairListData>[];
        for (var item in response['data']['list']) {
          data.add(MetalWiseRepairListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchItemWiseRepairReport
  static Future fetchItemWiseRepairReport(
      {FetchItemWiseRepairReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: itemWiserepairReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <ItemWiseRepairReportListData>[];
        for (var item in response['data']['list']) {
          data.add(ItemWiseRepairReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchpurityWiseRepairReport
  static Future fetchpurityWiseRepairReport(
      {FetchPurityWiseRepairReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purityWiserepairReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurityWiseRepairReportListData>[];
        for (var item in response['data']['list']) {
          data.add(PurityWiseRepairReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchvendorWiseRepairReport
  static Future fetchvendorWiseRepairReport(
      {FetchVendorWiseRepairReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: vendorWiserepairReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorWiseRepairReportListData>[];
        for (var item in response['data']['list']) {
          data.add(VendorWiseRepairReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationVendorWiseReport
  static Future fetchPurchaseandbillingWiseReport(
      {FetchPurchaseandbillingReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchaseandbillmetalWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchaseandbillingReportResponse>[];
        for (var item in response['data']['list']) {
          data.add(PurchaseandbillingReportResponse.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationVendorWiseReport
  static Future fetchPurchaseandbillingPurityWiseReport(
      {FetchPurchaseandbillingPurityReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchaseandbillpurityWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchaseandbillingPurityReportResponse>[];
        for (var item in response['data']['list']) {
          data.add(PurchaseandbillingPurityReportResponse.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationVendorWiseReport
  static Future fetchPurchaseandbillingitemWiseReport(
      {FetchPurchaseandbillingItemReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchaseandbillitemWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchaseandbillingItemReportResponse>[];
        for (var item in response['data']['list']) {
          data.add(PurchaseandbillingItemReportResponse.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationVendorWiseReport
  static Future fetchPurchaseandbillingsubitemWiseReport(
      {FetchPurchaseandbillingSubItemReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchaseandbillsubitemWiseReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchaseandbillingSubItemReportResponse>[];
        for (var item in response['data']['list']) {
          data.add(PurchaseandbillingSubItemReportResponse.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationVendorWiseReport
  static Future fetchPurchaseandbillingvendorWiseReport(
      {FetchPurchaseandbillingVendorReportPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchaseandbillvendorWiseReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchaseandbillingVendorReportResponse>[];
        for (var item in response['data']['list']) {
          data.add(PurchaseandbillingVendorReportResponse.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchEstimationVendorWiseReport
  static Future fetchDailyReportReport(
      {FetchDailyReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: dailyReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <DailyReportListData>[];
        for (var item in response['data']['list']) {
          data.add(DailyReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchDailySaleReport
  static Future fetchDailySaleReport(
      {FetchDailySaleReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: dailySaleReportEndpoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final data = <DailySaleReportListData>[];
        for (var item in response['data']['list']) {
          data.add(DailySaleReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  ///////////////fetchAllMetalDailySaleReport
  static Future fetchAllMetalDailySaleReport(
      {FetchAllMetalDailySaleReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: allMetalDailySaleReportEndpoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final data = <AllMetalDailySaleReportListData>[];
        for (var item in response['data']['list']) {
          data.add(AllMetalDailySaleReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchPurchasewisemetalReport(
      {FetchPurchasewiseMetalRepaortListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchasMetalReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchasewiseMetalRepaortListData>[];
        for (var item in response['data']['list']) {
          data.add(PurchasewiseMetalRepaortListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchPurchasewisevendorReport(
      {FetchPurchasewiseVendorReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchasVendorReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchasewiseVendorReportListData>[];
        for (var item in response['data']['list']) {
          data.add(PurchasewiseVendorReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  //////////////////fetchSizeBasedReport
  static Future fetchPurchaseitemReport(
      {FetchPurchaseitemreportlistdataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchaseitemReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <Purchaseitemreportlistdata>[];
        for (var item in response['data']['list']) {
          data.add(Purchaseitemreportlistdata.fromJson(item));
        }

        return {"total_pages": response['total_pages'], "data": data};
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
  ////////////////////////////

  static Future fetchPurchasesubitemReport(
      {FetchPurchaseSubitemreportlistdataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: purchaseiSubtemReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PurchaseSubitemreportlistdata>[];
        for (var item in response['data']['list']) {
          data.add(PurchaseSubitemreportlistdata.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchCustomerCRDRReport(
      {FetchCustomerCRDRListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: customerCRDRReportEndpoint, body: payload!.toJson());
    
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <CustomerCRDRListData>[];
        for (var item in response['data']['list']) {
          data.add(CustomerCRDRListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchbillingCRDRReport(
      {FetchBillingCRDRListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: billingCRDRReportEndpoint, body: payload!.toJson());
    
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <BillingCRDRListData>[];
        for (var item in response['data']['list']) {
          data.add(BillingCRDRListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

///////////////fetchVendorCrdrReport
  static Future fetchVendorCrdrReport(
      {FetchVendorCRDRReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: vendorCrDrReportEndpoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorCRDRReportListData>[];
        for (var item in response['data']['list']) {
          data.add(VendorCRDRReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  ///////////////fetchCashPurchaseReport
  static Future fetchCashPurchaseReport(
      {FetchCashPurchaseReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: cashPurchaseReportEndpoint, body: payload!.toJson());

    if (response != null) {
      if (response['status'] == 200) {
        final data = <CashPurchaseReportListData>[];
        for (var item in response['data']['list']) {
          data.add(CashPurchaseReportListData.fromJson(item));
        }
        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchItemClosingReport(
      {FetchItemClosingReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: itemclosingReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <ItemClosingReportListData>[];
        for (var item in response['data']['list']) {
          data.add(ItemClosingReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchLiveStockReport(
      {FetchLiveStockReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: livestockReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <LiveStockReportListData>[];
        for (var item in response['data']['list']) {
          data.add(LiveStockReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchRepairReport(
      {FetchRepairReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: repairReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <RepairReportListData>[];
        for (var item in response['data']['list']) {
          data.add(RepairReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchOrderReport({FetchOrderReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderReportEndpoint, body: payload!.toJson());
    
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchOrderBillReport(
      {FetchOrderBillReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderbillReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderBillReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderBillReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchApprovalPendingReport(
      {FetchApprovalPendingReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: approvalpendingReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <ApprovalPendingReportListData>[];
        for (var item in response['data']['list']) {
          data.add(ApprovalPendingReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

  static Future fetchApprovalReceivedReport(
      {FetchApprovalReceivedReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: approvalReceivedReportEndpoint, body: payload!.toJson());
    
    if (response != null) {
      if (response['status'] == 200) {
        final data = <ApprovalReceivedReportListData>[];
        for (var item in response['data']['list']) {
          data.add(ApprovalReceivedReportListData.fromJson(item));
        }

        return {"list": data, "data": response['data']};
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
  ////////////////////////////

static Future fetchApprovalIssuedReport(
      {FetchApprovalIssueReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: approvalIssueReportEndpoint, body: payload!.toJson());
        
    if (response != null) {
      if (response['status'] == 200) {
        final data = <ApprovalIssueReportListData>[];
        for (var item in response['data']['list']) {
          data.add(ApprovalIssueReportListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////

  //////////////////fetchDirectIssueReport
  static Future fetchDirectIssueReport(
      {FetchDirectIssueReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: directIssueReportEndPoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <DirectIssueReportListData>[];
        for (var item in response['data']['list']) {
          data.add(DirectIssueReportListData.fromJson(item));
        }

        return {"total_pages": response['total_pages'], "data": data};
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
  ////////////////////////////

   ////////////////////////////
 
static Future fetchBillRepaymentReport(
      {FetchBillRepaymentReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: billRepaymentReportEndpoint, body: payload!.toJson());
       
    if (response != null) {
      if (response['status'] == 200) {
        final data = <BillRepaymentReportListData>[];
        for (var item in response['data']['list']) {
          data.add(BillRepaymentReportListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////
 
 ////////////////////////////
 
static Future fetchPaymentFlowReport(
      {PepaymentFlowReportListPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: PaymentFlowReportEndpoint, body: payload!.toJson());
       
    if (response != null) {
      if (response['status'] == 200) {
        final data = <PaymentFlowReportListData>[];
        for (var item in response['data']['list']) {
          data.add(PaymentFlowReportListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////
 
 
static Future fetchVendorInwardsReport(
      {FetchVendorInwardReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: vendorInwardReportEndpoint, body: payload!.toJson());
        
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorInwardReportListData>[];
        for (var item in response['data']['list']) {
          data.add(VendorInwardReportListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////
 
 
 
static Future fetchVendorOutwardsReport(
      {FetchVendorOutwardReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: vendorOutwardReportEndpoint, body: payload!.toJson());
        
    if (response != null) {
      if (response['status'] == 200) {
        final data = <VendorOutwardReportListData>[];
        for (var item in response['data']['list']) {
          data.add(VendorOutwardReportListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////
 

static Future fetchStockOutwardsReport(
      {FetchStockOutwardListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: stockOutwardReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <StockOutwardListData>[];
        for (var item in response['data']['list']) {
          data.add(StockOutwardListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////
 
 
 
 
static Future fetchOrderPendingReport(
      {FetchOrderPendingReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: orderpendingReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <OrderPendingReportListData>[];
        for (var item in response['data']['list']) {
          data.add(OrderPendingReportListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////

  ///////////////////////////
  static Future fetchManualEstimationBillingReport(
      {FetchManualEstimationBillingReportListDataPayload? payload}) async {
    var response = await ApiCalls.postWithToken(
        url: manualestimationReportEndpoint, body: payload!.toJson());
    if (response != null) {
      if (response['status'] == 200) {
        final data = <ManualEstimationBillingReportListData>[];
        for (var item in response['data']['list']) {
          data.add(ManualEstimationBillingReportListData.fromJson(item));
        }
 
        return {"list" : data, "data": response['data']};
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
  ////////////////////////////


}
