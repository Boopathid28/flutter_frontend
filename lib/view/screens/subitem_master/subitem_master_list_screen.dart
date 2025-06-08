import 'package:ausales_application/controller/designer/designer_form_controller.dart';
import 'package:ausales_application/controller/subitem_master/subitem_form_controller.dart';
import 'package:ausales_application/controller/subitem_master/subitem_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/subitem_master/subitem_master_service.dart';
import 'package:ausales_application/view/screens/subitem_master/subitem_master_tag_items_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/subitem_master/subitem_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/subitem_master/subitem_master_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/subitem_master/subitem_master_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubitemMasterListScreen extends StatefulWidget {
  @override
  State<SubitemMasterListScreen> createState() => _SubitemMasterListScreenState();
}

class _SubitemMasterListScreenState extends State<SubitemMasterListScreen> {
  final SubitemMasterListController _subitemMasterListController =
      Get.put(SubitemMasterListController());

  final DesignerFormController _designerFormController =
      Get.put(DesignerFormController());

  @override
  void initState() {
    super.initState();
    _subitemMasterListController.getSubItemList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _subitemMasterListController.scaffoldKey,
      onRefresh: () {
        _subitemMasterListController.getSubItemList(context);
      },
      child: Scaffold(
        key: _subitemMasterListController.scaffoldKey,
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
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            "Sub Item",
                            style: TextPalette.screenTitle,
                          ),
                          SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _subitemMasterListController.getSubItemList(context);
                        },
                        icon: Icon(Icons.refresh))
                        ],
                      ),
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
                                  SubitemMasterForm());
                            })),
                    
                  ],
                ),
              ),
              SubitemMasterTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _subitemMasterListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _subitemMasterListController
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
                                        'Sub Item Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Sub Item Code',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Item',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Stock Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Calculation Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Active',
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
                                        _subitemMasterListController
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
                value: _subitemMasterListController.itemsPerPage.value,
                onChanged: (value) {
                  _subitemMasterListController.itemsPerPage(value);
                  _subitemMasterListController.getSubItemList(context);
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
              'Page ${_subitemMasterListController.page.value} of ${_subitemMasterListController.totalpages.value}',
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
                onPressed: _subitemMasterListController.page.value > 1
                    ? () {
                        if (_subitemMasterListController.page.value > 1) {
                          _subitemMasterListController
                              .page(_subitemMasterListController.page.value - 1);
                          _subitemMasterListController.getSubItemList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _subitemMasterListController.page.value <
                        _subitemMasterListController.totalpages.value
                    ? () {
                        if (_subitemMasterListController.page.value <
                            _subitemMasterListController.totalpages.value) {
                          _subitemMasterListController
                              .page(_subitemMasterListController.page.value + 1);
                          _subitemMasterListController.getSubItemList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<SubItemListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final SubitemFormController _subitemFormController =
      Get.put(SubitemFormController());
  final SubitemMasterListController _subitemMasterListController =
      Get.put(SubitemMasterListController());

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
          row.subItemCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.itemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.stockType.toString().split('_').join(' '),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.calculationType.toString().split('_').join(' '),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(
          Tooltip(message: "Update Sub Item Status",child: CustomSwitch(value: row.isActive, onChanged:(index) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                await SubitemMasterService.updateSubItemStatus(
                    menuId: menuId.toString(),
                    subItemId: row.id.toString(),
                    context: context);
              }
              _subitemMasterListController.getSubItemList(context);
            } ),),
        ),
        DataCell(Row(
          children: [
            Tooltip(
              message: "View Sub Item",
              child: GestureDetector(
                onTap: () async {
                  _subitemFormController.getSubItemViewDetails(context, row);
                  
                },
                child: Icon(Icons.visibility)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(message: "View Tag Details",
            child: GestureDetector(
                onTap: () {
                  Get.to(() => SubitemMasterTagItemsScreen(), arguments: [row.id, row.subItemName, row.subItemCode]);
                },
                child: Icon(Icons.document_scanner)),),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Edit Sub Item",
              child: IconButton(onPressed:  () {
                  _subitemFormController.getSubItemDetails(context, row);
                },
            icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete Sub Item",
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => SubitemDeletePopup(item: row));
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
