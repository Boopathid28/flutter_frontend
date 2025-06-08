import 'dart:developer';

import 'package:ausales_application/controller/direct_issues/direct_issues_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/diamond_master/diamond_master_model.dart';
import 'package:ausales_application/model/direct_issues/direct_issues_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/service/direct_issues/direct_issues_services.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class DirectIssuesFormController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final DirectIssuesListController _directIssuesListController =
      Get.put(DirectIssuesListController());

  final directissuesFormKey = GlobalKey<FormState>();

  Rx<DiamondMasterListData?> currentApprovalIssues =
      Rx<DiamondMasterListData?>(null);

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchvendorController = TextEditingController();

  TextEditingController duedateController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  RxList<ItemTagdetailsList> itemtagParticularList = <ItemTagdetailsList>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getVendorList();
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

  Future getVendorList() async {
    vendorDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
  }

  Future gettagId(BuildContext context) async {
    if (itemtagParticularList.value.isNotEmpty) {
      Get.back();
    } else {
      toastification.show(
          type: ToastificationType.error,
          title: Text('Add tag Details'),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  Future submitApprovalIssuesForm(BuildContext context) async {
    if (directissuesFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;

        if (itemtagParticularList.value.isNotEmpty) {
          List<TagItemDetails> tagId = <TagItemDetails>[].obs;
          for (var i in itemtagParticularList.value) {
            TagItemDetails item = TagItemDetails(tagDetails: i.id);
            tagId.add(item);
          }
          final CreateDirectIssuesPayload payload =
              CreateDirectIssuesPayload(
                  menuId: await HomeSharedPrefs.getCurrentMenu(),
                  issueTo: selectedVendor.value!.value.toString(),
                  remarks: remarkController.text,
                  dueDate: duedateController.text,
                  branch: isBranchuser.value == true
                      ? selectedBranch.value!.value
                      : null,
                  tagItemDetails: tagId);

          await DirectIssuesServices.createDirectIssues(
              context: context, payload: payload);
          _directIssuesListController.getdirectissuesList(context);
          resetForm();
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.error,
              title: Text('Fill Tag Details'),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);

          isFormSubmit.value = false;     
        }
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    directissuesFormKey.currentState!.reset();
    selectedBranch.value = null;
    selectedVendor.value = null;
    remarkController.clear();
    itemtagParticularList([]);
    fromMode("create");
  }
}
