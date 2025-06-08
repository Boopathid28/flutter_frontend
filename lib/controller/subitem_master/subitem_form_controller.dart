import 'package:ausales_application/controller/subitem_master/subitem_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/subitem_master/subitem_master_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/subitem_master/subitem_master_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/subitem_master/subitem_view_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubitemFormController extends GetxController {
  final SubitemMasterListController _subitemMasterListController =
      Get.put(SubitemMasterListController());

  TextEditingController itemDetailSearchController = TextEditingController();

  final subitemFormKey = GlobalKey<FormState>();

  Rx<SubItemDetailsData?> currentSubItem = Rx<SubItemDetailsData?>(null);

  TextEditingController subItemNameController = TextEditingController();
  TextEditingController subItemCodeController = TextEditingController();
  TextEditingController hsnCodeController = TextEditingController();

  TextEditingController minFixedRateController = TextEditingController();
  TextEditingController fixedRateController = TextEditingController();

  TextEditingController minWastagePercentageController = TextEditingController();
  TextEditingController wastagePercentageController = TextEditingController();
  TextEditingController minFlatWastageController = TextEditingController();
  TextEditingController flatWastageController = TextEditingController();
  TextEditingController minMakingChargePerGramController = TextEditingController();
  TextEditingController makingChargePerGramController = TextEditingController();
  TextEditingController minFlatMakingChargeController = TextEditingController();
  TextEditingController flatMakingChargeController = TextEditingController();

  TextEditingController minPerGramRateController = TextEditingController();
  TextEditingController perGramRateController = TextEditingController();

  TextEditingController minPerPieceRateController = TextEditingController();
  TextEditingController perPieceRateController = TextEditingController();

  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedStockType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMeasurementType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedWastageCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMakingChargeCalcuationType =
      Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPerGramCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFlatWastageType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> stockTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> measurementTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> calculationTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> weightTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> flatWastageTypeDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    getItemList();
    getStockTypeList();
    getMeasurementTypeList();
    getWeightTypeList();
    getFlatWastageTypeList();
  }

  Future getItemList() async {
    itemDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    tempList.forEach((item) {
      itemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.itemName.toString()));
    });
  }

  Future getStockTypeList() async {
    stockTypeDropDown([]);
    final List<StockTypeDropdownModel> tempList =
        await DropdownService.stockTypeDropDown();
    tempList.forEach((item) {
      stockTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
    });
  }

  Future getMeasurementTypeList() async {
    measurementTypeDropDown([]);
    final List<MeasurementTypeDropdownModel> tempList =
        await DropdownService.measurementTypeDropDown();
    tempList.forEach((item) {
      measurementTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
    });
  }

  Future getCalculationTypeList({required String value}) async {
    calculationTypeDropDown([]);
    final List<CalculationTypeDropdownModel> tempList =
        await DropdownService.calculationTypeDropDown(stockType: value);
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

  Future submitSubitemForm(BuildContext context) async {
    if (subitemFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          var payload;

          if (selectedCalculationType.value?.value == fixedRateCalcType) {
            payload = CreateSubItemPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          } else if (selectedCalculationType.value?.value == weightCalcType) {
            payload = CreateSubItemPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          } else if (selectedCalculationType.value?.value ==
              perGramRateCalcType) {
            payload = CreateSubItemPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          } else if (selectedCalculationType.value?.value ==
              perPieceRateCalcType) {
            payload = CreateSubItemPayload(
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          await SubitemMasterService.createSubItem(
              context: context, payload: payload);
          _subitemMasterListController.getSubItemList(context);
        } else {
          var payload;

          if (selectedCalculationType.value?.value == fixedRateCalcType) {
            payload = UpdateSubItemPayload(
                id: currentSubItem.value!.id.toString(),
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          } else if (selectedCalculationType.value?.value == weightCalcType) {
            payload = UpdateSubItemPayload(
                id: currentSubItem.value!.id.toString(),
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          } else if (selectedCalculationType.value?.value ==
              perGramRateCalcType) {
            payload = UpdateSubItemPayload(
                id: currentSubItem.value!.id.toString(),
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          } else if (selectedCalculationType.value?.value ==
              perPieceRateCalcType) {
            payload = UpdateSubItemPayload(
                id: currentSubItem.value!.id.toString(),
                menuId: await HomeSharedPrefs.getCurrentMenu(),
                itemDetails: selectedItem.value!.value,
                subItemName: subItemNameController.text,
                subItemCode: subItemCodeController.text,
                hsnCode: hsnCodeController.text,
                stockType: selectedStockType.value!.value,
                measurementType: selectedMeasurementType.value?.value,
                calculationType: selectedCalculationType.value!.value,
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
          await SubitemMasterService.updateSubItem(
              context: context, payload: payload);
          _subitemMasterListController.getSubItemList(context);
        }
        resetForm();
        Get.back();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    subitemFormKey.currentState!.reset();
    currentSubItem.value = null;
    subItemNameController.clear();
    subItemCodeController.clear();
    hsnCodeController.clear();
    selectedItem.value = null;
    selectedStockType.value = null;
    selectedCalculationType.value = null;
    selectedMeasurementType.value = null;

    fixedRateController.clear();

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

  Future getSubItemDetails(BuildContext context, SubItemListData item) async {
    final SubItemDetailsData? data = await SubitemMasterService.retrieveSubItem(
        context: context, subItemId: item.id.toString());

    if (data != null) {
      currentSubItem(data);

      getCalculationTypeList(value: data.stockType.toString());

      selectedItem(DropdownModel(
          value: data.itemDetails.toString(), label: data.itemName.toString()));
      subItemNameController.text = data.subItemName!;
      subItemCodeController.text = data.subItemCode!;
      hsnCodeController.text = data.hsnCode!;
      selectedStockType(DropdownModel(
          value: data.stockType.toString(),
          label: data.stockTypeName.toString()));

      if (data.measurementType != null) {
        selectedMeasurementType(DropdownModel(
            value: data.measurementType.toString(),
            label: data.measurementTypeName.toString()));
      } else {
        selectedMeasurementType(null);
      }
      selectedCalculationType(DropdownModel(
          value: data.calculationType.toString(),
          label: data.calculationTypeName.toString()));

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
      minMakingChargePerGramController.text = data.minMakingChargePerGram.toString();
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

      await Get.dialog(
          barrierDismissible: false,
          SubitemMasterForm());
    } else {
      resetForm();
    }
  }

  Future getSubItemViewDetails(
      BuildContext context, SubItemListData item) async {
    final SubItemDetailsData? data = await SubitemMasterService.retrieveSubItem(
        context: context, subItemId: item.id.toString());


    if (data != null) {
      currentSubItem(data);
      await Get.dialog(
          barrierDismissible: false,
          SubitemViewPopup());
    } else {
      currentSubItem(null);
    }
  }
}
