import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/single_tag_update/single_tag_update_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/single_tag_update/single_tag_update_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleTagUpdateController extends HeaderController {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController tagSearchController = TextEditingController();

  TextEditingController tagTypeSearchController = TextEditingController();
  
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedTag = Rx<DropdownModel?>(null);

  Rx<DropdownModel?> selectedWastageCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMakingChargeCalcuationType =
      Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPerGramCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFlatWastageType = Rx<DropdownModel?>(null);

  TextEditingController measurementValueController = TextEditingController();
  TextEditingController huidController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController catalogueCoverWeightController = TextEditingController();
  TextEditingController stoneWeightController = TextEditingController();
  TextEditingController diamondWeightController = TextEditingController();

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
  

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> tagDropDown = <DropdownModel>[].obs;

  RxList<DropdownModel> tagTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> weightTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> mcWeightTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> flatWastageTypeDropDown = <DropdownModel>[].obs;

  RxList<TagTypeDropdownModel> tagTypeList = <TagTypeDropdownModel>[].obs;

  Rx<DropdownModel?> selectedTagType = Rx<DropdownModel?>(null);

  RxString measurementType = "".obs;
  RxString calculationType = "".obs;

  RxObjectMixin<RetrieveTagDetails> tagDetailsData = RetrieveTagDetails().obs;
  RxList<TagStoneDetails> stoneDetailsList = <TagStoneDetails>[].obs;
  RxList<TagDiamondDetails> diamondDetailsList = <TagDiamondDetails>[].obs;

  RxList<String> deletedStoneDetailsList = <String>[].obs;
  RxList<String> deletedDiamondDetailsList = <String>[].obs;

  RxInt totalStonePieces = 0.obs;
  RxInt totalDiamondPieces = 0.obs;
  RxDouble totalStoneAmount = 0.0.obs;
  RxDouble totalDiamondAmount = 0.0.obs;

  RxDouble reduceStoneWeight = 0.0.obs;
  RxDouble reduceDiamondWeight = 0.0.obs;

  RxBool isFormSubmit = false.obs;
  RxBool isGetDetailsLoading = false.obs;

  @override
  RxBool get isBranchuser => super.isBranchuser;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    } else {
      getTagList(null);
    }

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

  Future getTagList(String? branch) async {
    tagDropDown([]);
    selectedTag.value = null;
    resetForm();
    final List<TagNumberDropdownModel> tempList =
        await DropdownService.TagNumberDropDown(branch);
    tempList.forEach((item) {
      tagDropDown.add(
          DropdownModel(label: item.tagNumber!, value: item.id.toString()));
    });
  }

  Future getWeightTypeList(DropdownModel selected, String field) async {
    weightTypeDropDown([]);
    final List<WeightTypeDropdownModel> tempList =
        await DropdownService.weightTypeDropDown();
    tempList.forEach((item) {
      weightTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
    });
    if (tempList.isNotEmpty) {
      if (field == 'perGramWeight') {
        selectedPerGramCalcuationType(selected);
      } else if (field == 'wastage') {
        selectedWastageCalcuationType(selected);
      }
    }
  }

  Future getMCWeightTypeList(DropdownModel selected, String field) async {
    mcWeightTypeDropDown([]);
    final List<WeightTypeDropdownModel> tempList =
        await DropdownService.weightTypeDropDown();
    tempList.forEach((item) {
      mcWeightTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
    });
    if (tempList.isNotEmpty) {
      selectedMakingChargeCalcuationType(selected);
    }
  }

  Future getFlatWastageTypeList(DropdownModel selected) async {
    flatWastageTypeDropDown([]);
    final List<FlatWastageTypeDropdownModel> tempList =
        await DropdownService.flatWastageTypeDropDown();
    tempList.forEach((item) {
      flatWastageTypeDropDown
          .add(DropdownModel(value: item.value!, label: item.lable.toString()));
    });
    if (tempList.isNotEmpty) {
      selectedFlatWastageType(selected);
    }
  }

  Future getTagTypeList(String metal, DropdownModel selected) async {
    tagTypeDropDown([]);

    final List<TagTypeDropdownModel> tempList =
        await DropdownService.tagTypeDropDown(metal: metal);

    tagTypeList(tempList);

    tempList.forEach((item) {
      tagTypeDropDown.add(DropdownModel(
          value: item.id.toString(),
          label: "${item.tagName.toString()}(${item.tagCode.toString()})"));
    });
    if (tempList.isNotEmpty) {
      selectedTagType(selected);
    }
  }

  void stoneAddCompleted(List<TagStoneDetails> data) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in data) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + (double.parse(i.stoneWeight.toString()??"0.0") / 5)).toString());
      }
      pieces = int.parse((pieces + int.parse(i.stonePieces.toString()??"0")).toString());
      weight = double.parse((weight + double.parse(i.stoneWeight.toString()??"0.0")).toString());
      amount = double.parse((amount + double.parse(i.stoneAmount.toString()??"0.0")).toString());
    }

    totalStonePieces(pieces);
    totalStoneAmount(amount);
    stoneWeightController.text = weight.toString();

    reduceStoneWeight(reduceWeight);

    calcNetWeight(grossWeight: tagDetailsData.value.grossWeight!.toStringAsFixed(3), reduceWeight: reduceWeightController.text,
    reduceStone: reduceWeight, reduceDiamond: reduceDiamondWeight.value);

  }

  void diamondAddCompleted(List<TagDiamondDetails> data) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in data) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + (double.parse(i.diamondWeight.toString()??"0.0") / 5)).toString());
      }
      pieces = int.parse((pieces + int.parse(i.diamondPieces.toString()??"0")).toString());
      weight = double.parse((weight + double.parse(i.diamondWeight.toString()??"0.0")).toString());
      amount = double.parse((amount + double.parse(i.diamondAmount.toString()??"0.0")).toString());
    }

    totalDiamondPieces(pieces);
    totalDiamondAmount(amount);
    diamondWeightController.text = weight.toString();

    reduceDiamondWeight(reduceWeight);

    calcNetWeight(grossWeight: tagDetailsData.value.grossWeight.toString(), reduceWeight: reduceWeightController.text,
    reduceStone: reduceStoneWeight.value, reduceDiamond: reduceWeight);

  }

  Future getTagDetails(BuildContext context, String tagNumber) async {
    isGetDetailsLoading(true);
    resetForm();
    int? menuId = await HomeSharedPrefs.getCurrentMenu();
    final RetrieveTagDetails? data = await SingleTagUpdateService.retrieveTagdetails(context: context, tagNumber: tagNumber, menuId: menuId.toString());

    if (data != null) {
      tagDetailsData(data);
      stoneDetailsList(data.stoneDetails);
      diamondDetailsList(data.diamondDetails);
      getTagTypeList(data.metalDetails.toString(), DropdownModel(value: data.tagType.toString(), label: "${data.tagTypeName.toString()}(${data.tagTypeCode.toString()})"));
      measurementValueController.text = data.measurementValue.toString();
      catalogueCoverWeightController.text = data.catalogueCoverWeight.toString();
      huidController.text = data.huid??"";
      remarksController.text = data.remark.toString();
      grossWeightController.text = data.availableGrossWeight!.toStringAsFixed(3);
      piecesController.text = data.availablePieces.toString();
      reduceWeightController.text = data.reduceWeight!.toStringAsFixed(3);
      netWeightController.text = data.availableNetWeight!.toStringAsFixed(3);

      stoneWeightController.text = data.totalStoneWeight!.toStringAsFixed(3);
      diamondWeightController.text = data.totalDiamondWeight!.toStringAsFixed(3);

      calculationType(data.calculationType);

      if (data.calculationType.toString() == fixedRateCalcType) {
        minFixedRateController.text = data.minFixedRate!.toStringAsFixed(2);
        fixedRateController.text = data.fixedRate!.toStringAsFixed(2);
      } else if (data.calculationType.toString() == perPieceRateCalcType) {
        minPerPieceRateController.text = data.minPerPieceRate.toString();
        perPieceRateController.text = data.perPieceRate.toString();
      } else if (data.calculationType.toString() == perGramRateCalcType) {
        getWeightTypeList(DropdownModel(value: data.perGramWeightType.toString(), label: data.perGramWeightTypeName.toString()), 'perGramWeight');
        minPerGramRateController.text = data.minPerGramRate.toString();
        perGramRateController.text = data.perGramRate.toString();
      } else if (data.calculationType.toString() == weightCalcType) {
        getWeightTypeList(DropdownModel(value: data.wastageCalculationType.toString(), label: data.wastageCalculationTypeName.toString()), 'wastage');
        getMCWeightTypeList(DropdownModel(value: data.makingChargeCalculationType.toString(), label: data.makingChargeCalculationTypeName.toString()), 'makingCharge');
        getFlatWastageTypeList(DropdownModel(value: data.flatWastageType.toString(), label: data.flatWastageTypeName.toString()));
        minWastagePercentageController.text = data.minWastagePercent.toString();
        wastagePercentageController.text = data.wastagePercent.toString();
        minFlatWastageController.text = data.minFlatWastage.toString();
        flatWastageController.text = data.flatWastage.toString();
        minMakingChargePerGramController.text = data.minMakingChargePerGram.toString();
        makingChargePerGramController.text = data.makingChargePerGram.toString();
        minFlatMakingChargeController.text = data.minFlatMakingCharge.toString();
        flatMakingChargeController.text = data.flatMakingCharge.toString();
      }
      stoneAddCompleted(data.stoneDetails??[]);
      diamondAddCompleted(data.diamondDetails??[]);
    }

    isGetDetailsLoading(false);
  }

  

  resetFilterForm() {
    selectedTag.value = null;
    if (isBranchuser.value) {
      tagDropDown([]);
    }
    selectedBranch.value = null;
  }

  resetForm() {
    
    tagTypeDropDown([]);
    selectedTagType.value = null;
    measurementType("");
    measurementValueController.clear();
    remarksController.clear();
    huidController.clear();
    calculationType("");
    netWeightController.clear();
    catalogueCoverWeightController.clear();
    reduceWeightController.clear();
    grossWeightController.clear();
    piecesController.clear();

    stoneWeightController.clear();
    diamondWeightController.clear();
    totalDiamondAmount(0.0);
    totalDiamondPieces(0);
    totalStoneAmount(0.0);
    totalDiamondPieces(0);
    reduceDiamondWeight(0.0);
    reduceStoneWeight(0.0);

    deletedDiamondDetailsList([]);
    deletedStoneDetailsList([]);
    stoneDetailsList([]);
    diamondDetailsList([]);

    minFixedRateController.clear();
    fixedRateController.clear();

    minPerGramRateController.clear();
    perPieceRateController.clear();

    selectedPerGramCalcuationType.value = null;
    minPerGramRateController.clear();
    perGramRateController.clear();

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

  }

  void calcNetWeight(
      {required String grossWeight,
      required String reduceWeight,
      required double reduceStone,
      required double reduceDiamond}) {
    netWeightController.text =
        (double.parse(grossWeight.isEmpty ? "0" : grossWeight) -
                (reduceStone +
                    reduceDiamond +
                    double.parse(reduceWeight.isEmpty ? "0" : reduceWeight)))
            .toString();
  }

  Future updateTagDetails(BuildContext context) async {
    if (!isFormSubmit.value) {
      isFormSubmit(true);
      int? menuId = await HomeSharedPrefs.getCurrentMenu();
      if (calculationType.value == fixedRateCalcType) {
        SingleTagUpdatePayload payload = SingleTagUpdatePayload(
          tagNumber: selectedTag.value?.label,
          menuId: menuId,
          tagType: selectedTagType.value?.value,
          measurementValue: measurementValueController.text,
          huid: huidController.text,
          remark: remarksController.text,
          grossWeight: double.parse(grossWeightController.text.isEmpty ? "0" : grossWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0" : reduceWeightController.text),
          pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
          netWeight: double.parse(netWeightController.text.isEmpty ? "0" : netWeightController.text),
          catalogueCoverWeight: double.parse(catalogueCoverWeightController.text.isNotEmpty ? catalogueCoverWeightController.text : "0"),
          totalStonePieces: totalStonePieces.value,
          totalStoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text),
          totalStoneAmount: totalStoneAmount.value,
          totalDiamondPieces: totalDiamondPieces.value,
          totalDiamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text),
          totalDiamondAmount: totalDiamondAmount.value,
          minFixedRate: double.parse(minFixedRateController.text.isEmpty ? "0" : minFixedRateController.text),
          fixedRate: double.parse(fixedRateController.text.isEmpty ? "0" : fixedRateController.text),
          stoneDetails: stoneDetailsList.value,
          diamondDetails: diamondDetailsList.value,
          deleteStone: deletedStoneDetailsList.value,
          deleteDiamond: deletedDiamondDetailsList.value
        );

        final String? data =await SingleTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          resetForm();
          resetFilterForm();
        }
      } else if (calculationType.value == perPieceRateCalcType) {
        SingleTagUpdatePayload payload = SingleTagUpdatePayload(
          tagNumber: selectedTag.value?.label,
          menuId: menuId,
          tagType: selectedTagType.value?.value,
          measurementValue: measurementValueController.text,
          huid: huidController.text,
          remark: remarksController.text,
         grossWeight: double.parse(grossWeightController.text.isEmpty ? "0" : grossWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0" : reduceWeightController.text),
          pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
          netWeight: double.parse(netWeightController.text.isEmpty ? "0" : netWeightController.text),
          catalogueCoverWeight: double.parse(catalogueCoverWeightController.text.isNotEmpty ? catalogueCoverWeightController.text : "0"),
          totalStonePieces: totalStonePieces.value,
          totalStoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text),
          totalStoneAmount: totalStoneAmount.value,
          totalDiamondPieces: totalDiamondPieces.value,
          totalDiamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text),
          totalDiamondAmount: totalDiamondAmount.value,
          minPerPieceRate: double.parse(minPerPieceRateController.text.isEmpty ? "0" : minPerPieceRateController.text),
          perPieceRate: double.parse(perPieceRateController.text.isEmpty ? "0" : perPieceRateController.text),
          stoneDetails: stoneDetailsList.value,
          diamondDetails: diamondDetailsList.value,
          deleteStone: deletedStoneDetailsList.value,
          deleteDiamond: deletedDiamondDetailsList.value
        );

        final String? data =await SingleTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          resetForm();
          resetFilterForm();
        }
      }  else if (calculationType.value == perGramRateCalcType) {
        SingleTagUpdatePayload payload = SingleTagUpdatePayload(
          tagNumber: selectedTag.value?.label,
          menuId: menuId,
          tagType: selectedTagType.value?.value,
          measurementValue: measurementValueController.text,
          huid: huidController.text,
          remark: remarksController.text,
         grossWeight: double.parse(grossWeightController.text.isEmpty ? "0" : grossWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0" : reduceWeightController.text),
          pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
          netWeight: double.parse(netWeightController.text.isEmpty ? "0" : netWeightController.text),
          catalogueCoverWeight: double.parse(catalogueCoverWeightController.text.isNotEmpty ? catalogueCoverWeightController.text : "0"),
          // netWeight: double.parse(netWeightController.text.isEmpty ? "0" : netWeightController.text),
          totalStonePieces: totalStonePieces.value,
          totalStoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text),
          totalStoneAmount: totalStoneAmount.value,
          totalDiamondPieces: totalDiamondPieces.value,
          totalDiamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text),
          totalDiamondAmount: totalDiamondAmount.value,
          perGramWeightType: selectedPerGramCalcuationType.value?.value,
          minPerGramRate: double.parse(minPerGramRateController.text.isEmpty ? "0" : minPerGramRateController.text),
          perGramRate: double.parse(perGramRateController.text.isEmpty ? "0" : perGramRateController.text),
          stoneDetails: stoneDetailsList.value,
          diamondDetails: diamondDetailsList.value,
          deleteStone: deletedStoneDetailsList.value,
          deleteDiamond: deletedDiamondDetailsList.value
        );

        final String? data =await SingleTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          resetForm();
          resetFilterForm();
        }
      } else if (calculationType.value == weightCalcType) {
        SingleTagUpdatePayload payload = SingleTagUpdatePayload(
          tagNumber: selectedTag.value?.label,
          menuId: menuId,
          tagType: selectedTagType.value?.value,
          measurementValue: measurementValueController.text,
          huid: huidController.text,
          remark: remarksController.text,
          grossWeight: double.parse(grossWeightController.text.isEmpty ? "0" : grossWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text.isEmpty ? "0" : reduceWeightController.text),
          pieces: int.parse(piecesController.text.isEmpty ? "0" : piecesController.text),
          netWeight: double.parse(netWeightController.text.isEmpty ? "0" : netWeightController.text),
          catalogueCoverWeight: double.parse(catalogueCoverWeightController.text.isNotEmpty ? catalogueCoverWeightController.text : "0"),
          // netWeight: double.parse(netWeightController.text.isEmpty ? "0" : netWeightController.text),
          totalStonePieces: totalStonePieces.value,
          totalStoneWeight: double.parse(stoneWeightController.text.isEmpty ? "0" : stoneWeightController.text),
          totalStoneAmount: totalStoneAmount.value,
          totalDiamondPieces: totalDiamondPieces.value,
          totalDiamondWeight: double.parse(diamondWeightController.text.isEmpty ? "0" : diamondWeightController.text),
          totalDiamondAmount: totalDiamondAmount.value,
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
          stoneDetails: stoneDetailsList.value,
          diamondDetails: diamondDetailsList.value,
          deleteStone: deletedStoneDetailsList.value,
          deleteDiamond: deletedDiamondDetailsList.value
        );

        final String? data =await SingleTagUpdateService.updateTagdetails(payload: payload, context: context);

        if (data != null) {
          resetForm();
          resetFilterForm();
        }
      }
      isFormSubmit(false);
    }
  }
}