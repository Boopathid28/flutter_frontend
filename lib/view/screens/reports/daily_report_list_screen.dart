import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/over_all_daily_report_controller.dart';
import 'package:ausales_application/controller/reports/overall_daily_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/daily_report_models.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/overall_daily_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/daily_report/daily_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/overall_daily_report/overall_daily_report_header.dart';

class DailyReportListScreen extends StatefulWidget {
  @override
  State<DailyReportListScreen> createState() => _DailyReportListScreenState();
}

class _DailyReportListScreenState extends State<DailyReportListScreen> {
  final DailyReportControllers _dailyReportControllers =
      Get.put(DailyReportControllers());

  @override
  void initState() {
    super.initState();
      DateTime today = DateTime.now();
      String formattedDate =
                    DateFormat('yyyy-MM-dd').format(today);
    _dailyReportControllers.fromDateController.text = formattedDate;
    _dailyReportControllers.getDailyreport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _dailyReportControllers.scaffoldKey,
      onRefresh: () {
        _dailyReportControllers.getDailyreport(context);
      },
      child: Scaffold(
        key: _dailyReportControllers.scaffoldKey,
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
                padding: EdgeInsets.symmetric(vertical: 8.0 , horizontal: 8.0),
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Daily Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _dailyReportControllers
                                  .getDailyreport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _dailyReportControllers.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _dailyReportControllers.exportData(context);
                          }))
                      ],
                    ),
              ),
              // OrderMetalWiseReportTotalViews(),
              DailyReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _dailyReportControllers.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _dailyReportControllers
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
                                        'Customer / Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Tag Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Purity Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Metal Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Gross Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Net Weight',
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
                                        'Item name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Sub Item name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Stone Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Diamond Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Reduced Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Exchange Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Cash Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Card Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Upi Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Bank Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                         DataColumn(
                                          label: Text(
                                        'Total Advance Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Total Advance Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Total Chit Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Total Chit Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Total Old Gold Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Total Old Gold Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Payment Refference num',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Suspense Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Suspense Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'vendor Charges',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Pure Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Making Charge',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Wastage Percent',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      
                                    ],
                                    source: _DataSource(context,
                                        _dailyReportControllers.tableData.value),
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
                value: _dailyReportControllers.itemsPerPage.value,
                onChanged: (value) {
                  _dailyReportControllers.itemsPerPage(value);
                  _dailyReportControllers.getDailyreport(context);
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
              'Page ${_dailyReportControllers.page.value} of ${_dailyReportControllers.totalpages.value}',
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
                onPressed: _dailyReportControllers.page.value > 1
                    ? () {
                        if (_dailyReportControllers.page.value > 1) {
                          _dailyReportControllers
                              .page(_dailyReportControllers.page.value - 1);
                          _dailyReportControllers.getDailyreport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _dailyReportControllers.page.value <
                        _dailyReportControllers.totalpages.value
                    ? () {
                        if (_dailyReportControllers.page.value <
                            _dailyReportControllers.totalpages.value) {
                          _dailyReportControllers
                              .page(_dailyReportControllers.page.value + 1);
                          _dailyReportControllers.getDailyreport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<DailyReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final DailyReportControllers _dailyReportControllers =
      Get.put(DailyReportControllers());

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
          row.refernceId ?? "-",
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.customerVendorName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.amount == null? "-" : row.amount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.tagNumber == null ? "-" : row.tagNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),

        DataCell(Text(
          row.purityName == null  ? "-" : row.purityName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.metalName == null  ? "-" : row.metalName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.grossWeight == null  ? "-" : row.grossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        
           DataCell(Text(
          row.netWeight == null ? "-" : row.netWeight.toString(),
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
          row.itemName == null ? "-" : row.itemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.subItemName == null  ? "-" : row.subItemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.stoneAmount == null ? "-" : row.stoneAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
            DataCell(Text(
          row.diamondAmount == null  ? "-" : row.diamondAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.reduceWeight == null  ? "-" : row.reduceWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
            DataCell(Text(
          row.exchangeAmount == null ? "-" : row.exchangeAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.cashAmount == null ? "-" : row.cashAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.cardAmount == null ? "-" : row.cardAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.upiAmount == null ? "-" : row.upiAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.bankAmount == null  ? "-" : row.bankAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.totalAdvanceAmount == null ? "-" : row.totalAdvanceAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.totalAdvanceWeight == null ? "-" : row.totalAdvanceWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalChitAmount == null  ? "-" : row.totalChitAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalChitWeight == null ? "-" : row.totalChitWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalOldGoldAmount == null  ? "-" : row.totalOldGoldAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalOldGoldWeight == null  ? "-" : row.totalOldGoldWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.paymentReffrenceNumber == null? "-" : row.paymentReffrenceNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.suspenseAmount == null  ? "-" : row.suspenseAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.suspenseweight == null  ? "-" : row.suspenseweight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.vendorCharges == null  ? "-" : row.vendorCharges.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.pureWeight == null   ? "-" : row.pureWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.makingCharge == null   ? "-" : row.makingCharge.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.wastagePercent == null   ? "-" : row.wastagePercent.toString(),
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
