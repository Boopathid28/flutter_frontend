import 'package:ausales_application/controller/reports/daily_stock_subitem_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/daily_stock_subitem_wise_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/daily_stock_subitem_wise_report/daily_stock_subitem_wise_report_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/daily_stock_subitem_wise_report/daily_stock_subitem_wise_report_total_items_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockSubitemWiseReportScreen extends StatefulWidget {
  const DailyStockSubitemWiseReportScreen({super.key});

  @override
  State<DailyStockSubitemWiseReportScreen> createState() =>
      _DailyStockSubitemWiseReportScreenState();
}

class _DailyStockSubitemWiseReportScreenState
    extends State<DailyStockSubitemWiseReportScreen> {
  final DailyStockSubitemItemWiseReportController
      _dailyStockSubitemItemWiseReportController =
      Get.put(DailyStockSubitemItemWiseReportController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: HeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Daily Stock Subitem Wise Report",
                            style: Responsive.isMobile(context)
                                ? TextPalette.tableDataTextStyle
                                : TextPalette.screenTitle,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                              onPressed: () {
                                _dailyStockSubitemItemWiseReportController
                                    .getDailyStockSubitemItemWiseReport();
                              },
                              icon: const Icon(Icons.refresh)),
                        ],
                      ),
                      Obx(() => PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _dailyStockSubitemItemWiseReportController
                              .isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _dailyStockSubitemItemWiseReportController
                                .exportData(context);
                          }))
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const DailyStockSubitemWiseReportTableHeader(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Obx(
                    () => _dailyStockSubitemItemWiseReportController
                            .isTableLoading.value
                        ? const SizedBox()
                        : const DailyStockSubitemWiseReportTotalItemsData(),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
            Container(
              height: 550.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Obx(() => _dailyStockSubitemItemWiseReportController
                          .isTableLoading.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: const LinearProgressIndicator(),
                        )
                      : ListView(
                          children: [
                            Obx(() => PaginatedDataTable(
                                  showEmptyRows: false,
                                  rowsPerPage:
                                      _dailyStockSubitemItemWiseReportController
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
                                      'Subitem name',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Subitem code',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Open pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Open weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Issued weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Issued Pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Received weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Received Pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Out pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Out weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Close pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Close weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                  ],
                                  source: _DataSource(
                                      context,
                                      _dailyStockSubitemItemWiseReportController
                                          .tableData.value),
                                  dataRowHeight: 56,
                                  columnSpacing: 16,
                                  horizontalMargin: 12,
                                  headingRowHeight: 56,
                                )),
                          ],
                        )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: Responsive.isMobile(context) ? 118.h : 60.h,
                      width: size.width - 38,
                      padding: const EdgeInsets.all(16.0),
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
          ],
        )),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  SizedBox itemsPerPageChange(BuildContext context) {
    return SizedBox(
      child: Responsive.isMobile(context)
          ? Column(
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
                      value: _dailyStockSubitemItemWiseReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _dailyStockSubitemItemWiseReportController
                            .itemsPerPage(value);
                        _dailyStockSubitemItemWiseReportController
                            .getDailyStockSubitemItemWiseReport();
                      },
                      items: [1, 5, 10, 20, 50]
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              ))
                          .toList(),
                    )),
              ],
            )
          : Row(
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
                      value: _dailyStockSubitemItemWiseReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _dailyStockSubitemItemWiseReportController
                            .itemsPerPage(value);
                        _dailyStockSubitemItemWiseReportController
                            .getDailyStockSubitemItemWiseReport();
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
    return Obx(() => Responsive.isMobile(context)
        ? Column(
            children: [
              Text(
                'Page ${_dailyStockSubitemItemWiseReportController.page.value} of ${_dailyStockSubitemItemWiseReportController.totalpages.value}',
                style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 12.sp
                        : 10.sp),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _dailyStockSubitemItemWiseReportController
                                  .page.value >
                              1
                          ? () {
                              if (_dailyStockSubitemItemWiseReportController
                                      .page.value >
                                  1) {
                                _dailyStockSubitemItemWiseReportController.page(
                                    _dailyStockSubitemItemWiseReportController
                                            .page.value -
                                        1);
                                _dailyStockSubitemItemWiseReportController
                                    .getDailyStockSubitemItemWiseReport();
                              }
                            }
                          : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _dailyStockSubitemItemWiseReportController
                                  .page.value <
                              _dailyStockSubitemItemWiseReportController
                                  .totalpages.value
                          ? () {
                              if (_dailyStockSubitemItemWiseReportController
                                      .page.value <
                                  _dailyStockSubitemItemWiseReportController
                                      .totalpages.value) {
                                _dailyStockSubitemItemWiseReportController.page(
                                    _dailyStockSubitemItemWiseReportController
                                            .page.value +
                                        1);
                                _dailyStockSubitemItemWiseReportController
                                    .getDailyStockSubitemItemWiseReport();
                              }
                            }
                          : null),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Page ${_dailyStockSubitemItemWiseReportController.page.value} of ${_dailyStockSubitemItemWiseReportController.totalpages.value}',
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
                  onPressed:
                      _dailyStockSubitemItemWiseReportController.page.value > 1
                          ? () {
                              if (_dailyStockSubitemItemWiseReportController
                                      .page.value >
                                  1) {
                                _dailyStockSubitemItemWiseReportController.page(
                                    _dailyStockSubitemItemWiseReportController
                                            .page.value -
                                        1);
                                _dailyStockSubitemItemWiseReportController
                                    .getDailyStockSubitemItemWiseReport();
                              }
                            }
                          : null),
              IconButton(
                  icon: Icon(Icons.arrow_forward,
                      size: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 20.sp
                          : 15.sp),
                  onPressed:
                      _dailyStockSubitemItemWiseReportController.page.value <
                              _dailyStockSubitemItemWiseReportController
                                  .totalpages.value
                          ? () {
                              if (_dailyStockSubitemItemWiseReportController
                                      .page.value <
                                  _dailyStockSubitemItemWiseReportController
                                      .totalpages.value) {
                                _dailyStockSubitemItemWiseReportController.page(
                                    _dailyStockSubitemItemWiseReportController
                                            .page.value +
                                        1);
                                _dailyStockSubitemItemWiseReportController
                                    .getDailyStockSubitemItemWiseReport();
                              }
                            }
                          : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<DailyStockSubitemItemWiseReportList> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final DailyStockSubitemItemWiseReportController
      _dailyStockSubitemItemWiseReportController =
      Get.put(DailyStockSubitemItemWiseReportController());

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
        DataCell(Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.grey), // Customize the border color
          ),
          child: Text(
            row.subItemName.toString(),
            style: TextPalette.tableDataTextStyle,
          ),
        )),
        DataCell(Text(
          row.subItemCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.openPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.openWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.issuedWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.issuedPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.receivedWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.receivedPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.outPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.outWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.closePieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.closeWeight.toString(),
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
