import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/customer/customer_creation_common_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_item_form_controller.dart';
import 'package:ausales_application/controller/old_purchase/old_purchase_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/old_purchase/old_purchase_service.dart';
import 'package:ausales_application/utils/validation_helpler.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_purchase/old_purchase_printout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class OldPurchaseFormController extends HeaderController {
  final OldPurchaseItemFormController _oldPurchaseItemFormController =
      Get.put(OldPurchaseItemFormController());

  final CustomerCreationCommonController _customerCreationCommonController =
      Get.put(CustomerCreationCommonController());
  final OldPurchaseListController _oldPurchaseListController =
      Get.put(OldPurchaseListController());

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final oldPurchaseDetailsFormKey = GlobalKey<FormState>();

  TextEditingController customerMobileController = TextEditingController();

  TextEditingController branchSearchController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> gstTypeDropDown = <DropdownModel>[].obs;

  RxObjectMixin<CustomerVerificationResponse> customerDetails =
      CustomerVerificationResponse().obs;

  RxBool isFormSubmit = false.obs;
  RxBool isValidCustomer = false.obs;
  RxBool isVerifyCustomerLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    } else {
      getCustomerList();
    }

    getGstTypeList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    customerDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      customerDropDown.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    });
    selectedCustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getGstTypeList() async {
    gstTypeDropDown([]);
    final List<GstTypeDropdownModel> tempList =
        await DropdownService.gstTypeDropDown();
    tempList.forEach((item) {
      gstTypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future submitCustomerCreationForm(BuildContext context) async {
    if (_customerCreationCommonController.customerCommonFormKey.currentState!
        .validate()) {
      if (!_customerCreationCommonController.isFormSubmit.value) {
        _customerCreationCommonController.isFormSubmit(true);
        if (_customerCreationCommonController.fromMode.value == "create") {
          final CreateCustomerPayload payload = CreateCustomerPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            customerName:
                _customerCreationCommonController.customerNamecontroller.text,
            mobileNumber: int.parse(
                _customerCreationCommonController.mobilenumbercontroller.text),
            customerGroup: int.parse(_customerCreationCommonController
                .selectedCustomergroup.value!.value),
          );

          await CustomerService.createCustomer(
              context: context, payload: payload);

          findCustomer(
              _customerCreationCommonController.mobilenumbercontroller.text,
              context);
        }
        _customerCreationCommonController.resetForm();
        Get.back();
      }
    }
  }

  Future findCustomer(String value, BuildContext context) async {
    var validMobile = await ValidationHelper.phone(value);

    isValidCustomer(false);

    if (validMobile.isEmpty) {
      isVerifyCustomerLoading(true);
      int? menuId = await HomeSharedPrefs.getCurrentMenu();
      CustomerVerificationResponse? data =
          await CustomerService.customerVerification(
              mobile: value, menuId: menuId.toString(), context: context);

      if (data != null) {
        customerDetails(data);
        isValidCustomer(true);
      } else {
        customerDetails(null);
        _customerCreationCommonController.mobilenumbercontroller.text = value;
        await Get.dialog(
            barrierDismissible: false,
            CustomerCreationCommonPopup(
                  onSubmit: submitCustomerCreationForm,
                ));
      }
      isVerifyCustomerLoading(false);
    }
  }

  Future submitForm(BuildContext context, bool print) async {
    if (oldPurchaseDetailsFormKey.currentState!.validate()) {
      isFormSubmit(true);

      if (isValidCustomer.value) {
        if (_oldPurchaseItemFormController.particulars.isNotEmpty) {
          OldPurchasePayload payload = OldPurchasePayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              customerDetails: customerDetails.value.id,
              branch: selectedBranch.value?.value,
              oldItemDetails: _oldPurchaseItemFormController.particulars.value);

          final String? data = await OldPurchaseService.createOldPurchase(
              context: context, payload: payload);

          if (data != null) {
            _oldPurchaseListController.getOldPurchaseList(context);
            if (print == true) {
              final CompanyDetailsData? companyData =
                  await CompanyService.retrieveCompany(context: context);

              if (companyData != null) {
                final OldPurchaseRetrieveResponse? oldPurchaseData =
                    await OldPurchaseService.retrieveOldPurchase(
                        context: context, oldPurdchaseId: data.toString());
                _oldPurchaseListController.isPrintLoadingIndex("");
                if (oldPurchaseData != null) {
                  await Get.dialog(
                      barrierDismissible: false,
                      OldPurchasePrintout(
                          companyDetailsData: companyData,
                          oldPurchaseDetails: oldPurchaseData));
                }
              }
            }
            resetForm(context);
            _oldPurchaseItemFormController.resetForm(context);
            navOldPurchaseList();
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Add at least one item"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text("Add customer details"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
      isFormSubmit(false);
    }
  }

  Future resetForm(BuildContext context) async {
    _oldPurchaseItemFormController.particulars([]);
    _oldPurchaseItemFormController.resetForm(context);
    selectedBranch.value = null;

    customerMobileController.clear();
    _oldPurchaseItemFormController.selectedGstType.value = null;
    isValidCustomer(false);    
  }
}
