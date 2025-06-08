import 'package:ausales_application/controller/reports/cash_purchase_report_list_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CashPurchaseReportSummary extends StatefulWidget {
  const CashPurchaseReportSummary({super.key});

  @override
  State<CashPurchaseReportSummary> createState() =>
      _CashPurchaseReportSummaryState();
}

class _CashPurchaseReportSummaryState
    extends State<CashPurchaseReportSummary> {
  final CashPurchaseReportListController
      _cashPurchaseReportListController =
      Get.put(CashPurchaseReportListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(color: ColorPalete.tableHeaderBgColor),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40.w,
        runSpacing: 16.w,
        children: [
          Obx(() => items(
              title: 'Total Gross Weight',
              value: _cashPurchaseReportListController.overview.value.totalGrossWeight
                  .toString())),
          Obx(() => items(
              title: 'Total Dust Weight',
              value: _cashPurchaseReportListController.overview.value.totalDustWeight
                  .toString())),
          Obx(() => items(
              title: 'Total Net Weight',
              value: _cashPurchaseReportListController.overview.value.totalNetWeight
                  .toString())),
          Obx(() => items(
              title: 'Total Amount',
              value: _cashPurchaseReportListController.overview.value.totalAmount
                  .toString())),
          
        ],
      ),
    );
  }

  Column items({required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: TextPalette.tableHeaderTextStyle,
        ),
        SizedBox(
          height: 8.w,
        ),
        Text(
          value,
          style: TextPalette.tableDataTextStyle,
        )
      ],
    );
  }
}
