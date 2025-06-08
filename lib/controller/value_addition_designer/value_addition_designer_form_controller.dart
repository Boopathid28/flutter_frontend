import 'dart:developer';

import 'package:ausales_application/controller/value_addition_designer/value_addition_designer_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/value_addition_designer/value_addition_designer_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/value_addition_designer/value_addition_designer_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/value_addition_designer/value_addition_designer_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueAdditionDesignerFormController extends GetxController {
  final ValueAdditionDesignerListController
      _valueAdditionDesignerListController =
      Get.put(ValueAdditionDesignerListController());

  TextEditingController subitemDetailSearchController = TextEditingController();
  TextEditingController designerSearchController = TextEditingController();

  final valueadditionFormKey = GlobalKey<FormState>();

  Rx<ValueAdditionDesignerDetailsData?> currentValueAddition =
      Rx<ValueAdditionDesignerDetailsData?>(null);

  TextEditingController fixedRateController = TextEditingController();
  TextEditingController touchController = TextEditingController();

  TextEditingController wastagePercentageController = TextEditingController();
  TextEditingController flatWastageController = TextEditingController();
  TextEditingController makingChargePerGramController = TextEditingController();
  TextEditingController flatMakingChargeController = TextEditingController();

  TextEditingController perGramRateController = TextEditingController();

  TextEditingController perPieceRateController = TextEditingController();

  Rx<DropdownModel?> selectedDesigner = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedWastageCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMakingChargeCalcuationType =
      Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPerGramCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFlatWastageType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> designerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subitemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> calculationTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> weightTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> flatWastageTypeDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    getSubItemList();
    getWeightTypeList();
    getFlatWastageTypeList();
    getDesignerList();
    getCalculationTypeList();
  }

  Future getSubItemList() async {
    subitemDropDown([]);
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: null);
    tempList.forEach((item) {
      subitemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.subItemName.toString()));
    });
  }

  Future getDesignerList() async {
    designerDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      designerDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.designerName.toString()));
    });
  }

  Future getCalculationTypeList() async {
    calculationTypeDropDown([]);
    final List<CalculationTypeDropdownModel> tempList =
        await DropdownService.calculationTypeDropDown();
    tempList.forEach((item) {
      calculationTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
    });
  }

  Future getWeightTypeList() async {
    weightTypeDropDown([]);
    final List<WeightTypeDropdownModel> tempList =
        await DropdownService.weightTypeDropDown();
    tempList.forEach((item) {
      weightTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
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
    if (tempList.isNotEmpty) {
      selectedFlatWastageType(
          DropdownModel(value: tempList[0].value!, label: tempList[0].lable!));
    }
  }

  Future submitValueadditiondesignerForm(BuildContext context) async {
    if (valueadditionFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          var payload;

          if (selectedCalculationType.value?.value == fixedRateCalcType) {
            payload = CreateValueAdditionDesignerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                designerDetails: selectedDesigner.value!.value,
                calculationType: selectedCalculationType.value!.value,
                fixedRate: fixedRateController.text,
                touch: null,
                wastageCalculationType: null,
                wastagePercent: null,
                flatWastageType: null,
                flatWastage: null,
                makingChargeCalculationType: null,
                makingChargePerGram: null,
                flatMakingCharge: null,
                perGramWeightType: null,
                perGramRate: null,
                perPieceRate: null);
          } else if (selectedCalculationType.value?.value == weightCalcType) {
            payload = CreateValueAdditionDesignerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                designerDetails: selectedDesigner.value!.value,
                calculationType: selectedCalculationType.value!.value,
                fixedRate: null,
                touch: touchController.text,
                wastageCalculationType:
                    selectedWastageCalcuationType.value!.value,
                wastagePercent: wastagePercentageController.text,
                flatWastageType: selectedFlatWastageType.value!.value,
                flatWastage: flatWastageController.text,
                makingChargeCalculationType:
                    selectedMakingChargeCalcuationType.value!.value,
                makingChargePerGram: makingChargePerGramController.text,
                flatMakingCharge: flatWastageController.text,
                perGramWeightType: null,
                perGramRate: null,
                perPieceRate: null);
          } else if (selectedCalculationType.value?.value ==
              perGramRateCalcType) {
            payload = CreateValueAdditionDesignerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                designerDetails: selectedDesigner.value!.value,
                calculationType: selectedCalculationType.value!.value,
                fixedRate: null,
                touch: null,
                wastageCalculationType: null,
                wastagePercent: null,
                flatWastageType: null,
                flatWastage: null,
                makingChargeCalculationType: null,
                makingChargePerGram: null,
                flatMakingCharge: null,
                perGramWeightType: selectedPerGramCalcuationType.value!.value,
                perGramRate: perGramRateController.text,
                perPieceRate: null);
          } else if (selectedCalculationType.value?.value ==
              perPieceRateCalcType) {
            payload = CreateValueAdditionDesignerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                designerDetails: selectedDesigner.value!.value,
                calculationType: selectedCalculationType.value!.value,
                fixedRate: null,
                touch: null,
                wastageCalculationType: null,
                wastagePercent: null,
                flatWastageType: null,
                flatWastage: null,
                makingChargeCalculationType: null,
                makingChargePerGram: null,
                flatMakingCharge: null,
                perGramWeightType: null,
                perGramRate: null,
                perPieceRate: perPieceRateController.text);
          }

          await ValueAdditionDesignerService.createValueadditiondesigner(
              context: context, payload: payload);
          _valueAdditionDesignerListController
              .getValueAdditionDesignerlist(context);
        } else {
          var payload;

          if (selectedCalculationType.value?.value == fixedRateCalcType) {
            payload = UpdateValueAdditionDesignerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              designerDetails: int.parse(selectedDesigner.value!.value),
              subItemDetails: int.parse(selectedSubItem.value!.value),
              calculationType: selectedCalculationType.value!.value,
              fixedRate: fixedRateController.text,
               touch: null,
              wastageCalculationType: null,
              wastagePercent: null,
              flatWastageType: null,
              flatWastage: null,
              makingChargeCalculationType: null,
              makingChargePerGram: null,
              flatMakingCharge: null,
              perGramWeightType: null,
              perGramRate: null,
              perPieceRate: null,
              id: currentValueAddition.value!.id,);
          } else if (selectedCalculationType.value?.value == weightCalcType) {
            payload = UpdateValueAdditionDesignerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              designerDetails: int.parse(selectedDesigner.value!.value),
              subItemDetails: int.parse(selectedSubItem.value!.value),
              calculationType: selectedCalculationType.value!.value,
              fixedRate: null,
               touch: touchController.text,
              wastageCalculationType:
                  selectedWastageCalcuationType.value!.value,
              wastagePercent: wastagePercentageController.text,
              flatWastageType: selectedFlatWastageType.value!.value,
              flatWastage: flatWastageController.text,
              makingChargeCalculationType:
                  selectedMakingChargeCalcuationType.value!.value,
              makingChargePerGram: makingChargePerGramController.text,
              flatMakingCharge: flatWastageController.text,
              perGramWeightType: null,
              perGramRate: null,
              perPieceRate: null,
              id: currentValueAddition.value!.id,);
          } else if (selectedCalculationType.value?.value == perGramRateCalcType) {
            payload = UpdateValueAdditionDesignerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              designerDetails: int.parse(selectedDesigner.value!.value),
              subItemDetails: int.parse(selectedSubItem.value!.value),
              calculationType: selectedCalculationType.value!.value,
              fixedRate: null,
               touch: null,
              wastageCalculationType: null,
              wastagePercent: null,
              flatWastageType: null,
              flatWastage: null,
              makingChargeCalculationType: null,
              makingChargePerGram: null,
              flatMakingCharge: null,
              perGramWeightType: selectedPerGramCalcuationType.value!.value,
              perGramRate: perGramRateController.text,
              perPieceRate: null,
            id: currentValueAddition.value!.id,);
          } else if (selectedCalculationType.value?.value == perPieceRateCalcType) {
            payload = UpdateValueAdditionDesignerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
             designerDetails: int.parse(selectedDesigner.value!.value),
              subItemDetails: int.parse(selectedSubItem.value!.value),
              calculationType: selectedCalculationType.value!.value,
              fixedRate: null,
               touch: null,
              wastageCalculationType: null,
              wastagePercent: null,
              flatWastageType: null,
              flatWastage: null,
              makingChargeCalculationType: null,
              makingChargePerGram: null,
              flatMakingCharge: null,
              perGramWeightType: null,
              perGramRate: null,
              perPieceRate: perGramRateController.text,
             id: currentValueAddition.value!.id,);
          }
          await ValueAdditionDesignerService.updateValueAdditionDesigner(
              context: context, payload: payload);
          _valueAdditionDesignerListController.getValueAdditionDesignerlist(context);
        }
        resetForm();
        Get.back();
      }
    }
  }

  resetForm() {
    Get.back();
    isFormSubmit.value = false;
    valueadditionFormKey.currentState!.reset();
    currentValueAddition.value = null;
    selectedDesigner.value = null;
    selectedSubItem.value = null;
    selectedCalculationType.value = null;

    fixedRateController.clear();

    touchController.clear();
    selectedWastageCalcuationType.value = null;
    wastagePercentageController.clear();
    selectedFlatWastageType.value = null;
    flatWastageController.clear();
    selectedMakingChargeCalcuationType.value = null;
    makingChargePerGramController.clear();
    flatMakingChargeController.clear();

    selectedPerGramCalcuationType.value = null;
    perGramRateController.clear();

    perPieceRateController.clear();

    fromMode("create");
  }

  Future getValueAdditionDesignerDetails(
      BuildContext context, ValueAdditionListData item) async {
    final ValueAdditionDesignerDetailsData? data =
        await ValueAdditionDesignerService.retrieveValueAdditionDesigner(
            context: context, valueadditionId: item.id.toString());

    if (data != null) {

      currentValueAddition(data);

      selectedDesigner(DropdownModel(
          value: data.designerDetails.toString(),
          label: data.designerDetailsName.toString()));
           selectedSubItem(DropdownModel(
          value: data.subItemDetails.toString(),
          label: data.subItemDetailsName.toString()));
      selectedCalculationType(DropdownModel(
          value: data.calculationType!,
          label: data.calculationTypeName.toString()));

      fixedRateController.text = data.fixedRate.toString();

      touchController.text = data.touch.toString();
      selectedWastageCalcuationType(DropdownModel(
          value: data.wastageCalculationType.toString(),
          label: data.wastageCalculationTypeName.toString()));
      wastagePercentageController.text = data.wastagePercent.toString();
      selectedFlatWastageType(DropdownModel(
          value: data.flatWastageType.toString(),
          label: data.flatWastageTypeName.toString()));
      flatWastageController.text = data.flatWastage.toString();
      selectedMakingChargeCalcuationType(DropdownModel(
          value: data.makingChargeCalculationType.toString(),
          label: data.makingChargeCalculationTypeName.toString()));
      makingChargePerGramController.text = data.makingChargePerGram.toString();
      flatMakingChargeController.text = data.flatMakingCharge.toString();

      selectedPerGramCalcuationType(DropdownModel(
          value: data.perGramWeightType.toString(),
          label: data.perGramWeightTypeName.toString()));
      perGramRateController.text = data.perGramRate.toString();

      perPieceRateController.text = data.perPieceRate.toString();

      fromMode("update");

      await Get.dialog(
          barrierDismissible: false,
          ValueAdditionDesignerForm());
    } else {
      resetForm();
    }
  }
}
