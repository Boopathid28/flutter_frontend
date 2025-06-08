import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/overall_daily_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/overall_daily_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/overall_daily_report/overall_daily_report_header.dart';

class OverallDailyReportListScreen extends StatefulWidget {
  @override
  State<OverallDailyReportListScreen> createState() => _OverallDailyReportListScreenState();
}

class _OverallDailyReportListScreenState extends State<OverallDailyReportListScreen> {
  final OverallDailyReportController _overallDailyReportController =
      Get.put(OverallDailyReportController());

  @override
  void initState() {
    super.initState();
    _overallDailyReportController.getoverallDailyreport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _overallDailyReportController.scaffoldKey,
      onRefresh: () {
        _overallDailyReportController.getoverallDailyreport(context);
      },
      child: Scaffold(
        key: _overallDailyReportController.scaffoldKey,
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
                              "Overall Daily Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _overallDailyReportController
                                  .getoverallDailyreport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _overallDailyReportController.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _overallDailyReportController.exportData(context);
                          }))
                      ],
                    ),
              ),
              // OrderMetalWiseReportTotalViews(),
              OverallDailyReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _overallDailyReportController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _overallDailyReportController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'Refference Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Total Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Pieces',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Paid Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Balance',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Total In Payment',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Total Out Payment',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _overallDailyReportController.tableData.value),
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
                value: _overallDailyReportController.itemsPerPage.value,
                onChanged: (value) {
                  _overallDailyReportController.itemsPerPage(value);
                  _overallDailyReportController.getoverallDailyreport(context);
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
              'Page ${_overallDailyReportController.page.value} of ${_overallDailyReportController.totalpages.value}',
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
                onPressed: _overallDailyReportController.page.value > 1
                    ? () {
                        if (_overallDailyReportController.page.value > 1) {
                          _overallDailyReportController
                              .page(_overallDailyReportController.page.value - 1);
                          _overallDailyReportController.getoverallDailyreport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _overallDailyReportController.page.value <
                        _overallDailyReportController.totalpages.value
                    ? () {
                        if (_overallDailyReportController.page.value <
                            _overallDailyReportController.totalpages.value) {
                          _overallDailyReportController
                              .page(_overallDailyReportController.page.value + 1);
                          _overallDailyReportController.getoverallDailyreport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<OverallDailyReportResponse> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final OverallDailyReportController _overallDailyReportController =
      Get.put(OverallDailyReportController());

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
          row.referenceId ?? "-",
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.type.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.pieces == null ? "-" : row.pieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.paidAmount == null ? "-" : row.paidAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),

        DataCell(Text(
          row.balance == null ? "-" : row.balance.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalInPayment == null ? "-" : row.totalInPayment.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.totalOutPayment == null ? "-" : row.totalOutPayment.toString(),
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
