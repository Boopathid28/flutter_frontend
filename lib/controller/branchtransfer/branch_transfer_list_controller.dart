import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/branch_transfer/branch_transfer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/model/stock_assign/stock_assign_models.dart';
import 'package:ausales_application/service/branch_transfer_assign/branch_transfer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchTransferListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchboxController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxObjectMixin<DropdownModel?> selectedActiveStatus =
      DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive').obs;

  RxList<DropdownModel> activeStatusFilterList = [
    DropdownModel(value: 'Active/Inactive', label: 'Active/Inactive'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Inactive', label: 'Inactive')
  ].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = false.obs;
  RxBool validationisTableLoading = true.obs;
  RxList<BranchTransferListData> tableData = <BranchTransferListData>[].obs;
  Rx<ValidationAssignTagResponse?> tableDataValidation =
      Rx<ValidationAssignTagResponse?>(null);

  RxList<ItemTagdetailsList> itemtagParticularList = <ItemTagdetailsList>[].obs;

  RxList<DropdownModel> catalogdropdown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedCatalog = Rx<DropdownModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getCatalogDropdownList();
  }

  Future getCatalogDropdownList() async {
    catalogdropdown([]);
    final List<CatalogDropdownModel> tempList =
        await DropdownService.catalogDropDown();
    catalogdropdown.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      catalogdropdown.add(
          DropdownModel(label: item.catalogNumber!, value: item.id.toString()));
    });
    selectedCatalog(DropdownModel(value: "0", label: "All"));
  }

  Future getbranchTransferList(BuildContext context) async {
    isTableLoading(true);

    FetchBranchTransferListPayload payload = FetchBranchTransferListPayload(
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? branchtransfer =
        await BranchTransferService.fetctBranchTransferList(payload: payload);

    if (branchtransfer != null) {
      tableData(branchtransfer['data']);
      totalpages(branchtransfer['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }
}
