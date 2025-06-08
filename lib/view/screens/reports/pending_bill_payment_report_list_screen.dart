import 'package:ausales_application/controller/reports/pending_bill_payment_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/pending_bill_payment_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/pending_bill_payment_report/pending_bill_payment_report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PendingBillPaymentReportListScreen extends StatefulWidget {
  @override
  State<PendingBillPaymentReportListScreen> createState() =>
      _PendingBillPaymentReportListScreenState();
}

class _PendingBillPaymentReportListScreenState
    extends State<PendingBillPaymentReportListScreen> {
  final PendingBillPaymentReportController _pendingBillPaymentReportController =
      Get.put(PendingBillPaymentReportController());

  @override
  void initState() {
    super.initState();
    _pendingBillPaymentReportController
        .getPendingBillPaymentReportList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _pendingBillPaymentReportController.scaffoldKey,
      onRefresh: () {
        _pendingBillPaymentReportController
            .getPendingBillPaymentReportList(context);
      },
      child: Scaffold(
        key: _pendingBillPaymentReportController.scaffoldKey,
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
                child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Pending Bill Payment Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _pendingBillPaymentReportController
                                  .getPendingBillPaymentReportList(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _pendingBillPaymentReportController.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _pendingBillPaymentReportController.exportData(context);
                          }))
                      ],
                    ),
              ),
              PendingBillPaymentReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _pendingBillPaymentReportController
                            .isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage:
                                        _pendingBillPaymentReportController
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
                                        'Bill Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Bill Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
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
                                        'GST Amount',
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
                                        'Remaining Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created At',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _pendingBillPaymentReportController
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
                value: _pendingBillPaymentReportController.itemsPerPage.value,
                onChanged: (value) {
                  _pendingBillPaymentReportController.itemsPerPage(value);
                  _pendingBillPaymentReportController
                      .getPendingBillPaymentReportList(context);
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
              'Page ${_pendingBillPaymentReportController.page.value} of ${_pendingBillPaymentReportController.totalpages.value}',
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
                onPressed: _pendingBillPaymentReportController.page.value > 1
                    ? () {
                        if (_pendingBillPaymentReportController.page.value >
                            1) {
                          _pendingBillPaymentReportController.page(
                              _pendingBillPaymentReportController.page.value -
                                  1);
                          _pendingBillPaymentReportController
                              .getPendingBillPaymentReportList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _pendingBillPaymentReportController.page.value <
                        _pendingBillPaymentReportController.totalpages.value
                    ? () {
                        if (_pendingBillPaymentReportController.page.value <
                            _pendingBillPaymentReportController
                                .totalpages.value) {
                          _pendingBillPaymentReportController.page(
                              _pendingBillPaymentReportController.page.value +
                                  1);
                          _pendingBillPaymentReportController
                              .getPendingBillPaymentReportList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<PendingBillPaymentReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final PendingBillPaymentReportController _pendingBillPaymentReportController =
      Get.put(PendingBillPaymentReportController());

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
          row.billDate.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.customerName.toString(),
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
          row.remainingAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.createdAt!),
          style: TextPalette.tableDataTextStyle,
        ))
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
