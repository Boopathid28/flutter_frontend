import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/vendor_inwards_report_list_controller.dart';
import 'package:ausales_application/controller/reports/vendor_outwards_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/vendor_outwards_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_inwards_report/vendor_inwards_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_inwards_report/vendor_inwards_report_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_outwards_report/vendor_outwards_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/vendor_outwards_report/vendor_outwards_report_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorOutwardsReportScreens extends StatefulWidget {
  @override
  State<VendorOutwardsReportScreens> createState() => _VendorOutwardsReportScreensState();
}

class _VendorOutwardsReportScreensState extends State<VendorOutwardsReportScreens> {
  final VendorOutwardsReportController _vendorOutwardsReportController =
      Get.put(VendorOutwardsReportController());

  @override
  void initState() {
    super.initState();
    _vendorOutwardsReportController.getVendorOutwardsListreport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _vendorOutwardsReportController.scaffoldKey,
      onRefresh: () {
        _vendorOutwardsReportController.getVendorOutwardsListreport(context);
      },
      child: Scaffold(
        key: _vendorOutwardsReportController.scaffoldKey,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Vendor Outwards Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _vendorOutwardsReportController
                                  .getVendorOutwardsListreport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _vendorOutwardsReportController.isExportLoading.value,
                              text: 'Export to Excel',
                              onPressed: () {
                                _vendorOutwardsReportController.exportData(context);
                              })),
                              SizedBox(width: 10,),
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _vendorOutwardsReportController.isExportPdfLoading.value,
                              text: 'Export to Pdf',
                              onPressed: () {
                                _vendorOutwardsReportController.exportPdfData(context);
                              })),
                          ],
                        )
                      ],
                    ),
              ),
              VendorOutwardsReportTotalViews(),
              VendorOutwardsReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _vendorOutwardsReportController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _vendorOutwardsReportController
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
                                        'Pieces',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Gross Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                     
                                    ],
                                    source: _DataSource(context,
                                        _vendorOutwardsReportController.tableData.value),
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
                value: _vendorOutwardsReportController.itemsPerPage.value,
                onChanged: (value) {
                  _vendorOutwardsReportController.itemsPerPage(value);
                  _vendorOutwardsReportController.getVendorOutwardsListreport(context);
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
              'Page ${_vendorOutwardsReportController.page.value} of ${_vendorOutwardsReportController.totalpages.value}',
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
                onPressed: _vendorOutwardsReportController.page.value > 1
                    ? () {
                        if (_vendorOutwardsReportController.page.value > 1) {
                          _vendorOutwardsReportController
                              .page(_vendorOutwardsReportController.page.value - 1);
                          _vendorOutwardsReportController.getVendorOutwardsListreport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _vendorOutwardsReportController.page.value <
                        _vendorOutwardsReportController.totalpages.value
                    ? () {
                        if (_vendorOutwardsReportController.page.value <
                            _vendorOutwardsReportController.totalpages.value) {
                          _vendorOutwardsReportController
                              .page(_vendorOutwardsReportController.page.value + 1);
                          _vendorOutwardsReportController.getVendorOutwardsListreport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<VendorOutwardReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final VendorOutwardsReportController _vendorOutwardsReportController =
      Get.put(VendorOutwardsReportController());

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
          row.sNo != null ? row.sNo.toString() : "",
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.vendorCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.vendorName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.pieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.grossWeight.toString(),
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
