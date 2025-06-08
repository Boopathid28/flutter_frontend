import 'package:ausales_application/controller/reports/purity_wise_sales_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/purity_wise_sale_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/metal_wise_sales_report/metal_wise_sales_report_tabel_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/purity_wise_sales_report/purity_wise_sales_report_tabel_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurityWiseSalesReportScreen extends StatefulWidget {
  const PurityWiseSalesReportScreen({super.key});

  @override
  State<PurityWiseSalesReportScreen> createState() =>
      _PurityWiseSalesReportScreenState();
}

class _PurityWiseSalesReportScreenState
    extends State<PurityWiseSalesReportScreen> {
  final PurityWiseSalesReportController
      _purityWiseSalesReportController =
      Get.put(PurityWiseSalesReportController());

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
                            "Purity Wise Sales Report",
                            style: Responsive.isMobile(context)
                                ? TextPalette.tableDataTextStyle
                                : TextPalette.screenTitle,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                              onPressed: () {
                                _purityWiseSalesReportController
                                    .getPurityWiseSalesReport();
                              },
                              icon: const Icon(Icons.refresh)),
                        ],
                      ),
                      Obx(() =>PrimaryButton(
                        btnWidth: 150.w,
                        isLoading: _purityWiseSalesReportController.isExportLoading.value,
                        text: 'Export',
                        onPressed: () {
                          _purityWiseSalesReportController.exportData(context);
                        }))
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const PurityWiseSalesReportTabelHeader(),
                 
                 
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
                  Obx(() => _purityWiseSalesReportController
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
                                      _purityWiseSalesReportController
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
                                      'Metal name',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                     DataColumn(
                                        label: Text(
                                      'Purity name',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Total pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Total gross weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Total amount',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                  
                                  ],
                                  source: _DataSource(
                                      context,
                                      _purityWiseSalesReportController
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
                      value: _purityWiseSalesReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _purityWiseSalesReportController
                            .itemsPerPage(value);
                        _purityWiseSalesReportController
                            .getPurityWiseSalesReport();
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
                      value: _purityWiseSalesReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _purityWiseSalesReportController
                            .itemsPerPage(value);
                        _purityWiseSalesReportController
                            .getPurityWiseSalesReport();
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
                'Page ${_purityWiseSalesReportController.page.value} of ${_purityWiseSalesReportController.totalpages.value}',
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
                      onPressed: _purityWiseSalesReportController
                                  .page.value >
                              1
                          ? () {
                              if (_purityWiseSalesReportController
                                      .page.value >
                                  1) {
                                _purityWiseSalesReportController.page(
                                    _purityWiseSalesReportController
                                            .page.value -
                                        1);
                                _purityWiseSalesReportController
                                    .getPurityWiseSalesReport();
                              }
                            }
                          : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _purityWiseSalesReportController
                                  .page.value <
                              _purityWiseSalesReportController
                                  .totalpages.value
                          ? () {
                              if (_purityWiseSalesReportController
                                      .page.value <
                                  _purityWiseSalesReportController
                                      .totalpages.value) {
                                _purityWiseSalesReportController.page(
                                    _purityWiseSalesReportController
                                            .page.value +
                                        1);
                                _purityWiseSalesReportController
                                    .getPurityWiseSalesReport();
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
                'Page ${_purityWiseSalesReportController.page.value} of ${_purityWiseSalesReportController.totalpages.value}',
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
                      _purityWiseSalesReportController.page.value > 1
                          ? () {
                              if (_purityWiseSalesReportController
                                      .page.value >
                                  1) {
                                _purityWiseSalesReportController.page(
                                    _purityWiseSalesReportController
                                            .page.value -
                                        1);
                                _purityWiseSalesReportController
                                    .getPurityWiseSalesReport();
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
                      _purityWiseSalesReportController.page.value <
                              _purityWiseSalesReportController
                                  .totalpages.value
                          ? () {
                              if (_purityWiseSalesReportController
                                      .page.value <
                                  _purityWiseSalesReportController
                                      .totalpages.value) {
                                _purityWiseSalesReportController.page(
                                    _purityWiseSalesReportController
                                            .page.value +
                                        1);
                                _purityWiseSalesReportController
                                    .getPurityWiseSalesReport();
                              }
                            }
                          : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<PurityWiseSaleReport> data;
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
          row.metalName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.purityName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
       DataCell(Text(
          row.totalPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalGrossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.totalGrossWeight.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        // DataCell(Text(
        //   row.totalAmount.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        
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
