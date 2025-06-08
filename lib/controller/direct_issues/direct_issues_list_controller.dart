import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/direct_issues/direct_issues_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/direct_issues/direct_issues_services.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/direct_issues/direct_view_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectIssuesListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController vendorSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  TextEditingController dateFilterController = TextEditingController();
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<DirectIssuesListData> tableData = <DirectIssuesListData>[].obs;

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;

  RxList<ItemDetails> particularData = <ItemDetails>[].obs;
  Rx<RetriveDirectIssuesDetails?> currentdirectdetails =
      Rx<RetriveDirectIssuesDetails?>(null);

  @override
  void onInit() async {
    super.onInit();
    getVendorList();
  }

  Future getVendorList() async {
    vendorDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    vendorDropDown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
    selectedVendor(DropdownModel(value: "0", label: "All"));
  }

  FutureOr getdirectissuesList(BuildContext context) async {
    isTableLoading(true);

    String? fromDate;
    String? toDate;
    String? vendorFilter;

    if (selectedVendor.value != null && selectedVendor.value?.value != "0") {
      vendorFilter = selectedVendor.value!.value;
    } else {
      vendorFilter = null;
    }

    if (dateFilterController.text.isNotEmpty) {
      fromDate = dateFilterController.text.split(' to ')[0];
      toDate = dateFilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchDirectIssuesListPayload payload = FetchDirectIssuesListPayload(
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        fromDate: fromDate,
        toDate: toDate,
        designer: vendorFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? userList =
        await DirectIssuesServices.fetchDirectIssuesList(payload: payload);

    if (userList != null) {
      tableData(userList['data']);
      totalpages(userList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  Future getdirectDetails(
      BuildContext context, DirectIssuesListData item) async {
    final RetriveDirectIssuesDetails? data =
        await DirectIssuesServices.retrieveDirectItem(
            context: context, directId: item.id.toString());

    if (data != null) {
      particularData([]);
      currentdirectdetails(data);
      for (var i in currentdirectdetails.value?.itemDetails ?? []) {
        particularData.add(i);
      }
      await Get.dialog(
          barrierDismissible: false,
          DirectViewPopup());
    } else {
      currentdirectdetails(null);
    }
  }
}
