import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/approval_issues/approval_issues_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/model/vendor_discount/vendor_discount_model.dart';
import 'package:ausales_application/service/approval_issues/approval_issues_services.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovalIssuesListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController vendorSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  TextEditingController dateFilterController = TextEditingController();
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<ApprovalIssuesListData> tableData = <ApprovalIssuesListData>[].obs;

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;


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

  FutureOr getapprovalissuesList(BuildContext context) async {
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

    FetchApprovalIssuesListPayload payload = FetchApprovalIssuesListPayload(
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        fromDate: fromDate,
        toDate: toDate,
        designer: vendorFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? userList =
        await ApprovalIssuesServices.fetchApprovalIssuesList(payload: payload);

    if (userList != null) {

      tableData(userList['data']);
      totalpages(userList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
