import 'package:ausales_application/controller/company_ledger/company_ledger_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyLedgerTotalViews extends StatefulWidget {
  const CompanyLedgerTotalViews({super.key});

  @override
  State<CompanyLedgerTotalViews> createState() =>
      _CompanyLedgerTotalViewsState();
}

class _CompanyLedgerTotalViewsState
    extends State<CompanyLedgerTotalViews> {
  final CompanyLedgerListController
      _companyLedgerListController =
      Get.put(CompanyLedgerListController());
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
                      "Total Expense Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_companyLedgerListController.totalExpenseAmount ?? ""}",
                      style: TextPalette.viewDetailsDataTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Income Amount: ",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${_companyLedgerListController.totalIncomeAmount ?? ""}",
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
