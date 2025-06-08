import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/bulk_tag_update/bulk_tag_update_model.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/bulk_tag_update/bulk_tag_update_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class BulkTagUpdateController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController searchMetalController = TextEditingController();
  TextEditingController searchPurityController = TextEditingController();
  TextEditingController searchItemController = TextEditingController();
  TextEditingController searchSubItemController = TextEditingController();
  TextEditingController searchBranchController = TextEditingController();

  TextEditingController fromWeightController = TextEditingController();
  TextEditingController toWeightController = TextEditingController();

  Rx<DropdownModel?> selectedCalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubitem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedTagType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedWeightType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> calculationTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> purityDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subitemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> tagtypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> weighttypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  RxList<BulkTagListData> tableData = <BulkTagListData>[].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = false.obs;
  RxBool isFilterFormSubmit = false.obs;
  RxBool isUpdateFormSubmit = false.obs;
  RxBool isFiltered = true.obs;


  // Form fields
  TextEditingController minFixedRateController = TextEditingController();
  TextEditingController fixedRateController = TextEditingController();

  TextEditingController minWastagePercentageController =
      TextEditingController();
  TextEditingController wastagePercentageController = TextEditingController();
  TextEditingController minFlatWastageController = TextEditingController();
  TextEditingController flatWastageController = TextEditingController();
  TextEditingController minMakingChargePerGramController =
      TextEditingController();
  TextEditingController makingChargePerGramController = TextEditingController();
  TextEditingController minFlatMakingChargeController = TextEditingController();
  TextEditingController flatMakingChargeController = TextEditingController();

  TextEditingController minPerGramRateController = TextEditingController();
  TextEditingController perGramRateController = TextEditingController();

  TextEditingController minPerPieceRateController = TextEditingController();
  TextEditingController perPieceRateController = TextEditingController();

  Rx<DropdownModel?> selectedWastageCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMakingChargeCalcuationType =
      Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPerGramCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFlatWastageType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> flatWastageTypeDropDown = <DropdownModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    isFiltered(false);
    getCalculationTypeList();
    getMetalList();
    getPurityList(null);
    getItemList(null, null);
    getSubItemList(null, null, null);
    getBranchList();
    getIsBranchUser();
    getTagTypeList(null);
    getWeightTypeList();
    getFlatWastageTypeList();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    tempList.forEach((item) {
      metalDropDown.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
  }

  Future getPurityList(String? metal) async {
    purityDropDown([]);
    selectedPurity.value = null;
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(metal);
    tempList.forEach((item) {
      purityDropDown.add(
          DropdownModel(label: item.purityName!, value: item.id.toString()));
    });
  }

  Future getItemList(String? purity, String? metal) async {
    itemDropDown([]);
    selectedItem.value = null;
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown(purity: purity, metal: metal);
    tempList.forEach((item) {
      itemDropDown
          .add(DropdownModel(label: item.itemName!, value: item.id.toString()));
    });
  }

  Future getSubItemList(String? item, String? metal, String? purity) async {
    subitemDropDown([]);
    selectedSubitem.value = null;
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: item, metal: metal, purity: purity);
    tempList.forEach((item) {
      subitemDropDown.add(
          DropdownModel(label: item.subItemName!, value: item.id.toString()));
    });
  }

  Future getCalculationTypeList() async {
    calculationTypeDropDown([]);
    final List<CalculationTypeDropdownModel> tempList =
        await DropdownService.calculationTypeDropDown();
    tempList.forEach((item) {
      calculationTypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getTagTypeList(String? metal) async {
    tagtypeDropDown([]);
    selectedTagType.value = null;
    final List<TagTypeDropdownModel> tempList =
        await DropdownService.tagTypeDropDown(metal: metal);
    tempList.forEach((item) {
      tagtypeDropDown
          .add(DropdownModel(label: item.tagName!, value: item.id.toString()));
    });
  }

  Future getWeightTypeList() async {
    weighttypeDropDown([]);
    final List<WeightTypeDropdownModel> tempList =
        await DropdownService.weightTypeDropDown();
    tempList.forEach((item) {
      weighttypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getFlatWastageTypeList() async {
    flatWastageTypeDropDown([]);
    final List<FlatWastageTypeDropdownModel> tempList =
        await DropdownService.flatWastageTypeDropDown();
    tempList.forEach((item) {
      flatWastageTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
    });
  }

  Future getTagDetailsList(BuildContext context) async {

    if (selectedCalculationType.value != null) {

      if (!isFilterFormSubmit.value) {
        isTableLoading(true);
        isFilterFormSubmit(true);
        int? menuId = await HomeSharedPrefs.getCurrentMenu();
        BulkTagListPayload payload = BulkTagListPayload(
          calculationType: selectedCalculationType.value?.value,
          metal: selectedMetal.value?.value,
          purity: selectedPurity.value?.value,
          item: selectedItem.value?.value,
          subItem: selectedSubitem.value?.value,
          tagType: selectedTagType.value?.value,
          weightType: selectedWeightType.value?.value,
          branch: selectedBranch.value?.value,
          fromWeight: fromWeightController.text,
          toWeight: toWeightController.text,
          menuId: menuId.toString(),
          page: page.value.toString(),
          itemsPerPage: itemsPerPage.value.toString()
        );


        final data = await BulkTagUpdateService.retrieveTagdetails(payload: payload, context: context);

        if (data != null) {
          if (data['data'].length > 0) {
            isFiltered(true);
          } else {
            toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.error,
              title: Text('No data found'),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
            isFiltered(false);
          }
          tableData(data['data']);
          totalpages(data['total_pages']);
        }

        isTableLoading(false);
        isFilterFormSubmit(false);
      } 
    } else {
        toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.error,
              title: Text('Calculation type is required'),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
      }
      
  }



  resetForm() {
    fromWeightController.clear();
    toWeightController.clear();

    selectedCalculationType.value = null;
    selectedBranch.value = null;
    selectedMetal.value = null;
    selectedPurity.value = null;
    selectedItem.value = null;
    selectedSubitem.value = null;
    selectedTagType.value = null;
    selectedWeightType.value = null;

    getCalculationTypeList();
    getMetalList();
    getPurityList(null);
    getItemList(null, null);
    getSubItemList(null, null, null);
    getBranchList();
    getIsBranchUser();
    getTagTypeList(null);
    getWeightTypeList();
  }

  resetUpdateForm() {
    selectedWastageCalcuationType.value = null;
    wastagePercentageController.clear();
    minWastagePercentageController.clear();
    selectedFlatWastageType.value = null;
    flatMakingChargeController.clear();
    minFlatWastageController.clear();
    selectedMakingChargeCalcuationType.value = null;
    minMakingChargePerGramController.clear();
    makingChargePerGramController.clear();
    flatMakingChargeController.clear();
    minFlatMakingChargeController.clear();

    fixedRateController.clear();
    minFixedRateController.clear();

    perPieceRateController.clear();
    minPerPieceRateController.clear();

    selectedPerGramCalcuationType.value = null;
    perGramRateController.clear();
    minPerGramRateController.clear();
  }

  Future updateTagdetails(BuildContext context) async {
    if (!isUpdateFormSubmit.value) {
      isUpdateFormSubmit(true);
      int? menuId = await HomeSharedPrefs.getCurrentMenu();
      if (selectedCalculationType.value!.value == fixedRateCalcType) {
        BulkTagUpdatePayload payload = BulkTagUpdatePayload(
          menuId: menuId,
          calculationType: selectedCalculationType.value?.value,
          branch: isBranchuser.value ? selectedBranch.value?.value : null,
          metal: selectedMetal.value?.value,
          purity: selectedPurity.value?.value,
          item: selectedItem.value?.value,
          subItem: selectedSubitem.value?.value,
          tagType: selectedTagType.value?.value,
          weightType: selectedWeightType.value?.value,
          fromWeight: fromWeightController.text,
          toWeight: toWeightController.text,
          minFixedRate: double.parse(minFixedRateController.text.isEmpty ? "0" : minFixedRateController.text),
          fixedRate: double.parse(fixedRateController.text.isEmpty ? "0" : fixedRateController.text),
        );
        
        final String? data = await BulkTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          isFiltered(false);
          resetUpdateForm();
        }
      } else if (selectedCalculationType.value!.value == perPieceRateCalcType) {
        BulkTagUpdatePayload payload = BulkTagUpdatePayload(
          menuId: menuId,
          calculationType: selectedCalculationType.value?.value,
          branch: isBranchuser.value ? selectedBranch.value?.value : null,
          metal: selectedMetal.value?.value,
          purity: selectedPurity.value?.value,
          item: selectedItem.value?.value,
          subItem: selectedSubitem.value?.value,
          tagType: selectedTagType.value?.value,
          weightType: selectedWeightType.value?.value,
          fromWeight: fromWeightController.text,
          toWeight: toWeightController.text,
          minPerPieceRate: double.parse(minPerPieceRateController.text.isEmpty ? "0" : minPerPieceRateController.text),
          perPieceRate: double.parse(perPieceRateController.text.isEmpty ? "0" : perPieceRateController.text),
        );
        final String? data = await BulkTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          isFiltered(false);
          resetUpdateForm();
        }
      } else if (selectedCalculationType.value!.value == perGramRateCalcType) {
        BulkTagUpdatePayload payload = BulkTagUpdatePayload(
          menuId: menuId,
          calculationType: selectedCalculationType.value?.value,
          branch: isBranchuser.value ? selectedBranch.value?.value : null,
          metal: selectedMetal.value?.value,
          purity: selectedPurity.value?.value,
          item: selectedItem.value?.value,
          subItem: selectedSubitem.value?.value,
          tagType: selectedTagType.value?.value,
          weightType: selectedWeightType.value?.value,
          fromWeight: fromWeightController.text,
          toWeight: toWeightController.text,
          perGramWeightType: selectedPerGramCalcuationType.value?.value,
          minPerGramRate: double.parse(minPerGramRateController.text.isEmpty ? "0" : minPerGramRateController.text),
          perGramRate: double.parse(perGramRateController.text.isEmpty ? "0" : perGramRateController.text),
        );
        
        final String? data = await BulkTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          isFiltered(false);
          resetUpdateForm();
        }
      } else if (selectedCalculationType.value!.value == weightCalcType) {
        BulkTagUpdatePayload payload = BulkTagUpdatePayload(
          menuId: menuId,
          calculationType: selectedCalculationType.value?.value,
          branch: isBranchuser.value ? selectedBranch.value?.value : null,
          metal: selectedMetal.value?.value,
          purity: selectedPurity.value?.value,
          item: selectedItem.value?.value,
          subItem: selectedSubitem.value?.value,
          tagType: selectedTagType.value?.value,
          weightType: selectedWeightType.value?.value,
          fromWeight: fromWeightController.text,
          toWeight: toWeightController.text,
          wastageCalculationType: selectedWastageCalcuationType.value?.value,
          minWastagePercent: double.parse(minWastagePercentageController.text.isEmpty ? "0" : minWastagePercentageController.text),
          wastagePercent: double.parse(wastagePercentageController.text.isEmpty ? "0" : wastagePercentageController.text),
          flatWastageType: selectedFlatWastageType.value?.value,
          minFlatWastage: double.parse(minFlatWastageController.text.isEmpty ? "0" : minFlatWastageController.text),
          flatWastage: double.parse(flatWastageController.text.isEmpty ? "0" : flatWastageController.text),
          makingChargeCalculationType: selectedMakingChargeCalcuationType.value?.value,
          minMakingChargePerGram: double.parse(minMakingChargePerGramController.text.isEmpty ? "0" : minMakingChargePerGramController.text),
          makingChargePerGram: double.parse(makingChargePerGramController.text.isEmpty ? "0" : makingChargePerGramController.text),
          minFlatMakingCharge: double.parse(minFlatMakingChargeController.text.isEmpty ? "0" : minFlatMakingChargeController.text),
          flatMakingCharge: double.parse(flatMakingChargeController.text.isEmpty ? "0" : flatMakingChargeController.text),
        );

        final String? data = await BulkTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          isFiltered(false);
          resetUpdateForm();
        }
      }

      isUpdateFormSubmit(false);
    }
  }
}