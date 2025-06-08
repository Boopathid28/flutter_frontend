import 'package:ausales_application/controller/user/user_form_controller.dart';
import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/user/user_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/user/user_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/user/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/user/password_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/user/user_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/user/user_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserListController _userListController = Get.put(UserListController());

  @override
  void initState() {
    super.initState();
    _userListController.getUserList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _userListController.scaffoldKey,
      onRefresh: () {
        _userListController.getUserList(context);
      },
      child: Scaffold(
        key: _userListController.scaffoldKey,
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
                      "Users",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _userListController.getUserList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              UserForm(),
              UserTableHeader(),
              Container(
                height: 550,
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _userListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage:
                                        _userListController.itemsPerPage.value,
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
                                        'User ID',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Username',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Role',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Active',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Session Count',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Session Timeout',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Last Login',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _userListController.tableData.value),
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
                value: _userListController.itemsPerPage.value,
                onChanged: (value) {
                  _userListController.itemsPerPage(value);
                  _userListController.getUserList(context);
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
              'Page ${_userListController.page.value} of ${_userListController.totalpages.value}',
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
                onPressed: _userListController.page.value > 1
                    ? () {
                        if (_userListController.page.value > 1) {
                          _userListController
                              .page(_userListController.page.value - 1);
                          _userListController.getUserList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _userListController.page.value <
                        _userListController.totalpages.value
                    ? () {
                        if (_userListController.page.value <
                            _userListController.totalpages.value) {
                          _userListController
                              .page(_userListController.page.value + 1);
                          _userListController.getUserList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<UserListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final UserFormController _userFormController = Get.put(UserFormController());
  final UserListController _userListController = Get.put(UserListController());

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
          row.id.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.username.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.roleName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
       
        DataCell(Tooltip(
          message: "update user status",
          child: CustomSwitch(
            value: row.isActive,
            onChanged: (value) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                await UserService.updateUserStatus(
                    menuId: menuId.toString(),
                    userId: row.id.toString(),
                    context: context);
              }
              _userListController.getUserList(context);
            },
          ),
        )),
        // DataCell(CustomSwitch(
        //   value: row.isAdmin,
        //   onChanged: (value) async {
        //     int? menuId = await HomeSharedPrefs.getCurrentMenu();
        //     if (menuId != null) {
        //       await UserService.updateUserAdminStatus(
        //           menuId: menuId.toString(),
        //           userId: row.id.toString(),
        //           context: context);
        //     }
        //     _userListController.getUserList(context);
        //   },
        // )),
        DataCell(Text(
          row.sessionCount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          "${(row.sessionTimeout! / 60).round().toString()} Min",
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.lastLogin.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "change user password",
              child: GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                            PasswordPopup(userId: row.id.toString()));
                  },
                  child: Icon(Icons.lock_reset)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "edit user",
              child: IconButton(
                onPressed: () {
                  _userFormController.usernameController.text = row.username!;
                  _userFormController.sessionCountController.text =
                      row.sessionCount!.toString();
                  _userFormController.sessionTimeOutController.text =
                      (row.sessionTimeout! / 60).round().toString();
                  _userFormController.selectedUserRole(DropdownModel(
                      value: row.role.toString(), label: row.roleName!));
                  if (_userListController.isBranchuser.value) {
                    _userFormController.selectedBranch(DropdownModel(
                        value: row.branch.toString(),
                        label: row.branchName.toString()));
                  }
                  _userFormController.currentUser(row);
                  _userFormController.fromMode("update");
                },
                icon: Icon(Icons.edit),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "delete user",
              child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => DeletePopup(user: row));
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
