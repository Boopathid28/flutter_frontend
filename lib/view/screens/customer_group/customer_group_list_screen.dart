import 'package:ausales_application/controller/customer_group/customer_group_form_controller.dart';
import 'package:ausales_application/controller/customer_group/customer_group_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/customer_group/customer_group_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/customer_group/customer_group_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer_group/customer_group_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer_group/customer_group_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer_group/delete_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomergroupListScreen extends StatefulWidget {
  @override
  State<CustomergroupListScreen> createState() => _CustomergroupListState();
}

class _CustomergroupListState extends State<CustomergroupListScreen> {
  final CustomerGroupListController _customerGroupListController =
      Get.put(CustomerGroupListController());

  @override
  void initState() {
    super.initState();
    _customerGroupListController.getcustomergrouplist(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _customerGroupListController.scaffoldKey,
      onRefresh: () {
        _customerGroupListController.getcustomergrouplist(context);
      },
      child: Scaffold(
        key: _customerGroupListController.scaffoldKey,
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
                      "Customer Group",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _customerGroupListController
                              .getcustomergrouplist(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              CustomerGroupForm(),
              CustomerGroupTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _customerGroupListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _customerGroupListController
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
                                        'CustomerGroupname',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
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
                                        _customerGroupListController
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
                value: _customerGroupListController.itemsPerPage.value,
                onChanged: (value) {
                  _customerGroupListController.itemsPerPage(value);
                  _customerGroupListController.getcustomergrouplist(context);
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
              'Page ${_customerGroupListController.page.value} of ${_customerGroupListController.totalpages.value}',
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
                onPressed: _customerGroupListController.page.value > 1
                    ? () {
                        if (_customerGroupListController.page.value > 1) {
                          _customerGroupListController.page(
                              _customerGroupListController.page.value - 1);
                          _customerGroupListController
                              .getcustomergrouplist(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _customerGroupListController.page.value <
                        _customerGroupListController.totalpages.value
                    ? () {
                        if (_customerGroupListController.page.value <
                            _customerGroupListController.totalpages.value) {
                          _customerGroupListController.page(
                              _customerGroupListController.page.value + 1);
                          _customerGroupListController
                              .getcustomergrouplist(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<CustomergroupListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CustomerGroupFormController _customerGroupFormController =
      Get.put(CustomerGroupFormController());
  final CustomerGroupListController _customerGroupListController =
      Get.put(CustomerGroupListController());

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
          row.customerGroupName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(
          Tooltip(
            message: "Update Customer Group Staus",
            child: CustomSwitch(
            value: row.isActive,
            onChanged: (index) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                await CustomerGroupService.updateCustomerGroupStatus(
                    menuId: menuId.toString(),
                    customergroupId: row.id.toString(),
                    context: context);
              }
              _customerGroupListController.getcustomergrouplist(context);
            }),
          )
        ),
        DataCell(Row(
          children: [
            Tooltip(
              message: "Edit Customer Group",
              child: IconButton(
                onPressed: () {
                  _customerGroupFormController.customergroupcontroller.text =
                      row.customerGroupName!;
                  _customerGroupFormController.currentCustomergroup(row);
                  _customerGroupFormController.fromMode("update");
                },
                icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete Customer Group",
              child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                     
                          CustomerGroupDeletePopup(customergroup: row));
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
