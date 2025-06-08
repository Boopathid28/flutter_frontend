import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/vendor_inward_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorInwardsReportListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fromDateController = TextEditingController();
  TextEditingController searchvendorController = TextEditingController();
  TextEditingController searchitemController = TextEditingController();

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;

  RxBool isTableLoading = true.obs;

  RxBool isExportLoading = false.obs;
  RxBool isExportPdfLoading = false.obs;

  RxList<VendorInwardReportListData> tableData =
      <VendorInwardReportListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getVendorList();
    getItemList();
  }

  Future getVendorList() async {
    vendorDropDown([]);
    vendorDropDown.add(DropdownModel(value: '0', label: 'All'));
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    for (var item in tempList) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    }
    selectedVendor(DropdownModel(value: '0', label: 'All'));
  }

  Future getItemList() async {
    itemDropDown([]);
    itemDropDown.add(DropdownModel(value: '0', label: 'All'));
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    for (var item in tempList) {
      itemDropDown
          .add(DropdownModel(label: item.itemName!, value: item.id.toString()));
    }
    selectedItem(DropdownModel(value: '0', label: 'All'));
  }

  Future getVendorInwardsListreport(BuildContext context) async {
    isTableLoading(true);

    String? vendorFilter;
    String? itemFilter;

    if (selectedVendor.value != null && selectedVendor.value?.value != "0") {
      vendorFilter = selectedVendor.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedItem.value != null && selectedItem.value?.value != "0") {
      itemFilter = selectedItem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    FetchVendorInwardReportListDataPayload payload =
        FetchVendorInwardReportListDataPayload(
            page: page.value,
            fromDate: fromDateController.text.isEmpty
                ? null
                : fromDateController.text,
            item: itemFilter,
            vendor: vendorFilter,
            itemsPerPage: itemsPerPage.value,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? vendorinwardsreportList =
        await ReportsServices.fetchVendorInwardsReport(payload: payload);

    if (vendorinwardsreportList != null) {
      tableData(vendorinwardsreportList['list']);
      totalpages(vendorinwardsreportList['data']['total_pages']);
      totalPieces(vendorinwardsreportList['data']['total_pieces'].toString());
      totalGrossWeight(
          vendorinwardsreportList['data']['total_gross_weight'].toString());
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
    String? vendorFilter;
    String? itemFilter;

    if (selectedVendor.value != null && selectedVendor.value?.value != "0") {
      vendorFilter = selectedVendor.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedItem.value != null && selectedItem.value?.value != "0") {
      itemFilter = selectedItem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    FetchVendorInwardReportListDataPayload payload =
        FetchVendorInwardReportListDataPayload(
            page: page.value,
            fromDate: fromDateController.text.isEmpty
                ? null
                : fromDateController.text,
            item: itemFilter,
            vendor: vendorFilter,
            itemsPerPage: itemsPerPage.value,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportVendorInwardsListReport(
        payload, context);

    isExportLoading(false);
  }

  Future exportPdfData(BuildContext context) async {
    isExportPdfLoading(true);
    String? vendorFilter;
    String? itemFilter;

    if (selectedVendor.value != null && selectedVendor.value?.value != "0") {
      vendorFilter = selectedVendor.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedItem.value != null && selectedItem.value?.value != "0") {
      itemFilter = selectedItem.value?.value.toString();
    } else {
      itemFilter = null;
    }

    FetchVendorInwardReportListDataPayload payload =
        FetchVendorInwardReportListDataPayload(
            page: page.value,
            fromDate: fromDateController.text.isEmpty
                ? null
                : fromDateController.text,
            item: itemFilter,
            vendor: vendorFilter,
            itemsPerPage: itemsPerPage.value,
            menuId: await HomeSharedPrefs.getCurrentMenu());
    var response = await ExportReportService.exportVendorInwardsListPdfReport(
        payload, context);

    isExportPdfLoading(false);
  }
}
