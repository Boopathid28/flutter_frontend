import 'package:ausales_application/controller/reports/daily_stock_designer_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockDesignerWiseReportTotalItemsData extends StatefulWidget {
  const DailyStockDesignerWiseReportTotalItemsData({super.key});

  @override
  State<DailyStockDesignerWiseReportTotalItemsData> createState() =>
      _DailyStockDesignerWiseReportTotalItemsDataState();
}

class _DailyStockDesignerWiseReportTotalItemsDataState
    extends State<DailyStockDesignerWiseReportTotalItemsData> {
  final DailyStockDesignerWiseReportController
      _dailyStockDesignerWiseReportController =
      Get.put(DailyStockDesignerWiseReportController());

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
              value: _dailyStockDesignerWiseReportController.totalOutPieces.value
                  .toString()),
          items(
              title: 'Total In Pieces',
              value: _dailyStockDesignerWiseReportController.totalInPieces.value
                  .toString()),
          items(
              title: 'Total Out Weight',
              value: _dailyStockDesignerWiseReportController.totalOutWeight.value
                  .toString()),
          items(
              title: 'Total In Weight',
              value: _dailyStockDesignerWiseReportController.totalInWeight.value
                  .toString()),
          items(
              title: 'Total Open Pieces',
              value: _dailyStockDesignerWiseReportController.totalOpenPieces.value
                  .toString()),
          items(
              title: 'Total Close Pieces',
              value: _dailyStockDesignerWiseReportController.totalClosePieces.value
                  .toString()),
          items(
              title: 'Total Open Weight',
              value: _dailyStockDesignerWiseReportController.totalOpenWeight.value
                  .toString()),
          items(
              title: 'Total Close Weight',
              value: _dailyStockDesignerWiseReportController.totalCloseWeight.value
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
