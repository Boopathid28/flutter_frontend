import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_pending_report_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderPendingReportTotalViews extends StatefulWidget {
  const OrderPendingReportTotalViews({super.key});

  @override
  State<OrderPendingReportTotalViews> createState() =>
      _OrderPendingReportTotalViewsState();
}

class _OrderPendingReportTotalViewsState
    extends State<OrderPendingReportTotalViews> {
  final OrderPendingReportListController
      _orderPendingReportListController =
      Get.put(OrderPendingReportListController());
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
                      "${_orderPendingReportListController.totalPieces ?? ""}",
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
                      "${_orderPendingReportListController.totalGrossWeight ?? ""}",
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
