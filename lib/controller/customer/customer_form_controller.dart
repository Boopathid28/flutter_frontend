import 'dart:developer';

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

class CustomerFormController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final CustomerListController _customerListController =
      Get.put(CustomerListController());

  final customerFormKey = GlobalKey<FormState>();

  Rx<CustomerListData?> currentCustomer = Rx<CustomerListData?>(null);

  TextEditingController customerNamecontroller = TextEditingController();
  TextEditingController pannumbercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController maritalstatuscontroller = TextEditingController();
  TextEditingController upiidcontroller = TextEditingController();
  TextEditingController aadharnumbercontroller = TextEditingController();
  TextEditingController gstnumbercontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  TextEditingController searchCustomerController = TextEditingController();

  Rx<DropdownModel?> selectedCustomergroup = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMarriageStatus = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> customergroupDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> marriageStatusDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCustomergroupList();
    getMarriageStatusList();
    getIsBranchUser();
  }

  Future getCustomergroupList() async {
    customergroupDropDown([]);
    final List<CustomergroupDropdownModel> tempList =
        await DropdownService.customergroupDropDown(isfilter: isFilter);
    tempList.forEach((item) {
      customergroupDropDown.add(
          DropdownModel(label: item.customerGroup!, value: item.id.toString()));
    });
  }

  Future getMarriageStatusList() async {
    marriageStatusDropDown([]);
    final List<MarriageDropdownModel> tempList =
        await DropdownService.marriageDropDown();
    tempList.forEach((item) {
      marriageStatusDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future submitCustomerForm(BuildContext context) async {
    if (customerFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateCustomerPayload payload = CreateCustomerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              customerName: customerNamecontroller.text,
              panNumber: pannumbercontroller.text,
              address: addresscontroller.text,
              aadharNumber: aadharnumbercontroller.text,
              gstNumber: gstnumbercontroller.text,
              mobileNumber: int.parse(mobilenumbercontroller.text),
              customerGroup: int.parse(selectedCustomergroup.value!.value),
              dob: dobcontroller.text.isEmpty ? null : dobcontroller.text,
              email: emailcontroller.text,
              upiId: upiidcontroller.text,
              maritalStatus: selectedMarriageStatus.value?.value);
          await CustomerService.createCustomer(
              context: context, payload: payload);
          _customerListController.getcustomerlist(context);
        } else {
          final UpdateCustomerPayload payload = UpdateCustomerPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            customerName: customerNamecontroller.text,
            panNumber: pannumbercontroller.text,
            address: addresscontroller.text,
            aadharNumber: aadharnumbercontroller.text,
            gstNumber: gstnumbercontroller.text,
            mobileNumber: int.parse(mobilenumbercontroller.text),
            customerGroup: int.parse(selectedCustomergroup.value!.value),
            dob: dobcontroller.text.isEmpty ? null : dobcontroller.text,
            email: emailcontroller.text,
            upiId: upiidcontroller.text,
            maritalStatus: selectedMarriageStatus.value?.value,
            id: currentCustomer.value?.id,
          );
          await CustomerService.updateCustomer(
              context: context, payload: payload);
          _customerListController.getcustomerlist(context);
        }
        resetForm();
        Get.back();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    customerFormKey.currentState!.reset();
    selectedCustomergroup.value = null;
    customerNamecontroller.clear();
    pannumbercontroller.clear();
    addresscontroller.clear();
    aadharnumbercontroller.clear();
    gstnumbercontroller.clear();
    mobilenumbercontroller.clear();
    dobcontroller.clear();
    emailcontroller.clear();
    upiidcontroller.clear();
    maritalstatuscontroller.clear();
    currentCustomer.value = null;
    fromMode("create");
  }
}
