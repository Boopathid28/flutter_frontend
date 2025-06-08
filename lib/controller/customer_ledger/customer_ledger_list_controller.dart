import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/customer_ledger/customer_ledger_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/customer_ledger/customer_ledger_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerLedgerListController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchCustomerController = TextEditingController();
  TextEditingController searchTransactiontypeController =
      TextEditingController();
      TextEditingController searchSalesEntrytypeController =
      TextEditingController();
  TextEditingController searchMetalController = TextEditingController();
  TextEditingController searchPurityController = TextEditingController();
  TextEditingController searchBranchController = TextEditingController();
  TextEditingController searchItemController = TextEditingController();
  TextEditingController searchSubItemController = TextEditingController();
  TextEditingController searchStockTypeController = TextEditingController();
  TextEditingController customerledgerDateController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxDouble creditamount = 0.0.obs;
  RxDouble creditweight = 0.0.obs;
  RxDouble debitamount = 0.0.obs;
  RxDouble debitweight = 0.0.obs;
  RxDouble remainingamount = 0.0.obs;
  RxDouble remainingweight = 0.0.obs;
  
  RxBool isExportLoading = false.obs;

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedcustomer = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedentrytype = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedtransactiontype = Rx<DropdownModel?>(null);

  RxObjectMixin<DropdownModel?> selectedCancelledStatus =
      DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel').obs;

  RxList<DropdownModel> cancelledStatusFilterList = [
    DropdownModel(value: 'Active/Cancel', label: 'Active/Cancel'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Cancel', label: 'Cancel')
  ].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<CustomerLedgerListData> tableData = <CustomerLedgerListData>[].obs;

  RxList<DropdownModel> brachFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> customerFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> entrytypeFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> transactiontypeFilterList = <DropdownModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    bool value = await getIsBranchUser();
    if (value = true) {
      getBranchList();
    }
    getTransactiontypeList();
    getEntryTypeList();
    getCustomerList();
  }

  Future getBranchList() async {
    brachFilterList([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    brachFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      brachFilterList.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
    selectedbranch(DropdownModel(value: "0", label: "All"));
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
    selectedcustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getEntryTypeList() async {
    entrytypeFilterList([]);
    final List<SalesExpensetypeDropDownModel> tempList =
        await DropdownService.salesexpensetypeDropDownModel();
    entrytypeFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      entrytypeFilterList
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedentrytype(DropdownModel(value: "0", label: "All"));
  }

  Future getTransactiontypeList() async {
    transactiontypeFilterList([]);
    final List<TransactionTypeDropdownModel> tempList =
        await DropdownService.transactionTypeDropDown();
    transactiontypeFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      transactiontypeFilterList
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedtransactiontype(DropdownModel(value: "0", label: "All"));
  }

  Future getcustomerledgerList(BuildContext context) async {
    isTableLoading(true);

    String? customerFilter;
    String? transactiontypeFilter;
    String? entrytypeFilterList;
    String? fromDate;
    String? branch;
    String? toDate;
    bool? isCancelledFilter;

    if (selectedCancelledStatus.value!.value == "Active") {
      isCancelledFilter = false;
    } else if (selectedCancelledStatus.value!.value == "Cancel") {
      isCancelledFilter = true;
    } else {
      isCancelledFilter = null;
    }

    if (selectedentrytype.value != null &&
        selectedentrytype.value?.value != "0") {
      entrytypeFilterList = selectedentrytype.value?.value.toString();
    } else {
      entrytypeFilterList = null;
    }

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branch = selectedbranch.value?.value.toString();
    } else {
      branch = null;
    }

    if (selectedtransactiontype.value != null &&
        selectedtransactiontype.value?.value != "0") {
      transactiontypeFilter = selectedtransactiontype.value?.value.toString();
    } else {
      transactiontypeFilter = null;
    }

     if (selectedcustomer.value != null &&
        selectedcustomer.value?.value != "0") {
      customerFilter = selectedcustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (customerledgerDateController.text.isNotEmpty) {
      fromDate = customerledgerDateController.text.split(' to ')[0];
      toDate = customerledgerDateController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchCustomerLedgerListPayload payload = FetchCustomerLedgerListPayload(
        search: searchController.text,
        page: page.value,
        customerDetails: customerFilter,
        cancelStatus: isCancelledFilter,
        entryType: entrytypeFilterList,
        branch: branch,
        transactionType: transactiontypeFilter,
        itemsPerPage: itemsPerPage.value,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? customerledgerList =
        await CustomerLedgerService.fetchCustomerLedgerList(payload: payload);

    if (customerledgerList != null) {
      tableData(customerledgerList['list']);
      totalpages(customerledgerList['data']['total_pages']);
      creditamount(double.parse(customerledgerList['data']['credit_amount'].toString()));
      creditweight(double.parse(customerledgerList['data']['credit_weight'].toString()));
      debitamount(double.parse(customerledgerList['data']['debit_amount'].toString()));
      debitweight(double.parse(customerledgerList['data']['debit_weight'].toString()));
      remainingamount(
          double.parse(customerledgerList['data']['remaining_amount'].toString()));
      remainingweight(
          double.parse(customerledgerList['data']['remaining_weight'].toString()));
    } else {
      tableData([]);
      totalpages(1);
      creditamount(0.0);
      creditweight(0.0);
      debitamount(0.0);
      debitweight(0.0);
      remainingamount(0.0);
      remainingweight(0.0);
    }

    isTableLoading(false);
  }




   Future exportData(BuildContext context) async {
    isExportLoading(true);

     String? customerFilter;
    String? transactiontypeFilter;
    String? entrytypeFilterList;
    String? fromDate;
    String? branch;
    String? toDate;
    bool? isCancelledFilter;

    if (selectedCancelledStatus.value!.value == "Active") {
      isCancelledFilter = false;
    } else if (selectedCancelledStatus.value!.value == "Cancel") {
      isCancelledFilter = true;
    } else {
      isCancelledFilter = null;
    }

    if (selectedentrytype.value != null &&
        selectedentrytype.value?.value != "0") {
      entrytypeFilterList = selectedentrytype.value?.value.toString();
    } else {
      entrytypeFilterList = null;
    }

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branch = selectedbranch.value?.value.toString();
    } else {
      branch = null;
    }

    if (selectedtransactiontype.value != null &&
        selectedtransactiontype.value?.value != "0") {
      transactiontypeFilter = selectedtransactiontype.value?.value.toString();
    } else {
      transactiontypeFilter = null;
    }

     if (selectedcustomer.value != null &&
        selectedcustomer.value?.value != "0") {
      customerFilter = selectedcustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (customerledgerDateController.text.isNotEmpty) {
      fromDate = customerledgerDateController.text.split(' to ')[0];
      toDate = customerledgerDateController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchCustomerLedgerListPayload(
        search: searchController.text,
        page: page.value,
        customerDetails: customerFilter,
        cancelStatus: isCancelledFilter,
        entryType: entrytypeFilterList,
        branch: branch,
        transactionType: transactiontypeFilter,
        itemsPerPage: itemsPerPage.value,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu()
    );
    var response =
        await ExportReportService.exportCustomerLedgerReport(payload, context);

    isExportLoading(false);
  }
}
