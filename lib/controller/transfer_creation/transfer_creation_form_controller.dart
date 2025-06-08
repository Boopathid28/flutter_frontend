import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/transfer_creation/transfer_creation_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/transfer_creation/transfer_creation_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/transfer_creation/transfer_creation_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferCreationFormController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final transfercreationFormKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController metalSearchController = TextEditingController();

  TextEditingController transferCreationDateFilterController =
      TextEditingController();

  RxList<String> selectedItems = <String>[].obs;

  RxList<String> selectedRemoveItems = <String>[].obs;
  RxList<String> selectedcancellItems = <String>[].obs;
  RxList<String> selectedEditItems = <String>[].obs;

  Rx<TransferCreationDetailsData?> currentTransferCreation =
      Rx<TransferCreationDetailsData?>(null);

  RxList<TransferCreationDataListData> transfercreationdataparticularlist =
      <TransferCreationDataListData>[].obs;

  RxList<TransferCreationDataListData>
      transfercreationdataparticularUpdatelist =
      <TransferCreationDataListData>[].obs;
  RxList<TransferCreationDataListData> tableData =
      <TransferCreationDataListData>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> oldmetalDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedOldMetal = Rx<DropdownModel?>(null);

  RxString transfercreationFormMode = "create".obs;
  RxString stoneFormUpdateId = "".obs;
  RxBool isTableLoading = false.obs;
  RxBool isFormSubmit = false.obs;
  RxBool isFindLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getMetalList();
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

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    for (var item in tempList) {
      metalDropDown.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
    }
  }

  Future getOldItemDetailsList() async {
    metalDropDown([]);

    final List<OldMetalDropdownModel> tempList =
        await DropdownService.oldMetalDropDown();
    for (var item in tempList) {
      oldmetalDropDown
          .add(DropdownModel(label: item.oldRate!, value: item.id.toString()));
    }
  }

  Future gettransfercreationList(BuildContext context) async {
    String? metalfilter;
    String? brachfilter;
    String? fromdate;
    String? toDate;

    if (selectedMetal.value != null && selectedMetal.value?.value != "0") {
      metalfilter = selectedMetal.value?.value.toString();
    } else {
      metalfilter = null;
    }

    if (selectedBranch.value != null && selectedBranch.value?.value != "0") {
      brachfilter = selectedBranch.value?.value.toString();
    } else {
      brachfilter = null;
    }

    if (transferCreationDateFilterController.text.isNotEmpty) {
      fromdate = transferCreationDateFilterController.text.split(' to ')[0];
      toDate = transferCreationDateFilterController.text.split(' to ')[1];
    } else {
      fromdate = null;
      toDate = null;
    }

    TransferCreationDataListPayload payload = TransferCreationDataListPayload(
        metal: metalfilter,
        branch: brachfilter,
        fromDate: fromdate,
        toDate: toDate,
        menuId: await HomeSharedPrefs.getCurrentMenu());
    if (!isFindLoading.value) {

      isFindLoading(true);
      isTableLoading(true);

      final Map<String, dynamic>? transfercreation =
          await TransfercreationService.fetchTransfercreationDataList(
              payload: payload);
      if (transfercreation != null) {
        tableData(transfercreation['data']);

        for (var i in tableData.value) {
          final TransferCreationDataListData transferCreationDataListData =
              TransferCreationDataListData(
                  metalDetailsName: i.metalDetailsName,
                  grossWeight: i.grossWeight,
                  dustWeight: i.dustWeight,
                  netWeight: i.netWeight,
                  customerName: i.customerName,
                  id: i.id);
          transfercreationdataparticularlist.insert(
              0, transferCreationDataListData);
        }
      } else {
        tableData([]);
      }
isFindLoading(false);
      isTableLoading(false);
    }

  }

  void updateTempList(bool value, TransferCreationDataListData item) {
    if (value) {
      selectedItems.add(item.id.toString());
    } else {
      selectedItems.remove(item.id.toString());
    }
  }

  void updateRemoveTempList(bool value, TransferCreationDataListData item) {
    if (value) {
      selectedRemoveItems.add(item.id.toString());
      selectedcancellItems.remove(item.id.toString());
    } else {
      selectedRemoveItems.remove(item.id.toString());
      selectedcancellItems.add(item.id.toString());
    }
  }

  void updateNewTempList(bool value, TransferCreationDataListData item) {
    if (value) {
      selectedEditItems.add(item.id.toString());
    } else {
      selectedEditItems.remove(item.id.toString());
    }
  }

  Future submitTransferCreationForm(BuildContext context) async {
    if (transfercreationFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (transfercreationFormMode.value == "create") {
          String? fromdate;
          String? toDate;

          if (transferCreationDateFilterController.text.isNotEmpty) {
            fromdate =
                transferCreationDateFilterController.text.split(' to ')[0];
            toDate = transferCreationDateFilterController.text.split(' to ')[1];
          } else {
            fromdate = null;
            toDate = null;
          }

          List<int> templist = [];
          for (var i in transfercreationdataparticularlist.value) {
            templist.add(i.id!);
          }

          final TransferCreationPayload payload = TransferCreationPayload(
              metal: selectedMetal.value!.value,
              branch: selectedBranch.value?.value,
              fromDate: fromdate,
              toDate: toDate,
              oldItemDetails: selectedItems.value,
              menuId: await HomeSharedPrefs.getCurrentMenu());

          final Map<String, dynamic>? transfercreation =
              await TransfercreationService.createtransferCreation(
                  payload: payload, context: context);
          navTransferCreationList();
          resetForm();
        } else {
          final UpdateTransferCreationPayload payload =
              UpdateTransferCreationPayload(
                  menuId: await HomeSharedPrefs.getCurrentMenu(),
                  id: currentTransferCreation.value!.id,
                  removeItems: selectedcancellItems,
                  newItems: selectedEditItems);

          await TransfercreationService.updateTransferCreation(
              context: context, payload: payload);
        }
        isFormSubmit.value = false;
        resetForm();
        Get.back();
      }
    }
  }

  Future getTransferCreationDetails(
      BuildContext context, TransferCreationListData item) async {
    final TransferCreationDetailsData? data =
        await TransfercreationService.retrieveTransferCreation(
            context: context, transferId: item.id.toString());
    if (data != null) {
      currentTransferCreation(data);

      selectedMetal(DropdownModel(
          value: data!.metal.toString(), label: data.metalName.toString()));
      selectedBranch(DropdownModel(
          value: data!.branch.toString(), label: data.branchName.toString()));

      transferCreationDateFilterController.text =
          [data.fromDate, data.toDate].join(" to ");

      for (var i in data.oldItemDetails!) {
        final TransferCreationDataListData transferCreationDataListData =
            TransferCreationDataListData(
                metalDetailsName: i.metalDetailsName,
                dustWeight: i.dustWeight,
                olditemDetails: i.olditemDetails,
                netWeight: i.netWeight,
                grossWeight: i.grossWeight,
                customerName: i.customerName,
                id: i.id);
        transfercreationdataparticularUpdatelist.insert(
            0, transferCreationDataListData);
        // selectedItems.add(i.olditemDetails.toString());
      }
      for (var i in transfercreationdataparticularUpdatelist.value) {
        selectedRemoveItems.add(i.id.toString());
      }
      gettransfercreationList(context);
      transfercreationFormMode("update");
      Get.to(() => TransferCreationForm());
    } else {
      resetForm();
    }
  }

  resetForm() {
    transfercreationFormMode("create");
    selectedMetal.value = null;
    selectedBranch.value = null;
    selectedRemoveItems([]);
    selectedEditItems([]);
    selectedItems([]);
    selectedcancellItems([]);
    transferCreationDateFilterController.clear();
    transfercreationdataparticularUpdatelist([]);
    transfercreationdataparticularlist([]);
  }
}
