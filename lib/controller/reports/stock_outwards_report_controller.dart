import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/model/reports/order_sub_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/stock_outward_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockOutwardsReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchMetalController = TextEditingController();
  TextEditingController searchItemController = TextEditingController();
  TextEditingController searchDesignerController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedmetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selecteditem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selecteddesigner = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> itemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> designerFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<StockOutwardListData> tableData =
      <StockOutwardListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getMetalList();
    getItemList();
    getDesignerList();
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


  Future getDesignerList() async {
    designerFilterList([]);
    final List<DesignerDropdownModel> templist =
        await DropdownService.designerDropDown();
    designerFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      designerFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.designerName.toString()));
    });
    selecteddesigner(DropdownModel(value: "0", label: "All"));
  }

 
  Future getstockoutwardsreport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? metalFilter;
    String? itemFilter;
    String? designerFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
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
    if (selecteddesigner.value != null && selecteddesigner.value?.value != "0") {
      designerFilter = selecteddesigner.value?.value.toString();
    } else {
      designerFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchStockOutwardListDataPayload payload =
        FetchStockOutwardListDataPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            metal: metalFilter,
            designer: designerFilter,
            item: itemFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? stockoutwardsreportList =
        await ReportsServices
            .fetchStockOutwardsReport(payload: payload);

    if (stockoutwardsreportList != null) {

 tableData(stockoutwardsreportList['list']);
    totalpages(stockoutwardsreportList['data']['total_pages']);
      totalPieces(stockoutwardsreportList['data']['total_pieces'].toString());
      totalGrossWeight(stockoutwardsreportList['data']['total_gross_weight'].toString());
    } else {
      tableData([]);
      totalpages(1);
      totalPieces("0");
      totalGrossWeight("0");
    }

    isTableLoading(false);
  }



   Future exportData(BuildContext context) async {
    isExportLoading(true);

   
    String? branchFilter;
       String? itemFilter;
    String? designerFilter;
    String? metalFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
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
    if (selecteddesigner.value != null && selecteddesigner.value?.value != "0") {
      designerFilter = selecteddesigner.value?.value.toString();
    } else {
      designerFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchStockOutwardListDataPayload(
        page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            metal: metalFilter,
              designer: designerFilter,
            item: itemFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportStockOutwardsListReport(payload, context, "excel");
    
    isExportLoading(false);
  }





  Future exportPdfData(BuildContext context) async {
    isExportPdfLoading(true);

   
    String? branchFilter;
       String? itemFilter;
    String? designerFilter;
    String? metalFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
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
    if (selecteddesigner.value != null && selecteddesigner.value?.value != "0") {
      designerFilter = selecteddesigner.value?.value.toString();
    } else {
      designerFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchStockOutwardListDataPayload(
        page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            metal: metalFilter,
              designer: designerFilter,
            item: itemFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportStockOutwardsListReport(payload, context, "pdf");
    
    isExportPdfLoading(false);
  }





}
