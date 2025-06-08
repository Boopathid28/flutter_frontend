import 'package:ausales_application/controller/reports/daily_stock_item_wise_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/daily_stock_item_wise_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/daily_stock_item_wise_report/daily_stock_item_wise_report_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/daily_stock_item_wise_report/daily_stock_item_wise_report_total_items_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyStockItemWiseReportScreen extends StatefulWidget {
  const DailyStockItemWiseReportScreen({super.key});

  @override
  State<DailyStockItemWiseReportScreen> createState() =>
      _DailyStockItemWiseReportScreenState();
}

class _DailyStockItemWiseReportScreenState
    extends State<DailyStockItemWiseReportScreen> {
  final DailyStockItemWiseReportController
      _dailyStockItemWiseReportController =
      Get.put(DailyStockItemWiseReportController());

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
                            "Daily Stock Item Wise Report",
                            style: Responsive.isMobile(context)
                                ? TextPalette.tableDataTextStyle
                                : TextPalette.screenTitle,
                          ),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconButton(
                          onPressed: () {
                            _dailyStockItemWiseReportController
                                .getDailyStockItemWiseReport();
                          },
                          icon: const Icon(Icons.refresh)),
                        ],
                      ),
                      Row(
                        children: [
                          Obx(() =>PrimaryButton(
                            btnWidth: 150.w,
                            isLoading: _dailyStockItemWiseReportController.isExportLoading.value,
                            text: 'Export to excel',
                            onPressed: () {
                              _dailyStockItemWiseReportController.exportData(context);
                            })),
                            SizedBox(width: 10,),
                          Obx(() =>PrimaryButton(
                            btnWidth: 150.w,
                            isLoading: _dailyStockItemWiseReportController.isExportPdfLoading.value,
                            text: 'Export to pdf',
                            onPressed: () {
                              _dailyStockItemWiseReportController.exportPdfData(context);
                            })),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const DailyStockItemWiseReportTableHeader(),
                  SizedBox(
                    height: 16.h,
                  ),
                 Obx(() =>  _dailyStockItemWiseReportController.isTableLoading.value?const SizedBox(): const DailyStockItemWiseReportTotalItemsData(),),
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
                  Obx(() => _dailyStockItemWiseReportController
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
                                      _dailyStockItemWiseReportController
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
                                      'Item name',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                  
                                    DataColumn(
                                        label: Text(
                                      'Open Qty',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Open weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                     DataColumn(
                                        label: Text(
                                      'Receipt Qty',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Receipt weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                     DataColumn(
                                        label: Text(
                                      'Sales Qty',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Sales weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                     DataColumn(
                                        label: Text(
                                      'Issued weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                     DataColumn(
                                        label: Text(
                                      'Issued Qty',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                     DataColumn(
                                        label: Text(
                                      'Different weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Close Qty',
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
                                      _dailyStockItemWiseReportController
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
                      value: _dailyStockItemWiseReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _dailyStockItemWiseReportController
                            .itemsPerPage(value);
                        _dailyStockItemWiseReportController
                            .getDailyStockItemWiseReport();
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
                      value: _dailyStockItemWiseReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _dailyStockItemWiseReportController
                            .itemsPerPage(value);
                        _dailyStockItemWiseReportController
                            .getDailyStockItemWiseReport();
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
                'Page ${_dailyStockItemWiseReportController.page.value} of ${_dailyStockItemWiseReportController.totalpages.value}',
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
                      onPressed: _dailyStockItemWiseReportController
                                  .page.value >
                              1
                          ? () {
                              if (_dailyStockItemWiseReportController
                                      .page.value >
                                  1) {
                                _dailyStockItemWiseReportController.page(
                                    _dailyStockItemWiseReportController
                                            .page.value -
                                        1);
                                _dailyStockItemWiseReportController
                                    .getDailyStockItemWiseReport();
                              }
                            }
                          : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _dailyStockItemWiseReportController
                                  .page.value <
                              _dailyStockItemWiseReportController
                                  .totalpages.value
                          ? () {
                              if (_dailyStockItemWiseReportController
                                      .page.value <
                                  _dailyStockItemWiseReportController
                                      .totalpages.value) {
                                _dailyStockItemWiseReportController.page(
                                    _dailyStockItemWiseReportController
                                            .page.value +
                                        1);
                                _dailyStockItemWiseReportController
                                    .getDailyStockItemWiseReport();
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
                'Page ${_dailyStockItemWiseReportController.page.value} of ${_dailyStockItemWiseReportController.totalpages.value}',
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
                      _dailyStockItemWiseReportController.page.value > 1
                          ? () {
                              if (_dailyStockItemWiseReportController
                                      .page.value >
                                  1) {
                                _dailyStockItemWiseReportController.page(
                                    _dailyStockItemWiseReportController
                                            .page.value -
                                        1);
                                _dailyStockItemWiseReportController
                                    .getDailyStockItemWiseReport();
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
                      _dailyStockItemWiseReportController.page.value <
                              _dailyStockItemWiseReportController
                                  .totalpages.value
                          ? () {
                              if (_dailyStockItemWiseReportController
                                      .page.value <
                                  _dailyStockItemWiseReportController
                                      .totalpages.value) {
                                _dailyStockItemWiseReportController.page(
                                    _dailyStockItemWiseReportController
                                            .page.value +
                                        1);
                                _dailyStockItemWiseReportController
                                    .getDailyStockItemWiseReport();
                              }
                            }
                          : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<DailyStockItemWiseReportList> data;
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
          row.itemName.toString(),
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
          row.inPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
           row.inWeight.toString(),
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
           row.issuedWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.issuedPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
         row.differenceWeight.toString(),
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
