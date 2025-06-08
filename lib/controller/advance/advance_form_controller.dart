import 'dart:math';

import 'package:ausales_application/controller/advance/advance_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/advance/advance_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class AdvanceFormController extends HeaderController {
  final AdvanceListController _advanceListController =
      Get.put(AdvanceListController());

  RxList<DenominationDetails> paymentParticulars = <DenominationDetails>[].obs;
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final advanceFormKey = GlobalKey<FormState>();

  TextEditingController searchVendorDesignerController =
      TextEditingController();
  TextEditingController searchadvancepurposecontroller =
      TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();
  TextEditingController advanceamountController = TextEditingController();
  TextEditingController advanceweightcontroller = TextEditingController();
  TextEditingController advancepurposecontroller = TextEditingController();
  TextEditingController searchpuritycontroller = TextEditingController();
  TextEditingController remarkcontroller = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> puritydropdown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);

  RxList<DropdownModel> advancedropdown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedAdvancePurpose = Rx<DropdownModel?>(null);

  RxBool totalweight = false.obs;

  RxBool isFormSubmit = false.obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getCustomerList();
    getPurityList();
    getAdvancePurposeList();
  }

  Future getAdvancePurposeList() async {
    advancedropdown([]);
    final List<AdvancePurposeDropdownmodel> tempList =
        await DropdownService.advancePurposeDropDown();
    tempList.forEach((item) {
      advancedropdown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
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

  Future getPurityList() async {
    puritydropdown([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    tempList.forEach((item) {
      puritydropdown.add(
          DropdownModel(label: item.purityName!, value: item.id.toString()));
    });
  }

  Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown(isFilter: isFilter);
    tempList.forEach((item) {
      customerDropDown.add(DropdownModel(
          label: "${item.customerName!}(${item.mobileNumber})",
          value: item.id.toString()));
    });
  }

  Future CreateAdvance(BuildContext context) async {
    if (advanceFormKey.currentState!.validate()) {
      if (paymentParticulars.value.isNotEmpty) {
        if (!isFormSubmit.value) {
          isFormSubmit(true);
          CreateAdvancePayload payload = CreateAdvancePayload(
              advanceWeightPurity: selectedPurity.value?.value,
              branch: selectedBranch.value?.value,
              customerDetails: selectedCustomer.value?.value,
              totalAdvanceAmount: advanceamountController.text.isEmpty
                  ? "0"
                  : advanceamountController.text,
              totalAdvanceWeight: advanceweightcontroller.text.isEmpty
                  ? "0"
                  : advanceweightcontroller.text,
              advancePurpose: selectedAdvancePurpose.value!.value,
              remark: remarkcontroller.text,
              denominationDetails: paymentParticulars,
              menuId: await HomeSharedPrefs.getCurrentMenu());

          final AdvanceCreateResponse? CreateAdvance =
              await AdvanceService.createAdvance(
                  payload: payload, context: context);
          _advanceListController.getAdvanceList(context);
          resetForm();
          Get.back();
          isFormSubmit(false);
        }
      }else {
        toastification.show(
          type: ToastificationType.error,
          title: Text('Atleast Add One Payment'),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
      }
    }
  }

  resetForm() {
    selectedBranch.value = null;
    selectedCustomer.value = null;
    selectedPurity.value = null;
    remarkcontroller.clear();
    advanceamountController.clear();
    advancepurposecontroller.clear();
    selectedAdvancePurpose.value = null;
    advancepurposecontroller.clear();
    advanceweightcontroller.clear();
    paymentParticulars([]);
  }
}
