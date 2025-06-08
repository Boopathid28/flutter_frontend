import 'package:ausales_application/controller/value_addition_designer/value_addition_designer_form_controller.dart';
import 'package:ausales_application/controller/value_addition_designer/value_addition_designer_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/value_addition_designer/value_addition_designer_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/value_addition_designer/value_addition_designer_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/value_addition_designer/value_addition_designer_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/value_addition_designer/value_addition_designer_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionDesignerListScreen extends StatefulWidget {
  @override
  State<ValueAdditionDesignerListScreen> createState() =>
      _ValueAdditionDesignerListScreenState();
}

class _ValueAdditionDesignerListScreenState
    extends State<ValueAdditionDesignerListScreen> {
  final ValueAdditionDesignerListController
      _valueAdditionDesignerListController =
      Get.put(ValueAdditionDesignerListController());

  // final DesignerFormController _valueAdditionDesignerFormController =
  //     Get.put(DesignerFormController());

  @override
  void initState() {
    super.initState();
    _valueAdditionDesignerListController.getValueAdditionDesignerlist(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _valueAdditionDesignerListController.scaffoldKey,
      onRefresh: () {
        _valueAdditionDesignerListController
            .getValueAdditionDesignerlist(context);
      },
      child: GestureDetector(
        child: Scaffold(
          key: _valueAdditionDesignerListController.scaffoldKey,
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
                ValueAdditionDesignerTableHeader(),
                Container(
                  height: 550.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Stack(
                    children: [
                      Obx(() => _valueAdditionDesignerListController
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
                                          _valueAdditionDesignerListController
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
                                          'Designer Name',
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
                                          'Calculation Type',
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
                                          _valueAdditionDesignerListController
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
                  ValueAdditionDesignerForm());
            }));
  }

  Row valueadditon(BuildContext context) {
    return Row(
      children: [
        Text(
          "Value Addition Designer",
          style: TextPalette.screenTitle,
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
            onPressed: () {
              _valueAdditionDesignerListController
                  .getValueAdditionDesignerlist(context);
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
                value: _valueAdditionDesignerListController.itemsPerPage.value,
                onChanged: (value) {
                  _valueAdditionDesignerListController.itemsPerPage(value);
                  _valueAdditionDesignerListController
                      .getValueAdditionDesignerlist(context);
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
              'Page ${_valueAdditionDesignerListController.page.value} of ${_valueAdditionDesignerListController.totalpages.value}',
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
                onPressed: _valueAdditionDesignerListController.page.value > 1
                    ? () {
                        if (_valueAdditionDesignerListController.page.value >
                            1) {
                          _valueAdditionDesignerListController.page(
                              _valueAdditionDesignerListController.page.value -
                                  1);
                          _valueAdditionDesignerListController
                              .getValueAdditionDesignerlist(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _valueAdditionDesignerListController.page.value <
                        _valueAdditionDesignerListController.totalpages.value
                    ? () {
                        if (_valueAdditionDesignerListController.page.value <
                            _valueAdditionDesignerListController
                                .totalpages.value) {
                          _valueAdditionDesignerListController.page(
                              _valueAdditionDesignerListController.page.value +
                                  1);
                          _valueAdditionDesignerListController
                              .getValueAdditionDesignerlist(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ValueAdditionListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ValueAdditionDesignerFormController
      _valueAdditionDesignerFormController =
      Get.put(ValueAdditionDesignerFormController());
  final ValueAdditionDesignerListController
      _valueAdditionDesignerListController =
      Get.put(ValueAdditionDesignerListController());

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
          row.designerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.subItemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.calculationType.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "Edit Designer",
              child: IconButton(
                onPressed: () {
                  _valueAdditionDesignerFormController
                      .getValueAdditionDesignerDetails(context, row);
                },
                icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete Designer",
              child: IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          ValueAdditionDesignerDeletePopup(item: row));
                },
                icon: Icon(Icons.delete)),
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
