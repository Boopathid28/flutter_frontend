import 'package:ausales_application/controller/suspense/suspense_form_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_list_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/screens/suspense/suspense_form_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/suspense_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/suspense_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseListScreen extends StatefulWidget {
  @override
  State<SuspenseListScreen> createState() => _SuspenseListScreenState();
}

class _SuspenseListScreenState extends State<SuspenseListScreen> {
  final SuspenseListController _suspenseListController =
      Get.put(SuspenseListController());

       final SuspenseFormController _suspenseFormController =
      Get.put(SuspenseFormController());

  @override
  void initState() {
    super.initState();
    _suspenseListController.getsuspenseList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _suspenseListController.scaffoldKey,
      onRefresh: () {
        _suspenseListController.getsuspenseList(context);
      },
      child: Scaffold(
        key: _suspenseListController.scaffoldKey,
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
                          "Suspense",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _suspenseListController.getsuspenseList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(
                        width: 100.w,
                        child: PrimaryButton(
                            btnHeight: 46.h,
                            isLoading: false,
                            text: "ADD +",
                            onPressed: () async {
                              Get.to(() => SuspenseFormScreen());
                            })),
                  ],
                ),
              ),
              SuspenseTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _suspenseListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _suspenseListController
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
                                        'Bill Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Redeem Status',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Cancel Status',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Closing Status',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Closed Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created At',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _suspenseListController.tableData.value),
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
                value: _suspenseListController.itemsPerPage.value,
                onChanged: (value) {
                  _suspenseListController.itemsPerPage(value);
                  _suspenseListController.getsuspenseList(context);
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
              'Page ${_suspenseListController.page.value} of ${_suspenseListController.totalpages.value}',
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
                onPressed: _suspenseListController.page.value > 1
                    ? () {
                        if (_suspenseListController.page.value > 1) {
                          _suspenseListController
                              .page(_suspenseListController.page.value - 1);
                          _suspenseListController.getsuspenseList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _suspenseListController.page.value <
                        _suspenseListController.totalpages.value
                    ? () {
                        if (_suspenseListController.page.value <
                            _suspenseListController.totalpages.value) {
                          _suspenseListController
                              .page(_suspenseListController.page.value + 1);
                          _suspenseListController.getsuspenseList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<SuspenseListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

        final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

  final SuspenseListController _suspenseListController = Get.put(SuspenseListController());

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
          row.billNumber??"-",
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.customerDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.isRedeemed! ? "Redeem" : "Not Redeem",
          style:TextStyle(
            color: row.isRedeemed! ? Colors.green : Colors.red,
            fontSize: 16.sp
          ),
        )),
        DataCell(Text(
          row.isCancelled! ? "Cancelled" : "Active",
          style:TextStyle(
            color: row.isCancelled! ? Colors.green : Colors.red,
            fontSize: 16.sp
          ),
        )),
        DataCell(Text(
          row.isClosed! ? "Closed" : "Active",
          style:TextStyle(
            color: row.isCancelled! ? Colors.green : Colors.red,
            fontSize: 16.sp
          ),
        )),
        DataCell(Text(
          DateHelper.convertDate(row.closedDate.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.createdAt.toString()),
        )),
        DataCell(Row(
          children: [
            
           Tooltip(
            message: "View Suspense",
            child:  Obx(() => _suspenseListController.isViewDetailsLoading.value == index.toString() ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(),) : IconButton(onPressed: () {
              _suspenseListController
                      .getSuspenseDetails(context, row, index.toString());
            }, icon:  Icon(Icons.visibility))),
           ),
            SizedBox(
              width: 5.w,
            ),
            Tooltip(
              message: "Payment",
              child: IconButton(onPressed: () {
              _suspensePaymentController
                      .getSuspenseDetails(context, row);
            }, icon: Icon(Icons.payment)),
            ),
            SizedBox(
              width: 5.w,
            ),
            Tooltip(
              message: "Cancel Suspense",
              child: IconButton(onPressed: () async{
              await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => SuspenseDeletePopup(item: row));
            }, icon: Icon(Icons.cancel)),
            ),
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
