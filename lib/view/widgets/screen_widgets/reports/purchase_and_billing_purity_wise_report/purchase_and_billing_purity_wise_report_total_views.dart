import 'package:ausales_application/controller/reports/order_purity_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_and_billing_purity_wise_report_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseAndBillingPurityWiseReportTotalViews extends StatefulWidget {
  const PurchaseAndBillingPurityWiseReportTotalViews({super.key});

  @override
  State<PurchaseAndBillingPurityWiseReportTotalViews> createState() =>
      _PurchaseAndBillingPurityWiseReportTotalViewsState();
}

class _PurchaseAndBillingPurityWiseReportTotalViewsState
    extends State<PurchaseAndBillingPurityWiseReportTotalViews> {
  final PurchaseAndBillingPurityWiseReportListController
      _purchaseAndBillingPurityWiseReportListController =
      Get.put(PurchaseAndBillingPurityWiseReportListController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Container(
        width: double.infinity,
        child: Obx(() => Wrap(
              runSpacing: 20.h,
              spacing: 20.w,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Pieces: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_purchaseAndBillingPurityWiseReportListController.totaloverallpurchasePieces ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Gross Weight: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_purchaseAndBillingPurityWiseReportListController.totaloverallpurchaseGrossWeight ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_purchaseAndBillingPurityWiseReportListController.totaloverallpurchaseamount ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                 Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Sales Pieces: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_purchaseAndBillingPurityWiseReportListController.totaloverallsalesPieces ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Sales Gross Weight: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_purchaseAndBillingPurityWiseReportListController.totaloverallsalesGrossWeight ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Sales Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_purchaseAndBillingPurityWiseReportListController.totaloverallsalesamount ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
