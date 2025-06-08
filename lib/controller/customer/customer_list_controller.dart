import 'dart:async';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerListController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController customerGroupController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus =
      DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;
  Rx<DropdownModel?> selectedCustomergroup = Rx<DropdownModel?>(null);

  RxList<DropdownModel> activeStatusFilterList = [
    DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Inactive', label: 'Inactive')
  ].obs;
  RxList<DropdownModel> customergroupFilterList = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<CustomerListData> tableData = <CustomerListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCustomergroupList();
    getIsBranchUser();
  }


  Future getCustomergroupList() async {
    customergroupFilterList([]);
    final List<CustomergroupDropdownModel> tempList =
        await DropdownService.customergroupDropDown();
    customergroupFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      customergroupFilterList.add(
          DropdownModel(label: item.customerGroup!, value: item.id.toString()));
    });
    selectedCustomergroup(DropdownModel(value: "0", label: "All"));
  }

  Future getcustomerlist(BuildContext context) async {
    isTableLoading(true);

    bool? isActiveFilter;
    String? customergroupfilter;

    if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Inactive") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }


    if (selectedCustomergroup.value != null &&
        selectedCustomergroup.value?.value != "0") {
      customergroupfilter = selectedCustomergroup.value?.value.toString();
    } else {
      customergroupfilter = null;
    }
    FetchCustomerListPayload payload = FetchCustomerListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        activeStatus: isActiveFilter,
        customerGroup: int.tryParse(customergroupfilter ?? ''),
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? customerlist =
        await CustomerService.fetchCustomerList(payload: payload);

    if (customerlist != null) {
      tableData(customerlist['data']);
      totalpages(customerlist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
