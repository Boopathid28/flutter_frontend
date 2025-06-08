import 'package:ausales_application/controller/reports/cash_purchase_report_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/cash_purchase_report_models..dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/cash_purchase_report/cash_purchase_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/cash_purchase_report/cash_purchase_report_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CashPurchaseReportListScreen extends StatefulWidget {
  @override
  State<CashPurchaseReportListScreen> createState() => _CashPurchaseReportListScreenState();
}

class _CashPurchaseReportListScreenState extends State<CashPurchaseReportListScreen> {
  final CashPurchaseReportListController _cashPurchaseReportListController =
      Get.put(CashPurchaseReportListController());

  @override
  void initState() {
    super.initState();
    _cashPurchaseReportListController.getCashPurchaseReport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _cashPurchaseReportListController.scaffoldKey,
      onRefresh: () {
        // _cashPurchaseReportListController.getCashPurchaseReport(context);
      },
      child: Scaffold(
        key: _cashPurchaseReportListController.scaffoldKey,
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
                              "Cash Purchase Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        // IconButton(
                        //     onPressed: () {
                        //       _cashPurchaseReportListController
                        //           .getCashPurchaseReport(context);
                        //     },
                        //     icon: const Icon(Icons.refresh)),
                          ],
                        ),

                        Obx(() =>Row(
                          children: [
                            PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _cashPurchaseReportListController.isExportLoading.value,
                              text: 'Export',
                              onPressed: () {   
                                _cashPurchaseReportListController.exportData(context);
                              }),
                              SizedBox(width: 10.w,),
                              Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _cashPurchaseReportListController.isExportPdfLoading.value,
                          text: 'Print Pdf',
                          onPressed: () {   
                            _cashPurchaseReportListController.exportDataPdf(context);
                          }))
                          ],
                        )),
                      ],
                    ),
              ),
              CashPurchaseReportSummary(),
              CashPurchaseReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _cashPurchaseReportListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _cashPurchaseReportListController
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
                                        'Bill No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Metal',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Item',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Metal Rate',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Gross Wgt',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Dust Wgt',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Net Wgt',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _cashPurchaseReportListController.tableData.value),
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
                value: _cashPurchaseReportListController.itemsPerPage.value,
                onChanged: (value) {
                  _cashPurchaseReportListController.itemsPerPage(value);
                  // _cashPurchaseReportListController.getCashPurchaseReport(context);
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
              'Page ${_cashPurchaseReportListController.page.value} of ${_cashPurchaseReportListController.totalpages.value}',
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
                onPressed: _cashPurchaseReportListController.page.value > 1
                    ? () {
                        if (_cashPurchaseReportListController.page.value > 1) {
                          _cashPurchaseReportListController
                              .page(_cashPurchaseReportListController.page.value - 1);
                          // _cashPurchaseReportListController.getCashPurchaseReport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _cashPurchaseReportListController.page.value <
                        _cashPurchaseReportListController.totalpages.value
                    ? () {
                        if (_cashPurchaseReportListController.page.value <
                            _cashPurchaseReportListController.totalpages.value) {
                          _cashPurchaseReportListController
                              .page(_cashPurchaseReportListController.page.value + 1);
                          // _cashPurchaseReportListController.getCashPurchaseReport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<CashPurchaseReportListData> data;
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
          row.bill.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.customer.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.date.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.metal.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.item.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.metalRate!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.grossWeight!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.dustWeight!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.netWeight!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.amount!.toStringAsFixed(2),
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
