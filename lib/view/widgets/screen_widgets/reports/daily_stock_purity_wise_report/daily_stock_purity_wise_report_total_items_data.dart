import 'package:ausales_application/controller/reports/daily_stock_purity_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockPurityWiseReportTotalItemsData extends StatefulWidget {
  const DailyStockPurityWiseReportTotalItemsData({super.key});

  @override
  State<DailyStockPurityWiseReportTotalItemsData> createState() =>
      _DailyStockPurityWiseReportTotalItemsDataState();
}

class _DailyStockPurityWiseReportTotalItemsDataState
    extends State<DailyStockPurityWiseReportTotalItemsData> {

  final DailyStockPurityWiseReportController
      _dailyStockPurityWiseReportController =
      Get.put(DailyStockPurityWiseReportController());

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
              value: _dailyStockPurityWiseReportController.totalOutPieces.value
                  .toString()),
          items(
              title: 'Total In Pieces',
              value: _dailyStockPurityWiseReportController.totalInPieces.value
                  .toString()),
          items(
              title: 'Total Out Weight',
              value: _dailyStockPurityWiseReportController.totalOutWeight.value
                  .toString()),
          items(
              title: 'Total In Weight',
              value: _dailyStockPurityWiseReportController.totalInWeight.value
                  .toString()),
          items(
              title: 'Total Open Pieces',
              value: _dailyStockPurityWiseReportController.totalOpenPieces.value
                  .toString()),
          items(
              title: 'Total Close Pieces',
              value: _dailyStockPurityWiseReportController.totalClosePieces.value
                  .toString()),
          items(
              title: 'Total Open Weight',
              value: _dailyStockPurityWiseReportController.totalOpenWeight.value
                  .toString()),
          items(
              title: 'Total Close Weight',
              value: _dailyStockPurityWiseReportController.totalCloseWeight.value
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
