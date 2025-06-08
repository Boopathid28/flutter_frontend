import 'package:ausales_application/controller/reports/suspense_repayment_report_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/suspense_repayment_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/suspense_repayment_report/suspense_repayment_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/suspense_repayment_report/suspense_repayment_report_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseRepaymentReportListScreen extends StatefulWidget {
  @override
  State<SuspenseRepaymentReportListScreen> createState() => _SuspenseRepaymentReportListScreenState();
}

class _SuspenseRepaymentReportListScreenState extends State<SuspenseRepaymentReportListScreen> {
  final SuspenseRepaymentReportListController _suspenseRepaymentReportListController =
      Get.put(SuspenseRepaymentReportListController());

  @override
  void initState() {
    super.initState();
    _suspenseRepaymentReportListController.getsuspenserepaymentreportList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _suspenseRepaymentReportListController.scaffoldKey,
       onRefresh: () {
        _suspenseRepaymentReportListController.getsuspenserepaymentreportList(context);
      },
      child: Scaffold(
       key: _suspenseRepaymentReportListController.scaffoldKey,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Suspense Repayment Report",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _suspenseRepaymentReportListController.getsuspenserepaymentreportList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    Obx(() => PrimaryButton(
                        btnWidth: 150.w,
                        isLoading: _suspenseRepaymentReportListController.isExportLoading.value,
                        text: 'Export',
                        onPressed: () {
                          _suspenseRepaymentReportListController.exportData(context);
                        }))
                  ],
                ),
              ),
              SuspenseRepaymentReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _suspenseRepaymentReportListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    rowsPerPage: _suspenseRepaymentReportListController
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
                                        'Suspense Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Payment Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Payment Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Paid Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Denomination',
                                        style: TextPalette.tableHeaderTextStyle,
                                      ))
                                    ],
                                    source: _DataSource(context,
                                        _suspenseRepaymentReportListController.tableData.value),
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
                value: _suspenseRepaymentReportListController.itemsPerPage.value,
                onChanged: (value) {
                  _suspenseRepaymentReportListController.itemsPerPage(value);
                  _suspenseRepaymentReportListController.getsuspenserepaymentreportList(context);
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
              'Page ${_suspenseRepaymentReportListController.page.value} of ${_suspenseRepaymentReportListController.totalpages.value}',
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
                onPressed: _suspenseRepaymentReportListController.page.value > 1
                    ? () {
                        if (_suspenseRepaymentReportListController.page.value > 1) {
                          _suspenseRepaymentReportListController
                              .page(_suspenseRepaymentReportListController.page.value - 1);
                          _suspenseRepaymentReportListController.getsuspenserepaymentreportList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _suspenseRepaymentReportListController.page.value <
                        _suspenseRepaymentReportListController.totalpages.value
                    ? () {
                        if (_suspenseRepaymentReportListController.page.value <
                            _suspenseRepaymentReportListController.totalpages.value) {
                          _suspenseRepaymentReportListController
                              .page(_suspenseRepaymentReportListController.page.value + 1);
                          _suspenseRepaymentReportListController.getsuspenserepaymentreportList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<SuspenseRepaymentReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final SuspenseRepaymentReportListController _suspenseRepaymentReportListController =
      Get.put(SuspenseRepaymentReportListController());

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
          row.suspenseId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.paymentId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
            DateHelper.convertDate(row.paymentDate.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.customerDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.paidAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(
          IconButton(onPressed: () async {
            await Get.dialog(SuspenseRepaymentReportTable(denominationList: row.denomination!));
          }, icon: Icon(Icons.visibility))
        )
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
