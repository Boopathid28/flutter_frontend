import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/suspense/suspense_service.dart';
import 'package:ausales_application/view/screens/suspense/suspense_view_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SuspenseListController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController searchCustomerController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);
  TextEditingController suspenseDateController = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerFilterList = <DropdownModel>[].obs;

  RxObjectMixin<DropdownModel?> selectedCancelledStatus =
      DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel').obs;

  RxList<DropdownModel> cancelledStatusFilterList = [
    DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Cancel', label: 'Cancel')
  ].obs;

  RxObjectMixin<DropdownModel?> selectedRedeemStatus =
      DropdownModel(value: 'Redeem/Not Redeem', label: 'Redeem/Not Redeem').obs;

  RxList<DropdownModel> redeemStatusFilterList = [
    DropdownModel(value: 'Redeem/Not Redeem', label: 'Redeem/Not Redeem'),
    DropdownModel(value: 'Redeem', label: 'Redeem'),
    DropdownModel(value: 'Not Redeem', label: 'Not Redeem')
  ].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxString isViewDetailsLoading = "".obs;

  RxList<SuspenseListData> tableData = <SuspenseListData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getIsBranchUser();
    getCustomerList();
  }

  Future getCustomerList() async {
    customerFilterList([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    customerFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      customerFilterList.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    });
    selectedCustomer(DropdownModel(value: "0", label: "All"));
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
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }

  Future getsuspenseList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? customerFilter;
    String? fromDate;
    String? toDate;
    bool? isCancelledFilter;
    bool? isRedeemFilter;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (suspenseDateController.text.isNotEmpty) {
      fromDate = suspenseDateController.text.split(' to ')[0];
      toDate = suspenseDateController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    if (selectedCancelledStatus.value!.value == "Active") {
      isCancelledFilter = false;
    } else if (selectedCancelledStatus.value!.value == "Cancel") {
      isCancelledFilter = true;
    } else {
      isCancelledFilter = null;
    }

    if (selectedRedeemStatus.value!.value == "Redeem") {
      isRedeemFilter = false;
    } else if (selectedRedeemStatus.value!.value == "Not Redeem") {
      isRedeemFilter = true;
    } else {
      isRedeemFilter = null;
    }

    FetchSuspenseListPayload payload = FetchSuspenseListPayload(
        search: searchController.text,
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        cancelStatus: isCancelledFilter,
        redeemeStatus: isRedeemFilter,
        itemsPerPage: itemsPerPage.value,
        customerDetails: customerFilter,
        branch: branchFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? suspenseList =
        await SuspenseService.fetchSuspense(payload: payload);

    if (suspenseList != null) {
      tableData(suspenseList['data']);
      totalpages(suspenseList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  Future getSuspenseDetails(
      BuildContext context, SuspenseListData item, String index) async {
    isViewDetailsLoading(index);
    final SuspenseDetailsData? data =
        await SuspenseService.retrieveSuspenseDetail(
            context: context, SuspenseId: item.id.toString());

    if (data != null) {
      Get.to(() => SuspenseViewDetailsScreen(suspenseData: data));

    }
    isViewDetailsLoading("");
  }
}
