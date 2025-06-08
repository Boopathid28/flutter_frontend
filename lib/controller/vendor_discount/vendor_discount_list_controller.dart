import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/vendor_discount/vendor_discount_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/vendor_discount/vendor_discount_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorDiscountListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();
  TextEditingController vendorSearchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  TextEditingController dateFilterController = TextEditingController();
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  RxObjectMixin<DropdownModel?> selectedActiveStatus = DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel').obs;

  RxList<DropdownModel> activeStatusFilterList =
      [DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Cancel', label: 'Cancel')].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<VendorDiscountListData> tableData = <VendorDiscountListData>[].obs;

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
    branchDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
    selectedBranch(DropdownModel(value: "0", label: "All"));
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

  FutureOr getVendorDiscountList(BuildContext context) async {
    isTableLoading(true);

    bool? isActiveFilter;
    String? fromDate;
    String? toDate;
    String? vendorFilter;
    String? branchFilter;

    if (selectedVendor.value != null && selectedVendor.value?.value != "0") {
      vendorFilter = selectedVendor.value!.value;
    } else {
      vendorFilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value!.value;
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

    FetchVendorDiscountListPayload payload = FetchVendorDiscountListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        status: isActiveFilter,
        fromDate: fromDate,
        toDate: toDate,
        vendor: vendorFilter,
        branch: isBranchuser.value ? branchFilter : null,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? userList =
        await VendorDiscountService.fetchVendorDiscountList(payload: payload);

    if (userList != null) {

      tableData(userList['data']);
      totalpages(userList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
