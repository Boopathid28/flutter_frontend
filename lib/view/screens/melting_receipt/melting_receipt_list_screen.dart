import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/controller/melting_receipt/melting_receipt_list_controller.dart';
import 'package:ausales_application/controller/melting_receipt/update_melting_receipt_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/melting_receipt/melting_receipt_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/melting_receipt/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/melting_receipt/melting_receipt_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/melting_receipt/melting_receipt_form_update.dart';
import 'package:ausales_application/view/widgets/screen_widgets/melting_receipt/melting_receipt_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MeltingReceiptScreen extends StatefulWidget {
  @override
  State<MeltingReceiptScreen> createState() => _MeltingReceiptScreenState();
}

class _MeltingReceiptScreenState extends State<MeltingReceiptScreen> {
  final MeltingReceiptListController _meltingReceiptListController =
      Get.put(MeltingReceiptListController());


  @override
  void initState() {
    super.initState();
    _meltingReceiptListController.getmeltingReceiptList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _meltingReceiptListController.scaffoldKey,
      onRefresh: () {
        _meltingReceiptListController.getmeltingReceiptList(context);
      },
      child: Scaffold(
        key: _meltingReceiptListController.scaffoldKey,
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
                          "Melting",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _meltingReceiptListController
                                  .getmeltingReceiptList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(
                        width: 100.w,
                        child: Obx(() => PrimaryButton(
                            btnHeight: 46.h,
                            isLoading:
                                _meltingReceiptListController.isFormAdd.value,
                            text: "ADD+",
                            onPressed: () async {
                              await Get.dialog(
                                  barrierDismissible: false,
                                  MeltingReceiptForm());
                            }))),
                  ],
                ),
              ),
              MeltingReceiptHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _meltingReceiptListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _meltingReceiptListController
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
                                        'Melting Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Issued Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Vendor Charge',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Is Received',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Is Cancelled',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Is Received',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _meltingReceiptListController
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
                value: _meltingReceiptListController.itemsPerPage.value,
                onChanged: (value) {
                  _meltingReceiptListController.itemsPerPage(value);
                  _meltingReceiptListController.getmeltingReceiptList(context);
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
              'Page ${_meltingReceiptListController.page.value} of ${_meltingReceiptListController.totalpages.value}',
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
                onPressed: _meltingReceiptListController.page.value > 1
                    ? () {
                        if (_meltingReceiptListController.page.value > 1) {
                          _meltingReceiptListController.page(
                              _meltingReceiptListController.page.value - 1);
                          _meltingReceiptListController
                              .getmeltingReceiptList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _meltingReceiptListController.page.value <
                        _meltingReceiptListController.totalpages.value
                    ? () {
                        if (_meltingReceiptListController.page.value <
                            _meltingReceiptListController.totalpages.value) {
                          _meltingReceiptListController.page(
                              _meltingReceiptListController.page.value + 1);
                          _meltingReceiptListController
                              .getmeltingReceiptList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<MeltingReceiptListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;
  final MeltingReceiptListController _meltingReceiptListController =
      Get.put(MeltingReceiptListController());
      
  final UpdateMeltingReceiptFormController _updateMeltingReceiptFormController =
      Get.put(UpdateMeltingReceiptFormController());

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
          row.meltingId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(
            row.issueDate.toString(),
          ),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.vendorCharges.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.bagNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.isCancelled! ? "True" : "False",
           style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: !row.isCancelled! ? Colors.red : Colors.green),
        )),
        DataCell(Text(
          row.isReceived! ? "True" : "False",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: !row.isReceived! ? Colors.red : Colors.green),
        )),
        DataCell(Row(
          children: [
            GestureDetector(
              onTap: () async {
                _updateMeltingReceiptFormController.currentMelting(row);
                await Get.dialog(
                  barrierDismissible: false,
                  MeltingReceiptFormUpdate(),
                );
              },
              child: Icon(Icons.receipt),
            ),
            GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      MeltingReceiptDeletePopup(melting: row));
                },
                child: Icon(Icons.delete)),
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
