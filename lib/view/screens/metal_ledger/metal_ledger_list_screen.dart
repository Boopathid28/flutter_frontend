import 'package:ausales_application/controller/customer/customer_form_controller.dart';
import 'package:ausales_application/controller/metal_ledger/metal_ledger_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/metal_ledger/metal_ledger_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_ledger/metal_ledger_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_ledger/metal_ledger_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalLedgerListScreen extends StatefulWidget {
  @override
  State<MetalLedgerListScreen> createState() => _MetalLedgerListScreenState();
}

class _MetalLedgerListScreenState extends State<MetalLedgerListScreen> {
  final MetalLedgerListController _metalLedgerListController =
      Get.put(MetalLedgerListController());
  final CustomerFormController _customerFormController =
      Get.put(CustomerFormController());

  @override
  void initState() {
    super.initState();
    _metalLedgerListController.getmetalledgerList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _metalLedgerListController.scaffoldKey,
       onRefresh: () {
        _metalLedgerListController.getmetalledgerList(context);
      },
      child: Scaffold(
        key: _metalLedgerListController.scaffoldKey,
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
                          "Metal Ledger",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _metalLedgerListController.getmetalledgerList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                  ],
                ),
              ),
              MetalLedgerTotalView(),
              MetalLedgerHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _metalLedgerListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    rowsPerPage: _metalLedgerListController
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
                                        'Metal Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Old Ledger Entry Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Entry Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Touch',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Is Cancelled',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Reference Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _metalLedgerListController
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
                value: _metalLedgerListController.itemsPerPage.value,
                onChanged: (value) {
                  _metalLedgerListController.itemsPerPage(value);
                  _metalLedgerListController.getmetalledgerList(context);
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
              'Page ${_metalLedgerListController.page.value} of ${_metalLedgerListController.totalpages.value}',
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
                onPressed: _metalLedgerListController.page.value > 1
                    ? () {
                        if (_metalLedgerListController.page.value > 1) {
                          _metalLedgerListController
                              .page(_metalLedgerListController.page.value - 1);
                          _metalLedgerListController.getmetalledgerList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _metalLedgerListController.page.value <
                        _metalLedgerListController.totalpages.value
                    ? () {
                        if (_metalLedgerListController.page.value <
                            _metalLedgerListController.totalpages.value) {
                          _metalLedgerListController
                              .page(_metalLedgerListController.page.value + 1);
                          _metalLedgerListController.getmetalledgerList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<MetalLedgerListResponse> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final MetalLedgerListController _metalLedgerListController =
      Get.put(MetalLedgerListController());

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
          row.metalDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.vendorDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.oldLedgerEntryType.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.entryDate!),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.touch.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.isCancelled! ? "Cancelled" : "Active",
          style: TextStyle(
            color: row.isCancelled! ? Colors.green : Colors.red,
            fontSize: 16.sp
          ),
        )),
         DataCell(Text(
          row.weight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
           DataCell(Text(
          row.refferenceNumber.toString(),
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