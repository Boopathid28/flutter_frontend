import 'dart:async';
import 'dart:developer';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/new_purchase/new_purchase_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/new_purchase/new_purchase_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_form/new_purchase_item_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NewPurchaseItemFormController extends GetxController {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final newPurchaseItemFormDetailsFormKey = GlobalKey<FormState>();

  TextEditingController metalRateController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController hallmarkChargesController = TextEditingController();
  TextEditingController otherChargesController = TextEditingController();
  TextEditingController totalWeightController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  TextEditingController stoneWeightController = TextEditingController();
  TextEditingController stoneAmountController = TextEditingController();
  TextEditingController stonePiecesController = TextEditingController();

  TextEditingController diamondWeightController = TextEditingController();
  TextEditingController diamondAmountController = TextEditingController();
  TextEditingController diamondPiecesController = TextEditingController();

  TextEditingController subItemSearchController = TextEditingController();
  TextEditingController itemSearchController = TextEditingController();

  TextEditingController fixedRateController = TextEditingController();

  TextEditingController wastagePercentageController = TextEditingController();
  TextEditingController flatWastageController = TextEditingController();
  TextEditingController makingChargePerGramController = TextEditingController();
  TextEditingController flatMakingChargeController = TextEditingController();
  TextEditingController touchController = TextEditingController();

  TextEditingController perGramRateController = TextEditingController();

  TextEditingController perPieceRateController = TextEditingController();


  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedGstType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPerGramCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedWastageCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFlatWastageType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMakingChargeCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel> selectedStoneReduceWeight = DropdownModel(value: "0", label: "No").obs;
  Rx<DropdownModel> selectedDiamondReduceWeight = DropdownModel(value: "0", label: "No").obs;

  RxString calculationType = "".obs;
  RxDouble gstPercent = 0.0.obs;

  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subItemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> calculationTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> weightTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> flatWastageTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> reduceWeightDropDown = [DropdownModel(value: "1", label: "Yes"), DropdownModel(value: "0", label: "No")].obs;

  RxList<ItemDropdownModel> itemList = <ItemDropdownModel>[].obs;
  RxList<SubItemDropdownModel> subItemList = <SubItemDropdownModel>[].obs;

  RxInt totalItems = 0.obs;
  RxInt totalPieces = 0.obs;
  RxDouble totalGrossWeight = 0.0.obs;
  RxDouble totalNetWeight = 0.0.obs;
  RxDouble hallmarkCharges = 0.0.obs;
  RxDouble otherCharges = 0.0.obs;
  RxDouble gstAmount = 0.0.obs;
  RxDouble grandTotalAmount = 0.0.obs;
  RxDouble payableGrandTotalAmount = 0.0.obs;
  RxDouble payableAmount = 0.0.obs;
  RxDouble payableWithRoundAmount = 0.0.obs;
  RxDouble payableWithoutGst = 0.0.obs;
  RxDouble payablPureWeight = 0.0.obs;
  RxDouble originalPayablPureWeight = 0.0.obs;

  RxList<NewPurchaseItemDetails> particulars = <NewPurchaseItemDetails>[].obs;
  

  RxBool isDeleteLoading = false.obs;

  RxString updatingItem = "".obs;
  RxString itemFormMode = "create".obs;

  // conversion weight to amt
  TextEditingController convertionRateController = TextEditingController();
  TextEditingController convertionGstController = TextEditingController();

  RxDouble convertedAmount = 0.0.obs;
  RxDouble convertedWeight = 0.0.obs;
  RxDouble convertionRate = 0.0.obs;
  RxDouble convertionGst = 0.0.obs;
  RxDouble convertionGstAmount = 0.0.obs;
  RxDouble convertionWithGst = 0.0.obs;
  RxBool isConvertedWeight = false.obs;

  

  //TDS fields
  TextEditingController tdsPercentController = TextEditingController(text: '0');
  TextEditingController roundOffController = TextEditingController(text: '0');
  TextEditingController weightRoundOffController = TextEditingController(text: '0');

  RxInt tdsAmount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getItemList();
    getCalculationTypeList();
    getWeightTypeList();
    getFlatWastageTypeList();
  }

  Future getItemList() async {
    itemDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    itemList(tempList);
    tempList.forEach((item) {
      itemDropDown
          .add(DropdownModel(label: item.itemName!, value: item.id.toString()));
    });
  }

  Future getSubItemList(String? item) async {
    subItemDropDown([]);
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: item);
    subItemList(tempList);
    tempList.forEach((item) {
      subItemDropDown
          .add(DropdownModel(label: item.subItemName!, value: item.id.toString()));
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

  Future getSubitemVendorCalculationDetails(String subItemId, BuildContext context,
      String vendorId, String calcTypeId, String calculationTypeName) async {
    final data = await NewPurchaseService.getSubitemVendorCalculationDetails(
        subItemId: subItemId,
        context: context,
        vendorId: vendorId);

    final SubItemVendorWeightCalcDetailsResponse details =
        SubItemVendorWeightCalcDetailsResponse.fromJson(data);
    if (data != null) {

      String currentCalculationType = details.calculationType != null ? details.calculationType.toString() : calculationType.toString();

      if (details.calculationType == null) {
        selectedCalculationType(DropdownModel(value: calculationType.toString(), label: calculationTypeName.toString()));
      } else {
        selectedCalculationType(DropdownModel(value: details.calculationType.toString(), label: details.calculationTypeName.toString()));
      }

      if (currentCalculationType == weightCalcType) {
        selectedWastageCalcuationType(DropdownModel(
            value: details.wastageCalculationType.toString(),
            label: details.wastageCalculationTypeName.toString()));
        wastagePercentageController.text = details.wastagePercent.toString();
        selectedFlatWastageType(DropdownModel(
            value: details.flatWastageType.toString(),
            label: details.flatWastageTypeName.toString()));
        flatWastageController.text = details.flatWastage.toString();
        selectedMakingChargeCalcuationType(DropdownModel(
            value: details.makingChargeCalculationType.toString(),
            label: details.makingChargeCalculationTypeName.toString()));
        makingChargePerGramController.text =
            details.makingChargePerGram.toString();
        flatMakingChargeController.text = details.flatMakingCharge.toString();
        touchController.text = details.touch.toString();
      } else if (currentCalculationType == perGramRateCalcType) {
        selectedPerGramCalcuationType(DropdownModel(
            value: details.perGramWeightType.toString(),
            label: details.perGramWeightTypeName.toString()));
        perGramRateController.text = details.perGramRate.toString();
      } else if (currentCalculationType == fixedRateCalcType) {
          fixedRateController.text = details.fixedRate.toString();
      } else if (currentCalculationType == perPieceRateCalcType) {
          perPieceRateController.text = details.perPieceRate.toString();
      }
    }
  } 

  void calculation({
    required String grossWeight,
    required String reduceWeight,
    required String stoneWeight,
    required String diamondWeight,
    required bool stoneReduceWeight,
    required bool diamondReduceWeight,
    required DropdownModel? calculationType,
    required DropdownModel gstType
  }) {

    double gross = double.parse(grossWeight.isEmpty ? "0" : grossWeight);
    double reduce = double.parse(reduceWeight.isEmpty ? "0" : reduceWeight);
    double stone = double.parse(stoneWeight.isEmpty ? "0" : stoneWeight);
    double diamond = double.parse(diamondWeight.isEmpty ? "0" : diamondWeight);

    double stoneAmount = double.parse(stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text);
    double diamondAmount = double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text);

    double netWeight = 0.0;

    if (stoneReduceWeight && diamondReduceWeight) {
      netWeight = gross - (reduce + stone + diamond);
    } else if (stoneReduceWeight) {
      netWeight = gross - (reduce + stone);
    } else if (diamondReduceWeight) {
      netWeight = gross - (reduce + diamond);
    } else {
      netWeight = gross - reduce;
    }

    netWeightController.text = netWeight.toStringAsFixed(3);

    double totalAmount = 0.0;
    double totalWeight = 0.0;

    if (calculationType != null) {
      if (calculationType.value == fixedRateCalcType) {
        double fixedAmount = double.parse(fixedRateController.text.isEmpty ? "0" : fixedRateController.text);
        totalAmount = fixedAmount + stoneAmount + diamondAmount;
      } else if (calculationType.value == perGramRateCalcType) {
        var perGramWeight = selectedPerGramCalcuationType.value?.value == grossWeightType ? gross : netWeight;
        double totalPerGramAmount = perGramWeight * double.parse(perGramRateController.text.isEmpty ? "0" : perGramRateController.text);
        totalAmount = totalPerGramAmount + stoneAmount + diamondAmount;
      } else if (calculationType.value == perPieceRateCalcType) {
        double perPieceAmount = double.parse(perPieceRateController.text.isEmpty ? "0" : perPieceRateController.text);
        double perPieceTotalAmount = perPieceAmount * int.parse(piecesController.text.isEmpty ? "0" : piecesController.text);
        totalAmount = perPieceTotalAmount + stoneAmount + diamondAmount;
      } else if (calculationType.value == weightCalcType) {
        double wastageWeight = 0.0;
        double mcWeight = 0.0;

        if (selectedWastageCalcuationType.value != null) {
          wastageWeight = selectedWastageCalcuationType.value?.value == grossWeightType ? gross : netWeight;
        } else {
          wastageWeight = 0.0;
        }

        if (selectedWastageCalcuationType.value != null) {
          mcWeight = selectedMakingChargeCalcuationType.value?.value == grossWeightType ? gross : netWeight;
        } else {
          mcWeight = 0.0;
        }

        double totalMC = (mcWeight * double.parse(makingChargePerGramController.text.isEmpty ? "0" : makingChargePerGramController.text)) + double.parse(flatMakingChargeController.text.isEmpty ? "0" : flatMakingChargeController.text);
        double wastageGram = wastageWeight * (double.parse(wastagePercentageController.text.isEmpty ? "0" : wastagePercentageController.text) / 100);

        double totalWastageAmount = 0.0;
        double totalWastageGram = wastageGram;

        if (selectedFlatWastageType.value?.value == flatWastageRupeeType) {
          totalWastageAmount = double.parse(flatWastageController.text.isEmpty ? "0" : flatWastageController.text);
        } else if (selectedFlatWastageType.value?.value == flatWastageGramType) {
          totalWastageGram = wastageGram + double.parse(flatWastageController.text.isEmpty ? "0" : flatWastageController.text);
        }

        totalAmount = totalMC + totalWastageAmount + stoneAmount + diamondAmount;
        double totalWastageWeight = totalWastageGram + netWeight;
        if (touchController.text.isEmpty) {
          totalWeight = 0.0;
        } else {
          totalWeight = totalWastageWeight * (double.parse(touchController.text.isEmpty ? "0" : touchController.text) / 100);
        }
      }

      double halmarkAmount = double.parse(hallmarkChargesController.text.isEmpty ? "0" : hallmarkChargesController.text);
      double otherAmount = double.parse(otherChargesController.text.isEmpty ? "0" : otherChargesController.text);

      double gstAmount = (totalAmount + halmarkAmount + otherAmount) * (gstPercent / 100);

      totalWeightController.text = totalWeight.toStringAsFixed(3);
      totalAmountController.text = (totalAmount + halmarkAmount + otherAmount + gstAmount).toStringAsFixed(2);
      gstAmountController.text = gstAmount.toStringAsFixed(2);
    }
  }

  void onCalculationTypeChange(DropdownModel calcType) {
    selectedCalculationType(calcType);

    if (calcType.value == fixedRateCalcType) {
      perPieceRateController.clear();

      selectedPerGramCalcuationType.value = null;
      perGramRateController.clear();

      selectedWastageCalcuationType.value = null;
      wastagePercentageController.clear();
      selectedFlatWastageType.value = null;
      flatWastageController.clear();
      selectedMakingChargeCalcuationType.value = null;
      makingChargePerGramController.clear();
      flatMakingChargeController.clear();
    } else if (calcType.value == perPieceRateCalcType) {
      fixedRateController.clear();

      selectedPerGramCalcuationType.value = null;
      perGramRateController.clear();

      selectedWastageCalcuationType.value = null;
      wastagePercentageController.clear();
      selectedFlatWastageType.value = null;
      flatWastageController.clear();
      selectedMakingChargeCalcuationType.value = null;
      makingChargePerGramController.clear();
      flatMakingChargeController.clear();
    } else if (calcType.value == perGramRateCalcType) {
      fixedRateController.clear();

      perPieceRateController.clear();

      selectedWastageCalcuationType.value = null;
      wastagePercentageController.clear();
      selectedFlatWastageType.value = null;
      flatWastageController.clear();
      selectedMakingChargeCalcuationType.value = null;
      makingChargePerGramController.clear();
      flatMakingChargeController.clear();
    } else if (calcType.value == weightCalcType) {
      fixedRateController.clear();

      perPieceRateController.clear();

      selectedPerGramCalcuationType.value = null;
      perGramRateController.clear();
    }

    calculation(
      calculationType: calcType, 
      grossWeight: grossWeightController.text, 
      reduceWeight: reduceWeightController.text,
      stoneWeight: stoneWeightController.text,
      diamondWeight: diamondWeightController.text,
      stoneReduceWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
      diamondReduceWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
      gstType: selectedGstType.value! 
    );
  }

  Future editItem(NewPurchaseItemDetails item, BuildContext context) async {
    itemFormMode("update");

    getSubItemList(item.itemDetails);

    selectedItem(DropdownModel(value: item.itemDetails.toString(), label: item.itemDetailsName.toString()));
    selectedSubItem(DropdownModel(value: item.subItemDetails.toString(), label: item.subItemDetailsName.toString()));
    piecesController.text = item.pieces.toString();
    grossWeightController.text = item.grossWeight.toString();
    reduceWeightController.text = item.reduceWeight.toString();
    netWeightController.text = item.netWeight.toString();
    stonePiecesController.text = item.stonePieces.toString();
    stoneWeightController.text = item.stoneWeight.toString();
    stoneAmountController.text = item.stoneAmount.toString();
    diamondPiecesController.text = item.diamondPieces.toString();
    diamondWeightController.text = item.diamondWeight.toString();
    diamondAmountController.text = item.diamondAmount.toString();
    selectedStoneReduceWeight(item.reduceStoneWeight! ?  DropdownModel(value: "1", label: "Yes"): DropdownModel(value: "0", label: "No"));
    selectedDiamondReduceWeight(item.reduceStoneWeight! ?  DropdownModel(value: "1", label: "Yes"): DropdownModel(value: "0", label: "No"));
    hallmarkChargesController.text = item.hallmarkCharges.toString();
    otherChargesController.text = item.otherCharges.toString();
    totalWeightController.text = item.totalWeight.toString();
    gstAmountController.text = item.gstAmount.toString();
    totalAmountController.text = item.totalAmount.toString();
    selectedCalculationType(DropdownModel(value: item.calculationType.toString(), label: item.calculationTypeName.toString()));

    for (var i  in subItemList.value) {
      if (i.id.toString() == item.subItemDetails.toString()) {
            calculationType(i.calculationType);
            if (selectedGstType.value!.value == interGstType) {
              gstPercent(i.interGst);
            } else if (selectedGstType.value!.value == intraGstType) {
              gstPercent(i.intraGst);
            }
        // _newPurchaseItemFormController.getSubitemCalculationDetails(value.value.toString(), context, i.calculationType.toString(), _newPurchaseItemFormController.grossWeightController.text);
        break;
      }
    }

    updatingItem(item.id);
    if (item.calculationType.toString() == fixedRateCalcType) {
      fixedRateController.text = item.fixedRate.toString();
    } else if (item.calculationType.toString() == perGramRateCalcType) {
      selectedPerGramCalcuationType(DropdownModel(value: item.perGramWeightType.toString(), label: item.perGramWeightTypeName.toString()));
      perGramRateController.text = item.perGramRate.toString();
    } else if (item.calculationType.toString() == perPieceRateCalcType) {
      perPieceRateController.text = item.perPieceRate.toString();
    } else if (item.calculationType.toString() == weightCalcType) {
      selectedWastageCalcuationType(DropdownModel(value: item.wastageCalculationType.toString(), label: item.wastageCalculationTypeName.toString()));
      wastagePercentageController.text = item.wastagePercent.toString();
      selectedFlatWastageType(DropdownModel(value: item.flatWastageType.toString(), label: item.flatWastageTypeName.toString()));
      flatWastageController.text = item.flatWastage.toString();
      selectedMakingChargeCalcuationType(DropdownModel(value: item.makingChargeCalculationType.toString(), label: item.makingChargeCalculationTypeName.toString()));
      makingChargePerGramController.text = item.makingChargePerGram.toString();
      flatMakingChargeController.text = item.flatMakingCharge.toString();
      touchController.text = item.touch.toString();
    }
    
    await Get.dialog(
      barrierDismissible: false,
      NewPurchaseItemForm()
    );
  }

  deleteItem(NewPurchaseItemDetails newPurchaseItem) {
    particulars.removeWhere((item) => item.id == newPurchaseItem.id);
    calculatePurchaseValue();
  }

  Future submitForm(BuildContext context) async {
    if (newPurchaseItemFormDetailsFormKey.currentState!.validate()) {

      if (itemFormMode.value == "create") {
        var uuid = Uuid();
        if (selectedCalculationType.value?.value == fixedRateCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: uuid.v4(),
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            fixedRate: double.parse(fixedRateController.text.isEmpty ? "0.0" : fixedRateController.text),
          );

          particulars.insert(0, itemDetails);
        } else if (selectedCalculationType.value?.value == perGramRateCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: uuid.v4(),
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            perGramWeightType: selectedPerGramCalcuationType.value?.value,
            perGramWeightTypeName: selectedPerGramCalcuationType.value?.label,
            perGramRate: double.parse(perGramRateController.text.isEmpty ? "0.0" : perGramRateController.text),
          );

          particulars.insert(0, itemDetails);
        } else if (selectedCalculationType.value?.value == perPieceRateCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: uuid.v4(),
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            perPieceRate: double.parse(perPieceRateController.text.isEmpty ? "0.0" : perPieceRateController.text),
          );

          particulars.insert(0, itemDetails);
        } else if (selectedCalculationType.value?.value == weightCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: uuid.v4(),
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            wastageCalculationType: selectedWastageCalcuationType.value?.value,
            wastageCalculationTypeName: selectedWastageCalcuationType.value?.label,
            wastagePercent: double.parse(wastagePercentageController.text.isEmpty ? "0.0" : wastagePercentageController.text),
            flatWastageType: selectedFlatWastageType.value?.value,
            flatWastageTypeName: selectedFlatWastageType.value?.label,
            flatWastage: double.parse(flatWastageController.text.isEmpty ? "0.0" : flatWastageController.text),
            makingChargeCalculationType: selectedMakingChargeCalcuationType.value?.value,
            makingChargeCalculationTypeName: selectedMakingChargeCalcuationType.value?.label,
            makingChargePerGram: double.parse(makingChargePerGramController.text.isEmpty ? "0.0" : makingChargePerGramController.text),
            flatMakingCharge: double.parse(flatMakingChargeController.text.isEmpty ? "0.0" : flatMakingChargeController.text),
            touch: double.parse(touchController.text.isEmpty ? "0.0" : touchController.text),
          );

          particulars.insert(0, itemDetails);
        } 

      } else {
        int index = particulars.indexWhere((item) => item.id == updatingItem.value);

        if (selectedCalculationType.value?.value == fixedRateCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: updatingItem.value,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            fixedRate: double.parse(fixedRateController.text.isEmpty ? "0.0" : fixedRateController.text),
          );
          particulars[index] = itemDetails;
        } else if (selectedCalculationType.value?.value == perGramRateCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: updatingItem.value,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            perGramWeightType: selectedPerGramCalcuationType.value?.value,
            perGramWeightTypeName: selectedPerGramCalcuationType.value?.label,
            perGramRate: double.parse(perGramRateController.text.isEmpty ? "0.0" : perGramRateController.text),
          );

          particulars[index] = itemDetails;
        } else if (selectedCalculationType.value?.value == perPieceRateCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: updatingItem.value,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            perPieceRate: double.parse(perPieceRateController.text.isEmpty ? "0.0" : perPieceRateController.text),
          );

          particulars[index] = itemDetails;
        } else if (selectedCalculationType.value?.value == weightCalcType) {
          NewPurchaseItemDetails itemDetails = NewPurchaseItemDetails(
            id: updatingItem.value,
            itemDetails: selectedItem.value?.value,
            itemDetailsName: selectedItem.value?.label,
            subItemDetails: selectedSubItem.value?.value,
            subItemDetailsName: selectedSubItem.value?.label,
            pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
            grossWeight: double.parse(grossWeightController.text.isEmpty ? "0.0" : grossWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0.0" : reduceWeightController.text),
            netWeight: double.parse(netWeightController.text.isEmpty ? "0.0" : netWeightController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
            stonePieces: int.parse(stonePiecesController.text.isEmpty ? "0.0" : stonePiecesController.text),
            stoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0.0" : stoneWeightController.text),
            reduceStoneWeight: selectedStoneReduceWeight.value.value == "1" ? true : false,
            diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
            diamondPieces: int.parse(diamondPiecesController.text.isEmpty ? "0.0" : diamondPiecesController.text),
            diamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0.0" : diamondWeightController.text),
            reduceDiamondWeight: selectedDiamondReduceWeight.value.value == "1" ? true : false,
            hallmarkCharges: double.parse(hallmarkChargesController.text.isEmpty ? "0.0" : hallmarkChargesController.text),
            otherCharges: double.parse(otherChargesController.text.isEmpty ? "0.0" : otherChargesController.text),
            totalWeight: double.parse(totalWeightController.text.isEmpty ? "0.0" : totalWeightController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
            calculationType: selectedCalculationType.value?.value,
            calculationTypeName: selectedCalculationType.value?.label,
            wastageCalculationType: selectedWastageCalcuationType.value?.value,
            wastageCalculationTypeName: selectedWastageCalcuationType.value?.label,
            wastagePercent: double.parse(wastagePercentageController.text.isEmpty ? "0.0" : wastagePercentageController.text),
            flatWastageType: selectedFlatWastageType.value?.value,
            flatWastageTypeName: selectedFlatWastageType.value?.label,
            flatWastage: double.parse(flatWastageController.text.isEmpty ? "0.0" : flatWastageController.text),
            makingChargeCalculationType: selectedMakingChargeCalcuationType.value?.value,
            makingChargeCalculationTypeName: selectedMakingChargeCalcuationType.value?.label,
            makingChargePerGram: double.parse(makingChargePerGramController.text.isEmpty ? "0.0" : makingChargePerGramController.text),
            flatMakingCharge: double.parse(flatMakingChargeController.text.isEmpty ? "0.0" : flatMakingChargeController.text),
            touch: double.parse(touchController.text.isEmpty ? "0.0" : touchController.text),
          );

          particulars[index] = itemDetails;
        } 
        
      }

      calculatePurchaseValue();
      resetForm(context);
      Get.back();

    }
  }

  Future resetForm(BuildContext context) async {
    selectedItem.value = null;
    selectedSubItem.value = null;
    piecesController.clear();
    grossWeightController.clear();
    reduceWeightController.clear();
    netWeightController.clear();
    stonePiecesController.clear();
    stoneWeightController.clear();
    stoneAmountController.clear();
    diamondPiecesController.clear();
    diamondWeightController.clear();
    diamondAmountController.clear();
    selectedStoneReduceWeight(DropdownModel(value: "0", label: "No"));
    selectedDiamondReduceWeight(DropdownModel(value: "0", label: "No"));
    hallmarkChargesController.clear();
    otherChargesController.clear();
    totalWeightController.clear();
    gstAmountController.clear();
    totalAmountController.clear();
    selectedCalculationType.value = null;
    
    fixedRateController.clear();

    selectedPerGramCalcuationType.value = null;
    perGramRateController.clear();

    perPieceRateController.clear();

    selectedWastageCalcuationType.value = null;
    wastagePercentageController.clear();
    selectedFlatWastageType.value = null;
    flatWastageController.clear();
    selectedMakingChargeCalcuationType.value = null;
    makingChargePerGramController.clear();
    flatMakingChargeController.clear();

    itemFormMode('create');
  }

  void calculatePurchaseValue() {
    int items = 0;
    int pieces = 0;
    double grossWeight = 0.0;
    double netWeight = 0.0;
    double gst = 0.0;
    double grandTotal = 0.0;
    double pureWeight = 0.0;
    for (var i in particulars) {
      items += 1;
      pieces += i.pieces!;
      grossWeight += i.grossWeight!;
      netWeight += i.netWeight!;
      gst += i.gstAmount!;
      grandTotal += i.totalAmount!;
      pureWeight += i.totalWeight!;
    } 

    totalItems(items);
    totalPieces(pieces);
    totalGrossWeight(grossWeight);
    totalNetWeight(netWeight);
    gstAmount(gst);
    grandTotalAmount(grandTotal);
    payableGrandTotalAmount(grandTotal);
    payablPureWeight(pureWeight);
    originalPayablPureWeight(pureWeight);
    isConvertedWeight(false);
    payableWithoutGst(grandTotal);

    calculateTdsAmount();
  }

  void convertWeightToAmount(BuildContext context) {
    String convertAmt = (payablPureWeight.value * double.parse(convertionRateController.text.isEmpty ? "0" : convertionRateController.text)).toStringAsFixed(2);

    String convertGstAmt = (double.parse(convertAmt??"0") * (double.parse(convertionGstController.text.isEmpty ? "0" : convertionGstController.text) / 100)).toStringAsFixed(2);

    convertionWithGst(double.parse(convertAmt) + double.parse(convertGstAmt));
    convertionGstAmount(double.parse(convertGstAmt));
    convertedAmount(double.parse(convertAmt));
  }

  void addWithPayable() {
    isConvertedWeight(true);
    convertedWeight(payablPureWeight.value);
    payablPureWeight(0.0);
    originalPayablPureWeight(0.0);
    convertionRate(double.parse(convertionRateController.text.isEmpty ? "0" : convertionRateController.text));
    payableWithoutGst(grandTotalAmount.value + convertedAmount.value);
    payableGrandTotalAmount(grandTotalAmount.value + convertionWithGst.value);
    convertionGst(double.parse(convertionGstController.text.isEmpty ? "0" : convertionGstController.text));
    calculateTdsAmount();
  }

  void calculateTdsAmount() {
    int tdsValue = (payableWithoutGst.value * (double.parse(tdsPercentController.text.isEmpty ? "0" : tdsPercentController.text) / 100)).round();
    tdsAmount(tdsValue);

    payableAmount(payableWithoutGst.value - tdsValue);

    double roundOff = double.tryParse(roundOffController.text.isEmpty
                ? "0"
                : roundOffController.text) ==
            null
        ? 0.0
        : double.parse(
            roundOffController.text.isEmpty ? "0" : roundOffController.text);

    payableWithRoundAmount((payableGrandTotalAmount.value - tdsValue) - (roundOff * -1));
  }

  void calculateWeightRoundOff() {
    double weightroundOff = double.tryParse(weightRoundOffController.text.isEmpty
                ? "0"
                : weightRoundOffController.text) ==
            null
        ? 0.0
        : double.parse(
            weightRoundOffController.text.isEmpty ? "0" : weightRoundOffController.text);
    payablPureWeight(originalPayablPureWeight.value - (weightroundOff * -1));
    calculateTdsAmount();
  }
}
