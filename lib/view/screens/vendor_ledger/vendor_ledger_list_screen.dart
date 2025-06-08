import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/controller/vendor_ledger/vendor_ledger_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/vendor_ledger/vendor_ledger_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_ledger/vendor_ledger_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_ledger/vendor_ledger_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorLedgerListScreen extends StatefulWidget {
  @override
  State<VendorLedgerListScreen> createState() => _VendorLedgerListScreenState();
}

class _VendorLedgerListScreenState extends State<VendorLedgerListScreen> {
  final VendorLedgerListController _vendorLedgerListController =
      Get.put(VendorLedgerListController());

  @override
  void initState() {
    super.initState();
    _vendorLedgerListController.getvendorledgerList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _vendorLedgerListController.scaffoldKey,
       onRefresh: () {
        _vendorLedgerListController.getvendorledgerList(context);
      },
      child: Scaffold(
       key: _vendorLedgerListController.scaffoldKey,
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
                  children: [
                    Text(
                      "Vendor Ledger",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _vendorLedgerListController.getvendorledgerList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              VendorLedgerTotalViews(),
              VendorLedgerTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _vendorLedgerListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _vendorLedgerListController
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
                                        'Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                        DataColumn(
                                          label: Text(
                                        'Refference Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Transaction Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                          DataColumn(
                                          label: Text(
                                        'Transaction Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Is Cancelled',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Transaction Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _vendorLedgerListController.tableData.value),
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
                value: _vendorLedgerListController.itemsPerPage.value,
                onChanged: (value) {
                  _vendorLedgerListController.itemsPerPage(value);
                  _vendorLedgerListController.getvendorledgerList(context);
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
              'Page ${_vendorLedgerListController.page.value} of ${_vendorLedgerListController.totalpages.value}',
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
                onPressed: _vendorLedgerListController.page.value > 1
                    ? () {
                        if (_vendorLedgerListController.page.value > 1) {
                          _vendorLedgerListController
                              .page(_vendorLedgerListController.page.value - 1);
                          _vendorLedgerListController.getvendorledgerList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _vendorLedgerListController.page.value <
                        _vendorLedgerListController.totalpages.value
                    ? () {
                        if (_vendorLedgerListController.page.value <
                            _vendorLedgerListController.totalpages.value) {
                          _vendorLedgerListController
                              .page(_vendorLedgerListController.page.value + 1);
                          _vendorLedgerListController.getvendorledgerList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<VendorLedgerListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CounterFormController _counterFormController =
      Get.put(CounterFormController());
  final VendorLedgerListController _vendorLedgerListController =
      Get.put(VendorLedgerListController());

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
          row.vendorDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
          DataCell(Text(
          row.refferenceNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.transactionType.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.transactionWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(
            Text(
           row.isCanceled! ? "yes" : "No",
          style: TextStyle(fontWeight:FontWeight.w600,fontSize: 15.sp,color: row.isCanceled! ? Colors.red : Colors.green),
        )),
        DataCell(Text(
          row.transactionAmount.toString(),
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
