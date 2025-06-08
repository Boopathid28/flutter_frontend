import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/new_purchase/new_purchase_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/new_purchase/new_purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPurchaseListController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController searchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController vendorSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedStatus = Rx<DropdownModel?>(DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'));

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> statusDropDown = <DropdownModel>[
    DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Cancel', label: 'Cancel')
  ].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  
  RxString isPrintLoadingIndex = "".obs;

  RxList<FetchNewPurchaseListResponse> tableData = <FetchNewPurchaseListResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBranchList();
    getIsBranchUser();
    getVendorList();
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

  Future getVendorList() async {
    vendorDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    vendorDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      vendorDropDown
          .add(DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
    selectedVendor(DropdownModel(value: "0", label: "All"));
  }
  
  Future getNewPurchaseList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? vendorFilter;
    bool? statusFilter;

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

    if (selectedStatus.value!.value == "Cancel") {
      statusFilter = true;
    } else if (selectedStatus.value!.value == "Active") {
      statusFilter = false;
    } else {
      statusFilter = null;
    }
    
    FetchNewPurchaseListPayload payload = FetchNewPurchaseListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        vendor: vendorFilter,
        status: statusFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? newPurchaseList =
        await NewPurchaseService.fetchNewPurchaseList(payload: payload);

    if (newPurchaseList != null) {

      tableData(newPurchaseList['data']);
      totalpages(newPurchaseList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}