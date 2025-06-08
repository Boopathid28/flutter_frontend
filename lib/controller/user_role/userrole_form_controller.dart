import 'package:ausales_application/controller/user_role/userrole_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/user_role/user_role_models.dart';
import 'package:ausales_application/service/user_role/user_role_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserroleFormController extends GetxController {
  final UserroleListController _userroleListController =
      Get.put(UserroleListController());

  final userroleFormKey = GlobalKey<FormState>();

  Rx<UserRoleListData?> currentUser = Rx<UserRoleListData?>(null);

  TextEditingController roleNameController = TextEditingController();

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  Future submitUserRoleForm(BuildContext context) async {
    if (userroleFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        if (fromMode.value == "create") {
          final CreateUserRolePayload payload = CreateUserRolePayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              roleName: roleNameController.text);

          await UserRoleService.createUserRole(
              context: context, payload: payload);
          _userroleListController.getUserRole();
        } else {
          final UpdateUserRolePayload payload = UpdateUserRolePayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            roleName: roleNameController.text,
            id: currentUser.value?.id,
          );

          await UserRoleService.updateUserRole(context: context, payload: payload);
          _userroleListController.getUserRole();
        }
        resetForm();
      }
    }
  }

  resetForm() {
    userroleFormKey.currentState!.reset();
    currentUser.value = null;
    fromMode("create");
  }
}