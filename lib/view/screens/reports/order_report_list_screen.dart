import 'package:ausales_application/controller/reports/billing_cr_dr_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_report_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/billing_cr_dr_models.dart';
import 'package:ausales_application/model/reports/order_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/billing_cr_dr_report/billing_cr_dr_report_data.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/billing_cr_dr_report/billing_cr_dr_report_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_report/order_report_data.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_report/order_report_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderReportListScreen extends StatefulWidget {
  @override
  State<OrderReportListScreen> createState() => _OrderReportListScreenState();
}

class _OrderReportListScreenState extends State<OrderReportListScreen> {
  final OrderReportListController _orderReportListController =
      Get.put(OrderReportListController());

  @override
  void initState() {
    super.initState();
    _orderReportListController.getOrderReport();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _orderReportListController.scaffoldKey,
      onRefresh: () {
        _orderReportListController.getOrderReport();
      },
      child: Scaffold(
        key: _orderReportListController.scaffoldKey,
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Order Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _orderReportListController
                                  .getOrderReport();
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _orderReportListController.isExportLoading.value,
                              text: 'Export',
                              onPressed: () {
                                _orderReportListController.exportData(context);
                              })),
                              SizedBox(width: 10,),
                              Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _orderReportListController.isExportPdfLoading.value,
                              text: 'Print Pdf', 
                              onPressed: () {
                                _orderReportListController.exportDataPdf(context);
                              })),
                          ],
                        )
                      ],
                    ),
              ),
              OrderReportData(),
              OrderReportTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _orderReportListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _orderReportListController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'SI No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Order Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Total Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Advance Cash',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Advance bank',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Advance Card',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Advance Upi',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Total Advance',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Old Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Old Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       
                                    ],
                                    source: _DataSource(context,
                                        _orderReportListController.tableData.value),
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
                value: _orderReportListController.itemsPerPage.value,
                onChanged: (value) {
                  _orderReportListController.itemsPerPage(value);
                  _orderReportListController.getOrderReport();
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
              'Page ${_orderReportListController.page.value} of ${_orderReportListController.totalpages.value}',
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
                onPressed: _orderReportListController.page.value > 1
                    ? () {
                        if (_orderReportListController.page.value > 1) {
                          _orderReportListController
                              .page(_orderReportListController.page.value - 1);
                          _orderReportListController.getOrderReport();
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _orderReportListController.page.value <
                        _orderReportListController.totalpages.value
                    ? () {
                        if (_orderReportListController.page.value <
                            _orderReportListController.totalpages.value) {
                          _orderReportListController
                              .page(_orderReportListController.page.value + 1);
                          _orderReportListController.getOrderReport();
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<OrderReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final OrderReportListController _orderReportListController =
      Get.put(OrderReportListController());

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
          row.orderId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.customerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.weight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.advanceCash.toString(),
          style: TextPalette.tableDataTextStyle,
        )),

        DataCell(Text(
          row.advanceBank.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.advanceCard.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.advanceUpi.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.totalAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.oldAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.oldWeight.toString(),
          style: TextPalette.tableDataTextStyle,
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
