import 'package:ausales_application/controller/reports/vendor_crdr_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorCrdrReportSummary extends StatefulWidget {
  const VendorCrdrReportSummary({super.key});

  @override
  State<VendorCrdrReportSummary> createState() =>
      _VendorCrdrReportSummaryState();
}

class _VendorCrdrReportSummaryState
    extends State<VendorCrdrReportSummary> {
  final VendorCrdrReportController
      _vendorCrdrReportController =
      Get.put(VendorCrdrReportController());

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
              title: 'Total Amount CR',
              value: _vendorCrdrReportController.overview.value.totalAmountCr
                  .toString())),
          Obx(() => items(
              title: 'Total Amount DR',
              value: _vendorCrdrReportController.overview.value.totalAmountDr
                  .toString())),
          Obx(() => items(
              title: 'Total Weight CR',
              value: _vendorCrdrReportController.overview.value.totalWeightCr
                  .toString())),
          Obx(() => items(
              title: 'Total Weight DR',
              value: _vendorCrdrReportController.overview.value.totalWeightDr
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
