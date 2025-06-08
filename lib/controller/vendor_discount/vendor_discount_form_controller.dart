import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/vendor_discount/vendor_discount_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/vendor_discount/vendor_discount_model.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/vendor_discount/vendor_discount_service.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorDiscountFormController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final VendorDiscountListController _vendorDiscountListController = Get.put(VendorDiscountListController());

  final vendorDiscountFormKey = GlobalKey<FormState>();

  TextEditingController vendorSearchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();

  TextEditingController discountWeightController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxObjectMixin<VendorPaymentRetrieveData> vendorPaymentDetails =
      VendorPaymentRetrieveData().obs;

  RxBool isFormSubmit = false.obs;

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getVendorList();
    bool value = await getIsBranchUser();
    if (value == true) {
      getBranchList();
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

  Future getVendorList() async {
    vendorDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
  }

  Future getVendorPaymentDetails(BuildContext context, String vendorId) async {
    int? menuId = await HomeSharedPrefs.getCurrentMenu();
    final VendorPaymentRetrieveData? data =
        await VendorPaymentService.retrieveVendorPaymentDetails(
            menuId: menuId.toString(), vendorId: vendorId, context: context);

    if (data != null) {
      vendorPaymentDetails(data);
    }
  }

  Future submitVendorDiscountForm(BuildContext context) async {
    if (vendorDiscountFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
          final CreateVendorDiscountPayload payload = CreateVendorDiscountPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              vendorDetails: selectedVendor.value?.value,
              discountAmount: double.parse(discountAmountController.text.isEmpty ? "0.0" : discountAmountController.text),
              discountWeight: double.parse(discountWeightController.text.isEmpty ? "0.0" : discountWeightController.text),
              remark: remarksController.text,
              branch: isBranchuser.value ? selectedBranch.value?.value : null
              );

          await VendorDiscountService.createVendorDiscount(context: context, payload: payload);
          _vendorDiscountListController.getVendorDiscountList(context);
        }
        resetForm();
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    vendorDiscountFormKey.currentState!.reset();
    selectedVendor.value = null;
  }
}
