import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseViewDetailsScreen extends StatefulWidget {
  SuspenseDetailsData suspenseData;
  SuspenseViewDetailsScreen({super.key, required this.suspenseData});

  @override
  State<SuspenseViewDetailsScreen> createState() =>
      _SuspenseViewDetailsScreenState();
}

class _SuspenseViewDetailsScreenState extends State<SuspenseViewDetailsScreen> {
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
                            "Suspense Details",
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
                        "Suspense ID: ${widget.suspenseData.suspenseId}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Customer Name: ${widget.suspenseData.customerDetailsName}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Suspense Amount: ${widget.suspenseData.suspenseAmount}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Suspense Weight: ${widget.suspenseData.suspenseWeight}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Total Paid Amount: ${widget.suspenseData.totalPaidAmount}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Remaining Amount: ${widget.suspenseData.remainingAmount}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Redeem: ${widget.suspenseData.isRedeemed! ? 'Yes' : 'No'}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Closed: ${widget.suspenseData.isClosed! ? 'Yes' : 'No'}",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      Text(
                        "Cancel: ${widget.suspenseData.isCancelled! ? 'Yes' : 'No'}",
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
                      "Item Details",
                      style: TextPalette.screenTitle,
                    ),
                    itemparticulars(size),
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
                      "Payment Details",
                      style: TextPalette.screenTitle,
                    ),
                    paymentParticulars(size),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container itemparticulars(Size size) {
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
                      'Metal Name',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Item',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'SubItem',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Metal Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 100.w,
                    child: Text(
                      'Metal Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Total Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: widget.suspenseData.itemDetails!.map((item) {
                return DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.metalDetailsName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.itemDetailsName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.subItemDetailsName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.metalAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.metalWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.totalAmount.toString()))),
                ]);
              }).toList(),
            )),
      ),
    );
  }

  Container paymentParticulars(Size size) {
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
                      'Payment Id',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Payment Date',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Paid Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Action',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: widget.suspenseData.paymentDetails!.map((item) {
                return DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.paymentId.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(DateHelper.convertDate(
                          item.paymentDate.toString())))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.paidAmount.toString()))),
                  DataCell(IconButton(
                    onPressed: () async {
                      await Get.dialog(
                          AlertDialog.adaptive(
                                title: Text('Denominations'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DataTable(
                                        headingRowColor: WidgetStateProperty
                                            .resolveWith<Color?>(
                                                (Set<WidgetState> states) =>
                                                    ColorPalete
                                                        .tableHeaderBgColor),
                                        columns: [
                                          DataColumn(
                                            label: SizedBox(
                                              width: 125.w,
                                              child: Text(
                                                'Payment Method',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 125.w,
                                              child: Text(
                                                'Payment Provider',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 125.w,
                                              child: Text(
                                                'Paid Amount',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          )
                                        ],
                                        rows: item.denominationDetails!
                                            .map((subItem) {
                                          return DataRow(cells: [
                                            DataCell(SizedBox(
                                                width: 100.w,
                                                child: Text(subItem
                                                    .paymentMethod
                                                    .toString()))),
                                            DataCell(SizedBox(
                                                width: 100.w,
                                                child: Text(
                                                    subItem.paymentProvider ??
                                                        "-"))),
                                            DataCell(SizedBox(
                                                width: 100.w,
                                                child: Text(subItem.paidAmount
                                                    .toString()))),
                                          ]);
                                        }).toList())
                                  ],
                                ),
                              ));
                    },
                    icon: Icon(Icons.visibility),
                  )),
                ]);
              }).toList(),
            )),
      ),
    );
  }
}
