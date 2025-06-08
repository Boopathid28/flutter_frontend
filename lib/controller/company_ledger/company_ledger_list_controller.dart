import 'dart:async';
import 'dart:developer';
 
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/company_ledger/company_ledger_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
class CompanyLedgerListController extends HeaderController {
 
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
 
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController companyledgerDateController = TextEditingController();
    TextEditingController branchSearchController = TextEditingController();
    TextEditingController expenseSearchController = TextEditingController();
 
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedCancelledStatus = DropdownModel(value: 'Cancelled/Active', label: 'Cancelled/Active').obs;
    Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
    Rx<DropdownModel?> selectedExpensetype = Rx<DropdownModel?>(null);
 
  RxList<DropdownModel> cancelledStatusFilterList =
      [DropdownModel(value: 'Cancelled/Active', label: 'Cancelled/Active'), DropdownModel(value: 'true', label: 'Cancelled'), DropdownModel(value: 'false', label: 'Active')].obs;
 
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> expensetypeDropDown = <DropdownModel>[].obs;
 
  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxString totalExpenseAmount = "0".obs;
  RxString totalIncomeAmount = "0".obs;
 
  RxList<CompanyLedgerListData> tableData = <CompanyLedgerListData>[].obs;
 
  @override
  void onInit() {
    super.onInit();
    getBranchList();
    getIsBranchUser();
    getExpensetypeList();
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
 
    Future getExpensetypeList() async {
    expensetypeDropDown([]);
    final List<ExpensetypeDropDownModel> tempList =
        await DropdownService.expensetypeDropDownModel();
    expensetypeDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      expensetypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedExpensetype(DropdownModel(value: "0", label: "All"));
  }
 
  Future getcompanyledgerList(BuildContext context) async {
    isTableLoading(true);
 
    bool? isCancelledFilter;
    String? expenseFilter;
        String? branchFilter;
        String? fromDate;
    String? toDate;
 
    if (selectedCancelledStatus.value!.value == "true") {
      isCancelledFilter = true;
    } else if (selectedCancelledStatus.value!.value == "false") {
      isCancelledFilter = false;
    } else {
      isCancelledFilter = null;
    }
       if (selectedBranch.value != null &&
        selectedBranch.value?.value != "0") {
     branchFilter = selectedBranch.value?.value.toString();
    } else {
     branchFilter = null;
    }
 
      if (selectedExpensetype.value != null && selectedExpensetype.value?.value != "0") {
      expenseFilter = selectedExpensetype.value?.value.toString();
    } else {
      expenseFilter = null;
    }

    if (companyledgerDateController.text.isNotEmpty) {
      fromDate = companyledgerDateController.text.split(' to ')[0];
      toDate = companyledgerDateController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }
 
 
    FetchCompanyLedgerListPayload payload = FetchCompanyLedgerListPayload(
        search: searchController.text,
        branch: branchFilter,
        status: isCancelledFilter,
        expensesType: expenseFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());
 
    final Map<String, dynamic>? companylist =
        await CompanyLedgerService.fetchCompanyLedgerList(payload: payload);
    if (companylist != null) {
      tableData(companylist['list']);
      totalpages(companylist['data']['total_pages']);
      totalExpenseAmount(companylist['data']['total_expenses_amount'].toString());
      totalIncomeAmount(companylist['data']['total_income_amount'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalExpenseAmount("0");
      totalIncomeAmount("0");
    }
 
    isTableLoading(false);
  }



  Future exportData(BuildContext context) async {
    isExportLoading(true);

     bool? isCancelledFilter;
    String? expenseFilter;
        String? branchFilter;
        String? fromDate;
    String? toDate;
 
    if (selectedCancelledStatus.value!.value == "true") {
      isCancelledFilter = true;
    } else if (selectedCancelledStatus.value!.value == "false") {
      isCancelledFilter = false;
    } else {
      isCancelledFilter = null;
    }
       if (selectedBranch.value != null &&
        selectedBranch.value?.value != "0") {
     branchFilter = selectedBranch.value?.value.toString();
    } else {
     branchFilter = null;
    }
 
      if (selectedExpensetype.value != null && selectedExpensetype.value?.value != "0") {
      expenseFilter = selectedExpensetype.value?.value.toString();
    } else {
      expenseFilter = null;
    }

    if (companyledgerDateController.text.isNotEmpty) {
      fromDate = companyledgerDateController.text.split(' to ')[0];
      toDate = companyledgerDateController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchCompanyLedgerListPayload(
       search: searchController.text,
        branch: branchFilter,
        status: isCancelledFilter,
        expensesType: expenseFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu()
    );
    var response =
        await ExportReportService.exportCompanyLedgerReport(payload, context);

    isExportLoading(false);
  }
}