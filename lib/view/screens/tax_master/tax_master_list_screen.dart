import 'package:ausales_application/controller/tax_master/tax_form_controller.dart';
import 'package:ausales_application/controller/tax_master/tax_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/tax/tax_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/tax_master/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/tax_master/tax_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/tax_master/tax_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/tax_master/view_tax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TaxMasterListScreen extends StatefulWidget {
  @override
  State<TaxMasterListScreen> createState() => _taxListScreenState();
}

class _taxListScreenState extends State<TaxMasterListScreen> {
  final TaxListController _taxListController = Get.put(TaxListController());
  final TaxFormController _taxFormController = Get.put(TaxFormController());

  @override
  void initState() {
    super.initState();
    _taxListController.getTaxList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _taxListController.scaffoldKey,
      onRefresh: () {
        _taxListController.getTaxList(context);
      },
      child: GestureDetector(
        child: Scaffold(
          key: _taxListController.scaffoldKey,
          appBar: PreferredSize(
            child: HeaderWidget(),
            preferredSize: Size.fromHeight(100.0),
          ),
          backgroundColor: ColorPalete.appBgColor,
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
                            "Tax",
                            style: TextPalette.screenTitle,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                              onPressed: () {
                                _taxListController.getTaxList(context);
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
                                await Get.dialog(
                                    barrierDismissible: false,
                                    TaxFormPopup());
                              })),
                    ],
                  ),
                ),
                TaxTableHeader(),
                Container(
                  height: 550.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Stack(
                    children: [
                      Obx(() => _taxListController.isTableLoading.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                              child: LinearProgressIndicator(),
                            )
                          : ListView(
                              children: [
                                Obx(() => PaginatedDataTable(
                                      showEmptyRows: false,
                                      rowsPerPage:
                                          _taxListController.itemsPerPage.value,
                                      headingRowColor: WidgetStateProperty
                                          .resolveWith<Color?>(
                                              (Set<WidgetState> states) =>
                                                  ColorPalete
                                                      .tableHeaderBgColor),
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                          'S.No',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Taxname',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Taxcode',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'MetalName',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Action',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                      ],
                                      source: _DataSource(context,
                                          _taxListController.tableData.value),
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
                value: _taxListController.itemsPerPage.value,
                onChanged: (value) {
                  _taxListController.itemsPerPage(value);
                  _taxListController.getTaxList(context);
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
              'Page ${_taxListController.page.value} of ${_taxListController.totalpages.value}',
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
                onPressed: _taxListController.page.value > 1
                    ? () {
                        if (_taxListController.page.value > 1) {
                          _taxListController
                              .page(_taxListController.page.value - 1);
                          _taxListController.getTaxList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _taxListController.page.value <
                        _taxListController.totalpages.value
                    ? () {
                        if (_taxListController.page.value <
                            _taxListController.totalpages.value) {
                          _taxListController
                              .page(_taxListController.page.value + 1);
                          _taxListController.getTaxList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<TaxListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final TaxFormController _taxFormController = Get.put(TaxFormController());
  final TaxListController _taxListController = Get.put(TaxListController());

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
          row.taxName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.taxCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.metalName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "view tax",
              child: GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                        TaxViewpopup(tax: row));
                  },
                  child: Icon(Icons.remove_red_eye)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "edit tax",
              child: IconButton(
                onPressed: () async {
                  _taxFormController.taxNameController.text = row.taxName!;
                  _taxFormController.taxCodeController.text = row.taxCode!;
                  _taxFormController.purchasecgstController.text =
                      row.purchaseCgst.toString();
                  _taxFormController.purchaseigstController.text =
                      row.purchaseIgst.toString();
                  _taxFormController.purchasesgstController.text =
                      row.purchaseSgst.toString();
                  _taxFormController.salescgstController.text =
                      row.salesCgst.toString();
                  _taxFormController.salesigstController.text =
                      row.salesIgst.toString();
                  _taxFormController.salessgstController.text =
                      row.salesSgst.toString();
                  _taxFormController.selectedMetal(DropdownModel(
                      value: row.metal.toString(), label: row.metalName!));
                  _taxFormController.currentTax(row);
                  _taxFormController.fromMode("update");
                  await Get.dialog(
                    barrierDismissible: false,
                    TaxFormPopup(),
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "delete tax",
              child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => TaxDeletepopup(tax: row));
                  },
                  child: Icon(Icons.delete)),
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
