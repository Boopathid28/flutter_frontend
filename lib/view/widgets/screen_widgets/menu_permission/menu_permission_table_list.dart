import 'package:ausales_application/controller/menu_permission/menu_permission_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:load_switch/load_switch.dart';

class MenuPermissionTableList extends StatefulWidget {
  const MenuPermissionTableList({super.key});

  @override
  State<MenuPermissionTableList> createState() =>
      _MenuPermissionTableListState();
}

class _MenuPermissionTableListState extends State<MenuPermissionTableList> {
  final MenuPermissionController _menuPermissionController =
      Get.put(MenuPermissionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _menuPermissionController.isTableLoading.value
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: LinearProgressIndicator(),
          )
        : Container(
          height: 650.h,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(horizontal: 15.w),
          padding: EdgeInsets.all(5.w),
          child: ListView(
            shrinkWrap: true,
            children: [
              Obx(() => DataTable(
                    headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) =>
                            ColorPalete.tableHeaderBgColor),
                    columns: [
                      DataColumn(
                          label: Text(
                        'S No',
                        style: TextPalette.tableHeaderTextStyle,
                      )),
                      DataColumn(
                          label: Text(
                        'Menu Name',
                        style: TextPalette.tableHeaderTextStyle,
                      )),
                      DataColumn(
                          label: Row(
                        children: [
                          Text(
                            'All',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: _menuPermissionController.allPermit.value,
                              onChanged: (bool? value) {
                                _menuPermissionController
                                  .updateMenuAllEnablePermission(
                                      context, value!, 6);
                              },
                            )
                        ],
                      )),
                      DataColumn(
                          label: Row(
                        children: [
                          Text(
                            'Module',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: _menuPermissionController.modulePermit.value,
                              onChanged: (bool? value) {
                                _menuPermissionController
                                  .updateMenuAllEnablePermission(
                                      context, value!, 1);
                              },
                            )
                        ],
                      )),
                      DataColumn(
                          label: Row(
                        children: [
                          Text(
                            'View',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: _menuPermissionController.viewPermit.value,
                              onChanged: (bool? value) {
                                _menuPermissionController
                                  .updateMenuAllEnablePermission(
                                      context, value!, 2);
                              },
                            )
                        ],
                      )),
                      DataColumn(
                          label: Row(
                        children: [
                          Text(
                            'Add',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: _menuPermissionController.addPermit.value,
                              onChanged: (bool? value) {
                                _menuPermissionController
                                  .updateMenuAllEnablePermission(
                                      context, value!, 3);
                              },
                            )
                        ],
                      )),
                      DataColumn(
                          label: Row(
                        children: [
                          Text(
                            'Edit',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: _menuPermissionController.editPermit.value,
                              onChanged: (bool? value) {
                                _menuPermissionController
                                  .updateMenuAllEnablePermission(
                                      context, value!, 4);
                              },
                            )
                        ],
                      )),
                      DataColumn(
                          label: Row(
                        children: [
                          Text(
                            'Delete',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: _menuPermissionController.deletePermit.value,
                              onChanged: (bool? value) {
                                _menuPermissionController
                                  .updateMenuAllEnablePermission(
                                      context, value!, 5);
                              },
                            )
                        ],
                      )),
                    ],
                    rows: _menuPermissionController.permissionList.value
                        .map((row) {
                      return DataRow(
                          color: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) => row.sNo! % 2 == 0
                                  ? ColorPalete.tableHeaderBgColor
                                  : Colors.white),
                          cells: [
                            DataCell(Text(
                              row.sNo.toString(),
                              style: TextPalette.tableDataTextStyle,
                            )),
                            DataCell(Text(
                              row.menuName.toString(),
                              style: TextPalette.tableDataTextStyle,
                            )),
                            DataCell(Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: row.allPermission,
                              onChanged: (bool? value) {
                                _menuPermissionController.updatePermission(
                                    row, 'all', value!, context);
                              },
                            )),
                            DataCell(Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: row.modulePermit,
                              onChanged: (bool? value) {
                                _menuPermissionController.updatePermission(
                                    row, 'module', value!, context);
                              },
                            )),
                            DataCell(Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: row.viewPermit,
                              onChanged: (bool? value) {
                                _menuPermissionController.updatePermission(
                                    row, 'view', value!, context);
                              },
                            )),
                            DataCell(Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: row.addPermit,
                              onChanged: (bool? value) {
                                _menuPermissionController.updatePermission(
                                    row, 'add', value!, context);
                              },
                            )),
                            DataCell(Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: row.editPermit,
                              onChanged: (bool? value) {
                                _menuPermissionController.updatePermission(
                                    row, 'edit', value!, context);
                              },
                            )),
                            DataCell(Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) =>
                                          ColorPalete.primaryBtnColor),
                              value: row.deletePermit,
                              onChanged: (bool? value) {
                                _menuPermissionController.updatePermission(
                                    row, 'delete', value!, context);
                              },
                            )),
                          ]);
                    }).toList(),
                  )),
            ],
          ),
        ));
  }
}
