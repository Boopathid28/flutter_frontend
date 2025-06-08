import 'package:ausales_application/controller/customer/customer_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCreationCommonController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final CustomerListController _customerListController =
      Get.put(CustomerListController());

  final customerCommonFormKey = GlobalKey<FormState>();

  TextEditingController customerNamecontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController searchCustomerGroupController = TextEditingController();

  Rx<DropdownModel?> selectedCustomergroup = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> customergroupDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getCustomergroupList();
    final bool branch = await getIsBranchUser();
    if (branch) {
      getBranchList();
    }
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
  Future getCustomergroupList() async {
    final List<CustomergroupDropdownModel> tempList =
        await DropdownService.customergroupDropDown(isfilter: isFilter);
    customergroupDropDown([]);
    tempList.forEach((item) {
      customergroupDropDown.add(
          DropdownModel(label: item.customerGroup!, value: item.id.toString()));
    });
  }

  resetForm() {
    isFormSubmit.value = false;
    customerCommonFormKey.currentState!.reset();
    selectedCustomergroup.value = null;
    selectedBranch.value = null;
    customerNamecontroller.clear();
    mobilenumbercontroller.clear();
    addresscontroller.clear();
    fromMode("create");
  }
}
