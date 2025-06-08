import 'dart:math';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/melting_receipt/melting_receipt_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/melting_receipt/melting_receipt_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/melting_receipt/melting_receipt_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeltingReceiptFormController extends HeaderController {
  final MeltingReceiptListController _meltingReceiptListController =
      Get.put(MeltingReceiptListController());
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final meltingreceiptFormKey = GlobalKey<FormState>();

  TextEditingController searchVendorDesignerController =
      TextEditingController();
  TextEditingController searchBagController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> vendordesignerdropdown = <DropdownModel>[].obs;
  RxList<DropdownModel> bagdropdown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedvendorDesiner = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedbag = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    } else {
      getbagdetails(null);
    }
    getVendorDesignerList();
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

  Future getVendorDesignerList() async {
    vendordesignerdropdown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      vendordesignerdropdown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
  }

  Future getbagdetails(String? branch) async {
    bagdropdown([]);
    final List<BagDropDownModel> tempList = await DropdownService.bagDropDown(branchId: branch);
    tempList.forEach((item) {
      bagdropdown.add(
          DropdownModel(label: item.bagNumber!, value: item.id.toString()));
    });
  }

  Future CreateMeltingReceipt(BuildContext context) async {
    if (meltingreceiptFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        CreateMeltingReceiptPayload payload = CreateMeltingReceiptPayload(
            vendorDetails: selectedvendorDesiner.value?.value,
            bagDetails: selectedbag.value?.value,
            branch: selectedBranch.value?.value,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final Map<String, dynamic>? CreateMeltingReceiptList =
            await MeltingReceiptService.createMeltingReceiptList(
                payload: payload, context: context);
        _meltingReceiptListController.getmeltingReceiptList(context);
        resetForm();
        Get.back();
        isFormSubmit(false);
      }
    }
  }

  resetForm() {
    selectedBranch.value = null;
    selectedbag.value = null;
    selectedvendorDesiner.value = null;
  }
}
