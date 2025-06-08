import 'package:ausales_application/controller/advance/advance_list_controller.dart';
import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/advance/advance_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/advance/advance_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/advance/delete_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvanceListScreen extends StatefulWidget {
  @override
  State<AdvanceListScreen> createState() => _AdvanceListScreenState();
}

class _AdvanceListScreenState extends State<AdvanceListScreen> {
  final AdvanceListController _advanceListController =
      Get.put(AdvanceListController());

  @override
  void initState() {
    super.initState();
    _advanceListController.getAdvanceList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _advanceListController.scaffoldKey,
      onRefresh: () {
        _advanceListController.getAdvanceList(context);
      },
      child: Scaffold(
        key: _advanceListController.scaffoldKey,
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
                          "Advance",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _advanceListController.getAdvanceList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(
                        width: 100.w,
                        child: Obx(() => PrimaryButton(
                            btnHeight: 46.h,
                            isLoading: _advanceListController.isFormAdd.value,
                            text: "ADD+",
                            onPressed: () async {
                              await Get.dialog(
                                  barrierDismissible: false,
                                  AdvanceForm());
                            }))),
                  ],
                ),
              ),
              AdvanceTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _advanceListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _advanceListController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'Advance Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Advance Purpose',
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
                                        'Is Redeem',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _advanceListController.tableData.value),
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
                value: _advanceListController.itemsPerPage.value,
                onChanged: (value) {
                  _advanceListController.itemsPerPage(value);
                  _advanceListController.getAdvanceList(context);
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
              'Page ${_advanceListController.page.value} of ${_advanceListController.totalpages.value}',
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
                onPressed: _advanceListController.page.value > 1
                    ? () {
                        if (_advanceListController.page.value > 1) {
                          _advanceListController
                              .page(_advanceListController.page.value - 1);
                          _advanceListController.getAdvanceList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _advanceListController.page.value <
                        _advanceListController.totalpages.value
                    ? () {
                        if (_advanceListController.page.value <
                            _advanceListController.totalpages.value) {
                          _advanceListController
                              .page(_advanceListController.page.value + 1);
                          _advanceListController.getAdvanceList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<AdvanceListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CounterFormController _counterFormController =
      Get.put(CounterFormController());
  final AdvanceListController _advanceListController =
      Get.put(AdvanceListController());

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
        DataCell(Row(
          children: [
            Text(
              row.advanceId.toString(),
              style: TextPalette.tableDataTextStyle,
            ),
            SizedBox(width: 5.w,),
            IconButton(
                iconSize: 20.sp,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: row.advanceId.toString()));
                },
                icon: Icon(
                  Icons.copy,
                  color: ColorPalete.primaryColor,
                ))
          ],
        )),
        DataCell(Text(
          row.advancePurpose.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalAdvanceAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalAdvanceWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.isCancelled! ? "Cancelled" : "Active",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: !row.isCancelled! ? Colors.green : Colors.red),
        )),
        DataCell(Text(
          row.isRedeemed! ? "Redeem" : "Not Redeem",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: !row.isRedeemed! ? Colors.red : Colors.green),
        )),
        DataCell(Text(
          row.customerDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "print",
              child: Obx(() =>  _advanceListController.isAdvancePrintLoading.value == index.toString() ?
              SizedBox(width: 20.w, height: 20.w, child: CircularProgressIndicator(),) :
              IconButton(
                  onPressed: () async {
                    _advanceListController.getAdvanceDetails(context, index.toString(), row.id.toString(), true);
                  },
                  icon: Icon(Icons.print))),
            ),
            SizedBox(
              width: 5.w,
            ),
           Tooltip(
            message: "view advance",
             child: Obx(() =>  _advanceListController.isAdvanceRetrieveLoading.value == index.toString() ?
              SizedBox(width: 20.w, height: 20.w, child: CircularProgressIndicator(),) :
              IconButton(
                  onPressed: () async {
                    _advanceListController.getAdvanceDetails(context, index.toString(), row.id.toString(),false);
                  },
                  icon: Icon(Icons.visibility))),
           ),
            SizedBox(
              width: 5.w,
            ),
            Tooltip(
              message: "cancel advance",
              child: IconButton(
                  onPressed: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                        AdvanceDeletePopup(advance: row));
                  },
                  icon: Icon(Icons.cancel)),
            )
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
