import 'package:ausales_application/controller/item_master/item_master_form_controller.dart';
import 'package:ausales_application/controller/item_master/item_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_master/item_master_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/item_master/item_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_master/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_master/item_master_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_master/item_master_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ItemMasterListScreen extends StatefulWidget {
  @override
  State<ItemMasterListScreen> createState() => _ItemMasterListScreenState();
}

class _ItemMasterListScreenState extends State<ItemMasterListScreen> {
  final ItemMasterListController _itemMasterListController =
      Get.put(ItemMasterListController());

  @override
  void initState() {
    super.initState();
    _itemMasterListController.getItemList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _itemMasterListController.scaffoldKey,
      onRefresh: () {
        _itemMasterListController.getItemList(context);
      },
      child: Scaffold(
        key: _itemMasterListController.scaffoldKey,
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
                  children: [
                    Text(
                      "Product Item",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _itemMasterListController.getItemList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              ItemMasterForm(),
              ItemMasterTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _itemMasterListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _itemMasterListController
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
                                        'Item Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Item Code',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Huid Charge',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Active',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Purity',
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
                                        _itemMasterListController
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
                value: _itemMasterListController.itemsPerPage.value,
                onChanged: (value) {
                  _itemMasterListController.itemsPerPage(value);
                  _itemMasterListController.getItemList(context);
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
              'Page ${_itemMasterListController.page.value} of ${_itemMasterListController.totalpages.value}',
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
                onPressed: _itemMasterListController.page.value > 1
                    ? () {
                        if (_itemMasterListController.page.value > 1) {
                          _itemMasterListController
                              .page(_itemMasterListController.page.value - 1);
                          _itemMasterListController.getItemList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _itemMasterListController.page.value <
                        _itemMasterListController.totalpages.value
                    ? () {
                        if (_itemMasterListController.page.value <
                            _itemMasterListController.totalpages.value) {
                          _itemMasterListController
                              .page(_itemMasterListController.page.value + 1);
                          _itemMasterListController.getItemList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ItemListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ItemMasterFormController _itemMasterFormController =
      Get.put(ItemMasterFormController());
  final ItemMasterListController _itemMasterListController =
      Get.put(ItemMasterListController());

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
          row.itemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.itemCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.huidCharges.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Tooltip(
          message: "Update Item Status",
          child: CustomSwitch(
            value: row.isActive,
            onChanged: (index) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                await ProductItemService.updateItemStatus(
                    menuId: menuId.toString(),
                    itemId: row.id.toString(),
                    context: context);
              }
              _itemMasterListController.getItemList(context);
            }),
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.purityName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(message: "Edit Item",
            child: IconButton(
                onPressed: () {
                  _itemMasterFormController.itemNameController.text =
                      row.itemName!;
                  _itemMasterFormController.itemCodeController.text =
                      row.itemCode!;
                  _itemMasterFormController.huidChargeController.text =
                      row.huidCharges.toString()!;
                  _itemMasterFormController.selectedPurity(DropdownModel(
                      value: row.purity.toString(), label: row.purityName!));
                  _itemMasterFormController.currentItem(row);
                  _itemMasterFormController.fromMode("update");
                },
                icon: Icon(Icons.edit)),),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete Item",
              child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      ItemMasterDeletePopup(item: row));
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
