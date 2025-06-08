import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/controller/stock_assign/stock_assign_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/stock_assign/stock_assign_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_assign/stock_assign_catalog_filter.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_assign/stock_assign_form_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class StockAssignListScreen extends StatefulWidget {
  @override
  State<StockAssignListScreen> createState() => _StockAssignListScreenState();
}

class _StockAssignListScreenState extends State<StockAssignListScreen> {
  final StockAssignListController _stockAssignListcontroller =
      Get.put(StockAssignListController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _stockAssignListcontroller.scaffoldKey,
      onRefresh: () {
        
      },
      child: Scaffold(
        key: _stockAssignListcontroller.scaffoldKey,
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
                    Text(
                      "Stock Assign",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                     SizedBox(
                          width: 100.w,
                          child: PrimaryButton(
                              btnHeight: 46.h,
                              isLoading: false,
                              text: "ADD +",
                              onPressed: () async {
                                if (_stockAssignListcontroller.selectedCatalog.value != null) {
                                  await Get.dialog(
                                    barrierDismissible: false,
                                    StockAssignFormPopup());
                                } else {
                                  toastification.show(
                                    context: context, // optional if you use ToastificationWrapper
                                    type: ToastificationType.info,
                                    title: Text("Select catalogue first!"),
                                    autoCloseDuration: notificationDuration,
                                    showProgressBar: false,
                                    pauseOnHover: false);
                                }
                              })),
                  ],
                ),
              ),
              StockAssignCatalogFilter(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _stockAssignListcontroller.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _stockAssignListcontroller
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
                                        'Catalog Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Tag Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Catalog Type',
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
                                        'Net Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      ))
                                    ],
                                    source: _DataSource(context,
                                        _stockAssignListcontroller.tableData.value),
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
                value: _stockAssignListcontroller.itemsPerPage.value,
                onChanged: (value) {
                  _stockAssignListcontroller.itemsPerPage(value);
                  // _stockAssignListcontroller.getstockList(context);
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
              'Page ${_stockAssignListcontroller.page.value} of ${_stockAssignListcontroller.totalpages.value}',
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
                onPressed: _stockAssignListcontroller.page.value > 1
                    ? () {
                        if (_stockAssignListcontroller.page.value > 1) {
                          _stockAssignListcontroller
                              .page(_stockAssignListcontroller.page.value - 1);
                          // _stockAssignListcontroller.getcounterList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _stockAssignListcontroller.page.value <
                        _stockAssignListcontroller.totalpages.value
                    ? () {
                        if (_stockAssignListcontroller.page.value <
                            _stockAssignListcontroller.totalpages.value) {
                          _stockAssignListcontroller
                              .page(_stockAssignListcontroller.page.value + 1);
                          // _stockAssignListcontroller.getcounterList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<StockAssignListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CounterFormController _counterFormController =
      Get.put(CounterFormController());
  final StockAssignListController _stockAssignListcontroller =
      Get.put(StockAssignListController());

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
          row.catalogNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.tagNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.catalogTypeName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.availablePieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.availableGrossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.availableNetWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        ))
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
