import 'package:ausales_application/controller/reports/vendor_crdr_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/vendor_crdr_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_crdr_report/vendor_crdr_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_crdr_report/vendor_crdr_report_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorCrdrReportListScreen extends StatefulWidget {
  @override
  State<VendorCrdrReportListScreen> createState() => _VendorCrdrReportListScreenState();
}

class _VendorCrdrReportListScreenState extends State<VendorCrdrReportListScreen> {
  final VendorCrdrReportController _vendorCrdrReportController =
      Get.put(VendorCrdrReportController());

  @override
  void initState() {
    super.initState();
    _vendorCrdrReportController.getVendorCrdrReport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _vendorCrdrReportController.scaffoldKey,
      onRefresh: () {
        // _vendorCrdrReportController.getVendorCrdrReport(context);
      },
      child: Scaffold(
        key: _vendorCrdrReportController.scaffoldKey,
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
                              "Vendor CR DR Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _vendorCrdrReportController
                                  .getVendorCrdrReport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),

                        Obx(() =>Row(
                          children: [
                            PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _vendorCrdrReportController.isExportLoading.value,
                              text: 'Export',
                              onPressed: () {   
                                _vendorCrdrReportController.exportData(context);
                              }),
                              SizedBox(width: 10.w,),
                              Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _vendorCrdrReportController.isExportPdfLoading.value,
                          text: 'Print Pdf',
                          onPressed: () {   
                            _vendorCrdrReportController.exportDataPdf(context);
                          }))
                          ],
                        )),
                      ],
                    ),
              ),
              VendorCrdrReportSummary(),
              VendorCrdrReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _vendorCrdrReportController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _vendorCrdrReportController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'S No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Vendor Code',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Amount(CR)',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Amount(DR)',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Weight(CR)',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),

                                       DataColumn(
                                          label: Text(
                                        'Weight(DR)',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _vendorCrdrReportController.tableData.value),
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
                value: _vendorCrdrReportController.itemsPerPage.value,
                onChanged: (value) {
                  _vendorCrdrReportController.itemsPerPage(value);
                  // _vendorCrdrReportController.getVendorCrdrReport(context);
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
              'Page ${_vendorCrdrReportController.page.value} of ${_vendorCrdrReportController.totalpages.value}',
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
                onPressed: _vendorCrdrReportController.page.value > 1
                    ? () {
                        if (_vendorCrdrReportController.page.value > 1) {
                          _vendorCrdrReportController
                              .page(_vendorCrdrReportController.page.value - 1);
                          // _vendorCrdrReportController.getVendorCrdrReport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _vendorCrdrReportController.page.value <
                        _vendorCrdrReportController.totalpages.value
                    ? () {
                        if (_vendorCrdrReportController.page.value <
                            _vendorCrdrReportController.totalpages.value) {
                          _vendorCrdrReportController
                              .page(_vendorCrdrReportController.page.value + 1);
                          // _vendorCrdrReportController.getVendorCrdrReport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<VendorCRDRReportListData> data;
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
          row.code.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.name.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.amountCr.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.amountDr.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.weightCr.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.weightDr.toString(),
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
