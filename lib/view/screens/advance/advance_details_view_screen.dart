import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvanceDetailsViewScreen extends StatefulWidget {
  AdvanceDetailsData advanceData;
  AdvanceDetailsViewScreen({super.key, required this.advanceData});

  @override
  State<AdvanceDetailsViewScreen> createState() =>
      _AdvanceDetailsViewScreenState();
}

class _AdvanceDetailsViewScreenState extends State<AdvanceDetailsViewScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Advance Details",
                            style: Responsive.isDesktop(context)
                                ? TextPalette.screenTitle
                                : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Center(
                  child: Wrap(
                    spacing: 20.w,
                    runSpacing: 15.h,
                    children: [
                      Text(
                        "Advance ID: ${widget.advanceData.advanceId}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Customer Name: ${widget.advanceData.customerDetailsName}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Advance Purpose: ${widget.advanceData.advancePurpose}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Advance Amount: ${widget.advanceData.totalAdvanceAmount}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Advance Weight: ${widget.advanceData.totalAdvanceWeight}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Advance Purity: ${widget.advanceData.purityName}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Remaining Amount: ${widget.advanceData.remainingAmount}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Redeem: ${widget.advanceData.isRedeemed! ? 'Yes' : 'No'}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Cancel: ${widget.advanceData.isCancelled! ? 'Yes' : 'No'}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log Details",
                      style: TextPalette.screenTitle,
                    ),
                    logParticulars(size),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ledger Details",
                      style: TextPalette.screenTitle,
                    ),
                    ledgerParticulars(size),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container logParticulars(Size size) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
            width: Responsive.isDesktop(context) ? size.width : null,
            child: DataTable(
              headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Bill NUmber',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Redeem Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Redeem Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Cancelled',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                
              ],
              rows: widget.advanceData.logDetails!.map((item) {
                return DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.billNumber.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.redeemAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.redeemWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.isCancelled! ? "yes" : "No"))),
                ]);
              }).toList(),
            )),
      ),
    );
  }

  Container ledgerParticulars(Size size) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
            width: Responsive.isDesktop(context) ? size.width : null,
            child: DataTable(
              headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Entry Date',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Entry Type',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Transaction Type',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Reference Number',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Transaction Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Transaction Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Cancelled',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: widget.advanceData.ledgerData!.map((item) {
                return DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100.w, child: Text(DateHelper.convertDate(item.entryDate.toString())))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                          item.entryType.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.transactionType.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.reffrenceNumber.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.transactionAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.transactionWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.isCancelled! ? "Yes" : "No"))),
                  
                ]);
              }).toList(),
            )),
      ),
    );
  }
}
