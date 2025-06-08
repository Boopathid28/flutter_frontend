import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/user/user_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFormController extends HeaderController {

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final UserListController _userListController = Get.put(UserListController());

  final userFormKey = GlobalKey<FormState>();

  TextEditingController branchSearchController = TextEditingController();

  Rx<UserListData?> currentUser = Rx<UserListData?>(null);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController sessionCountController = TextEditingController();
  TextEditingController sessionTimeOutController = TextEditingController();

  TextEditingController searchRoleController = TextEditingController();

  Rx<DropdownModel?> selectedUserRole = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxBool isPasswordVisible = false.obs;
  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserRoleList();
    getBranchList();
    getIsBranchUser();
  }

  Future getUserRoleList() async {
    userRoleDropDown([]);
    final List<UserRoleDropdownModel> tempList =
        await DropdownService.userRoleDropDown();
    tempList.forEach((item) {
      userRoleDropDown
          .add(DropdownModel(label: item.roleName!, value: item.id.toString()));
    });
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown
          .add(DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future submitUserForm(BuildContext context) async {
    if (userFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateUserPayload payload = CreateUserPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              password: passwordController.text.trim(),
              username: usernameController.text.trim(),
              branch: await AuthSharedPrefs.getBranch() ? selectedBranch.value!.value : null,
              isAdmin: false,
              sessionCount: sessionCountController.text,
              sessionTimeout: (int.parse(sessionTimeOutController.text) * 60).round().toString(),
              role: int.parse(selectedUserRole.value!.value));

          await UserService.createUser(context: context, payload: payload);
          _userListController.getUserList(context);
        } else {
          final UpdateUserPayload payload = UpdateUserPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              username: usernameController.text.trim(),
              id: currentUser.value?.id,
              branch: await AuthSharedPrefs.getBranch() ? selectedBranch.value!.value : null,
              isAdmin: currentUser.value!.isAdmin,
              sessionCount: sessionCountController.text,
              sessionTimeout: (int.parse(sessionTimeOutController.text) * 60).round().toString(),
              role: int.parse(selectedUserRole.value!.value));

          await UserService.updateUser(context: context, payload: payload);
          _userListController.getUserList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    userFormKey.currentState!.reset();
    selectedUserRole.value = null;
    selectedBranch.value = null;
    currentUser.value = null;
    fromMode("create");
  }
}
