import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_item_form_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/new_purchase/new_purchase_model.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/new_purchase/new_purchase_service.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class NewPurchaseFormController extends HeaderController {
  final NewPurchaseItemFormController _newPurchaseItemFormController =
      Get.put(NewPurchaseItemFormController());

  final NewPurchaseListController _newPurchaseListController =
      Get.put(NewPurchaseListController());

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final newPurchaseDetailsFormKey = GlobalKey<FormState>();

  TextEditingController vendorSearchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();

  TextEditingController poDateController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> designerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> gstTypeDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool isValidCustomer = false.obs;
  RxBool isVerifyLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getVendorList();
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

  Future getVendorList() async {
    designerDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      designerDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
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

  Future submitForm(BuildContext context) async {
    if (newPurchaseDetailsFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);

        if (_newPurchaseItemFormController.particulars.isNotEmpty) {
          int? menuId = await HomeSharedPrefs.getCurrentMenu();
          final VendorPaymentRetrieveData? vendordata =
              await VendorPaymentService.retrieveVendorPaymentDetails(
                  menuId: menuId.toString(),
                  vendorId: selectedVendor.value!.value,
                  context: context);

          if (vendordata != null) {
            NewPurchasePayload payload = NewPurchasePayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                openAmount: vendordata!.balanceAmount,
                openWeight: vendordata!.balanceWeight,
                branch: selectedBranch.value?.value,
                vendor: selectedVendor.value?.value,
                poDate: poDateController.text,
                remark: _newPurchaseItemFormController.remarkController.text,
                totalItems: _newPurchaseItemFormController.totalItems.value,
                totalPieces: _newPurchaseItemFormController.totalPieces.value,
                totalGrossWeight:
                    _newPurchaseItemFormController.totalGrossWeight.value,
                totalNetWeight:
                    _newPurchaseItemFormController.totalNetWeight.value,
                isConverted:
                    _newPurchaseItemFormController.isConvertedWeight.value,
                convertedWeight:
                    _newPurchaseItemFormController.convertedWeight.value,
                convertionRate:
                    _newPurchaseItemFormController.convertionRate.value,
                convertedAmount:
                    _newPurchaseItemFormController.convertionWithGst.value,
                coversionGst:
                    _newPurchaseItemFormController.convertionGst.value,
                withoutGstConverisonAmount:
                    _newPurchaseItemFormController.convertedAmount.value,
                withoutTdsAmount: _newPurchaseItemFormController
                    .payableGrandTotalAmount.value,
                tdsAmount: _newPurchaseItemFormController.tdsAmount.value,
                tdsPercent: double.parse(_newPurchaseItemFormController
                        .tdsPercentController.text.isEmpty
                    ? "0"
                    : _newPurchaseItemFormController.tdsPercentController.text),
                roundOff: double.parse(_newPurchaseItemFormController
                        .roundOffController.text.isEmpty
                    ? "0"
                    : _newPurchaseItemFormController.roundOffController.text),
                gstAmount: _newPurchaseItemFormController.gstAmount.value,
                payableAmount: _newPurchaseItemFormController.payableWithRoundAmount.value,
                payablePureWeight: _newPurchaseItemFormController.payablPureWeight.value,
                gstType: _newPurchaseItemFormController.selectedGstType.value?.value,
                newPurchaseItemDetails: _newPurchaseItemFormController.particulars.value);
            final String? data = await NewPurchaseService.createNewPurchase(
                context: context, payload: payload);

            if (data != null) {
              _newPurchaseListController.getNewPurchaseList(context);
              Get.back();
            }
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

        isFormSubmit(false);
      }
    }
  }

  Future resetForm(BuildContext context) async {
    _newPurchaseItemFormController.particulars([]);
    _newPurchaseItemFormController.resetForm(context);
    selectedBranch.value = null;
    isValidCustomer(false);
  }
}
