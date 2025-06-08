import 'dart:developer';
import 'dart:io';

import 'package:ausales_application/core/api_endpoints/reports/export_report_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_models.dart';
import 'package:ausales_application/model/customer_ledger/customer_ledger_models.dart';
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
import 'package:ausales_application/model/reports/day_book_report_models.dart';
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
import 'package:ausales_application/model/reports/purity_wise_purchase_report_models.dart';
import 'package:ausales_application/model/reports/purity_wise_repair_report_model.dart';
import 'package:ausales_application/model/reports/purity_wise_sale_report_models.dart';
import 'package:ausales_application/model/reports/repair_report_models.dart';
import 'package:ausales_application/model/reports/stock_outward_report_models.dart';
import 'package:ausales_application/model/reports/subitem_wise_sale_report_models.dart';
import 'package:ausales_application/model/reports/suspense_pending_report_model.dart';
import 'package:ausales_application/model/reports/vendor_crdr_report_models.dart';
import 'package:ausales_application/model/reports/vendor_inward_report_models.dart';
import 'package:ausales_application/model/reports/vendor_item_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_metal_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_outwards_report_models.dart';
import 'package:ausales_application/model/reports/vendor_purity_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_subitem_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_wise_repair_report_model.dart';
import 'package:ausales_application/model/reports/vendor_wise_report_models.dart';
import 'package:ausales_application/model/reports/suspense_redeem_report_models.dart';
import 'package:ausales_application/model/reports/suspense_repayment_report_models.dart';
import 'package:ausales_application/model/reports/tds_deduction_report_models.dart';
import 'package:ausales_application/model/stock_list/stock_list_models.dart';
import 'package:ausales_application/service/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:toastification/toastification.dart';

import 'package:pdf/pdf.dart';

class ExportReportService {
  /////////////////exportDailyStockSubItemWiseReport
  static Future exportDailyStockSubItemWiseReport(
      DailyStockSubitemItemWiseReportPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportDailyStockSubItemWiseReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Stock Sub Item Wise.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportDailyStockItemWiseReport
  static Future exportDailyStockItemWiseReport(
      DailyStockItemWiseReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportDailyStockItemWiseReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Stock Item Wise.xlsx";
 
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
 
  /////////////////exportDailyStockItemWisePdfReport
  static Future exportDailyStockItemWisePdfReport(
      DailyStockItemWiseReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportDailyStockItemWiseReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Stock Item Wise.pdf";
 
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportDailyStockMetalWiseReport
  static Future exportDailyStockMetalWiseReport(
      DailyStockMetalWiseReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportDailyStockMetalWiseReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Stock Metal Wise.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportDailyStockDesignerWiseReport
  static Future exportDailyStockDesignerWiseReport(
      DailyStockDesignerWiseReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportDailyStockDesignerWiseReportEndPoint,
        body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Stock Vendor Wise.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportDailyStockPurityWiseReport
  static Future exportDailyStockPurityWiseReport(
      DailyStockPurityWiseReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportDailyStockPurityWiseReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Stock Purity Wise.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportVendorItemWiseSalesReport
  static Future exportVendorItemWiseSalesReport(
      VendorItemWiseSalesReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorItemWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Vendor Item Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportVendorSubItemWiseSalesReport
  static Future exportVendorSubItemWiseSalesReport(
      VendorSubitemWiseSalesReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorSubItemWiseSalesReportEndPoint,
        body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Vendor Sub Item Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportVendorMetalWiseSalesReport
  static Future exportVendorMetalWiseSalesReport(
      VendorMetalWiseSalesReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorMetalWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Vendor Metal Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportVendorPurityWiseSalesReport
  static Future exportVendorPurityWiseSalesReport(
      VendorPurityWiseSalesReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorPurityWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Vendor Purity Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportVendorWiseSalesReport
  static Future exportVendorWiseSalesReport(
      VendorWiseReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Vendor  Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportSubItemWiseSalesReport
  static Future exportSubItemWiseSalesReport(
      SubitemWiseSaleReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportSubItemWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Sub Item Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportItemWiseSalesReport
  static Future exportItemWiseSalesReport(
      ItemWiseSaleReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportItemWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Item Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportMetalWiseSalesReport
  static Future exportMetalWiseSalesReport(
      MetalWiseSaleReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportMetalWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Metal Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  /////////////////exportPurityWiseSalesReport
  static Future exportPurityWiseSalesReport(
      PurityWiseSaleReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurityWiseSalesReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purity Wise Sales.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportSuspenseRedeemReport
  static Future exportSuspenseRedeemReport(
      FetchSuspenseRedeemReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportSuspenseRedeemReportEndPoint, body: payload.toJson());

    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Suspense Redeem.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportSuspenseRepaymentReport
  static Future exportSuspenseRepaymentReport(
      FetchSuspenseRepaymentReportListPaylaod payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportSuspenseRepaymentReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Suspense Repayment.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportSuspensePendingReport
  static Future exportSuspensePendingReport(
      SuspensePendingReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportSuspensePendingReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Suspense Pending.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportTdsDeductionReport(
      FetchTdsDeductionReportListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportTdsDeductionReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/TDS Deduction.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportDailypaymentReport(
      DailyPaymentReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportdailypaymentReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Payment.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportOverallDailyReport(
      FetchOverallDailyReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportoveralldailyReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/OverAll Daily.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportEstimationMetalwiseReport(
      FetchEstimationMetalWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportestimationmetalReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Estimation Metal.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportEstimationPuritywiseReport(
      FetchEstimationPurityWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportestimationpurityReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Estimation Purity.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportEstimationItemwiseReport(
      FetchEstimationItemWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportestimationitemReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Estimation Item.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportEstimationSubItemwiseReport(
      FetchEstimationSubItemWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportestimationsubitemReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Estimation SubItem.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportEstimationVendorwiseReport(
      FetchEstimationVendorDesignerWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportestimationvendorReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Estimation Vendor.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportCustomerSummaryReport(
      FetchCustomerSummaryListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportCustomerSummaryReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Customer Summary.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportrepairmetalReport(
      FetchMetalWiseRepairListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportrepairmetalReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Repair Metal.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportrepairpurityReport(
      FetchPurityWiseRepairReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportrepairpurityReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Repair Purity.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportrepairitemReport(
      FetchItemWiseRepairReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportrepairitemReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Repair Item.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportrepairvendorReport(
      FetchVendorWiseRepairReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportrepairvendorReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Repair Vendor.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportBillinggstReport(
      BillingGstReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportbillinggstReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Billing Gst.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportCataglogverficationReport(
      FetchCatalogVerificationReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportcatalogverficationReportEndPoint, body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Catalog Verification.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportOrdermetalReport(
      FetchOrderMetalWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportordermetalReportEndPoint, body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Order Metal.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportOrderpurityReport(
      FetchOrderPurityWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportorderpurityReportEndPoint, body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Order Purity.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportOrderitemReport(
      FetchOrderItemWiseReportListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportorderitemReportEndPoint, body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Order Item.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportOrderSubitemReport(
      FetchOrderSubItemWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportordersubitemReportEndPoint, body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Order SubItem.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportOrdervendorReport(
      FetchOrderVendorWiseReportListPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportordervendorReportEndPoint, body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Order Vendor.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportPendingbillReport(
      PendingBillPaymentReportPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportpendingReportEndPoint, body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Pending Bill.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportPurchaseandBillingmetalReport(
      FetchPurchaseandbillingReportPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchaseandBillingmetalReportEndPoint,
        body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase And Billing Metal.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportPurchaseandBillingpurityReport(
      FetchPurchaseandbillingPurityReportPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchaseandBillingpurityReportEndPoint,
        body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase And Billing Purity.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportPurchaseandBillingitemReport(
      FetchPurchaseandbillingItemReportPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchaseandBillingitemReportEndPoint,
        body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase And Billing Item.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportPurchaseandBillingSubitemReport(
      FetchPurchaseandbillingSubItemReportPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchaseandBillingsubitemReportEndPoint,
        body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase And Billing SubItem.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportTdsDeductionReport
  static Future exportPurchaseandBillingvendorReport(
      FetchPurchaseandbillingVendorReportPayload payload,
      BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchaseandBillingvendorReportEndPoint,
        body: payload.toJson());
    
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase And Billing Vendor.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportDailyReport(
      FetchDailyReportListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportdailyReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportCustomerLedgerReport(
      FetchCustomerLedgerListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportCustomerLedgerReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Customer Ledger.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportCompanyLedgerReport(
      FetchCompanyLedgerListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportCompanyLedgerReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Company Ledger.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportDailySaleReport
  static Future exportDailySaleReport(
      FetchDailySaleReportListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportdailysaleReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['excel_path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Daily Sale.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

////////////////////exportDailySalePdfReport
  static Future exportDailySalePdfReport(
      FetchDailySaleReportListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportdailysaleReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['pdf_path']}");

      Directory? appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Daily Sale Pdf.pdf";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
      await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////

  ////////////////////exportAllMetalDailySaleReport
  static Future exportAllMetalDailySaleReport(
      FetchDailySaleReportListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportAllMetalDailySaleReportEndPoint, body: payload.toJson());
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");

        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/All Metal Daily Sale.pdf";

        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");

        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/All Metal Daily Sale.xlsx";

        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);

        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {

      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {

        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////

  ////////////////////exportTdsDeductionReport
  static Future exportStockListReport(
      FetchStockListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportStockListReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['excel_path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Stock List.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////


 ////////////////////exportTdsDeductionReport
  static Future exportPurchaseMetalwiseListReport(
      FetchPurchasewiseMetalRepaortListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchasemetalReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase metal report.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////


////////////////////exportTdsDeductionReport
  static Future exportPurchasePuritywiseListReport(
      FetchPurityWisePurchaseReportListPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchasepurityReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase purity report.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////



////////////////////exportTdsDeductionReport
  static Future exportPurchaseItemwiseListReport(
      FetchPurchaseitemreportlistdataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchaseitemReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase item report.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////


////////////////////exportTdsDeductionReport
  static Future exportPurchaseSubItemwiseListReport(
      FetchPurchaseSubitemreportlistdataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchasesubitemReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase sub report.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////



////////////////////exportTdsDeductionReport
  static Future exportPurchaseVendorwiseListReport(
      FetchPurchasewiseVendorReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportPurchasevendorReportEndPoint, body: payload.toJson());
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
          url: "${baseUrl}/${response['data']['path']}");

      Directory? appDocDir = await getDownloadsDirectory();
      String filePath = "${appDocDir?.path}/Purchase vendor report.xlsx";

      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);

      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////



////////////////////exportCashPurchaseReport
  static Future exportCustomercrdrListReport(
      FetchCustomerCRDRListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportcustomercrdrReportEndPoint, body: payload.toJson());
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Customer CRDR report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Customer Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////




////////////////////exportCashPurchaseReport
  static Future exportBillingcrdrListReport(
      FetchBillingCRDRListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportbillingcrdrReportEndPoint, body: payload.toJson());
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Billing CRDR report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Billing CRDR Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////



////////////////////exportVendorCrDrReport
  static Future exportVendorCrDrReport(
      FetchVendorCRDRReportListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorCrDrReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Vendor CR-DR.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Vendor CR-DR.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////
 
  ////////////////////exportCashPurchaseReport
  static Future exportCashPurchaseReport(
      FetchCashPurchaseReportListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportCashPurchaseReportEndpoint, body: payload.toJson());
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Cash Purchase Report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Cash Purchase Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////

 ////////////////////exportItemClosingListReport
  static Future exportItemClosingListReport(
    FetchItemClosingReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportItemClosingReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Item Closing.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportItemClosingListPdfReport
  static Future exportItemClosingListPdfReport(
    FetchItemClosingReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportItemClosingReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Item Closing.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
      await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
 
 
 
 ////////////////////exportLiveStockListReport
  static Future exportLiveStockListReport(
    FetchLiveStockReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportLiveStockReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Live Stock.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportLiveStockListPdfReport
  static Future exportLiveStockListPdfReport(
    FetchLiveStockReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportLiveStockReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Live Stock.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
      await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
 ////////////////////exportLiveStockListReport
  static Future exportRepairListReport(
    FetchRepairReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportRepairReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Repair Report.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportLiveStockListPdfReport
  static Future exportRepairListPdfReport(
    FetchRepairReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportRepairReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Repair Report.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
      await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////





////////////////////exportCashPurchaseReport
  static Future exportOrderReport(
      FetchOrderReportListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportOrderReportEndPoint, body: payload.toJson());
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Order Report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Order Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////

 ////////////////////exportOrderBillListReport
  static Future exportOrderBillListReport(
    FetchOrderBillReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportOrderBillReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Order Bill Report.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportOrderBillListPdfReport
  static Future exportOrderBillListPdfReport(
    FetchOrderBillReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportOrderBillReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Order Bill Report.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
 
 
 ////////////////////exportApprovalPendingListReport
  static Future exportApprovalPendingListReport(
    FetchApprovalPendingReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportApprovalPendingReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Approval Pending Report.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportApprovalPendingListPdfReport
  static Future exportApprovalPendingListPdfReport(
    FetchApprovalPendingReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportApprovalPendingReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Approval Pending Report.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
       await Printing.layoutPdf(
        format: PdfPageFormat.roll80,
          onLayout: (format) async => file.readAsBytes(),
        );
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
 
 
 
 
////////////////////exportApprovalReceivedListReport
  static Future exportApprovalReceivedListReport(
    FetchApprovalReceivedReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportApprovalReceivedReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Approval Received Report.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
       await Printing.layoutPdf(
        format: PdfPageFormat.roll80,
          onLayout: (format) async => file.readAsBytes(),
        );
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportApprovalReceivedListPdfReport
  static Future exportApprovalReceivedListPdfReport(
    FetchApprovalReceivedReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportApprovalReceivedReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Approval Received Report.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
      await Printing.layoutPdf(
        format: PdfPageFormat.roll80,
          onLayout: (format) async => file.readAsBytes(),
        );

 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////


////////////////////exportApprovalIssuedListReport
  static Future exportApprovalIssuedListReport(
    FetchApprovalIssueReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportApprovalIsuedReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Approval Issued Report.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportApprovalIssuedListPdfReport
  static Future exportApprovalIssuedListPdfReport(
    FetchApprovalIssueReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportApprovalIsuedReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Approval Issued Report.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
      await Printing.layoutPdf(
        format: PdfPageFormat.roll80,
          onLayout: (format) async => file.readAsBytes(),
        );
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
  
  ////////////////////exportdayReport
  static Future exportdayReport(
      FetchDayBookListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportdayBookReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Day Book.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else if (exportType == "pdfview") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Day Book.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        return file.path;
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Day Book.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////

  ////////////////////exportDirectIssueReport
  static Future exportDirectIssueReport(
      FetchDirectIssueReportListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportAllMetalDailySaleReportEndPoint, body: payload.toJson());
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");

        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/All Metal Daily Sale.pdf";

        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");

        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/All Metal Daily Sale.xlsx";

        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);

        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {

      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {

        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////
  ///
  ////////////////////exportbillrepaymentReport
  static Future exportbillrepaymentReport(
      FetchBillRepaymentReportListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportbillrepaymentReportEndPoint, body: payload.toJson());
       
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Bill Repayment Report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Bill Repayment Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////
 
 
 
////////////////////exportbillrepaymentReport
  static Future exportpaymentflowReport(
      PepaymentFlowReportListPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exportPaymentFlowReportEndPoint, body: payload.toJson());
       
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Payment Flow Report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Payment Flow Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////
 
////////////////////exportVendorInwardsListReport
  static Future exportVendorInwardsListReport(
    FetchVendorInwardReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorInwardsReportEndPoint, body: payload.toJson());
        
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Vendor Inwards Report.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportVendorInwardsListPdfReport
  static Future exportVendorInwardsListPdfReport(
    FetchVendorInwardReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorInwardsReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Vendor Inwards Report.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
  await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
         
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportVendorInwardsListReport
  static Future exportVendorOutwardsListReport(
    FetchVendorOutwardReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorOutwardsReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['excel_path']}");
 
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.path}/Vendor Outwards Report.xlsx";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
 
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
     
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////
 
 
////////////////////exportVendorInwardsListPdfReport
  static Future exportVendorOutwardsListPdfReport(
    FetchVendorOutwardReportListDataPayload payload, BuildContext context) async {
    var response = await ApiCalls.postWithToken(
        url: exportVendorOutwardsReportEndPoint, body: payload.toJson());
        
    if (response != null) {
      var dowloadResponse = await ApiCalls.downloadFile(
        url: "${baseUrl}/${response['data']['pdf_path']}");
 
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = "${appDocDir.path}/Vendor Outwards Report.pdf";
     
      // Write the file to the local filesystem
      File file = File(filePath);
      await file.writeAsBytes(dowloadResponse);
  await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text("File downloaded successfully"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
         
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text("Failed to download file"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
  ///////////////////


////////////////////exportStockOutwardsListReport
  static Future exportStockOutwardsListReport(
      FetchStockOutwardListDataPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exporStockOutwardsReportEndPoint, body: payload.toJson());
       
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Customer Oustanding Summary Report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Customer Oustanding Summary Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////
 
 
 
 
////////////////////exportorderpendingListReport
  static Future exportorderpendingListReport(
      FetchOrderPendingReportListDataPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exporOrderPendingReportEndPoint, body: payload.toJson());
       
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Order Pending Report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Order Pending Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////
  
  ////////////////////exportmanualestimationReport
  static Future exportmanualestimationReport(
      FetchManualEstimationBillingReportListDataPayload payload,
      BuildContext context,
      String exportType) async {
    var response = await ApiCalls.postWithToken(
        url: exporManualEstimationReportEndPoint, body: payload.toJson());
       
    if (response != null) {
      if (exportType == "pdf") {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['pdf_path']}");
 
        Directory? appDocDir = await getTemporaryDirectory();
        String filePath = "${appDocDir.path}/Manual Estimation Report.pdf";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
        await Printing.layoutPdf(
          onLayout: (format) async => file.readAsBytes(),
        );
      } else {
        var dowloadResponse = await ApiCalls.downloadFile(
            url: "${baseUrl}/${response['data']['excel_path']}");
 
        Directory? appDocDir = await getDownloadsDirectory();
        String filePath = "${appDocDir?.path}/Manual Estimation Report.xlsx";
 
        // Write the file to the local filesystem
        File file = File(filePath);
        await file.writeAsBytes(dowloadResponse);
 
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.success,
            title: Text("File downloaded successfully"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
 
      if (exportType == "pdf") {
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to print file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
 
        toastification.show(
            type: ToastificationType.error,
            title: Text("Failed to download file"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }
  ///////////////////
}
