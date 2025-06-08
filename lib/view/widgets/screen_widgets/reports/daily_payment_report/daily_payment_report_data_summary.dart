import 'package:ausales_application/controller/reports/daily_payment_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyPaymentReportDataSummary extends StatefulWidget {
  const DailyPaymentReportDataSummary({super.key});

  @override
  State<DailyPaymentReportDataSummary> createState() =>
      _DailyPaymentReportDataSummaryState();
}

class _DailyPaymentReportDataSummaryState
    extends State<DailyPaymentReportDataSummary> {
  final DailyPaymentReportController _dailyPaymentReportController =
      Get.put(DailyPaymentReportController());

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
              title: 'Open Cash',
              value: _dailyPaymentReportController.openCashAmount.value
                  .toString()),
          items(
              title: 'Open Card',
              value: _dailyPaymentReportController.openCardAmount.value
                  .toString()),
          items(
              title: 'Open Bank',
              value: _dailyPaymentReportController.openBankAmount.value
                  .toString()),
          items(
              title: 'Open UPI',
              value:
                  _dailyPaymentReportController.openUPIAmount.value.toString()),
          items(
              title: 'Total Open Amount',
              value: _dailyPaymentReportController.openTotalAmount.value
                  .toString()),
          items(
              title: 'Close Cash',
              value: _dailyPaymentReportController.closeCashAmount.value
                  .toString()),
          items(
              title: 'Close Card',
              value: _dailyPaymentReportController.closeCardAmount.value
                  .toString()),
          items(
              title: 'Close Bank',
              value: _dailyPaymentReportController.closeBankAmount.value
                  .toString()),
          items(
              title: 'Close UPI',
              value: _dailyPaymentReportController.closeUPIAmount.value
                  .toString()),
          items(
              title: 'Total Close Amount',
              value: _dailyPaymentReportController.closeTotalAmount.value
                  .toString()),
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
