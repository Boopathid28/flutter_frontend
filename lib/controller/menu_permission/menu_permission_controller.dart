import 'dart:developer';

import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/menu_permission/menu_permission_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/menu_permission/menu_permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPermissionController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchRoleController = TextEditingController();

  RxList<MenuPermissionDataModel> permissionList =
      <MenuPermissionDataModel>[].obs;

  RxBool isTableLoading = true.obs;

  Rx<DropdownModel?> selectedUserRole = Rx<DropdownModel?>(null);

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;

  RxBool allPermit = false.obs;
  RxBool modulePermit = false.obs;
  RxBool viewPermit = false.obs;
  RxBool addPermit = false.obs;
  RxBool editPermit = false.obs;
  RxBool deletePermit = false.obs;

  Future<bool> getAllPermit() async {
    await Future.delayed(const Duration(seconds: 1));
    return allPermit.value;
  }

  @override
  void onInit() {
    super.onInit();
    getUserRoleList();
  }

  Future getUserRoleList() async {
    final List<UserRoleDropdownModel> tempList =
        await DropdownService.userRoleDropDown();
    userRoleDropDown([]);
    tempList.forEach((item) {
      userRoleDropDown
          .add(DropdownModel(label: item.roleName!, value: item.id.toString()));
    });
    selectedUserRole(DropdownModel(
        label: tempList[0].roleName!, value: tempList[0].id.toString()));
    getMenuPermissionList(tempList[0].id.toString());
  }

  Future getMenuPermissionList(String userRole) async {
    isTableLoading(true);
    final MenuPermissionDataResponse? data =
        await MenuPermissionService.getRoleBasedPermisionList(userRole);

    if (data != null) {
      permissionList(data.list);
      allPermit(data.allPermit);
      modulePermit(data.modulePermit);
      viewPermit(data.viewPermit);
      addPermit(data.addPermit);
      editPermit(data.editPermit);
      deletePermit(data.deletePermit);
    } else {
      permissionList([]);
      allPermit(false);
      modulePermit(false);
      viewPermit(false);
      addPermit(false);
      editPermit(false);
      deletePermit(false);
    }

    isTableLoading(false);
  }

  Future updatePermission(MenuPermissionDataModel item, String permission,
      bool value, BuildContext context) async {
    if (permission == 'module') {
      final ChangeMenuPermissionPayload payload = ChangeMenuPermissionPayload(
          menu: item.menu,
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          role: selectedUserRole.value!.value.toString(),
          modulePermit: value,
          viewPermit: item.viewPermit,
          addPermit: item.addPermit,
          editPermit: item.editPermit,
          deletePermit: item.deletePermit);
      await MenuPermissionService.updateMenuPermissionStatus(
          payload: payload, context: context);
      getMenuPermissionList(selectedUserRole.value!.value);
    } else if (permission == 'view') {
      final ChangeMenuPermissionPayload payload = ChangeMenuPermissionPayload(
          menu: item.menu,
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          role: selectedUserRole.value!.value.toString(),
          modulePermit: item.modulePermit,
          viewPermit: value,
          addPermit: item.addPermit,
          editPermit: item.editPermit,
          deletePermit: item.deletePermit);
      await MenuPermissionService.updateMenuPermissionStatus(
          payload: payload, context: context);
      getMenuPermissionList(selectedUserRole.value!.value);
    } else if (permission == 'add') {
      final ChangeMenuPermissionPayload payload = ChangeMenuPermissionPayload(
          menu: item.menu,
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          role: selectedUserRole.value!.value.toString(),
          modulePermit: item.modulePermit,
          viewPermit: item.viewPermit,
          addPermit: value,
          editPermit: item.editPermit,
          deletePermit: item.deletePermit);
      await MenuPermissionService.updateMenuPermissionStatus(
          payload: payload, context: context);
      getMenuPermissionList(selectedUserRole.value!.value);
    } else if (permission == 'edit') {
      final ChangeMenuPermissionPayload payload = ChangeMenuPermissionPayload(
          menu: item.menu,
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          role: selectedUserRole.value!.value.toString(),
          modulePermit: item.modulePermit,
          viewPermit: item.viewPermit,
          addPermit: item.editPermit,
          editPermit: value,
          deletePermit: item.deletePermit);
      await MenuPermissionService.updateMenuPermissionStatus(
          payload: payload, context: context);
      getMenuPermissionList(selectedUserRole.value!.value);
    } else if (permission == 'delete') {
      final ChangeMenuPermissionPayload payload = ChangeMenuPermissionPayload(
          menu: item.menu,
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          role: selectedUserRole.value!.value.toString(),
          modulePermit: item.modulePermit,
          viewPermit: item.viewPermit,
          addPermit: item.editPermit,
          editPermit: item.editPermit,
          deletePermit: value);
      await MenuPermissionService.updateMenuPermissionStatus(
          payload: payload, context: context);
      getMenuPermissionList(selectedUserRole.value!.value);
    } else if (permission == 'all') {
      final ChangeMenuPermissionPayload payload = ChangeMenuPermissionPayload(
          menu: item.menu,
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          role: selectedUserRole.value!.value.toString(),
          modulePermit: value,
          viewPermit: value,
          addPermit: value,
          editPermit: value,
          deletePermit: value);
      await MenuPermissionService.updateMenuPermissionStatus(
          payload: payload, context: context);
      getMenuPermissionList(selectedUserRole.value!.value);
    }
  }

  Future updateMenuAllEnablePermission(
      BuildContext context, bool value, int type) async {
    final MenuAllPermissionPayload payload = MenuAllPermissionPayload(
        menuId: await HomeSharedPrefs.getCurrentMenu(),
        role: selectedUserRole.value!.value.toString(),
        value: value,
        type: type);

    await MenuPermissionService.updateMenuAllPermissionStatus(
        payload: payload, context: context);
    getMenuPermissionList(selectedUserRole.value!.value);
  }
}
