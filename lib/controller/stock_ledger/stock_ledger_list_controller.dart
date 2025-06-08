import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/stock_ledger/stock_ledger_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/stock_ledger/stock_ledger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockLedgerListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchVendorDesignerController =
      TextEditingController();
  TextEditingController searchMetalController = TextEditingController();
  TextEditingController searchPurityController = TextEditingController();
  TextEditingController searchItemController = TextEditingController();
  TextEditingController searchSubItemController = TextEditingController();
  TextEditingController searchStockTypeController = TextEditingController();
  TextEditingController stockListDateController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString inStockpieces = "0".obs;
  RxString outStockpieces = "0".obs;
  RxString inStockgrossweight = "0".obs;
  RxString outStockgrossweight = "0".obs;

  Rx<DropdownModel?> selectedvendorDesiner = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedStockTypeLedger = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubitem = Rx<DropdownModel?>(null);

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<StockLedgerListData> tableData = <StockLedgerListData>[].obs;

  RxList<DropdownModel> vendordesignerFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> purityFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> itemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> stocktypeledgerFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> subitemFilterList = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getVendorDesignerList();
    getMetalList();
    getPurityList();
    getItemList();
    getSubItemList();
    getStockTypeLedgerList();
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

  Future getStockTypeLedgerList() async {
    stocktypeledgerFilterList([]);
    final List<StockTypeLedgerDropdownModel> tempList =
        await DropdownService.stockTypeLedgerDropDown();
    stocktypeledgerFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      stocktypeledgerFilterList
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedStockTypeLedger(DropdownModel(value: "0", label: "All"));
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

  Future getstockledgerList(BuildContext context) async {
    isTableLoading(true);

    String? vendorFilter;
    String? transactiontypeFilter;
    String? purityFilter;
    String? metalFilter;
    String? itemFilter;
    String? subitemfilter;
    String? stocktypeledgerfilter;
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

    if (selectedStockTypeLedger.value != null &&
        selectedStockTypeLedger.value?.value != "0") {
      stocktypeledgerfilter = selectedStockTypeLedger.value?.value.toString();
    } else {
      stocktypeledgerfilter = null;
    }

    if (selectedSubitem.value != null && selectedSubitem.value?.value != "0") {
      subitemfilter = selectedSubitem.value?.value.toString();
    } else {
      subitemfilter = null;
    }

    if (stockListDateController.text.isNotEmpty) {
      fromDate = stockListDateController.text.split(' to ')[0];
      toDate = stockListDateController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchStockLedgerListPayload payload = FetchStockLedgerListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        vendor: vendorFilter,
        purity: purityFilter,
        subItem: subitemfilter,
        stockType: stocktypeledgerfilter,
        metal: metalFilter,
        item: itemFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? stockledgerList =
        await StockLedgerService.fetchStockLedgerList(payload: payload);

    if (stockledgerList != null) {
      tableData(stockledgerList['list']);
      totalpages(stockledgerList['data']['total_pages']);
      inStockpieces(stockledgerList['data']['in_stock_pieces'].toString());
      outStockpieces(stockledgerList['data']['out_stock_pieces'].toString());
      inStockgrossweight(
          stockledgerList['data']['in_stock_gross_weight'].toString());
      outStockgrossweight(
          stockledgerList['data']['out_stock_gross_weight'].toString());
    } else {
      tableData([]);
      totalpages(1);
      inStockpieces("0");
      outStockpieces("0");
      inStockgrossweight("0");
      outStockgrossweight("0");
    }

    isTableLoading(false);
  }
}
