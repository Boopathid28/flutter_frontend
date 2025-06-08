import 'dart:developer';

import 'package:ausales_application/controller/branchtransfer/branch_transfer_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/branch_transfer/branch_transfer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/service/branch_transfer_assign/branch_transfer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/stock_assign/stock_assign_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class BranchTransferFormController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final BranchTransferListController _branchTransferListController =
      Get.put(BranchTransferListController());
  TextEditingController frombranchSearchController = TextEditingController();
  TextEditingController tobranchSearchController = TextEditingController();
  TextEditingController tagSearchController = TextEditingController();

  TextEditingController tagnumController = TextEditingController();
  RxObjectMixin<ItemTagdetailsList> tableData = ItemTagdetailsList().obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> tagnumberDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedFormBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedToBranch = Rx<DropdownModel?>(null);
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
      getBranchList();
      getTagnumberList(null.toString());
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

  Future getTagnumberList(String branch) async {
    tagnumberDropDown([]);
    final List<TagNumberDropdownModel> tempList =
        await DropdownService.TagNumberDropDown(branch);
    for (var item in tempList) {
      tagnumberDropDown.add(
          DropdownModel(label: item.tagNumber!, value: item.id.toString()));
    }
  }

  Future getTagItemList(String? tagnumber, BuildContext context) async {
    int? menuId = await HomeSharedPrefs.getCurrentMenu();
    final response = await StockAssignService.getTagItemdetails(
        context: context, tagnumber: tagnumber);

    if (response != null) {
      tableData(ItemTagdetailsList.fromJson(response['data']));
      var uuid = Uuid();
      final ItemTagdetailsList itemTagListData = ItemTagdetailsList(
          sNo: uuid.v4(),
          tagNumber: tableData.value.tagNumber,
          subItemDetailsName: tableData.value.subItemDetailsName);
      _branchTransferListController.itemtagParticularList
          .insert(0, itemTagListData);
    }
  }

  Future CreateBranchTransfer(BuildContext context) async {
    List<int> templist = [];
    for (var i in _branchTransferListController.itemtagParticularList.value) {
      templist.add(int.parse(i.tagNumber!));
    }
    CreateBranchTransferPayload payload = CreateBranchTransferPayload(
        tags: templist,
        toBranch: selectedToBranch.value?.value,
        branch: selectedFormBranch.value?.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? CreateBranchTransfer =
        await BranchTransferService.createBranchTransfer(
            payload: payload, context: context);
    resetForm();
    Get.back();
    _branchTransferListController.itemtagParticularList([]);
    _branchTransferListController.getbranchTransferList(context);
    if(isBranchuser.value == true){
    tagnumberDropDown([]);
    }else{
      getTagnumberList(null.toString());
    }
  }

  void deleteItemtag(BuildContext context, String index) {
    _branchTransferListController.itemtagParticularList
        .removeWhere((item) => item.sNo == index);
    Get.back();
  }

  resetForm() {
    selectedTag.value = null;
    selectedToBranch.value = null;
    selectedFormBranch.value = null;
  }
}
