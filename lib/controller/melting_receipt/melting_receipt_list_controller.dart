import 'dart:async';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/melting_receipt/melting_receipt_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/melting_receipt/melting_receipt_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MeltingReceiptListController extends HeaderController {

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
    TextEditingController branchSearchController = TextEditingController();
    TextEditingController vendorSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedReceivedStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
  RxObjectMixin<DropdownModel?> selectedCancelStatus = DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
    Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
    Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  RxList<DropdownModel> receivedStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'true', label: 'True'), DropdownModel(value: 'false', label: 'False')].obs;

        RxList<DropdownModel> cancelStatusFilterList =
      [DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'), DropdownModel(value: 'true', label: 'True'), DropdownModel(value: 'false', label: 'False')].obs;

  RxList<DropdownModel> vendorFilterList = <DropdownModel>[].obs;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isFormAdd = false.obs;

  RxList<MeltingReceiptListData> tableData = <MeltingReceiptListData>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if(branch == true){
    getBranchList();
    }
    getVendorDesignerList();
  }


    Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      branchDropDown
          .add(DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }

    Future getVendorDesignerList() async {
    vendorFilterList([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    vendorFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      vendorFilterList.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
    selectedVendor(DropdownModel(value: "0", label: "All"));
  }

  Future getmeltingReceiptList(BuildContext context) async {
    isTableLoading(true);

    bool? isReceivedFilter;
    bool? isCancelFilter;
        String? branchFilter;
        String? vendorFilter;

    if (selectedReceivedStatus.value!.value == "true") {
      isReceivedFilter = true;
    } else if (selectedReceivedStatus.value!.value == "false") {
      isReceivedFilter = false;
    } else {
      isReceivedFilter = null;
    }

     if (selectedCancelStatus.value!.value == "true") {
      isCancelFilter = true;
    } else if (selectedCancelStatus.value!.value == "false") {
      isCancelFilter = false;
    } else {
      isCancelFilter = null;
    }

       if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

     if (selectedVendor.value != null && selectedVendor.value?.value != "0") {
      vendorFilter = selectedVendor.value?.value.toString();
    } else {
      vendorFilter = null;
    }


    FetchMeltingReceiptPayload payload = FetchMeltingReceiptPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        receivedStatus: isReceivedFilter,
        vendor: vendorFilter,
        cancelStatus: isCancelFilter,
        branch: branchFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? meltinglist =
        await MeltingReceiptService.fetchMeltingReceiptList(payload: payload);

    if (meltinglist != null) {

      tableData(meltinglist['data']);
      totalpages(meltinglist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
