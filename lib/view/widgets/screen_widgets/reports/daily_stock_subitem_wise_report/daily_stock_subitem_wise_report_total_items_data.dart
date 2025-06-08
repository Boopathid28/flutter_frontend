import 'package:ausales_application/controller/reports/daily_stock_subitem_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockSubitemWiseReportTotalItemsData extends StatefulWidget {
  const DailyStockSubitemWiseReportTotalItemsData({super.key});

  @override
  State<DailyStockSubitemWiseReportTotalItemsData> createState() =>
      _DailyStockSubitemWiseReportTotalItemsDataState();
}

class _DailyStockSubitemWiseReportTotalItemsDataState
    extends State<DailyStockSubitemWiseReportTotalItemsData> {
  final DailyStockSubitemItemWiseReportController
      _dailyStockSubitemItemWiseReportController =
      Get.put(DailyStockSubitemItemWiseReportController());

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
              title: 'Total Out Pieces',
              value: _dailyStockSubitemItemWiseReportController.totalOutPieces.value
                  .toString()),
          items(
              title: 'Total In Pieces',
              value: _dailyStockSubitemItemWiseReportController.totalInPieces.value
                  .toString()),
          items(
              title: 'Total Out Weight',
              value: _dailyStockSubitemItemWiseReportController.totalOutWeight.value
                  .toString()),
          items(
              title: 'Total In Weight',
              value: _dailyStockSubitemItemWiseReportController.totalInWeight.value
                  .toString()),
          items(
              title: 'Total Open Pieces',
              value: _dailyStockSubitemItemWiseReportController.totalOpenPieces.value
                  .toString()),
          items(
              title: 'Total Close Pieces',
              value: _dailyStockSubitemItemWiseReportController.totalClosePieces.value
                  .toString()),
          items(
              title: 'Total Open Weight',
              value: _dailyStockSubitemItemWiseReportController.totalOpenWeight.value
                  .toString()),
          items(
              title: 'Total Close Weight',
              value: _dailyStockSubitemItemWiseReportController.totalCloseWeight.value
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
