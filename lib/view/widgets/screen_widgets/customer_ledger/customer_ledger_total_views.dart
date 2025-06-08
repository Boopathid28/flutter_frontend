import 'package:ausales_application/controller/customer_ledger/customer_ledger_list_controller.dart';
import 'package:ausales_application/controller/stock_ledger/stock_ledger_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerLedgerTotalViews extends StatefulWidget {
  const CustomerLedgerTotalViews({super.key});

  @override
  State<CustomerLedgerTotalViews> createState() => _CustomerLedgerTotalViewsState();
}

class _CustomerLedgerTotalViewsState extends State<CustomerLedgerTotalViews> {
  final CustomerLedgerListController _customerLedgerListController =
      Get.put(CustomerLedgerListController());
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
                              "Credit Amount: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_customerLedgerListController.creditamount.toStringAsFixed(2) ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Credit Weight: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_customerLedgerListController.creditweight.toStringAsFixed(2) ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Debit Amount: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_customerLedgerListController.debitamount.toStringAsFixed(2) ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Debit Weight: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_customerLedgerListController.debitweight.toStringAsFixed(2) ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                         Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Remaining Amount: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_customerLedgerListController.remainingamount.toStringAsFixed(2) ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Remaining Weight: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_customerLedgerListController.remainingweight.toStringAsFixed(2) ?? ""}",
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
