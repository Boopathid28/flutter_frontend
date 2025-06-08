import 'package:ausales_application/controller/reports/daily_stock_designer_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/daily_stock_designer_wise_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/daily_stock_designer_wise_report/daily_stock_designer_wise_report_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/daily_stock_designer_wise_report/daily_stock_designer_wise_report_total_items_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockDesignerWiseReportScreen extends StatefulWidget {
  const DailyStockDesignerWiseReportScreen({super.key});

  @override
  State<DailyStockDesignerWiseReportScreen> createState() =>
      _DailyStockDesignerWiseReportScreenState();
}

class _DailyStockDesignerWiseReportScreenState
    extends State<DailyStockDesignerWiseReportScreen> {
  final DailyStockDesignerWiseReportController
      _dailyStockDesignerWiseReportController =
      Get.put(DailyStockDesignerWiseReportController());

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Daily Stock Designer Wise Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _dailyStockDesignerWiseReportController
                                  .getDailyStockDesignerWiseReport();
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _dailyStockDesignerWiseReportController.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _dailyStockDesignerWiseReportController.exportData(context);
                          }))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const DailyStockDesignerWiseReportTableHeader(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Obx(
                    () => _dailyStockDesignerWiseReportController
                            .isTableLoading.value
                        ? const SizedBox()
                        : const DailyStockDesignerWiseReportTotalItemsData(),
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
                  Obx(() => _dailyStockDesignerWiseReportController
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
                                      _dailyStockDesignerWiseReportController
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
                                      'Designer name',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Designer code',
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
                                      'In pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'In weight',
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
                                      _dailyStockDesignerWiseReportController
                                          .tableData.value),
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
                      value: _dailyStockDesignerWiseReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _dailyStockDesignerWiseReportController
                            .itemsPerPage(value);
                        _dailyStockDesignerWiseReportController
                            .getDailyStockDesignerWiseReport();
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
                      value: _dailyStockDesignerWiseReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _dailyStockDesignerWiseReportController
                            .itemsPerPage(value);
                        _dailyStockDesignerWiseReportController
                            .getDailyStockDesignerWiseReport();
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
                'Page ${_dailyStockDesignerWiseReportController.page.value} of ${_dailyStockDesignerWiseReportController.totalpages.value}',
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
                      onPressed:
                          _dailyStockDesignerWiseReportController.page.value > 1
                              ? () {
                                  if (_dailyStockDesignerWiseReportController
                                          .page.value >
                                      1) {
                                    _dailyStockDesignerWiseReportController.page(
                                        _dailyStockDesignerWiseReportController
                                                .page.value -
                                            1);
                                    _dailyStockDesignerWiseReportController
                                        .getDailyStockDesignerWiseReport();
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
                          _dailyStockDesignerWiseReportController.page.value <
                                  _dailyStockDesignerWiseReportController
                                      .totalpages.value
                              ? () {
                                  if (_dailyStockDesignerWiseReportController
                                          .page.value <
                                      _dailyStockDesignerWiseReportController
                                          .totalpages.value) {
                                    _dailyStockDesignerWiseReportController.page(
                                        _dailyStockDesignerWiseReportController
                                                .page.value +
                                            1);
                                    _dailyStockDesignerWiseReportController
                                        .getDailyStockDesignerWiseReport();
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
                'Page ${_dailyStockDesignerWiseReportController.page.value} of ${_dailyStockDesignerWiseReportController.totalpages.value}',
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
                  onPressed: _dailyStockDesignerWiseReportController.page.value > 1
                      ? () {
                          if (_dailyStockDesignerWiseReportController.page.value >
                              1) {
                            _dailyStockDesignerWiseReportController.page(
                                _dailyStockDesignerWiseReportController
                                        .page.value -
                                    1);
                            _dailyStockDesignerWiseReportController
                                .getDailyStockDesignerWiseReport();
                          }
                        }
                      : null),
              IconButton(
                  icon: Icon(Icons.arrow_forward,
                      size: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 20.sp
                          : 15.sp),
                  onPressed: _dailyStockDesignerWiseReportController.page.value <
                          _dailyStockDesignerWiseReportController.totalpages.value
                      ? () {
                          if (_dailyStockDesignerWiseReportController.page.value <
                              _dailyStockDesignerWiseReportController
                                  .totalpages.value) {
                            _dailyStockDesignerWiseReportController.page(
                                _dailyStockDesignerWiseReportController
                                        .page.value +
                                    1);
                            _dailyStockDesignerWiseReportController
                                .getDailyStockDesignerWiseReport();
                          }
                        }
                      : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<DailyStockDesignerWiseReportList> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

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
          row.designerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.designerCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.openPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
           double.parse(row.openWeight.toString() ?? "0.0").toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.inPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
            double.parse(row.inWeight.toString() ?? "0.0").toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
           double.parse(row.issuedWeight.toString() ?? "0.0").toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.issuedPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
         double.parse(row.receivedWeight.toString() ?? "0.0").toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.receivedPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),DataCell(Text(
          row.outPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
            double.parse(row.outWeight.toString() ?? "0.0").toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.closePieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          double.parse(row.closeWeight.toString() ?? "0.0").toStringAsFixed(2),
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
