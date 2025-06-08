import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/service/repair_type/repair_type_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/repair_creation/repair_creation_service.dart';
import 'package:get/get.dart';

class RepairCreationTableListController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  RxList<RepairTableList> tableData = <RepairTableList>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isTableLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch) {
      getBranchList();
    }
    getCustomerList();
    getRepairCreationTableList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    branchDropDown.add(DropdownModel(value: "0", label: 'All'));
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    for (var item in tempList) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    }
    selectedBranch(DropdownModel(value: "0", label: 'All'));
  }

  Future getCustomerList() async {
    customerDropDown([]);
    customerDropDown.add(DropdownModel(value: "0", label: 'All'));
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();

    for (var item in tempList) {
      customerDropDown.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    }
    selectedCustomer(DropdownModel(value: "0", label: 'All'));
  }

  Future getRepairCreationTableList() async {
    isTableLoading(true);
    String? branchFilter;
    String? customerFilter;
    if (selectedBranch.value?.value == '0') {
      branchFilter = null;
    } else {
      branchFilter = selectedBranch.value?.value;
    }

    if (selectedCustomer.value?.value == '0') {
      customerFilter = null;
    } else {
      customerFilter = selectedCustomer.value?.value;
    }

    
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = RepairTableListPayload(
        branch: branchFilter, customer: customerFilter, menuId: menuId);
    var response = await RepairCreationService.fetchRepairTableList(payload);
    if (response != null) {
      tableData(response['data']);
      totalpages(response['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }
}
