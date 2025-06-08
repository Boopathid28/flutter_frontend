import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/vendor_ledger/vendor_ledger_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/vendor_ledger/vendor_ledger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorLedgerListController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchVendorDesignerController =
      TextEditingController();
  TextEditingController searchTransactionController = TextEditingController();
  TextEditingController searchBranchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalAmount = "0".obs;
  RxString totalWeight = "0".obs;
  RxString discWeight = "0".obs;
  RxString discAmount = "0".obs;
  RxString paidWeight = "0".obs;
  RxString paidAmount = "0".obs;
  RxString balanceWeight = "0".obs;
  RxString balanceAmount = "0".obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus =
      DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel').obs;

  RxList<DropdownModel> activeStatusFilterList = [
    DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Cancel', label: 'Cancel')
  ].obs;

  Rx<DropdownModel?> selectedvendorDesiner = Rx<DropdownModel?>(DropdownModel(value: "0", label: "All"));
  Rx<DropdownModel?> selectedtransactiontype = Rx<DropdownModel?>(DropdownModel(value: "0", label: "All"));
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(DropdownModel(value: "0", label: "All"));

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<VendorLedgerListData> tableData = <VendorLedgerListData>[].obs;

  RxList<DropdownModel> vendordesignerFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> transactionTypeFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropdown = <DropdownModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getVendorDesignerList();
    getTransactionTypeList();

    bool value = await getIsBranchUser();

    if (value = true) {
      getBranchList();
    } 
  }

  Future getTransactionTypeList() async {
    transactionTypeFilterList([]);
    final List<TransactionTypeDropdownModel> tempList =
        await DropdownService.transactionTypeDropDown();
    transactionTypeFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      transactionTypeFilterList
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getBranchList() async {
    branchDropdown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchDropdown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      branchDropdown.add(DropdownModel(
          label: item.branchName!, value: item.id.toString()));
    });
    selectedvendorDesiner(DropdownModel(value: "0", label: "All"));
  }

  Future getVendorDesignerList() async {
    vendordesignerFilterList([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    vendordesignerFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      vendordesignerFilterList.add(DropdownModel(
          label: item.designerName!, value: item.id.toString()));
    });
    selectedvendorDesiner(DropdownModel(value: "0", label: "All"));
  }

  Future getvendorledgerList(BuildContext context) async {
    isTableLoading(true);

    bool? isActiveFilter;
    String? vendorFilter;
    String? branchFilter;
    String? transactiontypeFilter;

    if (selectedActiveStatus.value!.value == "Cancel") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }

    if (selectedvendorDesiner.value != null &&
        selectedvendorDesiner.value?.value != "0") {
      vendorFilter = selectedvendorDesiner.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedBranch.value != null &&
        selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedtransactiontype.value != null &&
        selectedtransactiontype.value?.value != "0") {
      transactiontypeFilter = selectedtransactiontype.value?.value.toString();
    } else {
      transactiontypeFilter = null;
    }

    FetchVendorLedgerListPayload payload = FetchVendorLedgerListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        vendor: vendorFilter,
        transactionType: transactiontypeFilter,
        status: isActiveFilter,
        branch: isBranchuser.value ? branchFilter : null,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? vendorledgerList =
        await VendorLedgerService.fetchVendorLedgerList(payload: payload);

    if (vendorledgerList != null) {
      tableData(vendorledgerList['list']);
      totalpages(vendorledgerList['data']['total_pages']);
      totalAmount(vendorledgerList['data']['total_amount'].toString());
      totalWeight(vendorledgerList['data']['total_weight'].toString());
      discWeight(vendorledgerList['data']['disc_weight'].toString());
      discAmount(vendorledgerList['data']['disc_amount'].toString());
      paidWeight(vendorledgerList['data']['paid_weight'].toString());
      paidAmount(vendorledgerList['data']['paid_amount'].toString());
      balanceWeight(vendorledgerList['data']['balance_weight'].toString());
      balanceAmount(vendorledgerList['data']['balance_amount'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalAmount("0");
      totalWeight("0");
      discWeight("0");
      discAmount("0");
      paidWeight("0");
      paidAmount("0");
      balanceWeight("0");
      balanceAmount("0");
    }

    isTableLoading(false);
  }
}
