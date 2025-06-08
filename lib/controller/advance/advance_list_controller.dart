import 'dart:async';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/advance/advance_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/view/screens/advance/advance_details_view_screen.dart';
import 'package:ausales_application/view/widgets/screen_widgets/advance/advance_printout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvanceListController extends HeaderController {
  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();
  TextEditingController advancepurposeSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  RxObjectMixin<DropdownModel?> selectedCancelStatus =
      DropdownModel(value: 'Active/Cancelled', label: 'Active/Cancelled').obs;

  RxObjectMixin<DropdownModel?> selectedRedeemStatus =
      DropdownModel(value: 'Redeem/Not Redeem', label: 'Redeem/Not Redeem').obs;
  Rx<DropdownModel?> selectedadvance = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedcustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> advanceDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> cancelStatusFilterList = [
    DropdownModel(value: 'Active/Cancelled', label: 'Active/Cancelled'),
    DropdownModel(value: 'Cancelled', label: 'Cancelled'),
    DropdownModel(value: 'Active', label: 'Active'),
  ].obs;

  RxList<DropdownModel> redeemStatusList = [
    DropdownModel(value: 'Redeem/Not Redeem', label: 'Redeem/Not Redeem'),
    DropdownModel(value: 'Redeem', label: 'Redeem'),
    DropdownModel(value: 'Not Redeem', label: 'Not Redeem'),
  ].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isFormAdd = false.obs;
  RxString isAdvanceRetrieveLoading = "".obs;
  RxString isAdvancePrintLoading = "".obs;

  RxList<AdvanceListData> tableData = <AdvanceListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBranchList();
    getIsBranchUser();
    getAdvanceDropdownList();
    getCustomerList();
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

    Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    customerDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      customerDropDown.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    });
    selectedcustomer(DropdownModel(value: "0", label: "All"));
  }

    Future getAdvanceDropdownList() async {
    advanceDropDown([]);
    final List<AdvancePurposeDropdownmodel> tempList =
        await DropdownService.advancePurposeDropDown();
    advanceDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      advanceDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    });
    selectedadvance(DropdownModel(value: "0", label: "All"));
  }

  Future getAdvanceList(BuildContext context) async {
    isTableLoading(true);

    bool? isCancelledFilter;
    bool? isRedeemFilter;
    String? branchFilter;
    String? customerFilter;
    String? advanceFilter;

    if (selectedCancelStatus.value!.value == "Cancelled") {
      isCancelledFilter = true;
    } else if (selectedCancelStatus.value!.value == "Active") {
      isCancelledFilter = false;
    } else {
      isCancelledFilter = null;
    }

       if (selectedRedeemStatus.value!.value == "Redeem") {
      isRedeemFilter = true;
    } else if (selectedRedeemStatus.value!.value == "Not Redeem") {
      isRedeemFilter = false;
    } else {
      isRedeemFilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

      if (selectedcustomer.value != null && selectedcustomer.value?.value != "0") {
      customerFilter = selectedcustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

      if (selectedadvance.value != null && selectedadvance.value?.value != "0") {
      advanceFilter = selectedadvance.value?.value.toString();
    } else {
      advanceFilter = null;
    }

    FetchAdvanceListPayload payload = FetchAdvanceListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        cancelStatus: isCancelledFilter,
        redeemStatus: isRedeemFilter,
        advancePurpose: advanceFilter,
        customerDetails: customerFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? advanceList =
        await AdvanceService.fetchAdvanceList(payload: payload);

    if (advanceList != null) {
      tableData(advanceList['data']);
      totalpages(advanceList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  Future getAdvanceDetails(BuildContext context, String index, String advanceId,bool isPrint) async {
    if (isPrint) {
      isAdvancePrintLoading(index);
    } else {
      isAdvanceRetrieveLoading(index);
    }
 
    final AdvanceDetailsData? data = await AdvanceService.retrieveAdvance(context: context, advanceId: advanceId);
 
    if (data != null) {
      if (isPrint) {
        await Get.dialog(barrierDismissible: false,AdvancePrintout(advanceDetails: data,));
      } else {
        Get.to(() => AdvanceDetailsViewScreen(advanceData: data));
      }
    }
    isAdvanceRetrieveLoading("");
    isAdvancePrintLoading("");
  }
}
