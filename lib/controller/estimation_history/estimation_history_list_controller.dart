import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/estimation/estimation_history_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/estimation/estimation_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation_history/estimation_view_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimationHistoryListController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController branchSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();

  TextEditingController estimtaitonEntryDateFilterController = TextEditingController();
     Rx<RetrieveEstimationDetails?> currentestimationdetails = Rx<RetrieveEstimationDetails?>(null);

     
  RxList<RetrieveParticularDetails> particularData = <RetrieveParticularDetails>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedBillStatus =
      DropdownModel(value: 'Billed/Not Billed', label: 'Billed/Not Billed').obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);

  RxList<DropdownModel> billStatusFilterList = [
    DropdownModel(value: 'Billed/Not Billed', label: 'Billed/Not Billed'),
    DropdownModel(value: 'Billed', label: 'Billed'),
    DropdownModel(value: 'Not Billed', label: 'Not Billed')
  ].obs;

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxString isPrintLoadingIndex = "".obs;

  RxList<EstimationHistoryListData> tableData = <EstimationHistoryListData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }

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
        await DropdownService.customerDropDown(isFilter: isFilter);
    customerDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      customerDropDown.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    });
    selectedCustomer(DropdownModel(value: "0", label: "All"));
  }

  Future getEstimationList(BuildContext context) async {
    isTableLoading(true);

    bool? isBillFilter;
    String? branchFilter;
    String? customerFilter;
    String? fromDate;
    String? toDate;

    if (selectedBillStatus.value!.value == "Billed") {
      isBillFilter = true;
    } else if (selectedBillStatus.value!.value == "Not Billed") {
      isBillFilter = false;
    } else {
      isBillFilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      branchFilter = selectedBranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedCustomer.value != null && selectedCustomer.value?.value != "0") {
      customerFilter = selectedCustomer.value?.value.toString();
    } else {
      customerFilter = null;
    }

    if (estimtaitonEntryDateFilterController.text.isNotEmpty) {
      fromDate = estimtaitonEntryDateFilterController.text.split(' to ')[0];
      toDate = estimtaitonEntryDateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchEstimationHistoryPayload payload = FetchEstimationHistoryPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        billStatus: isBillFilter,
        branch: isBranchuser.value ? branchFilter : null,
        customer: customerFilter,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? estimtaionList =
        await EstimationService.fetchEstimationList(payload: payload);

    if (estimtaionList != null) {
      tableData(estimtaionList['data']);
      totalpages(estimtaionList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  Future<RetrieveEstimationDetails?> getEstimationDetails(BuildContext context, String id) async {
    final RetrieveEstimationDetails? data = await EstimationService.retrieveEstimationDetail(context: context, estimationId: id);

    if (data != null) {
      return data;
    }
  }



   Future getestimationDetails(
      BuildContext context, EstimationHistoryListData item) async {

            final RetrieveEstimationDetails? data = await EstimationService.retrieveEstimationDetail(context: context, estimationId: item.id.toString());

    if (data != null) {
      particularData([]);
      currentestimationdetails(data);
      for(var i in currentestimationdetails.value?.particularDetails ?? []){
        particularData.add(i);
      }
      await Get.dialog(
          barrierDismissible: false,
          EstimationViewPopup());
    } else {
      currentestimationdetails(null);
    }
  } 
}
