import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/model/stock_assign/stock_assign_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/stock_assign/stock_assign_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_assign/assign_tag_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StockAssignListController extends HeaderController {
    @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchboxController = TextEditingController();
  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchfloorController = TextEditingController();
  TextEditingController searchcounterController = TextEditingController();

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

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = false.obs;
  RxBool validationisTableLoading = true.obs;
  RxList<StockAssignListData> tableData = <StockAssignListData>[].obs;
  Rx<ValidationAssignTagResponse?> tableDataValidation =
      Rx<ValidationAssignTagResponse?>(null);

  RxList<ItemTagdetailsList> itemtagParticularList = <ItemTagdetailsList>[].obs;

  RxList<DropdownModel> catalogDropdown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> floorDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> counterDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> catalogTypeDropDown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedCatalog = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFloor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCounter = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCatalogType = Rx<DropdownModel?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
     final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    } else {
      getFloordropdown(null);
    }
    getCatalogTypeList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getFloordropdown(String? branch) async {
    selectedFloor.value  = null;
    selectedCounter.value  = null;
    selectedCatalog.value  = null;
    counterDropDown([]);
    catalogDropdown([]);
    floorDropDown([]);
    final List<FloorDropdownModel> tempList =
        await DropdownService.floorDropdown(branch: branch);
    tempList.forEach((item) {
      floorDropDown.add(
          DropdownModel(label: item.floorName!, value: item.id.toString()));
    });
  }

  Future getCounterdropdown(String? floorId) async {

    selectedCounter.value  = null;
    selectedCatalog.value  = null;
    catalogDropdown([]);
    counterDropDown([]);
    final List<CounterDropdownModel> tempList =
        await DropdownService.counterDropDown(floor: floorId);
    tempList.forEach((item) {
      counterDropDown.add(
          DropdownModel(label: item.counterName!, value: item.id.toString()));
    });
  }

  Future getCatalogTypeList() async {
    catalogTypeDropDown([]);
    final List<CatalogTypeDropdownModel> tempList =
        await DropdownService.catalogTypeDropDown();
    tempList.forEach((item) {
      catalogTypeDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getCatalogdropdownList(String? counterId, String? catalogType) async {
    selectedCatalog.value  = null;
    catalogDropdown([]);
    final List<CatalogDropdownModel> tempList =
        await DropdownService.catalogDropDown(counter: counterId, catalogType: catalogType);
    tempList.forEach((item) {
      catalogDropdown.add(
          DropdownModel(label: item.catalogNumber!, value: item.id.toString()));
    });
  }

  Future getstockList(BuildContext context) async {
    isTableLoading(true);

    String? catalogfilter;

    if (selectedCatalog.value != null && selectedCatalog.value?.value != "0") {
      catalogfilter = selectedCatalog.value?.value.toString();
    } else {
      catalogfilter = null;
    }

    FetchStockAssignListPayload payload = FetchStockAssignListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        catalogType: selectedCatalogType.value?.value,
        catalogDetails: catalogfilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    final Map<String, dynamic>? stockassign =
        await StockAssignService.fetchStockAssignListList(payload: payload);

    if (stockassign != null) {
      tableData(stockassign['data']);
      totalpages(stockassign['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  Future getvalidationList(BuildContext context) async {
    validationisTableLoading(true);
    List<String> templist = [];
    for (var i in itemtagParticularList.value) {
      templist.add(i.tagNumber!);
    }

    ValidationTagPayload payload = ValidationTagPayload(
        tagDetails: templist, menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? stockassign =
        await StockAssignService.fetchValidationListList(payload: payload);

    if (stockassign != null) {
      tableDataValidation(stockassign['data']);
      Get.back();
      if (tableDataValidation.value!.popup == true) {
        await Get.dialog(
          barrierDismissible: false,
          AssignTagPopup(),
        );
      } else {
        CreateStockAssignPayload payload = CreateStockAssignPayload(
            tagDetails: templist,
            catalogDetails: selectedCatalog.value?.value,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final Map<String, dynamic>? CreateAssigntagList =
            await StockAssignService.createStockList(
                payload: payload, context: context);
      }
    } else {
      tableDataValidation(null);
      totalpages(1);
    }

    validationisTableLoading(false);
    itemtagParticularList([]);
  }

  Future CreateAssignStock(BuildContext context) async {
    List<String> templist = [];
    for (var i in itemtagParticularList.value) {
      templist.add(i.tagNumber!);
    }
    CreateStockAssignPayload payload = CreateStockAssignPayload(
        tagDetails: templist,
        catalogDetails: selectedCatalog.value?.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? CreateAssigntagList =
        await StockAssignService.createStockList(
            payload: payload, context: context);
    Get.back();
  }

  Future getvalidationcompleteList(BuildContext context) async {
    String? catalogfilter;
    validationisTableLoading(true);
    List<String> templist = [];
    for (var i in itemtagParticularList.value) {
      templist.add(i.tagNumber!);
    }

    ValidationTagPayload payload = ValidationTagPayload(
        tagDetails: templist, menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? stockassign =
        await StockAssignService.fetchValidationListList(payload: payload);

    if (stockassign != null) {
      tableDataValidation(stockassign['data']);
    } else {
      tableDataValidation(null);
      totalpages(1);
    }

    validationisTableLoading(false);
  }
}
