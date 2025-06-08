import 'dart:async';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPaymentListController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController dateFilterController = TextEditingController();

  TextEditingController searchVendorController = TextEditingController();
  TextEditingController searchBranchController = TextEditingController();

  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus =
      DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;

  RxList<DropdownModel> activeStatusFilterList = [
    DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Inactive', label: 'Inactive')
  ].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<VendorPaymentListData> tableData = <VendorPaymentListData>[].obs;

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
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
    selectedVendor(DropdownModel(value: "0", label: "All"));
  }

  Future getVendorList() async {
    vendorDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    vendorDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
    selectedVendor(DropdownModel(value: "0", label: "All"));
  }

  Future getVendorPaymentList(BuildContext context) async {
    isTableLoading(true);
    String? vendorFilter;
    String? branchFilter;
    bool? isActiveFilter;
    String? fromDate;
    String? toDate;

    if (selectedVendor.value != null && selectedVendor.value?.value != "0") {
      vendorFilter = selectedVendor.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedActiveStatus.value!.value == "Cancel") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }

    if (dateFilterController.text.isNotEmpty) {
      fromDate = dateFilterController.text.split(' to ')[0];
      toDate = dateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchVendorPaymentListPayload payload = FetchVendorPaymentListPayload(
        search: searchController.text,
        page: page.value,
        vendor: vendorFilter,
        status: isActiveFilter,
        fromDate: fromDate,
        toDate: toDate,
        itemsPerPage: itemsPerPage.value,
        branch: isBranchuser.value ? branchFilter : null,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? vendorPaymentList =
        await VendorPaymentService.fetchVendorPaymentList(payload: payload);

    if (vendorPaymentList != null) {
      tableData(vendorPaymentList['data']);
      totalpages(vendorPaymentList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
