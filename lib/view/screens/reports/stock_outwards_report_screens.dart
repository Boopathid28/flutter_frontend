import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/stock_outwards_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/stock_outward_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/stock_outwards_report/stock_outwards_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/stock_outwards_report/stock_outwards_report_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockOutwardsReportScreens extends StatefulWidget {
  @override
  State<StockOutwardsReportScreens> createState() => _StockOutwardsReportScreensState();
}

class _StockOutwardsReportScreensState extends State<StockOutwardsReportScreens> {
  final StockOutwardsReportController _stockOutwardsReportController =
      Get.put(StockOutwardsReportController());

  @override
  void initState() {
    super.initState();
    _stockOutwardsReportController.getstockoutwardsreport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _stockOutwardsReportController.scaffoldKey,
      onRefresh: () {
        _stockOutwardsReportController.getstockoutwardsreport(context);
      },
      child: Scaffold(
        key: _stockOutwardsReportController.scaffoldKey,
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
                              "Stock Outwards Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _stockOutwardsReportController
                                  .getstockoutwardsreport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _stockOutwardsReportController.isExportLoading.value,
                              text: 'Export to Excel',
                              onPressed: () {
                                _stockOutwardsReportController.exportData(context);
                              })),
                              SizedBox(width: 10,),
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _stockOutwardsReportController.isExportPdfLoading.value,
                              text: 'Export to Pdf',
                              onPressed: () {
                                _stockOutwardsReportController.exportPdfData(context);
                              })),
                          ],
                        )
                      ],
                    ),
              ),
              StockOutwardsReportTotalViews(),
              StockOutwardsReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _stockOutwardsReportController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _stockOutwardsReportController
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
                                        'Tag',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Item',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Gross Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                     
                                      DataColumn(
                                          label: Text(
                                        'Pieces',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      
                                    ],
                                    source: _DataSource(context,
                                        _stockOutwardsReportController.tableData.value),
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
                value: _stockOutwardsReportController.itemsPerPage.value,
                onChanged: (value) {
                  _stockOutwardsReportController.itemsPerPage(value);
                  _stockOutwardsReportController.getstockoutwardsreport(context);
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
              'Page ${_stockOutwardsReportController.page.value} of ${_stockOutwardsReportController.totalpages.value}',
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
                onPressed: _stockOutwardsReportController.page.value > 1
                    ? () {
                        if (_stockOutwardsReportController.page.value > 1) {
                          _stockOutwardsReportController
                              .page(_stockOutwardsReportController.page.value - 1);
                          _stockOutwardsReportController.getstockoutwardsreport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _stockOutwardsReportController.page.value <
                        _stockOutwardsReportController.totalpages.value
                    ? () {
                        if (_stockOutwardsReportController.page.value <
                            _stockOutwardsReportController.totalpages.value) {
                          _stockOutwardsReportController
                              .page(_stockOutwardsReportController.page.value + 1);
                          _stockOutwardsReportController.getstockoutwardsreport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<StockOutwardListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final StockOutwardsReportController _stockOutwardsReportController =
      Get.put(StockOutwardsReportController());

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
          row.tag.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.item.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.grossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.pieces.toString(),
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
