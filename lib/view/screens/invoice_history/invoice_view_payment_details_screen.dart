import 'dart:developer';

import 'package:ausales_application/controller/invoice_history/invoice_view_payment_details_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice_history/invoice_all_payment_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice_history/invoice_payment_printout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceViewPaymentDetailsScreen extends StatefulWidget {
  const InvoiceViewPaymentDetailsScreen({super.key});

  @override
  State<InvoiceViewPaymentDetailsScreen> createState() =>
      _InvoiceViewPaymentDetailsScreenState();
}

class _InvoiceViewPaymentDetailsScreenState
    extends State<InvoiceViewPaymentDetailsScreen> {
  final InvoiceViewPaymentDetailsController
      _invoiceViewPaymentDetailsController =
      Get.put(InvoiceViewPaymentDetailsController());

  @override
  void initState() {
    super.initState();
    _invoiceViewPaymentDetailsController.getBillingPaymentDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
        scaffoldKey: _invoiceViewPaymentDetailsController.scaffoldKey,
        onRefresh: () {},
        child: Scaffold(
          key: _invoiceViewPaymentDetailsController.scaffoldKey,
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
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                            "Billing Payment Details",
                            style: TextPalette.screenTitle,
                          ),
                        ],
                      ),
                      PrimaryButton(
                        btnWidth: 150.w,
                        isLoading: false,
                        text: "Full Payment Print",
                        onPressed: () async {
                          log(_invoiceViewPaymentDetailsController.totalPaid.value.toString());
                          await showDialog(context: context, barrierDismissible: false, builder: (_) => InvoiceAllPaymentPrintout(
                            totalPaid: _invoiceViewPaymentDetailsController.totalPaid.value,
                            paymentDate: _invoiceViewPaymentDetailsController.paymentDate.value,
                            customerName: _invoiceViewPaymentDetailsController.customerName.value,
                            customerMobile: _invoiceViewPaymentDetailsController.customerMobile.value,
                          ));
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.all(15.w),
                  margin: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: Obx(() => _invoiceViewPaymentDetailsController
                          .isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : _invoiceViewPaymentDetailsController.isNotFound.value
                          ? Text(
                              'No records found',
                              style: TextPalette.tableHeaderTextStyle,
                            )
                          : DataTable(
                              headingRowColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.tableHeaderBgColor),
                              columns: [
                                DataColumn(
                                    label: Text(
                                  'Action',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Payment Id',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Payment Date',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Total Amount ',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Denomination Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Exchange Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Chit Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Advance Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Suspense Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Paid Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                              ],
                              rows: _invoiceViewPaymentDetailsController
                                  .tableData.value
                                  .map((item) {
                                return DataRow(cells: [
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await (context: context, barrierDismissible: false, builder: (_) => InvoicePaymentPrintout(printData: item,));
                                          },
                                          icon: Icon(Icons.print))
                                    ],
                                  )),
                                  DataCell(Text(
                                    item.paymentId!,
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    DateHelper.convertDate(
                                        item.paymentDate ?? ""),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    item.totalAmount!.toStringAsFixed(2),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    item.denominationAmount!.toStringAsFixed(2),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    item.exchangeAmount!.toStringAsFixed(2),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    item.chitAmount!.toStringAsFixed(2),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    item.advanceAmount!.toStringAsFixed(2),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    item.suspenseAmount!.toStringAsFixed(2),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                  DataCell(Text(
                                    item.paidAmount!.toStringAsFixed(2),
                                    style: TextPalette.tableDataTextStyle,
                                  )),
                                ]);
                              }).toList())),
                )
              ],
            ),
          ),
        ));
  }
}
