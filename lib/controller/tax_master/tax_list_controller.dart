import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/tax/tax_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/tax_master/tax_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController searchController = TextEditingController();
  TextEditingController metalSearchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<TaxListData> tableData = <TaxListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  Future getMetalList() async {
    metalFilterList([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    metalFilterList.add(DropdownModel(value: "0", label: "All"));
    tempList.forEach((item) {
      metalFilterList.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
    selectedMetal(DropdownModel(value: "0", label: "All"));
  }

  Future getTaxList(BuildContext context) async {
    isTableLoading(true);
    
    String? metalFilter;

    if (selectedMetal.value != null && selectedMetal.value?.value != "0") {
      metalFilter = selectedMetal.value?.value.toString();
    } else {
      metalFilter = null;
    }

    FetchTaxListPayload payload = FetchTaxListPayload(
        search: searchController.text,
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        metal: int.tryParse(metalFilter ?? ''),
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? taxlist =
        await TaxService.fetchTaxList(payload: payload);

    if (taxlist != null) {
      tableData(taxlist['data']);
      totalpages(taxlist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }
}
