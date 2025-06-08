import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/live_stock_report_models.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_sub_item_wise_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveStockReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchMetalController = TextEditingController();
  TextEditingController searchitemController = TextEditingController();
  TextEditingController searchstocktypeController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedmetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selecteditem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedstocktype = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> itemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> stocktypeFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<LiveStockReportListData> tableData = <LiveStockReportListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getMetalList();
    getItemList();
    getStockTypeList();
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

  Future getStockTypeList() async {
    stocktypeFilterList([]);
    final List<StockTypeDropdownModel> templist =
        await DropdownService.stockTypeDropDown();
    stocktypeFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      stocktypeFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
    selectedstocktype(DropdownModel(value: "0", label: "All"));
  }

  Future getMetalList() async {
    metalFilterList([]);
    final List<MetalDropdownModel> templist =
        await DropdownService.metalDropDown();
    metalFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      metalFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.metalName.toString()));
    });
    selectedmetal(DropdownModel(value: "0", label: "All"));
  }

  Future getItemList() async {
    itemFilterList([]);
    final List<ItemDropdownModel> templist =
        await DropdownService.itemDropDown();
    itemFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      itemFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.itemName.toString()));
    });
    selecteditem(DropdownModel(value: "0", label: "All"));
  }

  Future getlivestockreport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? metalFilter;
    String? itemFilter;
    String? stocktypeFilter;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedstocktype.value != null && selectedstocktype.value?.value != "0") {
      stocktypeFilter = selectedstocktype.value?.value.toString();
    } else {
      stocktypeFilter = null;
    }

    if (selectedmetal.value != null && selectedmetal.value?.value != "0") {
      metalFilter = selectedmetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (selecteditem.value != null && selecteditem.value?.value != "0") {
      itemFilter = selecteditem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    FetchLiveStockReportListDataPayload payload =
        FetchLiveStockReportListDataPayload(
            page: page.value,
            metal: metalFilter,
            item: itemFilter,
            stocktype: stocktypeFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? livestockreportList =
        await ReportsServices.fetchLiveStockReport(payload: payload);

    if (livestockreportList != null) {
      tableData(livestockreportList['list']);
      totalpages(livestockreportList['data']['total_pages']);
      totalPieces(livestockreportList['data']['total_pieces'].toString());
      totalGrossWeight(
          livestockreportList['data']['total_gross_weight'].toString());
      totalNetWeight(
          livestockreportList['data']['total_net_weight'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalPieces("0");
      totalGrossWeight("0");
      totalNetWeight("0");
    }

    isTableLoading(false);
  }

  Future exportData(BuildContext context) async {
    isExportLoading(true);

    String? branchFilter;
    String? metalFilter;
    String? itemFilter;
    String? stocktypeFilter;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedstocktype.value != null && selectedstocktype.value?.value != "0") {
      stocktypeFilter = selectedstocktype.value?.value.toString();
    } else {
      stocktypeFilter = null;
    }

    if (selectedmetal.value != null && selectedmetal.value?.value != "0") {
      metalFilter = selectedmetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (selecteditem.value != null && selecteditem.value?.value != "0") {
      itemFilter = selecteditem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    FetchLiveStockReportListDataPayload payload =
        FetchLiveStockReportListDataPayload(
            page: page.value,
            metal: metalFilter,
            item: itemFilter,
            stocktype: stocktypeFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportLiveStockListReport(payload, context);

    isExportLoading(false);
  }

  Future exportPdfData(BuildContext context) async {
    isExportPdfLoading(true);

     String? branchFilter;
    String? metalFilter;
    String? itemFilter;
    String? stocktypeFilter;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedstocktype.value != null && selectedstocktype.value?.value != "0") {
      stocktypeFilter = selectedstocktype.value?.value.toString();
    } else {
      stocktypeFilter = null;
    }

    if (selectedmetal.value != null && selectedmetal.value?.value != "0") {
      metalFilter = selectedmetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    if (selecteditem.value != null && selecteditem.value?.value != "0") {
      itemFilter = selecteditem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    FetchLiveStockReportListDataPayload payload =
        FetchLiveStockReportListDataPayload(
            page: page.value,
            metal: metalFilter,
            item: itemFilter,
            stocktype: stocktypeFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportLiveStockListPdfReport(
        payload, context);

    isExportPdfLoading(false);
  }
}
