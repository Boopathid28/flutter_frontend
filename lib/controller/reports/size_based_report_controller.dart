import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/pending_bill_payment_report_models.dart';
import 'package:ausales_application/model/reports/size_based_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SizeBasedReportController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchController = TextEditingController();
  TextEditingController dateFilterController = TextEditingController();
  TextEditingController branchSearchFilterController = TextEditingController();
  TextEditingController customerSearchFilterController = TextEditingController();
  TextEditingController fromWeightController = TextEditingController();
  TextEditingController toWeightController = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> measurementTypeDropDown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMeasurementType = Rx<DropdownModel?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;

  RxList<SizeBasedReportListData> tableData = <SizeBasedReportListData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }
    getMeasurementList();
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

  Future getMeasurementList() async {
    measurementTypeDropDown([]);
    final List<MeasurementTypeDropdownModel> tempList =
        await DropdownService.measurementTypeDropDown();
    measurementTypeDropDown.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      measurementTypeDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    }
    selectedMeasurementType(DropdownModel(value: "0", label: "All"));
  }

  Future getSizeBasedReportList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? measurementTypeFilter;
    String? fromDate;
    String? toDate;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedMeasurementType.value != null && selectedMeasurementType.value?.value != "0") {
      measurementTypeFilter = selectedMeasurementType.value?.value.toString();
    } else {
      measurementTypeFilter = null;
    }

    if (dateFilterController.text.isNotEmpty) {
      fromDate = dateFilterController.text.split(' to ')[0];
      toDate = dateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    SizeBasedReportPayload payload = SizeBasedReportPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        measurementType: measurementTypeFilter,
        fromDate: fromDate,
        toDate: toDate,
        fromWeight: fromWeightController.text.isEmpty ? null : double.parse(fromWeightController.text),
        toWeight: toWeightController.text.isEmpty ? null : double.parse(toWeightController.text),
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? itemList =
        await ReportsServices.fetchSizeBasedReport(payload: payload);

    if (itemList != null) {
      tableData(itemList['data']);
      totalpages(itemList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }


}