import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/suspense_repayment_report/suspense_repayment_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/suspense_repayment_report/suspense_repayment_report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuspenseRepaymentReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchController = TextEditingController();
  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchcustomerController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedcustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> customerFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;
  RxString totalAmount = "0".obs;

  RxBool isTableLoading = true.obs;

  RxList<SuspenseRepaymentReportListData> tableData =
      <SuspenseRepaymentReportListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getCustomerList();
  }

  Future getBranchList() async {
    branchFilterList([]);
    final List<BranchDropDownModel> templist =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      branchFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.branchName.toString()));
    });
    selectedbranch(DropdownModel(value: "0", label: "All"));
  }

  Future getCustomerList() async {
    customerFilterList([]);
    final List<CustomerDropDownModel> templist =
        await DropdownService.customerDropDown();
    customerFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      customerFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.customerName.toString()));
    });
    selectedcustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getsuspenserepaymentreportList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? customerFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedcustomer.value != null && selectedcustomer.value?.value != "0") {
      customerFilter = selectedcustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchSuspenseRepaymentReportListPaylaod payload =
        FetchSuspenseRepaymentReportListPaylaod(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            search: searchController.text,
            customer: customerFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? suspenserepaymentreportList =
        await SuspenseRepaymentReportService
            .fetchSuspenseRepaymentReportList(payload: payload);

    if (suspenserepaymentreportList != null) {
      tableData(suspenserepaymentreportList['list']);
      totalpages(suspenserepaymentreportList['data']['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
