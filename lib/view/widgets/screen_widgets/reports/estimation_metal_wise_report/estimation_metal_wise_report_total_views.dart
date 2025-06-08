import 'package:ausales_application/controller/reports/estimation_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationMetalWiseReportTotalViews extends StatefulWidget {
  const EstimationMetalWiseReportTotalViews({super.key});

  @override
  State<EstimationMetalWiseReportTotalViews> createState() =>
      _EstimationMetalWiseReportTotalViewsState();
}

class _EstimationMetalWiseReportTotalViewsState
    extends State<EstimationMetalWiseReportTotalViews> {
  final EstimationMetalWiseReportListController
      _estimationMetalWiseReportListController =
      Get.put(EstimationMetalWiseReportListController());
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
                      "${_estimationMetalWiseReportListController.totalPieces ?? ""}",
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
                      "${_estimationMetalWiseReportListController.totalGrossWeight ?? ""}",
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
                      "${_estimationMetalWiseReportListController.totalNetWeight ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_estimationMetalWiseReportListController.totalAmount ?? ""}",
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
