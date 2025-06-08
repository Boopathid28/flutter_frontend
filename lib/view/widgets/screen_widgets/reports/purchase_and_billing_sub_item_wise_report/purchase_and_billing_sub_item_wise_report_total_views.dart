import 'package:ausales_application/controller/reports/order_sub_item_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_and_billing_sub_item_wise_report_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseAndBillingSubItemWiseReportTotalViews extends StatefulWidget {
  const PurchaseAndBillingSubItemWiseReportTotalViews({super.key});

  @override
  State<PurchaseAndBillingSubItemWiseReportTotalViews> createState() =>
      _PurchaseAndBillingSubItemWiseReportTotalViewsState();
}

class _PurchaseAndBillingSubItemWiseReportTotalViewsState
    extends State<PurchaseAndBillingSubItemWiseReportTotalViews> {
  final PurchaseAndBillingSubItemWiseReportListController
      _purchaseAndBillingSubItemWiseReportListController =
      Get.put(PurchaseAndBillingSubItemWiseReportListController());
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
                      "${_purchaseAndBillingSubItemWiseReportListController.totaloverallpurchasePieces ?? ""}",
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
                      "${_purchaseAndBillingSubItemWiseReportListController.totaloverallpurchaseGrossWeight ?? ""}",
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
                      "${_purchaseAndBillingSubItemWiseReportListController.totaloverallpurchaseamount ?? ""}",
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
                      "${_purchaseAndBillingSubItemWiseReportListController.totaloverallsalesPieces ?? ""}",
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
                      "${_purchaseAndBillingSubItemWiseReportListController.totaloverallsalesGrossWeight ?? ""}",
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
                      "${_purchaseAndBillingSubItemWiseReportListController.totaloverallsalesPieces ?? ""}",
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
