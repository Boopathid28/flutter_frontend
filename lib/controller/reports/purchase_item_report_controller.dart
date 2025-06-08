import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/billing_gst_report_models.dart';
import 'package:ausales_application/model/reports/pending_bill_payment_report_models.dart';
import 'package:ausales_application/model/reports/purchase_item_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PurchaseItemReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchController = TextEditingController();
  TextEditingController dateFilterController = TextEditingController();
  TextEditingController branchSearchFilterController = TextEditingController();
  TextEditingController customerSearchFilterController =  TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<Purchaseitemreportlistdata> tableData =
      <Purchaseitemreportlistdata>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }
    getItemList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    }
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }

  Future getItemList() async {
    itemDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    itemDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      itemDropDown
          .add(DropdownModel(label: item.itemName!, value: item.id.toString()));
    }
    selectedItem(DropdownModel(value: "0", label: "All"));
  }

  Future getPurchaseItemReportList(BuildContext context) async {
  // Start logging
  print("Fetching purchase item report list...");
  
  // Marking table loading as true
  isTableLoading(true);
  
  String? branchFilter;
  String? itemFilter;
  String? fromDate;
  String? toDate;

  // Logging selected branch details
  if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
    branchFilter = selectedBranch.value?.value.toString();
    print("Branch filter applied: $branchFilter");
  } else {
    branchFilter = null;
    print("No branch filter applied");
  }

  // Logging selected item details
  if (selectedItem.value != null && selectedItem.value?.value != "0") {
    itemFilter = selectedItem.value?.value.toString();
    print("Item filter applied: $itemFilter");
  } else {
    itemFilter = null;
    print("No item filter applied");
  }

  // Logging date filter
  if (dateFilterController.text.isNotEmpty) {
    fromDate = dateFilterController.text.split(' to ')[0];
    toDate = dateFilterController.text.split(' to ')[1];
    print("Date filter applied: From $fromDate to $toDate");
  } else {
    fromDate = null;
    toDate = null;
    print("No date filter applied");
  }

  // Creating the payload object
  FetchPurchaseitemreportlistdataPayload payload = FetchPurchaseitemreportlistdataPayload(
    page: page.value,
    itemsPerPage: itemsPerPage.value,
    branch: branchFilter,
    item: itemFilter,
    fromDate: fromDate,
    toDate: toDate,
    menuId: await HomeSharedPrefs.getCurrentMenu(),
  );
  
  // Logging payload information
  print("Payload data: ${payload.toString()}");

  // Fetching the report data
  final Map<String, dynamic>? itemList = await ReportsServices.fetchPurchaseitemReport(payload: payload);

  // Handling the response and logging data
  if (itemList != null) {
    print("Data fetched successfully");
    tableData(itemList['data']);
    totalpages(itemList['total_pages']);
  } else {
    print("No data found");
    tableData([]);
    totalpages(1);
  }

  // Marking table loading as false
  isTableLoading(false);
  
  print("Finished fetching purchase item report list.");
}

  Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? branchFilter;
  String? itemFilter;
  String? fromDate;
  String? toDate;

  // Logging selected branch details
  if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
    branchFilter = selectedBranch.value?.value.toString();
    print("Branch filter applied: $branchFilter");
  } else {
    branchFilter = null;
    print("No branch filter applied");
  }

  // Logging selected item details
  if (selectedItem.value != null && selectedItem.value?.value != "0") {
    itemFilter = selectedItem.value?.value.toString();
    print("Item filter applied: $itemFilter");
  } else {
    itemFilter = null;
    print("No item filter applied");
  }

  // Logging date filter
  if (dateFilterController.text.isNotEmpty) {
    fromDate = dateFilterController.text.split(' to ')[0];
    toDate = dateFilterController.text.split(' to ')[1];
    print("Date filter applied: From $fromDate to $toDate");
  } else {
    fromDate = null;
    toDate = null;
    print("No date filter applied");
  }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchPurchaseitemreportlistdataPayload(
       page: page.value,
    itemsPerPage: itemsPerPage.value,
    branch: branchFilter,
    item: itemFilter,
    fromDate: fromDate,
    toDate: toDate,
    menuId: await HomeSharedPrefs.getCurrentMenu(),);
    var response =
        await ExportReportService.exportPurchaseItemwiseListReport(payload, context);

    isExportLoading(false);
  }
}
