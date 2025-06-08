import 'dart:developer';

import 'package:ausales_application/controller/company_ledger/company_ledger_form_controller.dart';
import 'package:ausales_application/controller/company_ledger/company_ledger_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/company_ledger/comany_ledger_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/company_ledger/company_ledger_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/company_ledger/company_ledger_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/company_ledger/company_ledger_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/company_ledger/delete_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyLedgerListScreen extends StatefulWidget {
  @override
  State<CompanyLedgerListScreen> createState() => _CompanyLedgerListScreenState();
}

class _CompanyLedgerListScreenState extends State<CompanyLedgerListScreen> {
  final CompanyLedgerListController _companyLedgerListController =
      Get.put(CompanyLedgerListController());

       final CompanyLedgerFormController _companyLedgerFormController =
      Get.put(CompanyLedgerFormController());

  @override
  void initState() {
    super.initState();
    _companyLedgerListController.getcompanyledgerList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _companyLedgerListController.scaffoldKey,
      onRefresh: () {
        _companyLedgerListController.getcompanyledgerList(context);
      },
      child: Scaffold(
        key: _companyLedgerListController.scaffoldKey,
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
                          "Company Ledger",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _companyLedgerListController.getcompanyledgerList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                     Row(
                       children: [
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                             btnHeight: 46.h,
                          isLoading: _companyLedgerListController.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _companyLedgerListController.exportData(context);
                          })),
                          SizedBox(width: 10.w,),
                         SizedBox(
                            width: 100.w,
                            child: Obx(() => PrimaryButton(
                                btnHeight: 46.h,
                                isLoading:
                                    _companyLedgerFormController.isForm.value,
                                text: "ADD+",
                                onPressed: () async {
                                  await Get.dialog(
                                      barrierDismissible: false,
                                      CompanyLedgerForm());
                                }))),
                       ],
                     ),
                  ],
                ),
              ),
              CompanyLedgerTotalViews(),
              CompanyLedgerTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _companyLedgerListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _companyLedgerListController
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
                                        'Expense Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Expense Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Expense Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Sub Expense Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Payment Method',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Is Cancelled',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _companyLedgerListController.tableData.value),
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
                value: _companyLedgerListController.itemsPerPage.value,
                onChanged: (value) {
                  _companyLedgerListController.itemsPerPage(value);
                  _companyLedgerListController.getcompanyledgerList(context);
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
              'Page ${_companyLedgerListController.page.value} of ${_companyLedgerListController.totalpages.value}',
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
                onPressed: _companyLedgerListController.page.value > 1
                    ? () {
                        if (_companyLedgerListController.page.value > 1) {
                          _companyLedgerListController
                              .page(_companyLedgerListController.page.value - 1);
                          _companyLedgerListController.getcompanyledgerList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _companyLedgerListController.page.value <
                        _companyLedgerListController.totalpages.value
                    ? () {
                        if (_companyLedgerListController.page.value <
                            _companyLedgerListController.totalpages.value) {
                          _companyLedgerListController
                              .page(_companyLedgerListController.page.value + 1);
                          _companyLedgerListController.getcompanyledgerList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<CompanyLedgerListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CompanyLedgerFormController _companyLedgerFormController =
      Get.put(CompanyLedgerFormController());
  final CompanyLedgerListController _companyLedgerListController =
      Get.put(CompanyLedgerListController());

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
          row.expenseId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.expensesName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.expensesType.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.subExpensesName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.paymentMethod.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.amount!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.createdAt!.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
         DataCell(Text(
          row.isCanceled! ? "Cancelled" : "Active",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: row.isCanceled! ? Colors.green : Colors.red),
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(message: "Print Ledger",child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      CompanyLedgerPrintout(companyId: row.id!.toString()));
                },
                child: Icon(Icons.print)),),
            SizedBox(width: 10,),
            Tooltip(message: "Cancel Ledger",child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      CompanyLedgerDeletePopup(comany: row));
                },
                child: Icon(Icons.delete)),),
          ],
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
