import 'dart:io';

import 'package:ausales_application/controller/stock_list/stock_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/stock_list/stock_list_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_list/stock_list_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

class StockListScreen extends StatefulWidget {
  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  final StockListController _stockListController =
      Get.put(StockListController());

  Future exportToExcel() async {
    // Create a new Excel document
    var excel = Excel.createExcel();

    // Create a new sheet
    Sheet sheetObject = excel['stock list'];
                
    // Add data to the sheet
    List<List<TextCellValue>> data = [
      [
         TextCellValue('Tag Number'),
         TextCellValue('Metal'),
         TextCellValue('Purity'),
         TextCellValue('Branch'),
         TextCellValue('Stock Type'),
         TextCellValue('Item'),
         TextCellValue('Sub Item'),
         TextCellValue('Vendor'),
         TextCellValue('Date'),
         TextCellValue('Calculation Type'),
         TextCellValue('Is Billed')
      ]
    ];

    for (var i in _stockListController.tableData.value) {
      data.add([
        TextCellValue(i.tagNumber.toString()),
        TextCellValue(i.metalName.toString()),
        TextCellValue(i.purityName.toString()),
        TextCellValue(i.branchName.toString()),
        TextCellValue(i.stockTypeName.toString()),
        TextCellValue(i.itemName.toString()),
        TextCellValue(i.subItemName.toString()),
        TextCellValue(i.vendorName.toString()),
        TextCellValue(i.taggedAt.toString()),
        TextCellValue(i.calculationTypeName.toString()),
        TextCellValue(i.isBilled! ? "yes" : "no"),
      ]);
    }

    for (var row in data) {
      sheetObject.appendRow(row);
    }

    var fileBytes = excel.save();
    try {
      var directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}/stocklist.xlsx";
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.success,
          title: Text('File Saved ${filePath}'),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    } catch (e) {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.error,
          title: Text('File not saved'),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  @override
  void initState() {
    super.initState();
    _stockListController.getstockList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _stockListController.scaffoldKey,
      onRefresh: () {
        _stockListController.getstockList(context);
      },
      child: Scaffold(
        key: _stockListController.scaffoldKey,
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
                              "Stock List",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _stockListController
                                  .getstockList(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _stockListController.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _stockListController.exportData(context);
                          }))
                      ],
                    ),
             ),
              StockListTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _stockListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage:
                                        _stockListController.itemsPerPage.value,
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
                                        'Billed',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch Name',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
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
                                        'Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Calculation Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _stockListController.tableData.value),
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
                value: _stockListController.itemsPerPage.value,
                onChanged: (value) {
                  _stockListController.itemsPerPage(value);
                  _stockListController.getstockList(context);
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
              'Page ${_stockListController.page.value} of ${_stockListController.totalpages.value}',
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
                onPressed: _stockListController.page.value > 1
                    ? () {
                        if (_stockListController.page.value > 1) {
                          _stockListController
                              .page(_stockListController.page.value - 1);
                          _stockListController.getstockList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _stockListController.page.value <
                        _stockListController.totalpages.value
                    ? () {
                        if (_stockListController.page.value <
                            _stockListController.totalpages.value) {
                          _stockListController
                              .page(_stockListController.page.value + 1);
                          _stockListController.getstockList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<StockListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;
  final StockListController _stockListController =
      Get.put(StockListController());

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
        DataCell(Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                row.tagNumber.toString(),
                style: TextPalette.tableDataTextStyle,
              ),
            ),
            IconButton(
                iconSize: 20.sp,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: row.tagNumber.toString()));
                },
                icon: Icon(
                  Icons.copy,
                  color: ColorPalete.primaryColor,
                ))
          ],
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
          row.isBilled! ? "Yes" : "No",
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.stockTypeName.toString(),
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
          row.vendorName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.taggedAt.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.calculationTypeName.toString(),
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
