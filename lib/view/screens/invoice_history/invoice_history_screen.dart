import 'dart:developer';

import 'package:ausales_application/controller/invoice_history/invoice_history_list_controller.dart';
import 'package:ausales_application/controller/invoice_history/invoice_make_payment_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/invoice/invoice_history_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/screens/invoice_history/invoice_view_payment_details_screen.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/billing_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice_history/invoice_history_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice_history/invoice_make_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceHistoryScreen extends StatefulWidget {
  @override
  State<InvoiceHistoryScreen> createState() => _InvoiceHistoryScreenState();
}

class _InvoiceHistoryScreenState extends State<InvoiceHistoryScreen> {
  final InvoiceHistoryListController _invoiceHistoryListController =
      Get.put(InvoiceHistoryListController());

  @override
  void initState() {
    super.initState();
    _invoiceHistoryListController.getInvoiceList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _invoiceHistoryListController.scaffoldKey,
      onRefresh: () {
        _invoiceHistoryListController.getInvoiceList(context);
      },
      child: Scaffold(
        key: _invoiceHistoryListController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      "Billing History",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _invoiceHistoryListController.getInvoiceList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              InvoiceHistoryTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _invoiceHistoryListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _invoiceHistoryListController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'S.No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Bill No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Bill Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Customer',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Total Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Gst Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Payable Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Paid Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Balance Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _invoiceHistoryListController
                                            .tableData.value),
                                  )),
                            ],
                          )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 60.h,
                        width: size.width - 38,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15.r)),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemsPerPageChange(context),
                            SizedBox(
                              width: 5.w,
                            ),
                            changePage(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: defaultBottombarHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox itemsPerPageChange(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(
            'Rows per page:',
            style: TextStyle(
                fontSize: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? 12.sp
                    : 10.sp),
          ),
          SizedBox(
            width: 15.w,
          ),
          Obx(() => DropdownButton<int>(
                value: _invoiceHistoryListController.itemsPerPage.value,
                onChanged: (value) {
                  _invoiceHistoryListController.itemsPerPage(value);
                  _invoiceHistoryListController.getInvoiceList(context);
                },
                items: [1, 5, 10, 20, 50]
                    .map((value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }

  Obx changePage(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Page ${_invoiceHistoryListController.page.value} of ${_invoiceHistoryListController.totalpages.value}',
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? 12.sp
                      : 10.sp),
            ),
            IconButton(
                icon: Icon(Icons.arrow_back,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _invoiceHistoryListController.page.value > 1
                    ? () {
                        if (_invoiceHistoryListController.page.value > 1) {
                          _invoiceHistoryListController.page(
                              _invoiceHistoryListController.page.value - 1);
                          _invoiceHistoryListController.getInvoiceList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _invoiceHistoryListController.page.value <
                        _invoiceHistoryListController.totalpages.value
                    ? () {
                        if (_invoiceHistoryListController.page.value <
                            _invoiceHistoryListController.totalpages.value) {
                          _invoiceHistoryListController.page(
                              _invoiceHistoryListController.page.value + 1);
                          _invoiceHistoryListController.getInvoiceList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<BillingHistoryListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final InvoiceHistoryListController _invoiceHistoryListController =
      Get.put(InvoiceHistoryListController());

  final InvoiceMakePaymentController _invoiceMakePaymentController =
      Get.put(InvoiceMakePaymentController());

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow.byIndex(
      color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) =>
              index % 2 == 0 ? Colors.white : ColorPalete.tableHeaderBgColor),
      index: index,
      cells: [
        DataCell(Text(
          row.sNo.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.billId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.billDate.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.customerDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.gstAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.payableAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.paidAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.balanceAmount!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Obx(() => _invoiceHistoryListController
                        .isPaymentLoadingIndex.value ==
                    index.toString()
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    onPressed: () async {
                      _invoiceHistoryListController
                          .isPaymentLoadingIndex(index.toString());
                      final RetrieveBillingDetails? billDetails =
                          await _invoiceHistoryListController.getBillDetails(
                              context, row.id.toString());

                      if (billDetails != null) {
                        List<RetrieveParticularDetails> itemsList =
                            <RetrieveParticularDetails>[];

                        for (var i in billDetails.particularDetails!) {
                          if (i.calculationType == weightCalcType) {
                            var jsonData = i.toJson();

                            double wastageWeight =
                                i.wastageCalculationType == grossWeightType
                                    ? i.grossWeight ?? 0.0
                                    : i.netWeight ?? 0.0;
                            double wastageGram = wastageWeight *
                                ((i.wastagePercent ?? 0.0) / 100);
                            double wastageAmount =
                                wastageGram * (i.rate ?? 0.0);
                            jsonData['wastage_amount'] = wastageAmount;
                            itemsList.add(
                                RetrieveParticularDetails.fromJson(jsonData));
                          }
                        }

                        itemsList.sort((a, b) =>
                            b.wastagePercent!.compareTo(a.wastagePercent!));

                        await Get.dialog(
                            barrierDismissible: false,
                            InvoiceMakePayment(
                                  branch: billDetails.branch.toString(),
                                  customer:
                                      billDetails.customerDetails.toString(),
                                  gstType: billDetails.gstType!,
                                  totalAmount: billDetails.totalAmount!,
                                  gstAmount: billDetails.gstAmount!,
                                  payableAmount: billDetails.payableAmount!,
                                  paidAmount: billDetails.paidAmount!,
                                  balanceAmount: billDetails.balanceAmount!,
                                  billId: billDetails.id.toString(),
                                  customerMobile: billDetails.customerMobile!,
                                  tagItems: itemsList,
                                ));
                        _invoiceHistoryListController.isPaymentLoadingIndex("");
                      }
                    },
                    icon: Icon(Icons.payment))),
            SizedBox(
              width: 10.w,
            ),
            Obx(() => _invoiceHistoryListController.isPrintLoadingIndex.value ==
                    index.toString()
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    onPressed: () async {
                      _invoiceHistoryListController
                          .isPrintLoadingIndex(index.toString());
                      final CompanyDetailsData? data =
                          await CompanyService.retrieveCompany(
                              context: context);

                      if (data != null) {
                        final RetrieveBillingDetails? billDetails =
                            await _invoiceHistoryListController.getBillDetails(
                                context, row.id.toString());

                        if (billDetails != null) {
                          List<RetrieveParticularDetails> itemsList =
                              <RetrieveParticularDetails>[
                            ...billDetails.particularDetails!
                          ];
                           String? Paymentmode = "";
                          int totalPieces = 0;
                          double totalNetWeight = 0.0;
                          double totalGrossWeight = 0.0;
                          for (var i in billDetails.particularDetails!) {
                            totalPieces += i.pieces ?? 0;
                            totalGrossWeight += i.grossWeight ?? 0.0;
                            totalNetWeight += i.netWeight ?? 0.0;
                          }
                          itemsList.add(RetrieveParticularDetails(
                              pieces: totalPieces,
                              grossWeight: totalGrossWeight,
                              netWeight: totalNetWeight,
                              gstAmount: billDetails.gstAmount,
                              payableAmount: billDetails.payableAmount,
                              totalAmount: billDetails.totalAmount));

                              for(var i in billDetails.paymentDetails!){
                        for(var j in i.denominationDetails!){
                          Paymentmode = j.paymentMethod;
                        }
                      }
                          await Get.dialog(
                              barrierDismissible: false,
                              BillingPrintout(
                                  companyDetailsData: data,
                                  billingDetails: billDetails,
                                  items: itemsList,
                                  paymentMode: Paymentmode,));
                          _invoiceHistoryListController.isPrintLoadingIndex("");
                        }
                      }
                    },
                    icon: Icon(Icons.print))),
            GestureDetector(
                onTap: () async {
                  _invoiceHistoryListController.getbillDetails(context, row);
                },
                child: Icon(Icons.visibility)),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
                onTap: () async {
                  Get.to(() => InvoiceViewPaymentDetailsScreen(), arguments: row.id);
                },
                child: Icon(Icons.history)),
          ],
        )),
      ],
    );
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
