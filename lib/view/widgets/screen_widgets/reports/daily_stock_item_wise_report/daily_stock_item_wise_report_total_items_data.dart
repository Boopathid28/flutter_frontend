import 'package:ausales_application/controller/reports/daily_stock_item_wise_report_controller.dart';
import 'package:ausales_application/controller/reports/daily_stock_subitem_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockItemWiseReportTotalItemsData extends StatefulWidget {
  const DailyStockItemWiseReportTotalItemsData({super.key});

  @override
  State<DailyStockItemWiseReportTotalItemsData> createState() =>
      _DailyStockItemWiseReportTotalItemsDataState();
}

class _DailyStockItemWiseReportTotalItemsDataState
    extends State<DailyStockItemWiseReportTotalItemsData> {
  final DailyStockItemWiseReportController
      _dailyStockItemWiseReportController =
      Get.put(DailyStockItemWiseReportController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: ColorPalete.tableHeaderBgColor
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40.w,
        runSpacing: 16.w,
        children: [
          items(
              title: 'Total Sale Qty',
              value: _dailyStockItemWiseReportController.totalOutPieces.value
                  .toString()),
          items(
              title: 'Total Receipt Qty',
              value: _dailyStockItemWiseReportController.totalInPieces.value
                  .toString()),
          items(
              title: 'Total Sale Weight',
              value: _dailyStockItemWiseReportController.totalOutWeight.value
                  .toString()),
          items(
              title: 'Total Receipt Weight',
              value: _dailyStockItemWiseReportController.totalInWeight.value
                  .toString()),
          items(
              title: 'Total Open Qty',
              value: _dailyStockItemWiseReportController.totalOpenPieces.value
                  .toString()),
          items(
              title: 'Total Close Qty',
              value: _dailyStockItemWiseReportController.totalClosePieces.value
                  .toString()),
          items(
              title: 'Total Open Weight',
              value: _dailyStockItemWiseReportController.totalOpenWeight.value
                  .toString()),
          items(
              title: 'Total Close Weight',
              value: _dailyStockItemWiseReportController.totalCloseWeight.value
                  .toString()),
          items(
              title: 'Total Issue Weight',
              value: _dailyStockItemWiseReportController.totalIssueWeight.value
                  .toString()),
          items(
              title: 'Total Issue Qty',
              value: _dailyStockItemWiseReportController.totalIssuePieces.value
                  .toString()),
          items(
              title: 'Total Different Weight',
              value: _dailyStockItemWiseReportController.totalDifferentWeight.value
                  .toString())
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
