import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/lot/lot_item_form_controller.dart';
import 'package:ausales_application/controller/lot/lot_item_table_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/lot/lot_service.dart';
import 'package:ausales_application/view/screens/lot/lot_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class LotFormController extends HeaderController {
  final LotItemTableController _lotItemTableController =
      Get.put(LotItemTableController());
  final LotItemFormController _lotItemFormController =
      Get.put(LotItemFormController());

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

  Future submitLotFormDetails(BuildContext context) async {
    if (lotDetailsFormKey.currentState!.validate()) {
      if (_lotItemTableController.tableData.isEmpty) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.error,
            title: Text("Item list can not be empty"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      } else {
        isFormSubmit(true);

        if (fromMode.value == 'create') {
          final CreateLotDetailsPayload payload = CreateLotDetailsPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              entryDate: entryDateController.text,
              entryType: selectedEntryType.value!.value,
              designerDetails: selectedDesigner.value!.value,
              branch: isBranchuser.value ? selectedBranch.value!.value : null,
              refInvoiceNumber: refInvoiceNoController.text,
              hallmarkCertificateNumber: hallmarkCertificateNoController.text,
              hallmarkCenter: hallmarkCentreNoController.text,
              itemDetails: _lotItemTableController.tableData.value);
          final CreateLotDetailsResponse? data =
              await LotService.createLot(context: context, payload: payload);

          if (data != null) {
            navLotList();
          }
        } else {
          final UpdateLotPayload payload = UpdateLotPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              id: currentLotId.value,
              entryDate: entryDateController.text,
              entryType: selectedEntryType.value!.value,
              designerDetails: selectedDesigner.value!.value,
              branch: isBranchuser.value ? selectedBranch.value!.value : null,
              refInvoiceNumber: refInvoiceNoController.text,
              hallmarkCertificateNumber: hallmarkCertificateNoController.text,
              hallmarkCenter: hallmarkCentreNoController.text,
              itemDetails: _lotItemTableController.tableData.value);

          final CreateLotDetailsResponse? data =
              await LotService.updateLot(context: context, payload: payload);

          if (data != null) {
            navLotList();
          }
        }

        isFormSubmit(false);
      }
    }
  }

  Future getLotDetails(BuildContext context, LotListData item) async {
    LotDetailsData? data = await LotService.retrieveLot(
        context: context, lotId: item.id.toString());

    if (data != null) {
      fromMode("update");
      currentLotId(data.id);

      entryDateController.text = data.entryDate ?? "";
      refInvoiceNoController.text = data.refInvoiceNumber ?? "";
      hallmarkCertificateNoController.text =
          data.hallmarkCertificateNumber ?? "";
      hallmarkCentreNoController.text = data.hallmarkCenter ?? "";

      selectedBranch(DropdownModel(
          value: data.branch.toString(), label: data.branchName.toString()));
      selectedDesigner(DropdownModel(
          value: data.designerDetails.toString(),
          label: data.designerName.toString()));
      selectedEntryType(DropdownModel(
          value: data.entryType.toString(),
          label: data.entryTypeName.toString()));

      final List<LotFormItemDataModel> tempItemList = <LotFormItemDataModel>[];

      for (var element in data.itemList!) {
        tempItemList.add(LotFormItemDataModel(
            id: element.id,
            isDb: element.isDb,
            itemDetails: element.itemDetails,
            itemDetailsName: element.itemDetailsName,
            pieces: element.pieces.toString(),
            tagCount: element.tagCount.toString(),
            grossWeight: element.grossWeight.toString(),
            remark: element.remark.toString()));
      }

      _lotItemTableController.tableData(tempItemList);

      Get.to(() => LotFormScreen());
    }
  }

  void goBack() {
    fromMode("create");
    _lotItemFormController.resetForm();
    entryDateController.clear();
    selectedBranch.value = null;
    selectedEntryType.value = null;
    selectedDesigner.value = null;
    refInvoiceNoController.clear();
    hallmarkCertificateNoController.clear();
    hallmarkCentreNoController.clear();
    _lotItemTableController.tableData([]);
    Get.back();
  }

  void resetForm() {
    fromMode("create");
    _lotItemFormController.resetForm();
    entryDateController.clear();
    selectedBranch.value = null;
    selectedEntryType.value = null;
    selectedDesigner.value = null;
    refInvoiceNoController.clear();
    hallmarkCertificateNoController.clear();
    hallmarkCentreNoController.clear();
    _lotItemTableController.tableData([]);
  }
}
