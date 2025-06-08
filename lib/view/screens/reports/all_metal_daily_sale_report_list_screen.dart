import 'package:ausales_application/controller/reports/all_metal_daily_sale_report_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/all_metal_daily_sale_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/all_metal_daily_sale_report/all_metal_daily_sale_report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllMetalDailySaleReportListScreen extends StatefulWidget {
  @override
  State<AllMetalDailySaleReportListScreen> createState() => _AllMetalDailySaleReportListScreenState();
}

class _AllMetalDailySaleReportListScreenState extends State<AllMetalDailySaleReportListScreen> {
  final AllMetalDailySaleReportListController _allMetalDailySaleReportListController =
      Get.put(AllMetalDailySaleReportListController());

  @override
  void initState() {
    super.initState();
    _allMetalDailySaleReportListController.getAllMetalDailySaleReport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _allMetalDailySaleReportListController.scaffoldKey,
      onRefresh: () {
        // _allMetalDailySaleReportListController.getAllMetalDailySaleReport(context);
      },
      child: Scaffold(
        key: _allMetalDailySaleReportListController.scaffoldKey,
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
                              "All Metal Daily Sale Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        // IconButton(
                        //     onPressed: () {
                        //       _allMetalDailySaleReportListController
                        //           .getAllMetalDailySaleReport(context);
                        //     },
                        //     icon: const Icon(Icons.refresh)),
                          ],
                        ),

                        Obx(() =>Row(
                          children: [
                            PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _allMetalDailySaleReportListController.isExportLoading.value,
                              text: 'Export',
                              onPressed: () {   
                                _allMetalDailySaleReportListController.exportData(context);
                              }),
                              SizedBox(width: 10.w,),
                              Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _allMetalDailySaleReportListController.isExportPdfLoading.value,
                          text: 'Print Pdf',
                          onPressed: () {   
                            _allMetalDailySaleReportListController.exportDataPdf(context);
                          }))
                          ],
                        )),
                      ],
                    ),
              ),
              // DailySaleReportTotalViews(),
              AllMetalDailySaleReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _allMetalDailySaleReportListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _allMetalDailySaleReportListController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'Bill No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Bill Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Tag',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Metal Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),

                                       DataColumn(
                                          label: Text(
                                        'Purity Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Item Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Sub Item Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'PC',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Wt',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Total',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'GST',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Discount Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Rounde Off Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Sales',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Old Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Old Amount',
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
                                        'Bank Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Upi Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Advance Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Chit Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Suspence Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Total Paid',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Balance',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Excess',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       
                                    ],
                                    source: _DataSource(context,
                                        _allMetalDailySaleReportListController.tableData.value),
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
                value: _allMetalDailySaleReportListController.itemsPerPage.value,
                onChanged: (value) {
                  _allMetalDailySaleReportListController.itemsPerPage(value);
                  // _allMetalDailySaleReportListController.getAllMetalDailySaleReport(context);
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
              'Page ${_allMetalDailySaleReportListController.page.value} of ${_allMetalDailySaleReportListController.totalpages.value}',
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
                onPressed: _allMetalDailySaleReportListController.page.value > 1
                    ? () {
                        if (_allMetalDailySaleReportListController.page.value > 1) {
                          _allMetalDailySaleReportListController
                              .page(_allMetalDailySaleReportListController.page.value - 1);
                          // _allMetalDailySaleReportListController.getAllMetalDailySaleReport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _allMetalDailySaleReportListController.page.value <
                        _allMetalDailySaleReportListController.totalpages.value
                    ? () {
                        if (_allMetalDailySaleReportListController.page.value <
                            _allMetalDailySaleReportListController.totalpages.value) {
                          _allMetalDailySaleReportListController
                              .page(_allMetalDailySaleReportListController.page.value + 1);
                          // _allMetalDailySaleReportListController.getAllMetalDailySaleReport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<AllMetalDailySaleReportListData> data;
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
          row.billNo.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.billDate.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.customer.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.tag.toString(),
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
          row.itemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.subItemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.pc.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.wt.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.total.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.gst.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.discountAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.roundoffAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.sales.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.oldWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.oldAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.cashAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.cardAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.bankAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.phonePay.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.advanceAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.chitAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.suspenseAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalPaid.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.balance.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.excess.toString(),
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
