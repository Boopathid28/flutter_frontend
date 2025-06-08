import 'package:ausales_application/controller/reports/vendor_purity_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/vendor_subitem_wise_sales_report_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/vendor_purity_wise_sales_report_models.dart';
import 'package:ausales_application/model/reports/vendor_subitem_wise_sales_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_metal_wise_sales_report/vendor_metal_wise_sales_report_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_purity_wise_sales_report/vendor_purity_wise_sales_report_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_subitem_wise_sales_report/vendor_subitem_wise_sales_report_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorSubitemWiseSalesReportScreen extends StatefulWidget {
  const VendorSubitemWiseSalesReportScreen({super.key});

  @override
  State<VendorSubitemWiseSalesReportScreen> createState() =>
      _VendorSubitemWiseSalesReportScreenState();
}

class _VendorSubitemWiseSalesReportScreenState
    extends State<VendorSubitemWiseSalesReportScreen> {
  final VendorSubitemWiseSalesReportController
      _vendorSubitemWiseSalesReportController =
      Get.put(VendorSubitemWiseSalesReportController());

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
                            "Vendor Sub Item Wise Sales Report",
                            style: Responsive.isMobile(context)
                                ? TextPalette.tableDataTextStyle
                                : TextPalette.screenTitle,
                          ),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconButton(
                          onPressed: () {
                            _vendorSubitemWiseSalesReportController
                                .getVendorSubitemWiseSalesReport();
                          },
                          icon: const Icon(Icons.refresh)),
                        ],
                      ),

                      Obx(() =>PrimaryButton(
                        btnWidth: 150.w,
                        isLoading: _vendorSubitemWiseSalesReportController.isExportLoading.value,
                        text: 'Export',
                        onPressed: () {
                          _vendorSubitemWiseSalesReportController.exportData(context);
                        }))
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const VendorSubitemWiseSalesReportTableHeader(),
                 
                 
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
                  Obx(() => _vendorSubitemWiseSalesReportController
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
                                      _vendorSubitemWiseSalesReportController
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
                                      _vendorSubitemWiseSalesReportController
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
                      value: _vendorSubitemWiseSalesReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _vendorSubitemWiseSalesReportController
                            .itemsPerPage(value);
                        _vendorSubitemWiseSalesReportController
                            .getVendorSubitemWiseSalesReport();
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
                      value: _vendorSubitemWiseSalesReportController
                          .itemsPerPage.value,
                      onChanged: (value) {
                        _vendorSubitemWiseSalesReportController
                            .itemsPerPage(value);
                        _vendorSubitemWiseSalesReportController
                            .getVendorSubitemWiseSalesReport();
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
                'Page ${_vendorSubitemWiseSalesReportController.page.value} of ${_vendorSubitemWiseSalesReportController.totalpages.value}',
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
                      onPressed: _vendorSubitemWiseSalesReportController
                                  .page.value >
                              1
                          ? () {
                              if (_vendorSubitemWiseSalesReportController
                                      .page.value >
                                  1) {
                                _vendorSubitemWiseSalesReportController.page(
                                    _vendorSubitemWiseSalesReportController
                                            .page.value -
                                        1);
                                _vendorSubitemWiseSalesReportController
                                    .getVendorSubitemWiseSalesReport();
                              }
                            }
                          : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _vendorSubitemWiseSalesReportController
                                  .page.value <
                              _vendorSubitemWiseSalesReportController
                                  .totalpages.value
                          ? () {
                              if (_vendorSubitemWiseSalesReportController
                                      .page.value <
                                  _vendorSubitemWiseSalesReportController
                                      .totalpages.value) {
                                _vendorSubitemWiseSalesReportController.page(
                                    _vendorSubitemWiseSalesReportController
                                            .page.value +
                                        1);
                                _vendorSubitemWiseSalesReportController
                                    .getVendorSubitemWiseSalesReport();
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
                'Page ${_vendorSubitemWiseSalesReportController.page.value} of ${_vendorSubitemWiseSalesReportController.totalpages.value}',
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
                      _vendorSubitemWiseSalesReportController.page.value > 1
                          ? () {
                              if (_vendorSubitemWiseSalesReportController
                                      .page.value >
                                  1) {
                                _vendorSubitemWiseSalesReportController.page(
                                    _vendorSubitemWiseSalesReportController
                                            .page.value -
                                        1);
                                _vendorSubitemWiseSalesReportController
                                    .getVendorSubitemWiseSalesReport();
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
                      _vendorSubitemWiseSalesReportController.page.value <
                              _vendorSubitemWiseSalesReportController
                                  .totalpages.value
                          ? () {
                              if (_vendorSubitemWiseSalesReportController
                                      .page.value <
                                  _vendorSubitemWiseSalesReportController
                                      .totalpages.value) {
                                _vendorSubitemWiseSalesReportController.page(
                                    _vendorSubitemWiseSalesReportController
                                            .page.value +
                                        1);
                                _vendorSubitemWiseSalesReportController
                                    .getVendorSubitemWiseSalesReport();
                              }
                            }
                          : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<VendorSubitemWiseSalesReport> data;
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
          row.subItemName.toString(),
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
