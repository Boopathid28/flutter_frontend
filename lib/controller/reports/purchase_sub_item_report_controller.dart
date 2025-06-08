import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/order_sub_item_wise_report_models.dart';
import 'package:ausales_application/model/reports/purchase_sub_item_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseSubItemReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchitemController = TextEditingController();
  TextEditingController searchsubitemController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selecteditem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubitem = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> itemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> subitemFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;

  RxBool isExportLoading = false.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;

  RxBool isTableLoading = true.obs;

  RxList<PurchaseSubitemreportlistdata> tableData =
      <PurchaseSubitemreportlistdata>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getItemList();
    getSubItemList();
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

  Future getSubItemList() async {
    subitemFilterList([]);
    final List<SubItemDropdownModel> templist =
        await DropdownService.subItemDropDown();
    subitemFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      subitemFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.subItemName.toString()));
    });
    selectedSubitem(DropdownModel(value: "0", label: "All"));
  }

  Future getpurchasesubitemwisereport(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? itemFilter;
    String? subitemFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selecteditem.value != null && selecteditem.value?.value != "0") {
      itemFilter = selecteditem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    if (selectedSubitem.value != null && selectedSubitem.value?.value != "0") {
      subitemFilter = selectedSubitem.value?.value.toString();
    } else {
      subitemFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchPurchaseSubitemreportlistdataPayload payload =
        FetchPurchaseSubitemreportlistdataPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            item: itemFilter,
            subItem: subitemFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? purchasesubitemwisereportList =
        await ReportsServices.fetchPurchasesubitemReport(payload: payload);

    if (purchasesubitemwisereportList != null) {
      tableData(purchasesubitemwisereportList['list']);
      totalpages(purchasesubitemwisereportList['data']['total_pages']);
      // totalPieces(
      //     purchasesubitemwisereportList['data']['total_pieces'].toString());
      // totalGrossWeight(purchasesubitemwisereportList['data']
      //         ['total_gross_weight']
      //     .toString());
      // totalNetWeight(
      //     purchasesubitemwisereportList['data']['total_net_weight'].toString());
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
    String? itemFilter;
    String? subitemFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selecteditem.value != null && selecteditem.value?.value != "0") {
      itemFilter = selecteditem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    if (selectedSubitem.value != null && selectedSubitem.value?.value != "0") {
      subitemFilter = selectedSubitem.value?.value.toString();
    } else {
      subitemFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchPurchaseSubitemreportlistdataPayload(
        page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            item: itemFilter,
            subItem: subitemFilter,
            itemsPerPage: itemsPerPage.value,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response =
        await ExportReportService.exportPurchaseSubItemwiseListReport(payload, context);

        isExportLoading(false);
  }

}
