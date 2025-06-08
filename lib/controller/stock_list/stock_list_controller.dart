import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/stock_list/stock_list_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/stock_list/stock_list_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockListController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchVendorDesignerController =
      TextEditingController();
  TextEditingController searchMetalController = TextEditingController();
  TextEditingController searchPurityController = TextEditingController();
  TextEditingController searchItemController = TextEditingController();
  TextEditingController searchSubItemController = TextEditingController();
  TextEditingController searchStockTypeController = TextEditingController();
  TextEditingController searchCalculationTypeController =
      TextEditingController();
  TextEditingController branchSearchController = TextEditingController();

  TextEditingController StockEntryDateFilterController =
      TextEditingController();

  RxInt itemsPerPage = 20.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  Rx<DropdownModel?> selectedvendorDesiner = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedStockType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubitem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxBool isExportLoading = false.obs;
  RxList<StockListData> tableData = <StockListData>[].obs;

  RxList<DropdownModel> vendordesignerFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> purityFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> itemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> stocktypeFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> subitemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> calculationTypeFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getVendorDesignerList();
    getMetalList();
    getPurityList();
    getItemList();
    getSubItemList();
    getStockType();
    getBranchList();
    getIsBranchUser();
    getCalculationTypeList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }

  Future getVendorDesignerList() async {
    vendordesignerFilterList([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    vendordesignerFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      vendordesignerFilterList.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
    selectedvendorDesiner(DropdownModel(value: "0", label: "All"));
  }

  Future getMetalList() async {
    metalFilterList([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    metalFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      metalFilterList.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
    selectedMetal(DropdownModel(value: "0", label: "All"));
  }

  Future getStockType() async {
    stocktypeFilterList([]);
    final List<StockTypeDropdownModel> tempList =
        await DropdownService.stockTypeDropDown();
    stocktypeFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      stocktypeFilterList
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedStockType(DropdownModel(value: "0", label: "All"));
  }

  Future getPurityList() async {
    purityFilterList([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    purityFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      purityFilterList.add(
          DropdownModel(label: item.purityName!, value: item.id.toString()));
    });
    selectedPurity(DropdownModel(value: "0", label: "All"));
  }

  Future getItemList() async {
    itemFilterList([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    itemFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      itemFilterList
          .add(DropdownModel(label: item.itemName!, value: item.id.toString()));
    });
    selectedItem(DropdownModel(value: "0", label: "All"));
  }

  Future getSubItemList() async {
    subitemFilterList([]);
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: null);
    subitemFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      subitemFilterList.add(
          DropdownModel(label: item.subItemName!, value: item.id.toString()));
    });
    selectedSubitem(DropdownModel(value: "0", label: "All"));
  }

  Future getCalculationTypeList() async {
    calculationTypeFilterList([]);
    final List<CalculationTypeDropdownModel> tempList =
        await DropdownService.calculationTypeDropDown();
    calculationTypeFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      calculationTypeFilterList
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedCalculationType(DropdownModel(value: "0", label: "All"));
  }

  Future getstockList(BuildContext context) async {
    isTableLoading(true);

    String? vendorFilter;
    String? transactiontypeFilter;
    String? purityFilter;
    String? metalFilter;
    String? itemFilter;
    String? subitemfilter;
    String? stocktypefilter;
    String? calculationtypefilter;
    String? branchFilter;
    String? fromDate;
    String? toDate;

    if (selectedvendorDesiner.value != null &&
        selectedvendorDesiner.value?.value != "0") {
      vendorFilter = selectedvendorDesiner.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedMetal.value != null && selectedMetal.value?.value != "0") {
      metalFilter = selectedMetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (selectedPurity.value != null && selectedPurity.value?.value != "0") {
      purityFilter = selectedPurity.value?.value.toString();
    } else {
      purityFilter = null;
    }

    if (selectedItem.value != null && selectedItem.value?.value != "0") {
      itemFilter = selectedItem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    if (selectedStockType.value != null &&
        selectedStockType.value?.value != "0") {
      stocktypefilter = selectedStockType.value?.value.toString();
    } else {
      stocktypefilter = null;
    }

    if (selectedCalculationType.value != null &&
        selectedCalculationType.value?.value != "0") {
      calculationtypefilter = selectedCalculationType.value?.value.toString();
    } else {
      calculationtypefilter = null;
    }

    if (selectedSubitem.value != null && selectedSubitem.value?.value != "0") {
      subitemfilter = selectedSubitem.value?.value.toString();
    } else {
      subitemfilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (StockEntryDateFilterController.text.isNotEmpty) {
      fromDate = StockEntryDateFilterController.text.split(' to ')[0];
      toDate = StockEntryDateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchStockListPayload payload = FetchStockListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        vendor: vendorFilter,
        purity: purityFilter,
        subItem: subitemfilter,
        stockType: stocktypefilter,
        calculationType: calculationtypefilter,
        metal: metalFilter,
        item: itemFilter,
        fromDate: fromDate,
        toDate: toDate,
        branch: branchFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? stockList =
        await StockListService.fetchStockListList(payload: payload);

    if (stockList != null) {
      tableData(stockList['list']);
      totalpages(stockList['data']['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }




   Future exportData(BuildContext context) async {
    isExportLoading(true);

   String? vendorFilter;
    String? transactiontypeFilter;
    String? purityFilter;
    String? metalFilter;
    String? itemFilter;
    String? subitemfilter;
    String? stocktypefilter;
    String? calculationtypefilter;
    String? branchFilter;
    String? fromDate;
    String? toDate;

    if (selectedvendorDesiner.value != null &&
        selectedvendorDesiner.value?.value != "0") {
      vendorFilter = selectedvendorDesiner.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedMetal.value != null && selectedMetal.value?.value != "0") {
      metalFilter = selectedMetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (selectedPurity.value != null && selectedPurity.value?.value != "0") {
      purityFilter = selectedPurity.value?.value.toString();
    } else {
      purityFilter = null;
    }

    if (selectedItem.value != null && selectedItem.value?.value != "0") {
      itemFilter = selectedItem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    if (selectedStockType.value != null &&
        selectedStockType.value?.value != "0") {
      stocktypefilter = selectedStockType.value?.value.toString();
    } else {
      stocktypefilter = null;
    }

    if (selectedCalculationType.value != null &&
        selectedCalculationType.value?.value != "0") {
      calculationtypefilter = selectedCalculationType.value?.value.toString();
    } else {
      calculationtypefilter = null;
    }

    if (selectedSubitem.value != null && selectedSubitem.value?.value != "0") {
      subitemfilter = selectedSubitem.value?.value.toString();
    } else {
      subitemfilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (StockEntryDateFilterController.text.isNotEmpty) {
      fromDate = StockEntryDateFilterController.text.split(' to ')[0];
      toDate = StockEntryDateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchStockListPayload(
      search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        vendor: vendorFilter,
        purity: purityFilter,
        subItem: subitemfilter,
        stockType: stocktypefilter,
        calculationType: calculationtypefilter,
        metal: metalFilter,
        item: itemFilter,
        fromDate: fromDate,
        toDate: toDate,
        branch: branchFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());
  
    var response =
        await ExportReportService.exportStockListReport(payload, context);
    
    isExportLoading(false);
  }
}
