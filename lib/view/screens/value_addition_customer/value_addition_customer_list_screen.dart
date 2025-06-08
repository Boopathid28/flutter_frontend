import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_form_controller.dart';
import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/value_addition_customer/value_addition_customer_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/screens/value_addition_customer/value_addition_customer_form_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/value_addition_customer/value_addition_customer_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/value_addition_customer/value_addition_customer_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionCustomerListScreen extends StatefulWidget {
  @override
  State<ValueAdditionCustomerListScreen> createState() =>
      _ValueAdditionCustomerListScreenState();
}

class _ValueAdditionCustomerListScreenState
    extends State<ValueAdditionCustomerListScreen> {
  final ValueAdditionCustomerListController
      _valueAdditionCustomerListController =
      Get.put(ValueAdditionCustomerListController());

  // final DesignerFormController _valueAdditionCustomerFormController =
  //     Get.put(DesignerFormController());

  @override
  void initState() {
    super.initState();
    _valueAdditionCustomerListController.getValueAdditionCustomerlist(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _valueAdditionCustomerListController.scaffoldKey,
      onRefresh: () {
        _valueAdditionCustomerListController
            .getValueAdditionCustomerlist(context);
      },
      child: GestureDetector(
        child: Scaffold(
          key: _valueAdditionCustomerListController.scaffoldKey,
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
                    child: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: valueadditon(context),
                              ),
                              addbtn(context),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: valueadditon(context),
                              ),
                              addbtn(context),
                            ],
                          )),
                ValueAdditionCustomerTableHeader(),
                Container(
                  height: 550.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Stack(
                    children: [
                      Obx(() => _valueAdditionCustomerListController
                              .isTableLoading.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                              child: LinearProgressIndicator(),
                            )
                          : ListView(
                              children: [
                                Obx(() => PaginatedDataTable(
                                      showEmptyRows: false,
                                      rowsPerPage:
                                          _valueAdditionCustomerListController
                                              .itemsPerPage.value,
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
                                          'Sub Item Name',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'From Weight',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'To Weight',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Created By',
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
                                      source: _DataSource(
                                          context,
                                          _valueAdditionCustomerListController
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
      ),
    );
  }

  SizedBox addbtn(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: "ADD +",
            onPressed: () async {
              await Get.dialog(
                  barrierDismissible: false,
                  ValueAdditionCustomerFormScreen());
            }));
  }

  Row valueadditon(BuildContext context) {
    return Row(
      children: [
        Text(
          "Value Addition Customer",
          style: TextPalette.screenTitle,
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
            onPressed: () {
              _valueAdditionCustomerListController
                  .getValueAdditionCustomerlist(context);
            },
            icon: Icon(Icons.refresh))
      ],
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
                value: _valueAdditionCustomerListController.itemsPerPage.value,
                onChanged: (value) {
                  _valueAdditionCustomerListController.itemsPerPage(value);
                  _valueAdditionCustomerListController
                      .getValueAdditionCustomerlist(context);
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
              'Page ${_valueAdditionCustomerListController.page.value} of ${_valueAdditionCustomerListController.totalpages.value}',
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
                onPressed: _valueAdditionCustomerListController.page.value > 1
                    ? () {
                        if (_valueAdditionCustomerListController.page.value >
                            1) {
                          _valueAdditionCustomerListController.page(
                              _valueAdditionCustomerListController.page.value -
                                  1);
                          _valueAdditionCustomerListController
                              .getValueAdditionCustomerlist(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _valueAdditionCustomerListController.page.value <
                        _valueAdditionCustomerListController.totalpages.value
                    ? () {
                        if (_valueAdditionCustomerListController.page.value <
                            _valueAdditionCustomerListController
                                .totalpages.value) {
                          _valueAdditionCustomerListController.page(
                              _valueAdditionCustomerListController.page.value +
                                  1);
                          _valueAdditionCustomerListController
                              .getValueAdditionCustomerlist(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ValueAdditionCustomerData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ValueAdditionCustomerFormController
      _valueAdditionCustomerFormController =
      Get.put(ValueAdditionCustomerFormController());
  final ValueAdditionCustomerListController
      _valueAdditionCustomerListController =
      Get.put(ValueAdditionCustomerListController());

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
          row.subItemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.fromWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.toWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "Edit VA Customer",
              child: IconButton(
                onPressed: () {
                  _valueAdditionCustomerFormController
                      .getValueAdditionCustomerDetails(context, row);
                },
                icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete VA Customer",
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          ValueAdditionCustomerDeletePopup(item: row));
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
