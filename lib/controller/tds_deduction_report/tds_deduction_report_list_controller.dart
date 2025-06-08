import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/tds_deduction_report/tds_deduction_report_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/tds_deduction_report/tds_deduction_report_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TdsDeductionReportListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchController = TextEditingController();
  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchvendorController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedvendor = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> vendorFilterList = <DropdownModel>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
  RxString totalGrossWeight = "0".obs;
  RxString totalNetWeight = "0".obs;
  RxString totalAmount = "0".obs;

  RxBool isTableLoading = true.obs;

  RxList<TdsDeductionReportListData> tableData =
      <TdsDeductionReportListData>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getVendorList();
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

  Future getVendorList() async {
    vendorFilterList([]);
    final List<DesignerDropdownModel> templist =
        await DropdownService.designerDropDown();
    vendorFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      vendorFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.designerName.toString()));
    });
    selectedvendor(DropdownModel(value: "0", label: "All"));
  }

  Future gettdsdeductionreportList(BuildContext context) async {
    isTableLoading(true);

    String? branchFilter;
    String? vendorFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedvendor.value != null && selectedvendor.value?.value != "0") {
      vendorFilter = selectedvendor.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchTdsDeductionReportListPayload payload =
        FetchTdsDeductionReportListPayload(
            page: page.value,
            fromDate: fromDate,
            toDate: toDate,
            itemsPerPage: itemsPerPage.value,
            vendor: vendorFilter,
            search: searchController.text,
            branch: branchFilter,
            menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? tdsdeductionreportList =
        await TdsDeductionReportService
            .fetchTdsDeductionReportList(payload: payload);

    if (tdsdeductionreportList != null) {
      tableData(tdsdeductionreportList['list']);
      totalpages(tdsdeductionreportList['data']['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
