import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/old_purchase/old_purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OldPurchaseListController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController searchController = TextEditingController();
  TextEditingController entryDateRangeController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedStatus = Rx<DropdownModel?>(DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'));

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> statusDropDown = <DropdownModel>[
    DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'), DropdownModel(value: 'Active', label: 'Active'), DropdownModel(value: 'Cancel', label: 'Cancel')
  ].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  
  RxString isPrintLoadingIndex = "".obs;

  RxList<FetchOldPurchaseListResponse> tableData = <FetchOldPurchaseListResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBranchList();
    getIsBranchUser();
    getCustomerList();
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

  Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    customerDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      customerDropDown
          .add(DropdownModel(label: item.customerName!, value: item.id.toString()));
    });
    selectedCustomer(DropdownModel(value: "0", label: "All"));
  }
  
  Future getOldPurchaseList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? customerFilter;
    bool? statusFilter;
    String? fromDate;
    String? toDate;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (entryDateRangeController.text.isNotEmpty) {
      fromDate = entryDateRangeController.text.split(' to ')[0];
      toDate = entryDateRangeController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    if (selectedCustomer.value != null && selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (selectedStatus.value!.value == "Cancel") {
      statusFilter = true;
    } else if (selectedStatus.value!.value == "Active") {
      statusFilter = false;
    } else {
      statusFilter = null;
    }
    
    FetchOldPurchaseListPayload payload = FetchOldPurchaseListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        fromDate: fromDate,
        toDate: toDate,
        customer: customerFilter,
        status: statusFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? oldPurchaseList =
        await OldPurchaseService.fetchOldPurchaseList(payload: payload);

    if (oldPurchaseList != null) {

      tableData(oldPurchaseList['data']);
      totalpages(oldPurchaseList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}