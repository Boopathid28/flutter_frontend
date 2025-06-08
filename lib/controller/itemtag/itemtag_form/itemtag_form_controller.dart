import 'dart:developer';

import 'package:ausales_application/controller/itemtag/create_itemtag_branch_form_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_particulars_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_stone_form_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/itemtag/itemtag_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/itemtag/itemtag_form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ItemtagFormController extends HeaderController {
  final ItemtagFormParticularsController _itemtagFormParticularsController =
      Get.put(ItemtagFormParticularsController());

  final CreateItemtagBranchFormController _createItemtagBranchFormController =
      Get.put(CreateItemtagBranchFormController());

  //   final ItemtagStoneFormController _itemtagStoneFormController =
  // Get.put(ItemtagStoneFormController());

  final ItemtagListController _itemtagListController =
      Get.put(ItemtagListController());

  final itemtagDetailsFormKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController itemDetailSearchController = TextEditingController();
  TextEditingController subItemDetailSearchController = TextEditingController();
  TextEditingController tagTypeSearchController = TextEditingController();

  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedTagType = Rx<DropdownModel?>(null);

  Rx<DropdownModel?> selectedWastageCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMakingChargeCalcuationType =
      Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPerGramCalcuationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFlatWastageType = Rx<DropdownModel?>(null);

  TextEditingController tagCountController = TextEditingController();
  TextEditingController touchController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController measurementValueController = TextEditingController();
  TextEditingController catalogueCoverWeightController =
      TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
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

  TextEditingController totalStoneController = TextEditingController();
  TextEditingController totalDiamondController = TextEditingController();

  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subItemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> tagTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> weightTypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> flatWastageTypeDropDown = <DropdownModel>[].obs;

  RxList<LotItemListDropDownModel> itemList = <LotItemListDropDownModel>[].obs;
  RxList<SubItemDropdownModel> subItemList = <SubItemDropdownModel>[].obs;
  RxList<TagTypeDropdownModel> tagTypeList = <TagTypeDropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool isFormDone = false.obs;

  RxString lotItemId = "".obs;

  RxString measurementType = "".obs;
  RxString calculationType = "".obs;
  RxString stockType = "".obs;
  RxString tagEntryDetails = "".obs;

  RxInt totalStonePieces = 0.obs;
  RxInt totalDiamondPieces = 0.obs;
  RxDouble totalStoneAmount = 0.0.obs;
  RxDouble totalDiamondAmount = 0.0.obs;

  RxDouble reduceStoneWeight = 0.0.obs;
  RxDouble reduceDiamondWeight = 0.0.obs;

  RxString editableTagNumber = "".obs;

  RxList<StoneDetails> stoneParticularList = <StoneDetails>[].obs;
  RxList<DiamondDetails> diamondParticularList = <DiamondDetails>[].obs;

  RxDouble itemRemainingGrossWeight = 0.0.obs;
  RxInt itemRemainingPieces = 0.obs;
  RxInt itemRemainingTagCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    getLotItemList(args['lotNo']);
    getWeightTypeList();
    getFlatWastageTypeList();
  }

  Future getLotItemList(String lotNumber) async {
    itemDropDown([]);
    final List<LotItemListDropDownModel> tempList =
        await DropdownService.lotItemListDropDownByLot(lotNumber);
    itemList(tempList);

    tempList.forEach((item) {
      itemDropDown.add(DropdownModel(
          value: item.itemDetails.toString(), label: item.itemName.toString()));
    });
  }

  Future getSubItemList(String item, BuildContext context) async {
    subItemDropDown([]);
    selectedSubItem.value = null;
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: item);
    subItemList(tempList);

    tempList.forEach((item) {
      subItemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.subItemName.toString()));
    });

    for (var i in itemList) {
      if (i.itemDetails.toString() == item) {
        itemRemainingGrossWeight(i.remainingGrossWeight);
        itemRemainingPieces(i.remainingPieces);
        itemRemainingTagCount(i.remainingTagCount);
        lotItemId(i.id.toString());
        getTagTypeList(i.metal.toString());
        getStoneDiamondDetailsList(i.id.toString(), context);
        break;
      }
    }
  }

  Future getStoneDiamondDetailsList(
      String lotItemId, BuildContext context) async {
    final StoneAndDiamondDetailsResponse? data =
        await ItemtagFormService.getStoneDiamondDetailsById(
            lotItemIdId: lotItemId, context: context);

    if (data != null) {
      for (var i in data.stoneDetails??[]) {
        stoneParticularList.add(i);
        log("data  ${i}");
      }
      for (var i in data.diamondDetails??[]) {
        diamondParticularList.add(i);
      }
      stoneAddCompleted(context);
      diamondAddCompleted(context);
    } else {
      stoneParticularList([]);
      diamondParticularList([]);
    }
  }

  Future getTagTypeList(String metal) async {
    tagTypeDropDown([]);
    final List<TagTypeDropdownModel> tempList =
        await DropdownService.tagTypeDropDown(metal: metal);

    tagTypeList(tempList);

    tempList.forEach((item) {
      tagTypeDropDown.add(DropdownModel(
          value: item.id.toString(),
          label: "${item.tagName.toString()}(${item.tagCode.toString()})"));
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

  Future getSubitemCalculationDetails(String subItemId, BuildContext context,
      String calcTypeId, String grossWeight) async {
    final data = await ItemtagFormService.getSubitemCalculationDetails(
        subItemId: subItemId,
        context: context,
        calcTypeId: calcTypeId,
        grossWeight: grossWeight,
        lotItemId: lotItemId.value);

    if (calcTypeId == weightCalcType) {
      if (data != null) {
        final SubItemWeightCalcDetailsResponse details =
            SubItemWeightCalcDetailsResponse.fromJson(data);

        selectedWastageCalcuationType(DropdownModel(
            value: details.wastageCalculationType.toString(),
            label: details.wastageCalculationTypeName.toString()));
        wastagePercentageController.text = details.wastagePercent.toString();
        minWastagePercentageController.text =
            details.minWastagePercent.toString();
        selectedFlatWastageType(DropdownModel(
            value: details.flatWastageType.toString(),
            label: details.flatWastageTypeName.toString()));
        flatWastageController.text = details.flatWastage.toString();
        minFlatWastageController.text = details.minFlatWastage.toString();
        selectedMakingChargeCalcuationType(DropdownModel(
            value: details.makingChargeCalculationType.toString(),
            label: details.makingChargeCalculationTypeName.toString()));
        makingChargePerGramController.text =
            details.makingChargePerGram.toString();
        minMakingChargePerGramController.text =
            details.minMakingChargePerGram.toString();
        flatMakingChargeController.text = details.flatMakingCharge.toString();
        minFlatMakingChargeController.text =
            details.minFlatMakingCharge.toString();
      }
    } else if (calcTypeId == perGramRateCalcType) {
      if (data != null) {
        final SubItemPerGramCalcDetailsResponse details =
            SubItemPerGramCalcDetailsResponse.fromJson(data);

        selectedPerGramCalcuationType(DropdownModel(
            value: details.perGramWeightType.toString(),
            label: details.perGramWeightTypeName.toString()));
        perGramRateController.text = details.perGramRate.toString();
        minPerGramRateController.text = details.minPerGramRate.toString();
      }
    } else if (calcTypeId == fixedRateCalcType) {
      if (data != null) {
        final SubItemFixedCalcDetailsResponse details =
            SubItemFixedCalcDetailsResponse.fromJson(data);
        fixedRateController.text = details.fixedRate.toString();
        minFixedRateController.text = details.minFixedRate.toString();
      }
    } else if (calcTypeId == perPieceRateCalcType) {
      if (data != null) {
        final SubItemPerPieceCalcDetailsResponse details =
            SubItemPerPieceCalcDetailsResponse.fromJson(data);
        perPieceRateController.text = details.perPieceRate.toString();
        minPerPieceRateController.text = details.minPerPieceRate.toString();
      }
    }
  }

  Future submitItemForm(BuildContext context) async {
    if (itemtagDetailsFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        String? lotItemId;
        for (var i in itemList) {
          if (i.itemDetails.toString() ==
              selectedItem.value?.value.toString()) {
            lotItemId = i.id.toString();
            break;
          }
        }
        var args = Get.arguments;

        CreateTagEntryItemPayload payload = CreateTagEntryItemPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            lotItemDetails: lotItemId,
            tagCount: int.parse(tagCountController.text),
            pieces: int.parse(piecesController.text),
            grossWeight: double.parse(grossWeightController.text),
            netWeight: double.parse(netWeightController.text),
            reduceWeight: double.parse(reduceWeightController.text),
            tagEntryDetails: args['tagEntryId'],
            subItemDetails: selectedSubItem.value?.value,
            tagType: selectedTagType.value?.value,
            measurementValue: measurementValueController.text,
            catalogueCoverWeight: double.parse(
                catalogueCoverWeightController.text.isNotEmpty
                    ? catalogueCoverWeightController.text
                    : "0"),
            remark: remarksController.text,
            touch: double.parse(
                touchController.text.isEmpty ? "0.0" : touchController.text),
            totalStoneAmount: totalStoneAmount.value,
            totalStoneWeight: double.parse(stoneWeightController.text.isEmpty
                ? "0.0"
                : stoneWeightController.text),
            totalStonePieces: totalStonePieces.value,
            totalDiamondAmount: totalDiamondAmount.value,
            totalDiamondWeight: double.parse(
                diamondWeightController.text.isEmpty
                    ? "0.0"
                    : diamondWeightController.text),
            totalDiamondPieces: totalDiamondPieces.value,
            stoneDetails: stoneParticularList,
            diamondDetails: diamondParticularList,
            branch: args['branch']);

        var payloadData = payload.toJson();

        if (calculationType.value.toString() == fixedRateCalcType.toString()) {
          payloadData['min_fixed_rate'] = minFixedRateController.text;
          payloadData['fixed_rate'] = fixedRateController.text;
        } else if (calculationType.value.toString() ==
            weightCalcType.toString()) {
          payloadData['wastage_calculation_type'] =
              selectedWastageCalcuationType.value?.value;
          payloadData['min_wastage_percent'] =
              minWastagePercentageController.text;
          payloadData['wastage_percent'] = wastagePercentageController.text;
          payloadData['flat_wastage_type'] =
              selectedFlatWastageType.value?.value;
          payloadData['min_flat_wastage'] = minFlatWastageController.text;
          payloadData['flat_wastage'] = flatWastageController.text;
          payloadData['making_charge_calculation_type'] =
              selectedMakingChargeCalcuationType.value?.value;
          payloadData['min_making_charge_per_gram'] =
              minMakingChargePerGramController.text;
          payloadData['making_charge_per_gram'] =
              makingChargePerGramController.text;
          payloadData['min_flat_making_charge'] =
              minFlatMakingChargeController.text;
          payloadData['flat_making_charge'] = flatMakingChargeController.text;
        } else if (calculationType.value.toString() ==
            perGramRateCalcType.toString()) {
          payloadData['per_gram_weight_type'] =
              selectedPerGramCalcuationType.value?.value;
          payloadData['min_per_gram_rate'] = minPerGramRateController.text;
          payloadData['per_gram_rate'] = perGramRateController.text;
        } else if (calculationType.value.toString() ==
            perPieceRateCalcType.toString()) {
          payloadData['min_per_piece_rate'] = minPerPieceRateController.text;
          payloadData['per_piece_rate'] = perPieceRateController.text;
        }

        log("payload ${payloadData}");

        final String? data = await ItemtagFormService.createTagItem(
            payload: payloadData, context: context);

        if (data != null) {
          resetForm(context);
          _itemtagFormParticularsController.getItemTagList(context);
        }
        isFormSubmit(false);
      }
    }
  }

  resetForm(context) {
    itemtagDetailsFormKey.currentState!.reset();
    selectedItem.value = null;
    selectedSubItem.value = null;
    tagCountController.clear();
    piecesController.clear();
    grossWeightController.clear();
    reduceWeightController.clear();
    netWeightController.clear();
    selectedTagType.value = null;
    measurementType("");
    measurementValueController.clear();
    remarksController.clear();
    stoneWeightController.clear();
    diamondWeightController.clear();
    stoneParticularList([]);
    diamondParticularList([]);
    catalogueCoverWeightController.clear();
    calculationType("");

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

    _itemtagFormParticularsController.getItemTagList(context);
    itemRemainingGrossWeight(0.0);
    itemRemainingPieces(0);
    itemRemainingTagCount(0);

    stockType("");

    subItemDropDown([]);
    tagTypeDropDown([]);

    reduceDiamondWeight(0.0);
    reduceStoneWeight(0.0);
  }

  void onHuidChange(String value, String tagNumber) {
    int itemIndex = _itemtagFormParticularsController.itemTagList
        .indexWhere((item) => item.tagNumber! == tagNumber);
    var dataList = [..._itemtagFormParticularsController.itemTagList.value];
    TagItemDetailsResponse item = dataList[itemIndex];
    var jsonObjectItem = item.toJson();
    jsonObjectItem['huid'] = value;
    TagItemDetailsResponse updatedItem =
        TagItemDetailsResponse.fromJson(jsonObjectItem);

    _itemtagFormParticularsController.itemTagList[itemIndex] = updatedItem;
  }

  void onGrossWeightChange(String value, String tagNumber) {
    int itemIndex = _itemtagFormParticularsController.itemTagList
        .indexWhere((item) => item.tagNumber == tagNumber);
    var dataList = [..._itemtagFormParticularsController.itemTagList.value];
    TagItemDetailsResponse item = dataList[itemIndex];

    var jsonObjectItem = item.toJson();
    jsonObjectItem['gross_weight'] =
        double.parse(value.isEmpty ? "0.0" : value);

    double netWeightValue = double.parse(value.isEmpty ? "0.0" : value) -
        (item.reduceWeight! +
            item.totalDiamondWeight! +
            item.totalStoneWeight!);
    jsonObjectItem['net_weight'] = netWeightValue;

    TagItemDetailsResponse updatedItem =
        TagItemDetailsResponse.fromJson(jsonObjectItem);

    _itemtagFormParticularsController.itemTagList[itemIndex] = updatedItem;
  }

  void onReduceWeightChange(String value, String tagNumber) {
    int itemIndex = _itemtagFormParticularsController.itemTagList
        .indexWhere((item) => item.tagNumber == tagNumber);

    var dataList = [..._itemtagFormParticularsController.itemTagList.value];
    TagItemDetailsResponse item = dataList[itemIndex];

    var jsonObjectItem = item.toJson();
    jsonObjectItem['reduce_weight'] =
        double.parse(value.isEmpty ? "0.0" : value);

    double netWeightValue = item.grossWeight! -
        (double.parse(value.isEmpty ? "0.0" : value) +
            item.totalDiamondWeight! +
            item.totalStoneWeight!);
    jsonObjectItem['net_weight'] = netWeightValue;

    TagItemDetailsResponse updatedItem =
        TagItemDetailsResponse.fromJson(jsonObjectItem);

    _itemtagFormParticularsController.itemTagList[itemIndex] = updatedItem;
  }

  Future completeItemtagging(BuildContext context) async {
    final tempList = [];

    bool isValid = true;

    for (var i in _itemtagFormParticularsController.itemTagList.value) {
      if (i.huid == null || i.huid!.isEmpty) {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.warning,
            title: Text("Huid is missing for this ${i.tagNumber}"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
        isValid = false;
        break;
      } else {
        final dictData = {
          "tag_number": i.tagNumber,
          "gross_weight": i.grossWeight,
          "reduce_weight": i.reduceWeight,
          "net_weight": i.netWeight,
          "huid": i.huid
        };
        tempList.add(dictData);
      }
    }

    if (isValid) {
      if (!isFormDone.value) {
        isFormDone(true);

        final Object payload = {
          "menu_id": await HomeSharedPrefs.getCurrentMenu(),
          "tag_details": tempList,
          "remove_tag": null
        };

        final String? data = await ItemtagFormService.submitItemTagDetails(
            context: context, payload: payload);

        if (data != null) {
          _itemtagListController.getItemTagList(context);
          lotItemId("");
          Get.back();
        } else {
          toastification.show(
              context: context,
              type: ToastificationType.warning,
              title: Text("Tag details not created"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }

        isFormDone(false);
      }
    }
  }

  Future deleteTagItemDetails(String tagNumber, BuildContext context) async {
    final tempList = [];

    for (var i in _itemtagFormParticularsController.itemTagList.value) {
      if (i.huid != null &&
          i.huid!.isNotEmpty &&
          i.grossWeight != null &&
          i.reduceWeight != null &&
          i.netWeight != null) {
        final dictData = {
          "tag_number": i.tagNumber,
          "gross_weight": i.grossWeight,
          "reduce_weight": i.reduceWeight,
          "net_weight": i.netWeight,
          "huid": i.huid
        };
        tempList.add(dictData);
      }
    }

    final Object payload = {
      "menu_id": await HomeSharedPrefs.getCurrentMenu(),
      "tag_details": tempList,
      "remove_tag": tagNumber
    };

    final String? data = await ItemtagFormService.submitItemTagDetails(
        payload: payload, context: context);

    if (data != null) {
      _itemtagFormParticularsController.getItemTagList(context);
      editableTagNumber("");
    }
  }

  Future onEditableChange(
      TagItemDetailsResponse details, BuildContext context) async {
    if (editableTagNumber.value == details.tagNumber) {
      final Object payload = {
        "menu_id": await HomeSharedPrefs.getCurrentMenu(),
        "tag_details": [
          {
            "tag_number": details.tagNumber,
            "gross_weight": details.grossWeight,
            "reduce_weight": details.reduceWeight,
            "net_weight": details.netWeight,
            "huid": details.huid
          }
        ],
        "remove_tag": null
      };

      final String? data = await ItemtagFormService.submitItemTagDetails(
          payload: payload, context: context);

      if (data != null) {
        _itemtagFormParticularsController.getItemTagList(context);
        editableTagNumber("");
      }
    } else {
      editableTagNumber(details.tagNumber);
    }
  }

   void stoneAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in stoneParticularList) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + (double.parse(i.stoneWeight??"0.0") / 5)).toString());
      }
      pieces = int.parse((pieces + int.parse(i.stonePieces??"0")).toString());
      weight = double.parse((weight + double.parse(i.stoneWeight??"0.0")).toString());
      amount = double.parse((amount + double.parse(i.stoneAmount??"0.0")).toString());
    }

    totalStonePieces(pieces);
    totalStoneAmount(amount);
    stoneWeightController.text = weight.toString();

    reduceStoneWeight(reduceWeight);

    calcNetWeight(grossWeight: grossWeightController.text, reduceWeight: reduceWeightController.text,
    reduceStone: reduceWeight, reduceDiamond: reduceDiamondWeight.value);

  }

 void diamondAddCompleted(BuildContext context) {
    int pieces = 0;
    double weight = 0;
    double amount = 0;

    double reduceWeight = 0.0;

    for (var i in diamondParticularList) {

      if (i.reduceWeight!) {
        reduceWeight = double.parse((reduceWeight + (double.parse(i.diamondWeight??"0.0") / 5)).toString());
      }
      pieces = int.parse((pieces + int.parse(i.diamondPieces??"0")).toString());
      weight = double.parse((weight + double.parse(i.diamondWeight??"0.0")).toString());
      amount = double.parse((amount + double.parse(i.diamondAmount??"0.0")).toString());
    }

    totalDiamondPieces(pieces);
    totalDiamondAmount(amount);
    diamondWeightController.text = weight.toString();

    reduceDiamondWeight(reduceWeight);

    calcNetWeight(grossWeight: grossWeightController.text, reduceWeight: reduceWeightController.text,
    reduceStone: reduceStoneWeight.value, reduceDiamond: reduceWeight);

  }
}
