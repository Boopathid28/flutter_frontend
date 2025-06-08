import 'dart:developer';

import 'package:ausales_application/controller/order/image_upload_controller.dart';
import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OrderItemFormController extends GetxController {
  final OrderFormController _orderFormController =
      Get.put(OrderFormController());

        final ImageUploadController _imageUploadController =
      Get.put(ImageUploadController());

  final orderitemDetailsFormKey = GlobalKey<FormState>();

  TextEditingController puritySearchController = TextEditingController();
  TextEditingController itemSearchController = TextEditingController();
  TextEditingController subitemSearchController = TextEditingController();
  TextEditingController designerChargeController = TextEditingController();

  TextEditingController grossWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController measurementvalueController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController diamondAmountController = TextEditingController();
  TextEditingController stoneAmountController = TextEditingController();
  TextEditingController wastagePercentController = TextEditingController();
  TextEditingController makingChargePerGramController = TextEditingController();
  TextEditingController metalRateController = TextEditingController();
  TextEditingController huidAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController payableAmountController = TextEditingController();

  Rx<DropdownModel?> selectedpurity = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selecteditem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPriority = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedGendor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMeasurementtype = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubitem = Rx<DropdownModel?>(null);

  RxList<DropdownModel> subitemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> purityDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> priorityDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> genderDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> measurementtypeDropDown = <DropdownModel>[].obs;

  RxList<MetalDropdownModel> metalList = <MetalDropdownModel>[].obs;
  RxList<ItemDropdownModel> itemList = <ItemDropdownModel>[].obs;
  RxList<SubItemDropdownModel> subitemList = <SubItemDropdownModel>[].obs;

  RxString orderitemdetailsFormMode = "create".obs;
  RxString orderitemdetailFormUpdateId = "".obs;

  RxString wastageWeightType = "".obs;
  RxString makingChargeType = "".obs;
  RxDouble gstPercent = 0.0.obs;

  RxList<StoneDetails> stonedetailsParticulars = <StoneDetails>[].obs;
  RxList<DiamondDetails> diamonddetailsParticulars = <DiamondDetails>[].obs;

  RxInt totalStonePieces = 0.obs;
  RxDouble totalStoneWeight = 0.0.obs;
  RxDouble reduceStoneWeight = 0.0.obs;
  RxInt totalDiamondPieces = 0.obs;
  RxDouble totalDiamondWeight = 0.0.obs;
  RxDouble reduceDiamondWeight = 0.0.obs;

  RxDouble wasWeight = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getPurityList();
    getPriorityList();
    getGenderList();
    getMeasurementtypeList();
  }

  Future getPriorityList() async {
    priorityDropDown([]);
    final List<PriorityDropDown> tempList =
        await DropdownService.priorityDropDown();
    tempList.forEach((item) {
      priorityDropDown.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future getGenderList() async {
    genderDropDown([]);
    final List<GenderDropDownModel> tempList =
        await DropdownService.genderDropDown();
    tempList.forEach((item) {
      genderDropDown.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future getMeasurementtypeList() async {
    measurementtypeDropDown([]);
    final List<MeasurementTypeDropdownModel> tempList =
        await DropdownService.measurementTypeDropDown();
    tempList.forEach((item) {
      measurementtypeDropDown.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
  }

  Future getPurityList() async {
    purityDropDown([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    tempList.forEach((item) {
      
      purityDropDown.add(DropdownModel(
          value: item.id.toString(),
          label: "${item.purityName.toString()}(${item.metalMetalName})"));
    });
  }

  Future getItemList(String? PurityId) async {
    itemDropDown([]);
    subitemDropDown([]);
    selecteditem.value = null;
    selectedSubitem.value = null ;
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown(purity: PurityId);
    tempList.forEach((item) {
      itemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.itemName.toString()));
    });
    itemList(tempList);
  }

   Future getSubItemList(String? itemId) async {
    subitemDropDown([]);
    selectedSubitem.value = null;
    final List<SubItemDropdownModel> tempList =
        await DropdownService.subItemDropDown(item: itemId);
    tempList.forEach((item) {
      subitemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.subItemName.toString()));
    });
  }

  void onItemChange(DropdownModel value) {
    for (var i in itemList.value) {
      if (i.id.toString() == value.value.toString()) {
        if (_orderFormController.selectedGstType.value!.value == interGstType.toString()) {
          gstPercent(i.interGst);
        } else {
          gstPercent(i.intraGst);
        }
        selecteditem(value);
        metalRateController.text = i.metalRate.toString();
        break;
      }
    }
    calculateItemValue();
  }

  void ongrossweightchange ({required String grossweight}) {
    final double netWeight = double.parse(grossweight.isEmpty ? "0.0" : grossweight);

    netWeightController.text = netWeight.toString() ;
    calculateItemValue();
  }

  calculateItemValue() {
    double grossWgt = double.parse(grossWeightController.text.isNotEmpty ? grossWeightController.text : "0.0");
    double netWgt = double.parse(grossWeightController.text.isNotEmpty ? grossWeightController.text : "0.0") - (reduceDiamondWeight.value + reduceStoneWeight.value);
    double metalRate = double.parse(metalRateController.text.isNotEmpty ? metalRateController.text : "0.0");
    double wastagePercent = double.parse(wastagePercentController.text.isNotEmpty ? wastagePercentController.text : "0.0");
    double flatWastage = 0;
    double makingChargePerGram = double.parse(makingChargePerGramController.text.isNotEmpty ? makingChargePerGramController.text : "0.0");
    double flatMakingCharge = 0;
    double stoneAmount = double.parse(stoneAmountController.text.isNotEmpty ? stoneAmountController.text : "0.0");
    double diamondAmount = double.parse(diamondAmountController.text.isNotEmpty ? diamondAmountController.text : "0.0");
    double huidAmount = double.parse(huidAmountController.text.isNotEmpty ? huidAmountController.text : "0.0");
double designerCharge = double.parse(designerChargeController.text.isNotEmpty ? designerChargeController.text : "0.0");
    double wastageWeight = wastageWeightType.value == grossWeightType.toString() ? grossWgt : netWgt;
    double makingChargeWeight = wastageWeightType.value == grossWeightType.toString() ? grossWgt : netWgt;

    double metalValue = metalRate * netWgt;

    double totalWastageWeight = ((wastagePercent / 100) * wastageWeight);
    double wastageValue = (totalWastageWeight * metalRate) + flatWastage;

    wasWeight(totalWastageWeight);

    double makingChargeValue = (makingChargeWeight * makingChargePerGram) + flatMakingCharge;

    double totalValue = metalValue + wastageValue + makingChargeValue + stoneAmount + diamondAmount + huidAmount + designerCharge;
    double gstValue = totalValue * (gstPercent / 100);
    double payableValue = totalValue + gstValue;

    totalAmountController.text = totalValue.toStringAsFixed(2);
    gstAmountController.text = gstValue.toStringAsFixed(2);
    payableAmountController.text = payableValue.toStringAsFixed(2);
    netWeightController.text = netWgt.toStringAsFixed(2);
  }

  Future submitOrderItemdetailsForm(BuildContext context) async {
    if (orderitemDetailsFormKey.currentState!.validate()) {
      if (orderitemdetailsFormMode.value == 'create') {
        var uuid = Uuid();
        final OrderItemDetails orderItemDetails = OrderItemDetails(
          sNo: uuid.v4(),
          purityDetails: selectedpurity.value!.value,
          putrityDetailsName: selectedpurity.value!.label,
          itemDetails: selecteditem.value!.value,
          itemDetailsName: selecteditem.value!.label,
          subItemDetails: selectedSubitem.value!.value,
          subItemDetailsName: selectedSubitem.value!.label,
          grossWeight: grossWeightController.text,
          netWeight: netWeightController.text,
          pieces: int.parse(piecesController.text),
          metalRate: double.parse(metalRateController.text.isEmpty ? "0.0" : metalRateController.text),
          wastagePercent: wastagePercentController.text,
          wastageWeightReduced: wasWeight.value,
          makingCharge: makingChargePerGramController.text,
          priority: selectedPriority.value!.value,
          priorityName: selectedPriority.value!.label,
          gender: selectedGendor.value!.value,
          genderName: selectedGendor.value!.label,
          designCharges: double.parse(designerChargeController.text.isEmpty ? "0.0" : designerChargeController.text),
          measurementType: selectedMeasurementtype.value!.value,
          measurementTypeName: selectedMeasurementtype.value!.label,
          measurementValue: measurementvalueController.text,
          remarks: remarkController.text,
          totalDiamondPieces: totalDiamondPieces.value.toString(),
          totalStonePieces: totalStonePieces.value.toString(),
          totalDiamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
          totalStoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
          orderImages: _imageUploadController.imageId,
          orderUploadImages: _imageUploadController.orderUploadImage.value,
          huidAmount: double.parse(huidAmountController.text.isEmpty ? "0.0" : huidAmountController.text),
          totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
          gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
          stoneDetails: stonedetailsParticulars.value,
          diamondDetails: diamonddetailsParticulars.value,
          payableAmount: double.parse(payableAmountController.text.isEmpty ? "0.0" : payableAmountController.text),
        );

        _orderFormController.orderitemdetailsParticularList
            .insert(0, orderItemDetails);

            for(var i in stonedetailsParticulars){
log(i.stoneName.toString());
            }
      } else {
        int index = _orderFormController.orderitemdetailsParticularList
            .indexWhere(
                (item) => item.sNo == orderitemdetailFormUpdateId.value);
        final OrderItemDetails orderItemDetails = OrderItemDetails(
          sNo: orderitemdetailFormUpdateId.value,
          purityDetails: selectedpurity.value!.value,
          putrityDetailsName: selectedpurity.value!.label,
          itemDetails: selecteditem.value!.value,
          itemDetailsName: selecteditem.value!.label,
          subItemDetails: selectedSubitem.value!.value,
          subItemDetailsName: selectedSubitem.value!.label,
          grossWeight: grossWeightController.text,
          netWeight: netWeightController.text,
          pieces: int.parse(piecesController.text),
          designCharges: double.parse(designerChargeController.text.isEmpty ? "0.0" : designerChargeController.text),
          metalRate: double.parse(metalRateController.text.isEmpty ? "0.0" : metalRateController.text),
          wastagePercent: wastagePercentController.text,
          wastageWeightReduced: wasWeight.value,
          makingCharge: makingChargePerGramController.text,
          priority: selectedPriority.value!.value,
          priorityName: selectedPriority.value!.label,
          gender: selectedGendor.value!.value,
          genderName: selectedGendor.value!.label,
          measurementType: selectedMeasurementtype.value!.value,
          measurementTypeName: selectedMeasurementtype.value!.label,
          measurementValue: measurementvalueController.text,
          remarks: remarkController.text,
          totalDiamondPieces: totalDiamondPieces.value.toString(),
          totalStonePieces: totalStonePieces.value.toString(),
          totalDiamondAmount: double.parse(diamondAmountController.text.isEmpty ? "0.0" : diamondAmountController.text),
          totalStoneAmount: double.parse(stoneAmountController.text.isEmpty ? "0.0" : stoneAmountController.text),
          orderImages: _imageUploadController.imageId,
          stoneDetails: stonedetailsParticulars,
          diamondDetails: diamonddetailsParticulars,
          orderUploadImages: _imageUploadController.orderUploadImage.value,
          huidAmount: double.parse(huidAmountController.text.isEmpty ? "0.0" : huidAmountController.text),
          totalAmount: double.parse(totalAmountController.text.isEmpty ? "0.0" : totalAmountController.text),
          gstAmount: double.parse(gstAmountController.text.isEmpty ? "0.0" : gstAmountController.text),
          payableAmount: double.parse(payableAmountController.text.isEmpty ? "0.0" : payableAmountController.text),
        );
        _orderFormController.orderitemdetailsParticularList[index] =
            orderItemDetails;
      }
        resetOrderItemForm(context);
      _orderFormController.calculateOrderItemParticularsPayment();
    }
  }

  void editItem(BuildContext context, OrderItemDetails item) {
    grossWeightController.text = item.grossWeight!.toString();
    netWeightController.text = item.netWeight!.toString();
    piecesController.text = item.pieces!.toString();
    metalRateController.text = item.metalRate!.toStringAsFixed(2);
    wastagePercentController.text = item.wastagePercent??"0";
    wasWeight(item.wastageWeightReduced);
    makingChargePerGramController.text = item.makingCharge??"0";
    huidAmountController.text = item.huidAmount!.toStringAsFixed(2);
    totalAmountController.text = item.totalAmount!.toStringAsFixed(2);
    gstAmountController.text = item.gstAmount!.toStringAsFixed(2);
    payableAmountController.text = item.payableAmount!.toStringAsFixed(2);
    designerChargeController.text = item.designCharges!.toStringAsFixed(2);
    selectedpurity(DropdownModel(
        value: item.purityDetails.toString(),
        label: item.putrityDetailsName.toString()));
    selecteditem(DropdownModel(
        value: item.itemDetails.toString(), label: item.itemDetailsName.toString()));
    selectedSubitem(DropdownModel(
        value: item.subItemDetails.toString(),
        label: item.subItemDetailsName.toString()));
    selectedPriority(DropdownModel(
        value: item.priority.toString(), label: item.priorityName.toString()));
    selectedMeasurementtype(DropdownModel(
        value: item.measurementType.toString(),
        label: item.measurementTypeName.toString()));
    selectedGendor(DropdownModel(
        value: item.gender.toString(), label: item.genderName.toString()));
    totalDiamondPieces(int.parse(item.totalDiamondPieces??"0"));
    totalStonePieces(int.parse(item.totalStonePieces??"0"));
    measurementvalueController.text = item.measurementValue.toString();
    remarkController.text = item.remarks!;

    stoneAmountController.text = item.totalStoneAmount!.toStringAsFixed(2);
    diamondAmountController.text = item.totalDiamondAmount!.toStringAsFixed(2);

    orderitemdetailsFormMode('update');
    orderitemdetailFormUpdateId(item.sNo);

    for(var i in item.stoneDetails!){
        stonedetailsParticulars.add(i);
    }

    for(var i in item.diamondDetails!){
        diamonddetailsParticulars.add(i);
    }

     for (var i in item.orderUploadImages!) {
      _imageUploadController.imageurl.add(i.orderItemImage);
    }
  }

  void deleteItem(BuildContext context, String index) {
    _orderFormController.orderitemdetailsParticularList
        .removeWhere((item) => item.sNo == index);
    Get.back();
  }

  void resetOrderItemForm(BuildContext context) {
    selectedMeasurementtype.value = null;
    selectedpurity.value = null;
    selecteditem.value = null;
    selectedSubitem.value = null;
    selectedPriority.value = null;
    designerChargeController.clear();
    selectedGendor.value = null;
    metalRateController.clear();
    wastagePercentController.clear();
    wasWeight(0.0);
    makingChargePerGramController.clear();
    grossWeightController.clear();
    netWeightController.clear();
    piecesController.clear();
    measurementvalueController.clear();
    remarkController.clear();
    stoneAmountController.clear();
    diamondAmountController.clear();
    totalAmountController.clear();
    gstAmountController.clear();
    payableAmountController.clear();
    huidAmountController.clear();
    totalDiamondWeight(0.0);
    totalStoneWeight(0.0);
    reduceDiamondWeight(0.0);
    reduceStoneWeight(0.0);
    orderitemdetailsFormMode('create');
    orderitemdetailFormUpdateId("");
    _imageUploadController.orderUploadImage([]);
    stonedetailsParticulars([]);
    diamonddetailsParticulars([]);
  }
}
