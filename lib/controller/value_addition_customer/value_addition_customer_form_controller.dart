import 'dart:developer';

import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/value_addition_customer/value_addition_customer_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/value_addition_customer/value_addition_customer_service.dart';
import 'package:ausales_application/view/screens/value_addition_customer/value_addition_customer_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueAdditionCustomerFormController extends GetxController {
  final ValueAdditionCustomerListController
      _valueAdditionCustomerListController =
      Get.put(ValueAdditionCustomerListController());

  TextEditingController subitemDetailSearchController = TextEditingController();

  final valueadditioncustomerFormKey = GlobalKey<FormState>();

  Rx<ValueAdditionCustomerDetailsData?> currentValueAdditionCustomer =
      Rx<ValueAdditionCustomerDetailsData?>(null);

  TextEditingController minFixedRateController = TextEditingController();
  TextEditingController fixedRateController = TextEditingController();

  TextEditingController fromweightController = TextEditingController();
  TextEditingController toweightController = TextEditingController();

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

  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);

  Rx<DropdownModel?> selectedCalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedWastageCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMakingChargeCalcuationType =
      Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPerGramCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFlatWastageType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> subitemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> calculationTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> weightTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> flatWastageTypeDropDown = <DropdownModel>[].obs;

  RxList<SubItemDropdownModel> subItemList = <SubItemDropdownModel>[].obs;
  Rx<String?> selectedCalculation = Rx<String?>(null);

  RxList<ValueAdditionGetTagDetails> tableDataList =
      <ValueAdditionGetTagDetails>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool isFormFind = false.obs;
  RxBool isFormClose = false.obs;

  RxString fromMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    getSubItemList();
    getWeightTypeList();
    getFlatWastageTypeList();
    getCalculationTypeList();
  }

  Future getSubItemList() async {
    subitemDropDown([]);
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: null);
    subItemList(tempList);
    tempList.forEach((item) {
      subitemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.subItemName.toString()));
    });
  }

  Future getCalculationType(String id) async {
    for (var i in subItemList) {
      if (i.id.toString() == id) {
        selectedCalculation(i.calculationType);
        break;
      }
    }
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

  Future submitValueadditioncustomerForm(BuildContext context) async {
    if (valueadditioncustomerFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        if (fromMode.value == "create") {
          var payload;

          if (selectedCalculation.value == fixedRateCalcType) {
            payload = CreateValueAdditionCustomerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                fromWeight: "0",
                toWeight: "0",
                minFixedRate: minFixedRateController.text,
                fixedRate: fixedRateController.text,
                wastageCalculationType: null,
                minWastagePercent: null,
                wastagePercent: null,
                flatWastageType: null,
                minFlatWastage: null,
                flatWastage: null,
                makingChargeCalculationType: null,
                minMakingChargePerGram: null,
                makingChargePerGram: null,
                minFlatMakingCharge: null,
                flatMakingCharge: null,
                perGramWeightType: null,
                minPerGramRate: null,
                perGramRate: null,
                minPerPieceRate: null,
                perPieceRate: null);
          } else if (selectedCalculation.value == weightCalcType) {
            payload = CreateValueAdditionCustomerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                fromWeight: fromweightController.text,
                toWeight: toweightController.text,
                minFixedRate: null,
                fixedRate: null,
                wastageCalculationType:
                    selectedWastageCalcuationType.value!.value,
                minWastagePercent: minWastagePercentageController.text,
                wastagePercent: wastagePercentageController.text,
                flatWastageType: selectedFlatWastageType.value!.value,
                minFlatWastage: minFlatWastageController.text,
                flatWastage: flatWastageController.text,
                makingChargeCalculationType:
                    selectedMakingChargeCalcuationType.value!.value,
                minMakingChargePerGram: minMakingChargePerGramController.text,
                makingChargePerGram: makingChargePerGramController.text,
                minFlatMakingCharge: minFlatMakingChargeController.text,
                flatMakingCharge: flatMakingChargeController.text,
                perGramWeightType: null,
                minPerGramRate: null,
                perGramRate: null,
                minPerPieceRate: null,
                perPieceRate: null);
          } else if (selectedCalculation.value == perGramRateCalcType) {
            payload = CreateValueAdditionCustomerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                fromWeight: fromweightController.text,
                toWeight: toweightController.text,
                minFixedRate: null,
                fixedRate: null,
                wastageCalculationType: null,
                minWastagePercent: null,
                wastagePercent: null,
                flatWastageType: null,
                minFlatWastage: null,
                flatWastage: null,
                makingChargeCalculationType: null,
                minMakingChargePerGram: null,
                makingChargePerGram: null,
                minFlatMakingCharge: null,
                flatMakingCharge: null,
                perGramWeightType: selectedPerGramCalcuationType.value!.value,
                minPerGramRate: minPerGramRateController.text,
                perGramRate: perGramRateController.text,
                minPerPieceRate: null,
                perPieceRate: null);
          } else if (selectedCalculation.value == perPieceRateCalcType) {
            payload = CreateValueAdditionCustomerPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                subItemDetails: selectedSubItem.value!.value,
                fromWeight: "0",
                toWeight: "0",
                minFixedRate: null,
                fixedRate: null,
                wastageCalculationType: null,
                minWastagePercent: null,
                wastagePercent: null,
                flatWastageType: null,
                minFlatWastage: null,
                flatWastage: null,
                makingChargeCalculationType: null,
                minMakingChargePerGram: null,
                makingChargePerGram: null,
                minFlatMakingCharge: null,
                flatMakingCharge: null,
                perGramWeightType: null,
                minPerGramRate: null,
                perGramRate: null,
                minPerPieceRate: minPerPieceRateController.text,
                perPieceRate: perPieceRateController.text);
          }

          await ValueAdditionCustomerService.createValueadditioncustomer(
              context: context, payload: payload);
          _valueAdditionCustomerListController
              .getValueAdditionCustomerlist(context);
        } else {
          var payload;

          if (selectedCalculation == fixedRateCalcType) {
            payload = UpdateValueAdditionCustomerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              subItemDetails: selectedSubItem.value!.value,
              minFixedRate: minFixedRateController.text,
              fixedRate: fixedRateController.text,
              wastageCalculationType: null,
              minWastagePercent: null,
              wastagePercent: null,
              flatWastageType: null,
              minFlatWastage: null,
              flatWastage: null,
              makingChargeCalculationType: null,
              minMakingChargePerGram: null,
              makingChargePerGram: null,
              minFlatMakingCharge: null,
              flatMakingCharge: null,
              perGramWeightType: null,
              minPerGramRate: null,
              perGramRate: null,
              minPerPieceRate: null,
              perPieceRate: null,
              id: currentValueAdditionCustomer.value!.id,
            );
          } else if (selectedCalculation == weightCalcType) {
            payload = UpdateValueAdditionCustomerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              subItemDetails: selectedSubItem.value!.value,
              minFixedRate: null,
              fixedRate: null,
              wastageCalculationType:
                  selectedWastageCalcuationType.value!.value,
              minWastagePercent: minWastagePercentageController.text,
              wastagePercent: wastagePercentageController.text,
              flatWastageType: selectedFlatWastageType.value!.value,
              minFlatWastage: minFlatWastageController.text,
              flatWastage: flatWastageController.text,
              makingChargeCalculationType:
                  selectedMakingChargeCalcuationType.value!.value,
              minMakingChargePerGram: minMakingChargePerGramController.text,
              makingChargePerGram: makingChargePerGramController.text,
              minFlatMakingCharge: minFlatMakingChargeController.text,
              flatMakingCharge: flatWastageController.text,
              perGramWeightType: null,
              minPerGramRate: null,
              perGramRate: null,
              minPerPieceRate: null,
              perPieceRate: null,
              id: currentValueAdditionCustomer.value!.id,
            );
          } else if (selectedCalculation == perGramRateCalcType) {
            payload = UpdateValueAdditionCustomerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              subItemDetails: selectedSubItem.value!.value,
              minFixedRate: null,
              fixedRate: null,
              wastageCalculationType: null,
              minWastagePercent: null,
              wastagePercent: null,
              flatWastageType: null,
              minFlatWastage: null,
              flatWastage: null,
              makingChargeCalculationType: null,
              minMakingChargePerGram: null,
              makingChargePerGram: null,
              minFlatMakingCharge: null,
              flatMakingCharge: null,
              perGramWeightType: selectedPerGramCalcuationType.value!.value,
              minPerGramRate: minPerGramRateController.text,
              perGramRate: perGramRateController.text,
              minPerPieceRate: null,
              perPieceRate: null,
              id: currentValueAdditionCustomer.value!.id,
            );
          } else if (selectedCalculation == perPieceRateCalcType) {
            payload = UpdateValueAdditionCustomerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              subItemDetails: selectedSubItem.value!.value,
              minFixedRate: null,
              fixedRate: null,
              wastageCalculationType: null,
              minWastagePercent: null,
              wastagePercent: null,
              flatWastageType: null,
              minFlatWastage: null,
              flatWastage: null,
              makingChargeCalculationType: null,
              minMakingChargePerGram: null,
              makingChargePerGram: null,
              minFlatMakingCharge: null,
              flatMakingCharge: null,
              perGramWeightType: null,
              minPerGramRate: null,
              perGramRate: null,
              minPerPieceRate: minPerPieceRateController.text,
              perPieceRate: perPieceRateController.text,
              id: currentValueAdditionCustomer.value!.id,
            );
          }
          await ValueAdditionCustomerService.updateValueAdditionCustomer(
              context: context, payload: payload);
          _valueAdditionCustomerListController
              .getValueAdditionCustomerlist(context);
        }
        
        resetForm();
        Get.back();
      }
    }
  }

  resetForm() {
    isFormSubmit(true);
    valueadditioncustomerFormKey.currentState!.reset();
    currentValueAdditionCustomer.value = null;
    selectedSubItem.value = null;
    selectedCalculationType.value = null;

    fromweightController.clear();
    toweightController.clear();

    minFixedRateController.clear();
    fixedRateController.clear();

    selectedWastageCalcuationType.value = null;
    minWastagePercentageController.clear();
    wastagePercentageController.clear();
    selectedFlatWastageType.value = null;
    minFlatWastageController.clear();
    flatWastageController.clear();
    selectedMakingChargeCalcuationType.value = null;
    minMakingChargePerGramController.clear();
    makingChargePerGramController.clear();
    minFlatMakingChargeController.clear();
    flatMakingChargeController.clear();

    selectedPerGramCalcuationType.value = null;
    minPerGramRateController.clear();
    perGramRateController.clear();

    minPerPieceRateController.clear();
    perPieceRateController.clear();

    fromMode("create");
  }

  Future getValueAdditionCustomerDetails(
      BuildContext context, ValueAdditionCustomerData item) async {
    final ValueAdditionCustomerDetailsData? data =
        await ValueAdditionCustomerService.retrieveValueAdditionCustomer(
            context: context, valueadditioncustomerId: item.id.toString());

    if (data != null) {
      currentValueAdditionCustomer(data);
      getCalculationType(data.subItemDetails.toString());
      selectedSubItem(DropdownModel(
          value: data.subItemDetails.toString(),
          label: data.subItemDetailsName.toString()));

      fromweightController.text = data.fromWeight.toString();
      toweightController.text = data.toWeight.toString();

      minFixedRateController.text = data.minFixedRate.toString();
      fixedRateController.text = data.fixedRate.toString();

      selectedWastageCalcuationType(DropdownModel(
          value: data.wastageCalculationType.toString(),
          label: data.wastageCalculationTypeName.toString()));
      minWastagePercentageController.text = data.minWastagePercent.toString();
      wastagePercentageController.text = data.wastagePercent.toString();
      selectedFlatWastageType(DropdownModel(
          value: data.flatWastageType.toString(),
          label: data.flatWastageTypeName.toString()));
      minFlatWastageController.text = data.minFlatWastage.toString();
      flatWastageController.text = data.flatWastage.toString();
      selectedMakingChargeCalcuationType(DropdownModel(
          value: data.makingChargeCalculationType.toString(),
          label: data.makingChargeCalculationTypeName.toString()));
      minMakingChargePerGramController.text =
          data.minMakingChargePerGram.toString();
      makingChargePerGramController.text = data.makingChargePerGram.toString();
      minFlatMakingChargeController.text = data.minFlatMakingCharge.toString();
      flatMakingChargeController.text = data.flatMakingCharge.toString();

      selectedPerGramCalcuationType(DropdownModel(
          value: data.perGramWeightType.toString(),
          label: data.perGramWeightTypeName.toString()));
      minPerGramRateController.text = data.minPerGramRate.toString();
      perGramRateController.text = data.perGramRate.toString();

      minPerPieceRateController.text = data.minPerPieceRate.toString();
      perPieceRateController.text = data.perPieceRate.toString();

      fromMode("update");
      Get.to(() => ValueAdditionCustomerFormScreen());
    } else {
      resetForm();
    }
  }

  Future getValueAdditionCustomerTagList(String? subitemdetails,
      String? fromWeight, String? toweight, BuildContext context) async {
    final Map<String, dynamic>? data;
    if (subitemdetails != null) {
      if (fromweightController.text.isEmpty ||
          toweightController.text.isEmpty) {
        var fromWeight = "0";
        var toweight = "0";

        if (!isFormFind.value) {
          isFormFind(true);
          data = await ValueAdditionCustomerService.retrieveValueAdditionTagList(
              context: context,
              subItem: subitemdetails,
              fromweight: fromWeight,
              toweight: toweight);

          if (data != null) {
            tableDataList(data['data']);
          } else {
            tableDataList([]);
          }
          isFormFind(false);
        }

      } else {
        if (!isFormFind.value) {
          isFormFind(true);
          data = await ValueAdditionCustomerService.retrieveValueAdditionTagList(
            context: context,
            subItem: subitemdetails,
            fromweight: fromWeight,
            toweight: toweight);
          if (data != null) {
            tableDataList(data['data']);
          } else {
            tableDataList([]);
          }
          isFormFind(false);
        }
        
      }
    }
  }
}
