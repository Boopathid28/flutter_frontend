import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateItemtagBranchFormController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController lotNoSearchController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedLot = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> lotDropDown = <DropdownModel>[].obs;


  RxBool isContinueLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    // if (branch == true) {
    //   getBranchList();
    // } 
    // else {
      getLotList(null);
    // }
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

  Future getLotList(String? branch) async {
    selectedLot.value = null;
    lotDropDown([]);
    final List<LotListDropdownModel> tempList =
        await DropdownService.lotListDropDown(branch);
    tempList.forEach((item) {
      lotDropDown
          .add(DropdownModel(label: item.lotNumber.toString(), value: item.id.toString()));
    });
  }
  resetform() {
    selectedLot.value =null ;
  }

}