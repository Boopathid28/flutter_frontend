import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/order/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();

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

  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isTable = false.obs;

    RxString isPrintLoadingIndex = "".obs;

  RxList<OrderListData> tableData = <OrderListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCustomerList();
  }

  Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    customerDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      customerDropDown.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    });

    selectedCustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getorderList(BuildContext context) async {
    isTableLoading(true);

    bool? isActiveFilter;
    String? customerFilter;
    String? branchFilter;

    if (selectedActiveStatus.value!.value == "Active") {
      isActiveFilter = true;
    } else if (selectedActiveStatus.value!.value == "Inactive") {
      isActiveFilter = false;
    } else {
      isActiveFilter = null;
    }

    if (selectedCustomer.value != null &&
        selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    FetchOrderListPayload payload = FetchOrderListPayload(
        search: searchController.text,
        customer: customerFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? orderlist =
        await OrderService.fetchOrderList(payload: payload);

    if (orderlist != null) {
      tableData(orderlist['data']);
      totalpages(orderlist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
