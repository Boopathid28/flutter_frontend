import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/tag_master/tag_master_model.dart';
import 'package:ausales_application/model/user_role/user_role_models.dart';
import 'package:ausales_application/service/user_role/user_role_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserroleListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    RxList<UserRoleListData> userroleList = <UserRoleListData>[].obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController metalSearchFilterController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;

  RxList<DropdownModel> activeStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Inactive', label: 'Inactive')].obs;


  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<TagMasterListData> tableData = <TagMasterListData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }


  Future getUserRole() async {
    userroleList([]);
    final List<UserRoleListData> userRoleDataList =
        await UserRoleService.getUserRole();
    userroleList(userRoleDataList);
  }
 
}
