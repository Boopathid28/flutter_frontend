import 'package:ausales_application/controller/reports/order_purity_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purity_wise_repair_report_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurityWiseRepairReportTotalViews extends StatefulWidget {
  const PurityWiseRepairReportTotalViews({super.key});

  @override
  State<PurityWiseRepairReportTotalViews> createState() =>
      _PurityWiseRepairReportTotalViewsState();
}

class _PurityWiseRepairReportTotalViewsState
    extends State<PurityWiseRepairReportTotalViews> {
  final PurityWiseRepairReportListController
      _purityWiseRepairReportListController =
      Get.put(PurityWiseRepairReportListController());
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
                      "${_purityWiseRepairReportListController.totalPieces ?? ""}",
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
                      "${_purityWiseRepairReportListController.totalGrossWeight ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Net Weight: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_purityWiseRepairReportListController.totalNetWeight ?? ""}",
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
