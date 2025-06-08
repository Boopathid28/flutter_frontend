import 'dart:developer';

import 'package:ausales_application/controller/approval_issues/approval_issues_form_controller.dart';
import 'package:ausales_application/controller/approval_issues/approval_issues_list_controller.dart';
import 'package:ausales_application/controller/direct_issues/direct_issues_form_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/stock_assign/stock_assign_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/stock_assign/stock_assign_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class DirectIssuesTagFormController extends HeaderController {
  @override
  // TODO: implement isBranchusers
  RxBool get isBranchuser => super.isBranchuser;
  final DirectIssuesFormController _directIssuesFormController =
      Get.put(DirectIssuesFormController());
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController tagSearchController = TextEditingController();

  TextEditingController tagnumController = TextEditingController();
  RxObjectMixin<ItemTagdetailsList> tableData = ItemTagdetailsList().obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> tagnumberDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedTag = Rx<DropdownModel?>(null);

  RxString stoneFormMode = "create".obs;
  RxString stoneFormUpdateId = "".obs;
  RxBool isTableLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    } else {
      getTagnumberList(null);
    }
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getTagnumberList(String? branch) async {
    tagnumberDropDown([]);

    final List<TagNumberDropdownModel> tempList =
        await DropdownService.TagNumberDropDown(branch);
    for (var item in tempList) {
      tagnumberDropDown.add(
          DropdownModel(label: item.tagNumber!, value: item.id.toString()));
    }
  }

  Future getTagItemList(String? tagnumber, BuildContext context) async {
    log((_directIssuesFormController.itemtagParticularList
        .indexWhere((item) => item.tagNumber == tagnumber)).toString());

    if ((_directIssuesFormController.itemtagParticularList
            .indexWhere((item) => item.tagNumber == tagnumber) ==
        -1)) {
      int? menuId = await HomeSharedPrefs.getCurrentMenu();
      final response = await StockAssignService.getTagItemdetails(
          context: context, tagnumber: tagnumber);

      if (response != null) {
        tableData(ItemTagdetailsList.fromJson(response['data']));
        var uuid = Uuid();

        final ItemTagdetailsList itemTagListData = ItemTagdetailsList(
            sNo: uuid.v4(),
            tagNumber: tableData.value.tagNumber,
            id: tableData.value.id,
            subItemDetailsName: tableData.value.subItemDetailsName);
        _directIssuesFormController.itemtagParticularList
            .insert(0, itemTagListData);
      }
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.error,
          title: Text('This tag number already exsists'),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  void deleteItemtag(BuildContext context, String index) {
    _directIssuesFormController.itemtagParticularList
        .removeWhere((item) => item.sNo == index);
    Get.back();
  }

  resetForm() {
    selectedTag.value = null;
    selectedBranch.value = null;
    _directIssuesFormController.itemtagParticularList([]);
  }
}
