import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/model/manual_invoice/manual_invoice_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/invoice/invoice_service.dart';
import 'package:ausales_application/service/manual_invoice/manual_invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class ManualInvoiceItemController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ManualInvoiceController _manualInvoiceController =
      Get.put(ManualInvoiceController());

  final manualinvoiceItemFormKey = GlobalKey<FormState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController tagNumberController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController subItemController = TextEditingController();
  TextEditingController wastagePercentController = TextEditingController();
  TextEditingController flatWastageController = TextEditingController();
  TextEditingController makingChargePerGramController = TextEditingController();
  TextEditingController flatMakingChargeController = TextEditingController();
  TextEditingController stoneAmountController = TextEditingController();
  TextEditingController diamondAmountController = TextEditingController();
  TextEditingController huidAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController payableAmountController = TextEditingController();

  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);

  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subItemDropDown = <DropdownModel>[].obs;

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
  RxBool retrieveOrderNumberLoading = false.obs;

  RxList<ManualTagDetailStoneDetails> stoneParticularList =
      <ManualTagDetailStoneDetails>[].obs;
  RxList<ManualTagDetailDiamondDetails> diamondParticularList =
      <ManualTagDetailDiamondDetails>[].obs;

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

  @override
  void onInit() async {
    super.onInit();
    bool value = await getIsBranchUser();
    getItemList();
  }

  Future getItemList() async {
    itemDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    tempList.forEach((item) {
      itemDropDown
          .add(DropdownModel(label: item.itemName!, value: item.id.toString()));
    });
  }

  Future getSubItemList(String? Item) async {
    subItemDropDown([]);
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: Item);
    tempList.forEach((item) {
      subItemDropDown.add(
          DropdownModel(label: item.subItemName!, value: item.id.toString()));
    });
  }

  Future getManualTagDetails(BuildContext context, String tagNumber) async {
    retrieveTagNumberLoading(true);
    var resData = await ManualInvoiceService.getManualTagItemdetails(
        context: context,
        tagnumber: tagNumber,
        metal: _manualInvoiceController.selectedMetal.value?.value);

    if (resData != null) {
      ManualTagDetailsRetrieveData data =
          ManualTagDetailsRetrieveData.fromJson(resData['data']);
      calculationType(data.calculationType);

      stockType(data.stockType);
      if (data.calculationType == fixedRateCalcType) {
        minMetalRate(data.minFixedRate);
        remainingGrossWeight(data.availableGrossWeight);
        remainingPieces(data.availablePieces);
        remainingNetWeight(data.availableNetWeight);
        subItemController.text = data.subItemDetailsName.toString();
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

        if (_manualInvoiceController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_manualInvoiceController.selectedGstType.value?.value ==
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
        subItemController.text = data.subItemDetailsName.toString();
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

        if (_manualInvoiceController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_manualInvoiceController.selectedGstType.value?.value ==
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
        subItemController.text = data.subItemDetailsName.toString();
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

        if (_manualInvoiceController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_manualInvoiceController.selectedGstType.value?.value ==
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
        subItemController.text = data.subItemDetailsName.toString();
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

        if (_manualInvoiceController.selectedGstType.value?.value ==
            interGstType) {
          gstAmountController.text = data.interGstValue!.toStringAsFixed(2);
          payableAmountController.text =
              data.interSaleValue!.toStringAsFixed(2);
          gstPercent(data.interGstPercent);
        } else if (_manualInvoiceController.selectedGstType.value?.value ==
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

  void addManualParticularItem(BuildContext context) {
    if (manualinvoiceItemFormKey.currentState!.validate()) {
      if (itemFormMode.value == 'add') {
        String isValidTag = _manualInvoiceController.particulars
            .indexWhere((i) => i.tag == tagNumberController.text)
            .toString();
        if (isValidTag == '-1') {
          var uuid = Uuid();
          String id = uuid.v4();
          final ManualParticularDetails item = ManualParticularDetails(
              sNo: id,
              tag: tagNumberController.text,
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
                  itemId: selectedItem.value?.value,
                  itemName: selectedItem.value?.label,
                   subItemId: selectedSubItem.value?.value,
                  subItemName: selectedSubItem.value?.label,
              remainingGrossWeight: remainingGrossWeight.value,
              remainingPieces: remainingPieces.value,
              remainingNetWeight: remainingNetWeight.value,
              wastagePercent: double.parse(wastagePercentController.text.isEmpty
                  ? "0"
                  : wastagePercentController.text),
              flatWastage: double.parse(flatWastageController.text.isEmpty
                  ? "0"
                  : flatWastageController.text),
              makingChargePerGram: double.parse(
                  makingChargePerGramController.text.isEmpty
                      ? "0"
                      : makingChargePerGramController.text),
              flatMakingCharge: double.parse(
                  flatMakingChargeController.text.isEmpty
                      ? "0"
                      : flatMakingChargeController.text),
              stoneAmount: double.parse(stoneAmountController.text.isEmpty
                  ? "0"
                  : stoneAmountController.text),
              diamondAmount: double.parse(
                  diamondAmountController.text.isEmpty ? "0" : diamondAmountController.text),
              huidAmount: double.parse(huidAmountController.text.isEmpty ? "0" : huidAmountController.text),
              totalAmount: double.parse(totalAmountController.text.isEmpty ? "0" : totalAmountController.text),
              gstAmount: double.parse(gstAmountController.text.isEmpty ? "0" : gstAmountController.text),
              payableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
              actualPayableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
              calculationType: calculationType.value,
              gstPercent: gstPercent.value,
              minRate: minMetalRate.value,
              minWastagePercent: minWastagePercent.value,
              minFlatWastage: minFlatWastage.value,
              minMakingChargePerGram: minMakingChargePerGram.value,
              minFlatMakingCharge: minFlatMakingCharge.value,
              stoneDetails: stoneParticularList.value,
              diamondDetails: diamondParticularList.value,
              stockType: stockType.value,
              flatWastageType: flatWastageType.value,
              wastageWeightType: wastageWeightType.value,
              makingChargeType: makingChargeType.value);

          _manualInvoiceController.particulars.insert(0, item);
          resetManualForm(context: context);
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
        int? index = _manualInvoiceController.particulars
            .indexWhere((i) => i.sNo == editItemId.value);
        final ManualParticularDetails item = ManualParticularDetails(
            sNo: editItemId.value,
            tag: tagNumberController.text,
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
                  itemId: selectedItem.value?.value,
                  itemName: selectedItem.value?.label,
                   subItemId: selectedSubItem.value?.value,
                  subItemName: selectedSubItem.value?.label,
            remainingGrossWeight: remainingGrossWeight.value,
            remainingPieces: remainingPieces.value,
            remainingNetWeight: remainingNetWeight.value,
            wastagePercent: double.parse(wastagePercentController.text.isEmpty
                ? "0"
                : wastagePercentController.text),
            flatWastage: double.parse(flatWastageController.text.isEmpty
                ? "0"
                : flatWastageController.text),
            makingChargePerGram: double.parse(
                makingChargePerGramController.text.isEmpty
                    ? "0"
                    : makingChargePerGramController.text),
            flatMakingCharge: double.parse(flatMakingChargeController.text.isEmpty
                ? "0"
                : flatMakingChargeController.text),
            stoneAmount: double.parse(stoneAmountController.text.isEmpty
                ? "0"
                : stoneAmountController.text),
            diamondAmount: double.parse(diamondAmountController.text.isEmpty
                ? "0"
                : diamondAmountController.text),
            huidAmount: double.parse(huidAmountController.text.isEmpty ? "0" : huidAmountController.text),
            totalAmount: double.parse(totalAmountController.text.isEmpty ? "0" : totalAmountController.text),
            gstAmount: double.parse(gstAmountController.text.isEmpty ? "0" : gstAmountController.text),
            payableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
            actualPayableAmount: double.parse(payableAmountController.text.isEmpty ? "0" : payableAmountController.text),
            calculationType: calculationType.value,
            gstPercent: gstPercent.value,
            minRate: minMetalRate.value,
            minWastagePercent: minWastagePercent.value,
            minFlatWastage: minFlatWastage.value,
            minMakingChargePerGram: minMakingChargePerGram.value,
            minFlatMakingCharge: minFlatMakingCharge.value,
            stoneDetails: stoneParticularList.value,
            diamondDetails: diamondParticularList.value,
            stockType: stockType.value,
            flatWastageType: flatWastageType.value,
            wastageWeightType: wastageWeightType.value,
            makingChargeType: makingChargeType.value);
        _manualInvoiceController.particulars[index] = item;
        resetManualForm(context: context);
      }

      calculationManualBilling();
    }
  }

  void deleteManualParticularItem(
      BuildContext context, ManualParticularDetails item) {
    _manualInvoiceController.particulars.removeWhere((i) => i.sNo == item.sNo);
    calculationManualBilling();
  }

  void editManualParticularItem(BuildContext context, ManualParticularDetails item) {
    itemFormMode('update');
    editItemId(item.sNo);
    calculationType(item.calculationType);
    gstPercent(item.gstPercent);

    remainingGrossWeight(item.remainingGrossWeight);
    remainingNetWeight(item.remainingNetWeight);
    remainingPieces(item.remainingPieces);
    selectedItem(DropdownModel(value: item.itemId.toString(), label: item.itemName.toString()));
    selectedSubItem(DropdownModel(value: item.subItemId.toString(), label: item.subItemName.toString()));

    tagNumberController.text = item.tag!;
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

  void resetManualForm(
      {required BuildContext context, bool tagNumberReset = true}) {
    if (tagNumberReset) {
      tagNumberController.clear();
    }
    rateController.clear();
    piecesController.clear();
    grossWeightController.clear();
    subItemController.clear();
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
    calculationType("");
    stockType("");
    itemFormMode("add");
    editItemId("");
    selectedSubItem.value = null ;
    selectedItem.value = null ;

    minMetalRate(0.0);
    minWastagePercent(0.0);
    minFlatWastage(0.0);
    minMakingChargePerGram(0.0);
    minFlatMakingCharge(0.0);

    remainingPieces(0);
    remainingGrossWeight(0.0);
    remainingNetWeight(0.0);
  }

  void calculationManualBilling() {
    double totalAmount = 0.0;
    double gstAmount = 0.0;

    for (var i in _manualInvoiceController.particulars.value) {
      totalAmount += i.totalAmount!;
      gstAmount += i.gstAmount!;
    }

    _manualInvoiceController
        .totalAmount(double.parse(totalAmount.toStringAsFixed(2)));
    _manualInvoiceController
        .gstAmount(double.parse(gstAmount.toStringAsFixed(2)));

    _manualInvoiceController.calculateManualBilling();
  }

  void calculationManualItemValues() {
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
 
    if (calculationType.value == fixedRateCalcType) {
      totalValue = rate + stoneAmount + diamondAmount + huidAmount;
 
      gstValue = totalValue * (gstPercent.value / 100);
 
      payableValue = totalValue + gstValue;
    } else if (calculationType.value == perPieceRateCalcType) {
      double totalRate = rate * pieces;
 
      totalValue = totalRate + stoneAmount + diamondAmount + huidAmount;
 
      gstValue = totalValue * (gstPercent.value / 100);
 
      payableValue = totalValue + gstValue;
    } else if (calculationType.value == perGramRateCalcType) {
      double weight =
          perGramWeightType.value == grossWeightType ? grossWeight : netWeight;
 
      double totalRate = rate * weight;
 
      totalValue = totalRate + stoneAmount + diamondAmount + huidAmount;
 
      gstValue = totalValue * (gstPercent.value / 100);
 
      payableValue = totalValue + gstValue;
    } else if (calculationType.value == weightCalcType) {
      double wastageWeight =
          wastageWeightType.value == grossWeightType ? grossWeight : netWeight;
      String flatWasType = flatWastageType.value;
      double mcWeight =
          makingChargeType.value == grossWeightType ? grossWeight : netWeight;
 
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
 
      if (flatWasType == 'gram') {
        double wasGramAmt = wasGramValue * rate;
        double flatWasAmt = flatWastageValue * rate;
        totalWastageAmt = wasGramAmt + flatWasAmt;
      } else {
        double wasGramAmt = wasGramValue * rate;
        totalWastageAmt = wasGramAmt + flatWastageValue;
      }
 
      double netWeightPrice = netWeight * rate;
 
      log ("netWeightPrice$netWeightPrice");
      log ("totalWastageAmt$totalWastageAmt");
      log ("makingCharge$makingCharge");
      log ("stoneAmount$stoneAmount");
      log ("diamondAmount$diamondAmount");
      log ("huidAmount$huidAmount");
 
      totalValue = netWeightPrice +
          totalWastageAmt +
          makingCharge +
          stoneAmount +
          diamondAmount +
          huidAmount;
 
      gstValue = totalValue * (gstPercent.value / 100);
 
      payableValue = totalValue + gstValue;
    }
 
    netWeightController.text = netWeight.toStringAsFixed(3);
 
    totalAmountController.text = totalValue.toStringAsFixed(2);
    gstAmountController.text = gstValue.toStringAsFixed(2);
    payableAmountController.text = payableValue.toStringAsFixed(2);

    calculationManualBilling();
  }

  void reverseManualCalculation(BuildContext context) {
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
    if (_manualInvoiceController.selectedGstType.value != null) {
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

  Future getManualOrderDetails(BuildContext context, String orderNumber) async {
    retrieveOrderNumberLoading(true);
    var resData = await InvoiceService.getOrderdetails(
        context: context, ordernumber: orderNumber);

    if (resData != null) {
      ManualOrderTagDetailsListData data =
          ManualOrderTagDetailsListData.fromJson(resData['data']);

      if (data.itemDetails!.isNotEmpty) {
        _manualInvoiceController.particulars([]);
        _manualInvoiceController.orderId("");
        _manualInvoiceController.selectedMetal.value = null;

        _manualInvoiceController.selectedGstType(DropdownModel(
            value: data.gstType.toString(), label: data.gstType.toString()));
        _manualInvoiceController.customerMobileController.text =
            data.customerMobile.toString();
        _manualInvoiceController.findCustomer(
            _manualInvoiceController.customerMobileController.text, context);
        _manualInvoiceController.orderId(data.orderId);
        _manualInvoiceController.selectedMetal(DropdownModel(
            value: data.metalId.toString(), label: data.metalName.toString()));

        var uuid = Uuid();
        String id = uuid.v4();
        for (var i in data.itemDetails!) {
          final ManualParticularDetails particularDetails =
              ManualParticularDetails(
                  sNo: id,
                  tag: i.tagNumber,
                  rate: i.calculationType == fixedRateCalcType
                      ? i.fixedRate
                      : i.calculationType == perGramRateCalcType
                          ? i.perGramRate
                          : i.calculationType == perPieceRateCalcType
                              ? i.perPieceRate
                              : i.calculationType == weightCalcType
                                  ? i.metalRate
                                  : 0.0,
                  pieces: i.pieces,
                  grossWeight: i.grossWeight,
                  reduceWeight: i.reduceWeight,
                  netWeight: i.netWeight,
                  wastagePercent: i.wastagePercent,
                  flatWastage: i.flatWastage,
                  remainingGrossWeight: i.availableGrossWeight,
                  remainingPieces: i.availablePieces,
                  remainingNetWeight: i.availableNetWeight,
                  makingChargePerGram: i.makingChargePerGram,
                  flatMakingCharge: i.flatMakingCharge,
                  stoneAmount: i.totalStoneAmount,
                  diamondAmount: i.totalDiamondAmount,
                  huidAmount: i.huidRate,
                  totalAmount: i.withoutGstRate,
                  actualPayableAmount: i.intraSaleValue,
                  calculationType: i.calculationType,
                  gstPercent: _manualInvoiceController
                              .selectedGstType.value?.label ==
                          interGstType
                      ? i.interGstPercent
                      : _manualInvoiceController.selectedGstType.value?.label ==
                              intraGstType
                          ? i.intraGstPercent
                          : 0.0,
                  minRate: i.minFixedRate,
                  minWastagePercent: i.minWastagePercent,
                  minFlatWastage: i.minFlatWastage,
                  minMakingChargePerGram: i.minMakingChargePerGram,
                  stoneDetails: i.stoneDetails,
                  diamondDetails: i.diamondDetails,
                  stockType: i.stockType,
                  flatWastageType: i.flatWastageType,
                  wastageWeightType: i.wastageCalculationType,
                  makingChargeType: i.makingChargeCalculationType,
                  gstAmount: _manualInvoiceController
                              .selectedGstType.value?.label ==
                          interGstType
                      ? i.interGstValue
                      : _manualInvoiceController.selectedGstType.value?.label ==
                              intraGstType
                          ? i.intraGstValue
                          : 0.0,
                  payableAmount: _manualInvoiceController
                              .selectedGstType.value?.label ==
                          interGstType
                      ? i.interSaleValue
                      : _manualInvoiceController.selectedGstType.value?.label ==
                              intraGstType
                          ? i.intraSaleValue
                          : 0.0);
          _manualInvoiceController.particulars.add(particularDetails);

          log("particular  ${particularDetails.intergstAmount}");
        }

        _manualInvoiceController.orderController.text =
            data.orderTotalAmount.toString();
        calculationManualBilling();
        _manualInvoiceController.calculateManualBilling();
        _manualInvoiceController.orderNumberController.clear();
      } else {
        toastification.show(
            type: ToastificationType.error,
            title: Text('No Item Details'),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
    retrieveOrderNumberLoading(false);
  }


  Future getsubitemId(String? subItemId, BuildContext context) async {
  final SubItemGetDataListMannualEstimation? data  = await ManualInvoiceService.getSubitemCalculationDetails(subItemId: subItemId.toString(), context: context);
 
 
  if(data != null){
    calculationType(data.calculationType);
    stockType(data.stockType);
    if (data.calculationType == weightCalcType) {
      wastageWeightType(data.wastageCalculationType);
      flatWastageType(data.flatWastageType);
      makingChargeType(data.makingChargeCalculationType);
    } else if (data.calculationType == perGramRateCalcType) {
      perGramWeightType(data.perGramWeightType);
    }
    rateController.text = data.metalRate.toString();
    wastagePercentController.text = data.wastagePercent.toString();
    flatWastageController.text = data.flatWastage.toString();
    makingChargePerGramController.text = data.makingChargePerGram.toString();
    flatMakingChargeController.text = data.flatMakingCharge.toString();
    huidAmountController.text = data.huidRate.toString();
    if (_manualInvoiceController.selectedGstType.value?.value ==
            interGstType) {
          gstPercent(data.interGst);
        } else if (_manualInvoiceController.selectedGstType.value?.value ==
            intraGstType) {
          gstPercent(data.intraGst);
        }
  }
}
}
