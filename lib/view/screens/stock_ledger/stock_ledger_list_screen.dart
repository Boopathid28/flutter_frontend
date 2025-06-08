import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/controller/stock_ledger/stock_ledger_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/stock_ledger/stock_ledger_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_ledger/stock_ledger_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_ledger/stock_ledger_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockLedgerListScreen extends StatefulWidget {
  @override
  State<StockLedgerListScreen> createState() => _StockLedgerListScreenState();
}

class _StockLedgerListScreenState extends State<StockLedgerListScreen> {
  final StockLedgerListController _stockLedgerListController =
      Get.put(StockLedgerListController());

  @override
  void initState() {
    super.initState();
    _stockLedgerListController.getstockledgerList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _stockLedgerListController.scaffoldKey,
      onRefresh: () {
        _stockLedgerListController.getstockledgerList(context);
      },
      child: Scaffold(
        key: _stockLedgerListController.scaffoldKey,
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
                      "Stock Ledger",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _stockLedgerListController
                              .getstockledgerList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              StockLedgerTotalView(),
              StockLedgerTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _stockLedgerListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                 showEmptyRows: false,
                                    rowsPerPage: _stockLedgerListController
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
                                        'Tag Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Metal',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Purity',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Stock Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Item Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Sub Item',
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
                                      DataColumn(
                                          label: Text(
                                        'Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _stockLedgerListController
                                            .tableData.value),
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
                value: _stockLedgerListController.itemsPerPage.value,
                onChanged: (value) {
                  _stockLedgerListController.itemsPerPage(value);
                  _stockLedgerListController.getstockledgerList(context);
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
              'Page ${_stockLedgerListController.page.value} of ${_stockLedgerListController.totalpages.value}',
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
                onPressed: _stockLedgerListController.page.value > 1
                    ? () {
                        if (_stockLedgerListController.page.value > 1) {
                          _stockLedgerListController
                              .page(_stockLedgerListController.page.value - 1);
                          _stockLedgerListController
                              .getstockledgerList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _stockLedgerListController.page.value <
                        _stockLedgerListController.totalpages.value
                    ? () {
                        if (_stockLedgerListController.page.value <
                            _stockLedgerListController.totalpages.value) {
                          _stockLedgerListController
                              .page(_stockLedgerListController.page.value + 1);
                          _stockLedgerListController
                              .getstockledgerList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<StockLedgerListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;
  final StockLedgerListController _stockLedgerListController =
      Get.put(StockLedgerListController());

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
          row.tagNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.metal.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.purity.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.stockType.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.item.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.subItem.toString(),
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
         DataCell(Text(
          row.vendor.toString(),
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
