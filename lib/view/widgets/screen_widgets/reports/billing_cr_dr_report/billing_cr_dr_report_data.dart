import 'package:ausales_application/controller/reports/billing_cr_dr_report_list_controller.dart';
import 'package:ausales_application/controller/reports/estimation_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BillingCrDrReportData extends StatefulWidget {
  const BillingCrDrReportData({super.key});

  @override
  State<BillingCrDrReportData> createState() =>
      _BillingCrDrReportDataState();
}

class _BillingCrDrReportDataState
    extends State<BillingCrDrReportData> {
  final BillingCrDrReportListController
      _billingCrDrReportListController =
      Get.put(BillingCrDrReportListController());
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
                      "Total Cr: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_billingCrDrReportListController.TotalCr ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Dr: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_billingCrDrReportListController.TotalDr ?? ""}",
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
