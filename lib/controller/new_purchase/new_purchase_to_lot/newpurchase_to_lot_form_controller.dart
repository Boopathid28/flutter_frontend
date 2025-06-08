import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_item_table_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:ausales_application/model/new_purchase/new_pharchase_item_list.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/lot/lot_service.dart';
import 'package:ausales_application/service/new_purchase/new_pharchase_to_lot_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class NewpurchaseToLotFormController extends HeaderController {
  final NewpurchaseToLotItemTableController
      _newpurchaseToLotItemTableController =
      Get.put(NewpurchaseToLotItemTableController());

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final lotDetailsFormKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Rx<int?> currentLotId = Rx<int?>(null);

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController designerSearchController = TextEditingController();

  TextEditingController entryDateController = TextEditingController();
  TextEditingController refInvoiceNoController = TextEditingController();
  TextEditingController hallmarkCertificateNoController =
      TextEditingController();
  TextEditingController hallmarkCentreNoController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedEntryType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedDesigner = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> entryTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> designerDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    getBranchList();
    getIsBranchUser();
    getEntryTypeList();
    getDesignerList();
    fromMode("create");
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getEntryTypeList() async {
    entryTypeDropDown([]);
    final List<EntryTypeDropdownModel> tempList =
        await DropdownService.entryTypeDropDown();
    tempList.forEach((item) {
      entryTypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getDesignerList() async {
    designerDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      designerDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    });
  }


  void onTagcountChange(String value, String id) {
    int itemIndex = _newpurchaseToLotItemTableController.lotitemParticularList
        .indexWhere((item) => item.id.toString() == id);
    var dataList = [..._newpurchaseToLotItemTableController.lotitemParticularList.value];
    LotFormItemDataModel item = dataList[itemIndex];
    var jsonObjectItem = item.toJson();
    jsonObjectItem['tag_count'] = value;
    LotFormItemDataModel updatedItem =
        LotFormItemDataModel.fromJson(jsonObjectItem);

    _newpurchaseToLotItemTableController.lotitemParticularList[itemIndex] = updatedItem;
  }

  Future submitLotFormDetails(BuildContext context) async {
    if (lotDetailsFormKey.currentState!.validate()) {
      if (_newpurchaseToLotItemTableController.lotitemParticularList.isEmpty) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text("Item list Tag Number can not be empty"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
        isFormSubmit(true);

        final CreateLotDetailsPayload payload = CreateLotDetailsPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            entryDate: entryDateController.text,
            entryType: selectedEntryType.value!.value,
            designerDetails: selectedDesigner.value!.value,
            branch: isBranchuser.value ? selectedBranch.value!.value : null,
            refInvoiceNumber: refInvoiceNoController.text,
            hallmarkCertificateNumber: hallmarkCertificateNoController.text,
            hallmarkCenter: hallmarkCentreNoController.text,
            itemDetails: _newpurchaseToLotItemTableController.lotitemParticularList.value);
        final CreateLotDetailsResponse? data =
            await LotService.createLot(context: context, payload: payload);

        if (data != null) {
          navLotList();
          goBack();
        }

        isFormSubmit(false);
      }
    }
  }

  Future getLotDetails(BuildContext context, int? item) async {
    NewPurchaseItemDetails? data =
        await NewPharchaseToLotService.retrievePurchaseDetails(
            context: context, PoId: item.toString());
    if (data != null) {
      selectedBranch(DropdownModel(
          value: data.branchId.toString(), label: data.branchName.toString()));

      selectedDesigner(DropdownModel(
          value: data.vendorDetails.toString(),
          label: data.vendorName.toString()));

      refInvoiceNoController.text = data.poId!;
    }
  }

  void goBack() {
    entryDateController.clear();
    selectedBranch.value = null;
    selectedEntryType.value = null;
    selectedDesigner.value = null;
    refInvoiceNoController.clear();
    hallmarkCertificateNoController.clear();
    hallmarkCentreNoController.clear();
    _newpurchaseToLotItemTableController.lotitemParticularList([]);
  }
}
