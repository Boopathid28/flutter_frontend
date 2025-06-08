import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/metal_rates/metal_rate_master.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/metal_rate_master/metal_rate_master_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MetalRateMasterListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final metalRateFormKey = GlobalKey<FormState>();


  TextEditingController datarangefilterController = TextEditingController();

  RxInt itemsPerPage = 12.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;
  RxBool isFormSubmit = false.obs;

  RxList<MetalRateMasterListData> tableData = <MetalRateMasterListData>[].obs;

  RxList<PurityDropdownModel> purityDropDown = <PurityDropdownModel>[].obs;
  RxList<MetalRateFormFieldModel> fieldList = <MetalRateFormFieldModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPurityList();
  }

  Future getPurityList() async {
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    purityDropDown(tempList);

    fieldList([]);

    tempList.forEach((item) {
      fieldList.add(MetalRateFormFieldModel(
          label: [item.metalMetalName, item.purityName].join(" "),
          value: "",
          purity: item.id.toString()));
    });
  }

  Future getMetalRateMasterList(BuildContext context) async {
    isTableLoading(true);
     String? fromDate;
    String? toDate;

      if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchMetalRateMasterListPayload payload = FetchMetalRateMasterListPayload(
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        fromDate: fromDate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? userList =
        await MetalRateMasterService.fetchMetalRateMasterList(payload: payload);

    if (userList != null) {
      tableData(userList['data']);
      totalpages(userList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }

    isTableLoading(false);
  }

  onFieldValueUpdate(index, value) {
    var tempList = <MetalRateFormFieldModel>[];
    for (var i = 0; i < fieldList.length; i++) {
      if (index == i) {
        tempList.add(MetalRateFormFieldModel(purity: fieldList[i].purity, value: value, label: fieldList[i].label));
      } else {
        tempList.add(fieldList[i]);
      }
    }
    fieldList(tempList);
  }

  Future submitMetalRateForm(BuildContext context) async {
    if (metalRateFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;

        List<MetalRates> ratesList = <MetalRates>[];

        for (var i in fieldList) {
          ratesList.add(MetalRates(purity: i.purity, rate: i.value!.isEmpty ? null : i.value));
        }

        final CreateMetalRateMasterPayload payload =
            CreateMetalRateMasterPayload(
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          metalRates: ratesList,
        );

        await MetalRateMasterService.createMetalRateMaster(context: context, payload: payload);
      }
      isFormSubmit.value = false;
      getMetalRateMasterList(context);
      resetForm();
    }
  }

  resetForm() {
    metalRateFormKey.currentState!.reset();
  }
}
