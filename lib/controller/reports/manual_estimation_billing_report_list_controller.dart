import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/reports/billing_gst_report_models.dart';
import 'package:ausales_application/model/reports/manual_estimation_billing_report_models.dart';
import 'package:ausales_application/model/reports/pending_bill_payment_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/reports/export_report_service.dart';
import 'package:ausales_application/service/reports/reports_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ManualEstimationBillingReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchController = TextEditingController();
  TextEditingController dateFilterController = TextEditingController();
  TextEditingController branchSearchFilterController = TextEditingController();



  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);


    RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;


  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;
  RxBool isExportLoading = false.obs;

  RxList<ManualEstimationBillingReportListData> tableData = <ManualEstimationBillingReportListData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }
    
  }

  Future getBranchList() async {
    branchFilterList([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchFilterList.add(DropdownModel(value: "0", label: "All"));
    for (var item in tempList) {
      branchFilterList.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    }
    selectedBranch(DropdownModel(value: "0", label: "All"));
  }



  Future getManualEstimationBillingReportList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? fromDate;
    String? toDate;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }


    if (dateFilterController.text.isNotEmpty) {
      fromDate = dateFilterController.text.split(' to ')[0];
      toDate = dateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchManualEstimationBillingReportListDataPayload payload = FetchManualEstimationBillingReportListDataPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? manualestimationbillingList =
        await ReportsServices.fetchManualEstimationBillingReport(payload: payload);

    if (manualestimationbillingList != null) {
      tableData(manualestimationbillingList['list']);
      totalpages(manualestimationbillingList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }





  Future exportData(BuildContext context) async {
    isExportLoading(true);

   String? branchFilter;
    String? customerFilter;
    String? gstTypeFilter;
    String? fromDate;
    String? toDate;

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (dateFilterController.text.isNotEmpty) {
      fromDate = dateFilterController.text.split(' to ')[0];
      toDate = dateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }


    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = FetchManualEstimationBillingReportListDataPayload(
       search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu()
    );
    var response =
        await ExportReportService.exportmanualestimationReport(payload, context, "excel");
    
    isExportLoading(false);
  }
}