import 'package:ausales_application/controller/company_ledger/company_ledger_list_controller.dart';
import 'package:ausales_application/controller/metal_ledger/metal_ledger_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalLedgerTotalView extends StatefulWidget {
  const MetalLedgerTotalView({super.key});

  @override
  State<MetalLedgerTotalView> createState() =>
      _MetalLedgerTotalViewState();
}

class _MetalLedgerTotalViewState
    extends State<MetalLedgerTotalView> {
  final MetalLedgerListController
      _metalledgerlistcontroller =
      Get.put(MetalLedgerListController());
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
                      "Total Ic Weight: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_metalledgerlistcontroller.totalicweight.toStringAsFixed(2) ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Out Weight: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_metalledgerlistcontroller.totaloutWeight.toStringAsFixed(2) ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                 Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Remaining Weight: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_metalledgerlistcontroller.totalremainingWeight.toStringAsFixed(2) ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
