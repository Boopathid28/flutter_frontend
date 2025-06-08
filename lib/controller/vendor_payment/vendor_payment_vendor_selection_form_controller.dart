import 'dart:developer';

import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPaymentVendorSelectionFormController extends GetxController {

  TextEditingController vendorSearchController = TextEditingController();

  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;

  RxBool isContinueLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    getVendorList();
  }

  Future getVendorList() async {
    vendorDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      vendorDropDown
          .add(DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
  }

}