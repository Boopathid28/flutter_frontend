import 'package:ausales_application/controller/reports/daily_stock_metal_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockMetalWiseReportTotalItemsData extends StatefulWidget {
  const DailyStockMetalWiseReportTotalItemsData({super.key});

  @override
  State<DailyStockMetalWiseReportTotalItemsData> createState() =>
      _DailyStockMetalWiseReportTotalItemsDataState();
}

class _DailyStockMetalWiseReportTotalItemsDataState
    extends State<DailyStockMetalWiseReportTotalItemsData> {
  final DailyStockMetalWiseReportController
      _dailyStockMetalWiseReportController =
      Get.put(DailyStockMetalWiseReportController());

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
          items(
              title: 'Total Out Pieces',
              value: _dailyStockMetalWiseReportController.totalOutPieces.value
                  .toString()),
          items(
              title: 'Total In Pieces',
              value: _dailyStockMetalWiseReportController.totalInPieces.value
                  .toString()),
          items(
              title: 'Total Out Weight',
              value: _dailyStockMetalWiseReportController.totalOutWeight.value
                  .toString()),
          items(
              title: 'Total In Weight',
              value: _dailyStockMetalWiseReportController.totalInWeight.value
                  .toString()),
          items(
              title: 'Total Open Pieces',
              value: _dailyStockMetalWiseReportController.totalOpenPieces.value
                  .toString()),
          items(
              title: 'Total Close Pieces',
              value: _dailyStockMetalWiseReportController.totalClosePieces.value
                  .toString()),
          items(
              title: 'Total Open Weight',
              value: _dailyStockMetalWiseReportController.totalOpenWeight.value
                  .toString()),
          items(
              title: 'Total Close Weight',
              value: _dailyStockMetalWiseReportController.totalCloseWeight.value
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
