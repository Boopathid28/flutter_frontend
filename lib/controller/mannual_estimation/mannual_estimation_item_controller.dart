import 'dart:developer';

import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/estimation/estimation_model.dart';
import 'package:ausales_application/model/mannual_estimation/mannual_estimation_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/invoice/invoice_service.dart';
import 'package:ausales_application/service/item_tag_details/item_tag_details_service.dart';
import 'package:ausales_application/service/mannual_estimation/mannual_estimation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class MannualEstimationItemController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final MannualEstimationController _mannualEstimationController =
      Get.put(MannualEstimationController());

  final estimationItemFormKey = GlobalKey<FormState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController tagNumberController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController wastagePercentController = TextEditingController();
  TextEditingController flatWastageController = TextEditingController();
  TextEditingController makingChargePerGramController = TextEditingController();
  TextEditingController flatMakingChargeController = TextEditingController();
  TextEditingController stoneAmountController = TextEditingController();
  TextEditingController diamondAmountController = TextEditingController();
  TextEditingController huidAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController gstPercentController = TextEditingController();
  TextEditingController payableAmountController = TextEditingController();

  TextEditingController itemDetailSearchController = TextEditingController();
  TextEditingController subItemDetailSearchController = TextEditingController();
  TextEditingController searchPurityController = TextEditingController();

  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);

  TextEditingController calculationTypeSearchController =
      TextEditingController();
  TextEditingController wastagecalculationTypeSearchController =
      TextEditingController();
  TextEditingController flatwastageTypeSearchController =
      TextEditingController();
  TextEditingController makingchargecalculationtypeSearchController =
      TextEditingController();
  TextEditingController pergramweightTypeSearchController =
      TextEditingController();

  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedcalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedwasatgecalculationType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedflatwasatgeType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedmakingchargecalculationType =
      Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedpergramweightType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> itemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> subitemFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> calculationTypeFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> wastagecalculationTypeFilterList =
      <DropdownModel>[].obs;
  RxList<DropdownModel> flatwastageTypeFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> makingchargecalculationTypeFilterList =
      <DropdownModel>[].obs;
  RxList<DropdownModel> pergramweightTypeFilterList = <DropdownModel>[].obs;

  RxString calculationType = "".obs;
  RxString stockType = "".obs;

  RxString perGramWeightType = "".obs;
  RxString wastageWeightType = "".obs;
  RxString flatWastageType = "".obs;
  RxString makingChargeType = "".obs;

  RxDouble gstPercent = 0.0.obs;

  RxString itemFormMode = "add".obs;

  RxString editItemId = "".obs;

  RxBool retrieveTagNumberLoading = false.obs;

  RxList<MannualTagDetailStoneDetails> stoneParticularList =
      <MannualTagDetailStoneDetails>[].obs;
  RxList<MannualTagDetailDiamondDetails> diamondParticularList =
      <MannualTagDetailDiamondDetails>[].obs;

  RxInt totalStonePieces = 0.obs;
  RxDouble totalStoneWeight = 0.0.obs;
  RxInt totalDiamondPieces = 0.obs;
  RxDouble totalDiamondWeight = 0.0.obs;

  RxDouble reduceStoneWeight = 0.0.obs;
  RxDouble reduceDiamondWeight = 0.0.obs;

  RxDouble minWastagePercent = 0.0.obs;
  RxDouble minFlatWastage = 0.0.obs;
  RxDouble minMakingChargePerGram = 0.0.obs;
  RxDouble minFlatMakingCharge = 0.0.obs;
  RxDouble minMetalRate = 0.0.obs;
  RxInt remainingPieces = 0.obs;
  RxDouble remainingGrossWeight = 0.0.obs;
  RxDouble remainingNetWeight = 0.0.obs;

  RxList<DropdownModel> purityDropDown = <DropdownModel>[].obs;
  RxList<PurityDropdownModel> purityList = <PurityDropdownModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    bool value = await getIsBranchUser();

    if (value == true) {}
    getItemList();
    getCalculationTypeList();
    getwastagecalculationTypeList();
    getFlatWastageTypeList();
    makingchargecalculationTypeList();
    pergramweightTypeList();
    getPurityList();
  }

  Future getPurityList() async {
    purityDropDown([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    tempList.forEach((item) {
      purityDropDown.add(
          DropdownModel(label: item.purityName!, value: item.id.toString()));
    });
    purityList(tempList);
  }

  Future getItemList() async {
    itemFilterList([]);
    final List<ItemDropdownModel> templist =
        await DropdownService.itemDropDown();
    templist.forEach((item) {
      itemFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.itemName.toString()));
    });
  }

  Future getSubItemList(String? item) async {
    subitemFilterList([]);
    final List<SubItemDropdownModel> templist =
        await DropdownService.subItemDropDown(item: item);
    templist.forEach((item) {
      subitemFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.subItemName.toString()));
    });
  }

  Future getCalculationTypeList() async {
    calculationTypeFilterList([]);
    final List<CalculationTypeDropdownModel> templist =
        await DropdownService.calculationTypeDropDown();
    templist.forEach((item) {
      calculationTypeFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future getwastagecalculationTypeList() async {
    wastagecalculationTypeFilterList([]);
    final List<WeightTypeDropdownModel> templist =
        await DropdownService.weightTypeDropDown();
    templist.forEach((item) {
      wastagecalculationTypeFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future getFlatWastageTypeList() async {
    flatwastageTypeFilterList([]);
    final List<FlatWastageTypeDropdownModel> templist =
        await DropdownService.flatWastageTypeDropDown();
    templist.forEach((item) {
      flatwastageTypeFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future makingchargecalculationTypeList() async {
    makingchargecalculationTypeFilterList([]);
    final List<WeightTypeDropdownModel> templist =
        await DropdownService.weightTypeDropDown();
    templist.forEach((item) {
      makingchargecalculationTypeFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future pergramweightTypeList() async {
    pergramweightTypeFilterList([]);
    final List<WeightTypeDropdownModel> templist =
        await DropdownService.weightTypeDropDown();
    templist.forEach((item) {
      pergramweightTypeFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

// Future getsubitemId(String? subItemId, BuildContext context) async {
//   final SubItemGetDataListMannualEstimation? data  = await MannualEstimationService.getSubitemCalculationDetails(subItemId: subItemId.toString(), context: context);

//   if(data != null){
//     calculationType(data.calculationType);
//     stockType(data.stockType);
//     if (data.calculationType == weightCalcType) {
//       wastageWeightType(data.wastageCalculationType);
//       flatWastageType(data.flatWastageType);
//       makingChargeType(data.makingChargeCalculationType);
//     } else if (data.calculationType == perGramRateCalcType) {
//       perGramWeightType(data.perGramWeightType);
//     }
//     rateController.text = data.metalRate.toString();
//     wastagePercentController.text = data.wastagePercent.toString();
//     flatWastageController.text = data.flatWastage.toString();
//     makingChargePerGramController.text = data.makingChargePerGram.toString();
//     flatMakingChargeController.text = data.flatMakingCharge.toString();
//     huidAmountController.text = data.huidRate.toString();
//     if (_mannualEstimationController.selectedGstType.value?.value ==
//             interGstType) {
//           gstPercent(data.interGst);
//         } else if (_mannualEstimationController.selectedGstType.value?.value ==
//             intraGstType) {
//           gstPercent(data.intraGst);
//         }
//   }
// }

  Future getTagDetails(BuildContext context, String tagNumber) async {
    retrieveTagNumberLoading(true);
    var resData = await InvoiceService.getTagItemdetails(
        context: context,
        tagnumber: tagNumber,
        metal: _mannualEstimationController.selectedMetal.value?.value);

    if (resData != null) {
      MannualTagDetailsRetrieveData data =
          MannualTagDetailsRetrieveData.fromJson(resData['data']);
      calculationType(data.calculationType);

      stockType(data.stockType);
      if (data.calculationType == fixedRateCalcType) {
        minMetalRate(data.minFixedRate);
        remainingGrossWeight(data.availableGrossWeight);
        remainingPieces(data.availablePieces);
        remainingNetWeight(data.availableNetWeight);
        rateController.text = data.fixedRate!.toStringAsFixed(2);
        piecesController.text = data.availablePieces.toString();
        grossWeightController.text =
            data.availableGrossWeight!.toStringAsFixed(3);
        reduceWeightController.text = data.reduceWeight!.toStringAsFixed(3);
        netWeightController.text = data.availableNetWeight!.toStringAsFixed(3);
        stoneAmountController.text = data.totalStoneAmount!.toStringAsFixed(2);
        diamondAmountController.text =
            data.totalDiamondAmount!.toStringAsFixed(2);
        huidAmountController.text = data.huidRate!.toStringAsFixed(2);
        totalAmountController.text = data.withoutGstRate!.toStringAsFixed(2);

        totalStonePieces(data.totalStonePieces);
        totalStoneWeight(data.totalStoneWeight);

        reduceStoneWeight(data.stoneReduceWeight);
        reduceDiamondWeight(data.diamondReduceWeight);

        stoneParticularList(data.stoneDetails);
        diamondParticularList(data.diamondDetails);

        if (_mannualEstimationController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_mannualEstimationController.selectedGstType.value?.value ==
            intraGstType) {
          gstAmountController.text = data.intraGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.intraSaleValue!.toStringAsFixed(2);
          gstPercent(data.intraGstPercent);
        }
      } else if (data.calculationType == perGramRateCalcType) {
        minMetalRate(data.minPerGramRate);
        remainingGrossWeight(data.availableGrossWeight);
        remainingPieces(data.availablePieces);
        remainingNetWeight(data.availableNetWeight);
        rateController.text = data.perGramRate!.toStringAsFixed(2);
        piecesController.text = data.availablePieces.toString();
        grossWeightController.text =
            data.availableGrossWeight!.toStringAsFixed(3);
        reduceWeightController.text = data.reduceWeight!.toStringAsFixed(3);
        netWeightController.text = data.availableNetWeight!.toStringAsFixed(3);
        stoneAmountController.text = data.totalStoneAmount!.toStringAsFixed(2);
        diamondAmountController.text =
            data.totalDiamondAmount!.toStringAsFixed(2);
        huidAmountController.text = data.huidRate!.toStringAsFixed(2);
        totalAmountController.text = data.withoutGstRate!.toStringAsFixed(2);
        gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
        payableAmountController.text = data.interSaleValue!.toStringAsFixed(2);

        stoneParticularList(data.stoneDetails);
        diamondParticularList(data.diamondDetails);

        reduceStoneWeight(data.stoneReduceWeight);
        reduceDiamondWeight(data.diamondReduceWeight);

        if (_mannualEstimationController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_mannualEstimationController.selectedGstType.value?.value ==
            intraGstType) {
          gstAmountController.text = data.intraGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.intraSaleValue!.toStringAsFixed(2);
          gstPercent(data.intraGstPercent);
        }

        perGramWeightType(data.perGramWeightType);
      } else if (data.calculationType == perPieceRateCalcType) {
        minMetalRate(data.minPerPieceRate);
        remainingGrossWeight(data.availableGrossWeight);
        remainingPieces(data.availablePieces);
        remainingNetWeight(data.availableNetWeight);
        rateController.text = data.perPieceRate!.toStringAsFixed(2);
        piecesController.text = data.availablePieces.toString();
        grossWeightController.text =
            data.availableGrossWeight!.toStringAsFixed(3);
        reduceWeightController.text = data.reduceWeight!.toStringAsFixed(3);
        netWeightController.text = data.availableNetWeight!.toStringAsFixed(3);
        stoneAmountController.text = data.totalStoneAmount!.toStringAsFixed(2);
        diamondAmountController.text =
            data.totalDiamondAmount!.toStringAsFixed(2);
        huidAmountController.text = data.huidRate!.toStringAsFixed(2);
        totalAmountController.text = data.withoutGstRate!.toStringAsFixed(2);

        stoneParticularList(data.stoneDetails);
        diamondParticularList(data.diamondDetails);

        reduceStoneWeight(data.stoneReduceWeight);
        reduceDiamondWeight(data.diamondReduceWeight);

        if (_mannualEstimationController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_mannualEstimationController.selectedGstType.value?.value ==
            intraGstType) {
          gstAmountController.text = data.intraGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.intraSaleValue!.toStringAsFixed(2);
          gstPercent(data.intraGstPercent);
        }
      } else if (data.calculationType == weightCalcType) {
        remainingGrossWeight(data.availableGrossWeight);
        remainingPieces(data.availablePieces);
        remainingNetWeight(data.availableNetWeight);
        rateController.text = data.metalRate!.toStringAsFixed(2);
        piecesController.text = data.availablePieces.toString();
        grossWeightController.text =
            data.availableGrossWeight!.toStringAsFixed(3);
        reduceWeightController.text = data.reduceWeight!.toStringAsFixed(3);
        netWeightController.text = data.availableNetWeight!.toStringAsFixed(3);
        stoneAmountController.text = data.totalStoneAmount!.toStringAsFixed(2);
        diamondAmountController.text =
            data.totalDiamondAmount!.toStringAsFixed(2);
        huidAmountController.text = data.huidRate!.toStringAsFixed(2);
        totalAmountController.text = data.withoutGstRate!.toStringAsFixed(2);

        stoneParticularList(data.stoneDetails);
        diamondParticularList(data.diamondDetails);

        reduceStoneWeight(data.stoneReduceWeight);
        reduceDiamondWeight(data.diamondReduceWeight);

        if (_mannualEstimationController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_mannualEstimationController.selectedGstType.value?.value ==
            intraGstType) {
          gstAmountController.text = data.intraGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.intraSaleValue!.toStringAsFixed(2);
          gstPercent(data.intraGstPercent);
        }

        wastageWeightType(data.wastageCalculationType);
        flatWastageType(data.flatWastageType);
        makingChargeType(data.makingChargeCalculationType);

        wastagePercentController.text = data.wastagePercent!.toStringAsFixed(2);
        flatWastageController.text = data.flatWastage!.toStringAsFixed(2);
        makingChargePerGramController.text =
            data.makingChargePerGram!.toStringAsFixed(2);
        flatMakingChargeController.text =
            data.flatMakingCharge!.toStringAsFixed(2);

        minWastagePercent(data.minWastagePercent);
        minFlatWastage(data.minFlatWastage);
        minMakingChargePerGram(data.minMakingChargePerGram);
        minFlatMakingCharge(data.minFlatMakingCharge);
      }
    }

    retrieveTagNumberLoading(false);
  }

  void addParticularItem(BuildContext context) {
    if (estimationItemFormKey.currentState!.validate()) {
      if (itemFormMode.value == 'add') {
        String isValidTag = _mannualEstimationController.particulars
            .indexWhere((i) => i.tag == tagNumberController.text)
            .toString();
        if (isValidTag == '-1') {
          var uuid = Uuid();
          String id = uuid.v4();

          final MannualParticularDetails item = MannualParticularDetails(
              sNo: id,
              itemName: itemController.text,
              purity: selectedPurity.value?.value,
              purityName: selectedPurity.value?.label,
              calculationTypeName: selectedcalculationType.value?.label,
              wastageCalculationTypeName:
                  selectedwasatgecalculationType.value?.label,
              flatWastageTypeName: selectedflatwasatgeType.value?.label,
              makingChargeCalculationTypeName:
                  selectedmakingchargecalculationType.value?.label,
              perGramWeightTypeName: selectedpergramweightType.value?.label,
              rate: double.parse(
                  rateController.text.isEmpty ? "0" : rateController.text),
              pieces: int.parse(
                  piecesController.text.isEmpty ? "0" : piecesController.text),
              grossWeight: double.parse(grossWeightController.text.isEmpty
                  ? "0"
                  : grossWeightController.text),
              reduceWeight: double.parse(reduceWeightController.text.isEmpty
                  ? "0"
                  : reduceWeightController.text),
              netWeight: double.parse(netWeightController.text.isEmpty
                  ? "0"
                  : netWeightController.text),
              remainingGrossWeight: remainingGrossWeight.value,
              remainingPieces: remainingPieces.value,
              remainingNetWeight: remainingNetWeight.value,
              wastagePercent: double.parse(wastagePercentController.text.isEmpty
                  ? "0"
                  : wastagePercentController.text),
              flatWastage: double.parse(
                  flatWastageController.text.isEmpty ? "0" : flatWastageController.text),
              makingChargePerGram: double.parse(makingChargePerGramController.text.isEmpty ? "0" : makingChargePerGramController.text),
              flatMakingCharge: double.parse(flatMakingChargeController.text.isEmpty ? "0" : flatMakingChargeController.text),
              stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text),
              diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
              huidAmount: double.parse(huidAmountController.text.isEmpty ? "0" : huidAmountController.text),
              totalAmount: double.parse(totalAmountController.text.isEmpty ? "0" : totalAmountController.text),
              gstAmount: double.parse(gstAmountController.text.isEmpty ? "0" : gstAmountController.text),
              payableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
              actualPayableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
              calculationType: selectedcalculationType.value?.value,
              gstPercent: double.parse(gstPercentController.text.isEmpty ? "0" : gstPercentController.text),
              minRate: minMetalRate.value,
              minWastagePercent: minWastagePercent.value,
              minFlatWastage: minFlatWastage.value,
              minMakingChargePerGram: minMakingChargePerGram.value,
              minFlatMakingCharge: minFlatMakingCharge.value,
              stoneDetails: stoneParticularList.value,
              diamondDetails: diamondParticularList.value,
              stockType: stockType.value,
              flatWastageType: flatWastageType.value.isEmpty ? null : flatWastageType.value,
              wastageWeightType: wastageWeightType.value.isEmpty ? null : wastageWeightType.value,
              makingChargeType: makingChargeType.value.isEmpty ? null : makingChargeType.value);

          _mannualEstimationController.particulars.insert(0, item);
          resetForm(context: context);
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text('The ${tagNumberController.text} is already added!'),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        int? index = _mannualEstimationController.particulars
            .indexWhere((i) => i.sNo == editItemId.value);
        final MannualParticularDetails item = MannualParticularDetails(
            sNo: editItemId.value,
            itemName: itemController.text,
              purity: selectedPurity.value?.value,
              purityName: selectedPurity.value?.label,
              calculationTypeName: selectedcalculationType.value?.label,
              wastageCalculationTypeName:
                  selectedwasatgecalculationType.value?.label,
              flatWastageTypeName: selectedflatwasatgeType.value?.label,
              makingChargeCalculationTypeName:
                  selectedmakingchargecalculationType.value?.label,
              perGramWeightTypeName: selectedpergramweightType.value?.label,
              rate: double.parse(
                  rateController.text.isEmpty ? "0" : rateController.text),
              pieces: int.parse(
                  piecesController.text.isEmpty ? "0" : piecesController.text),
              grossWeight: double.parse(grossWeightController.text.isEmpty
                  ? "0"
                  : grossWeightController.text),
              reduceWeight: double.parse(reduceWeightController.text.isEmpty
                  ? "0"
                  : reduceWeightController.text),
              netWeight: double.parse(netWeightController.text.isEmpty
                  ? "0"
                  : netWeightController.text),
              remainingGrossWeight: remainingGrossWeight.value,
              remainingPieces: remainingPieces.value,
              remainingNetWeight: remainingNetWeight.value,
              wastagePercent: double.parse(wastagePercentController.text.isEmpty
                  ? "0"
                  : wastagePercentController.text),
              flatWastage: double.parse(
                  flatWastageController.text.isEmpty ? "0" : flatWastageController.text),
              makingChargePerGram: double.parse(makingChargePerGramController.text.isEmpty ? "0" : makingChargePerGramController.text),
              flatMakingCharge: double.parse(flatMakingChargeController.text.isEmpty ? "0" : flatMakingChargeController.text),
              stoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text),
              diamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
              huidAmount: double.parse(huidAmountController.text.isEmpty ? "0" : huidAmountController.text),
              totalAmount: double.parse(totalAmountController.text.isEmpty ? "0" : totalAmountController.text),
              gstAmount: double.parse(gstAmountController.text.isEmpty ? "0" : gstAmountController.text),
              payableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
              actualPayableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
              calculationType: selectedcalculationType.value?.value,
              gstPercent: double.parse(gstPercentController.text.isEmpty ? "0" : gstPercentController.text),
              minRate: minMetalRate.value,
              minWastagePercent: minWastagePercent.value,
              minFlatWastage: minFlatWastage.value,
              minMakingChargePerGram: minMakingChargePerGram.value,
              minFlatMakingCharge: minFlatMakingCharge.value,
              stoneDetails: stoneParticularList.value,
              diamondDetails: diamondParticularList.value,
              stockType: stockType.value,
              flatWastageType: flatWastageType.value.isEmpty ? null : flatWastageType.value,
              wastageWeightType: wastageWeightType.value.isEmpty ? null : wastageWeightType.value,
              makingChargeType: makingChargeType.value.isEmpty ? null : makingChargeType.value);
        _mannualEstimationController.particulars[index] = item;
        resetForm(context: context);
      }

      calculationEstimation();
    }
  }

  void deleteParticularItem(
      BuildContext context, MannualParticularDetails item) {
    _mannualEstimationController.particulars
        .removeWhere((i) => i.sNo == item.sNo);

    calculationEstimation();
  }

  void editParticularItem(BuildContext context, MannualParticularDetails item) {
    itemFormMode('update');
    editItemId(item.sNo);
    calculationType(item.calculationType);
    gstPercent(item.gstPercent);

    selectedPurity(DropdownModel(value: item.purity.toString(), label: item.purityName.toString()));

    remainingGrossWeight(item.remainingGrossWeight);
    remainingNetWeight(item.remainingNetWeight);
    remainingPieces(item.remainingPieces);

    gstPercentController.text = (item.gstPercent??0.0).toString();
    gstPercent(item.gstPercent??0.0);

    selectedcalculationType(DropdownModel(
        value: item.calculationType.toString(), label: item.calculationTypeName.toString()));
    itemController.text = item.itemName.toString();
    rateController.text = item.rate!.toStringAsFixed(2);
    piecesController.text = item.pieces.toString();
    grossWeightController.text = item.grossWeight!.toStringAsFixed(3);
    reduceWeightController.text = item.reduceWeight!.toStringAsFixed(3);
    netWeightController.text = item.netWeight!.toStringAsFixed(3);
    stoneAmountController.text = item.stoneAmount!.toStringAsFixed(2);
    diamondAmountController.text = item.diamondAmount!.toStringAsFixed(2);
    huidAmountController.text = item.huidAmount!.toStringAsFixed(2);
    totalAmountController.text = item.totalAmount!.toStringAsFixed(2);
    gstAmountController.text = item.gstAmount!.toStringAsFixed(2);
    payableAmountController.text = item.payableAmount!.toStringAsFixed(2);

    minMetalRate(item.minRate);

    if (item.calculationType == weightCalcType) {
      wastagePercentController.text = item.wastagePercent!.toStringAsFixed(2);
      flatWastageController.text = item.flatWastage!.toStringAsFixed(2);
      makingChargePerGramController.text =
          item.makingChargePerGram!.toStringAsFixed(2);
      flatMakingChargeController.text =
          item.flatMakingCharge!.toStringAsFixed(2);

      minWastagePercent(item.minWastagePercent);
      minFlatWastage(item.minFlatWastage);
      minMakingChargePerGram(item.minMakingChargePerGram);
      minFlatMakingCharge(item.minFlatMakingCharge);
    } else if (item.calculationType == fixedRateCalcType) {
    } else if (item.calculationType == perPieceRateCalcType) {
      remainingPieces(item.remainingPieces);
    } else if (item.calculationType == perGramRateCalcType) {
      remainingGrossWeight(item.remainingGrossWeight);
    }
  }

  void resetForm({required BuildContext context, bool tagNumberReset = true}) {
    if (tagNumberReset) {
      tagNumberController.clear();
    }
    rateController.clear();
    piecesController.clear();
    grossWeightController.clear();
    reduceWeightController.clear();
    netWeightController.clear();
    wastagePercentController.clear();
    flatWastageController.clear();
    makingChargePerGramController.clear();
    flatMakingChargeController.clear();
    stoneAmountController.clear();
    diamondAmountController.clear();
    huidAmountController.clear();
    totalAmountController.clear();
    gstAmountController.clear();
    payableAmountController.clear();
    selectedItem.value = null;
    selectedSubItem.value = null;
    selectedcalculationType.value = null;
    selectedflatwasatgeType.value = null;
    selectedmakingchargecalculationType.value = null;
    selectedwasatgecalculationType.value = null;
    selectedpergramweightType.value = null;
    gstPercentController.clear();
    itemController.clear();
    calculationType("");
    stockType("");
    itemFormMode("add");
    editItemId("");
    selectedPurity.value = null;

    minMetalRate(0.0);
    minWastagePercent(0.0);
    minFlatWastage(0.0);
    minMakingChargePerGram(0.0);
    minFlatMakingCharge(0.0);

    remainingPieces(0);
    remainingGrossWeight(0.0);
    remainingNetWeight(0.0);
  }

  void calculationEstimation() {
    double totalAmount = 0.0;
    double gstAmount = 0.0;

    for (var i in _mannualEstimationController.particulars.value) {
      totalAmount += i.totalAmount!;
      gstAmount += i.gstAmount!;
    }

    _mannualEstimationController
        .totalAmount(double.parse(totalAmount.toStringAsFixed(2)));
    _mannualEstimationController
        .gstAmount(double.parse(gstAmount.toStringAsFixed(2)));

    _mannualEstimationController.calculateBilling();
  }

  void calculationItemValues() {
    double rate =
        double.parse(rateController.text.isEmpty ? "0" : rateController.text);
    double pieces = double.parse(
        piecesController.text.isEmpty ? "0" : piecesController.text);
    double grossWeight = double.parse(
        grossWeightController.text.isEmpty ? "0" : grossWeightController.text);
    double reduceWeight = double.parse(reduceWeightController.text.isEmpty
        ? "0"
        : reduceWeightController.text);
    double netWeight = grossWeight -
        (reduceWeight + reduceStoneWeight.value + reduceDiamondWeight.value);
    double stoneAmount = double.parse(
        stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text);
    double diamondAmount = double.parse(diamondAmountController.text.isEmpty
        ? "0"
        : diamondAmountController.text);
    double huidAmount = double.parse(
        huidAmountController.text.isEmpty ? "0" : huidAmountController.text);

    double totalValue = 0.0;
    double gstValue = 0.0;
    double payableValue = 0.0;

    if (selectedcalculationType.value?.value == fixedRateCalcType) {
      totalValue = rate + stoneAmount + diamondAmount + huidAmount;

      gstValue = totalValue *
          (double.parse(gstPercentController.text.isEmpty
                  ? "0"
                  : gstPercentController.text) /
              100);

      payableValue = totalValue + gstValue;
    } else if (selectedcalculationType.value?.value == perPieceRateCalcType) {
      double totalRate = rate * pieces;

      totalValue = totalRate + stoneAmount + diamondAmount + huidAmount;

      gstValue = totalValue *
          (double.parse(gstPercentController.text.isEmpty
                  ? "0"
                  : gstPercentController.text) /
              100);

      payableValue = totalValue + gstValue;
    } else if (selectedcalculationType.value?.value == perGramRateCalcType) {
      double weight = selectedpergramweightType.value?.value == grossWeightType
          ? grossWeight
          : netWeight;

      double totalRate = rate * weight;

      totalValue = totalRate + stoneAmount + diamondAmount + huidAmount;

      gstValue = totalValue *
          (double.parse(gstPercentController.text.isEmpty
                  ? "0"
                  : gstPercentController.text) /
              100);

      payableValue = totalValue + gstValue;
    } else if (selectedcalculationType.value?.value == weightCalcType) {
      double wastageWeight =
          selectedwasatgecalculationType.value?.value == grossWeightType
              ? grossWeight
              : netWeight;
      String flatWasType = flatWastageType.value;
      double mcWeight =
          selectedmakingchargecalculationType.value?.value == grossWeightType
              ? grossWeight
              : netWeight;

      double wasPercentValue = double.parse(
          wastagePercentController.text.isEmpty
              ? "0"
              : wastagePercentController.text);
      double flatWastageValue = double.parse(flatWastageController.text.isEmpty
          ? "0"
          : flatWastageController.text);
      double mcPerGramValue = double.parse(
          makingChargePerGramController.text.isEmpty
              ? "0"
              : makingChargePerGramController.text);
      double flatMcValue = double.parse(flatMakingChargeController.text.isEmpty
          ? "0"
          : flatMakingChargeController.text);

      double wasGramValue = (wasPercentValue / 100) * wastageWeight;

      double makingCharge = (mcPerGramValue * mcWeight) + flatMcValue;

      double totalWastageAmt = 0.0;

      if (selectedflatwasatgeType.value?.value == 'gram') {
        double wasGramAmt = wasGramValue * rate;
        double flatWasAmt = flatWastageValue * rate;
        totalWastageAmt = wasGramAmt + flatWasAmt;
      } else {
        double wasGramAmt = wasGramValue * rate;
        totalWastageAmt = wasGramAmt + flatWastageValue;
      }

      double netWeightPrice = netWeight * rate;

      // log ("netWeightPrice$netWeightPrice");
      // log ("totalWastageAmt$totalWastageAmt");
      // log ("makingCharge$makingCharge");
      // log ("stoneAmount$stoneAmount");
      // log ("diamondAmount$diamondAmount");
      // log ("huidAmount$huidAmount");

      totalValue = netWeightPrice +
          totalWastageAmt +
          makingCharge +
          stoneAmount +
          diamondAmount +
          huidAmount;

      gstValue = totalValue *
          (double.parse(gstPercentController.text.isEmpty
                  ? "0"
                  : gstPercentController.text) /
              100);

      payableValue = totalValue + gstValue;
    }

    netWeightController.text = netWeight.toStringAsFixed(3);

    totalAmountController.text = totalValue.toStringAsFixed(2);
    gstAmountController.text = gstValue.toStringAsFixed(2);
    payableAmountController.text = payableValue.toStringAsFixed(2);

    calculationEstimation();
  }

  void reverseCalculation(BuildContext context) {
    double payable = double.parse(payableAmountController.text.isEmpty
        ? "0"
        : payableAmountController.text);

    double rate =
        double.parse(rateController.text.isEmpty ? "0" : rateController.text);
    double pieces = double.parse(
        piecesController.text.isEmpty ? "0" : piecesController.text);
    double grossWeight = double.parse(
        grossWeightController.text.isEmpty ? "0" : grossWeightController.text);
    double reduceWeight = double.parse(reduceWeightController.text.isEmpty
        ? "0"
        : reduceWeightController.text);
    double netWeight = grossWeight -
        (reduceWeight + reduceStoneWeight.value + reduceDiamondWeight.value);
    double stoneAmount = double.parse(
        stoneAmountController.text.isEmpty ? "0" : stoneAmountController.text);
    double diamondAmount = double.parse(diamondAmountController.text.isEmpty
        ? "0"
        : diamondAmountController.text);
    double huidAmount = double.parse(
        huidAmountController.text.isEmpty ? "0" : huidAmountController.text);

    double wihtoutGstAmount = 0.0;
    if (_mannualEstimationController.selectedGstType.value != null) {
      wihtoutGstAmount = (payable * 100) / (100 + 3);
    } else {
      wihtoutGstAmount = payable;
    }

    if (calculationType.value == fixedRateCalcType) {
      // double wihtoutGstAmount = (payable * 100) / (100+3);
      double wihtoutOtherAmount =
          wihtoutGstAmount - (huidAmount + stoneAmount + diamondAmount);

      totalAmountController.text = wihtoutGstAmount.toStringAsFixed(2);
      gstAmountController.text =
          (payable - wihtoutGstAmount).toStringAsFixed(2);
      rateController.text = wihtoutOtherAmount.toStringAsFixed(2);
    } else if (calculationType.value == perPieceRateCalcType) {
      // double wihtoutGstAmount = (payable * 100) / (100+3);
      double wihtoutOtherAmount =
          wihtoutGstAmount - (huidAmount + stoneAmount + diamondAmount);

      totalAmountController.text = wihtoutGstAmount.toStringAsFixed(2);
      gstAmountController.text =
          (payable - wihtoutGstAmount).toStringAsFixed(2);
      rateController.text = (wihtoutOtherAmount / pieces).toStringAsFixed(2);
    } else if (calculationType.value == perGramRateCalcType) {
      double weight =
          perGramWeightType.value == grossWeightType ? grossWeight : netWeight;

      // double wihtoutGstAmount = (payable * 100) / (100+3);
      double wihtoutOtherAmount =
          wihtoutGstAmount - (huidAmount + stoneAmount + diamondAmount);

      totalAmountController.text = wihtoutGstAmount.toStringAsFixed(2);
      gstAmountController.text =
          (payable - wihtoutGstAmount).toStringAsFixed(2);
      rateController.text = (wihtoutOtherAmount / weight).toStringAsFixed(2);
    } else if (calculationType.value == weightCalcType) {
      double wastageWeight =
          wastageWeightType.value == grossWeightType ? grossWeight : netWeight;
      String flatWasType = flatWastageType.value;
      double mcWeight =
          makingChargeType.value == grossWeightType ? grossWeight : netWeight;

      double flatWastageValue = double.parse(flatWastageController.text.isEmpty
          ? "0"
          : flatWastageController.text);
      double mcPerGramValue = double.parse(
          makingChargePerGramController.text.isEmpty
              ? "0"
              : makingChargePerGramController.text);
      double flatMcValue = double.parse(flatMakingChargeController.text.isEmpty
          ? "0"
          : flatMakingChargeController.text);

      double makingCharge = (mcPerGramValue * mcWeight) + flatMcValue;

      // double wihtoutGstAmount = (payable * 100) / (100+3);
      double wihtoutOtherAmount = wihtoutGstAmount -
          (huidAmount + stoneAmount + diamondAmount + makingCharge);

      if (flatWasType == 'gram') {
        double withoutFMC = wihtoutOtherAmount - (flatWastageValue * rate);
        double actualRate = netWeight * rate;

        double wastageWeightValue = withoutFMC - actualRate;

        double wastage = (wastageWeightValue * 100) / (wastageWeight * rate);

        totalAmountController.text = wihtoutGstAmount.toStringAsFixed(2);
        gstAmountController.text =
            (payable - wihtoutGstAmount).toStringAsFixed(2);
        wastagePercentController.text = wastage.toStringAsFixed(2);
      } else {
        double withoutFMC = wihtoutOtherAmount - flatWastageValue;
        double actualRate = netWeight * rate;

        double wastageWeightValue = withoutFMC - actualRate;

        double wastage = (wastageWeightValue * 100) / (wastageWeight * rate);

        totalAmountController.text = wihtoutGstAmount.toStringAsFixed(2);
        gstAmountController.text =
            (payable - wihtoutGstAmount).toStringAsFixed(2);
        wastagePercentController.text = wastage.toStringAsFixed(2);
      }
    }
  }
}
