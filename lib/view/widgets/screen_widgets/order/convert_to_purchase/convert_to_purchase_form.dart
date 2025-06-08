import 'package:ausales_application/controller/order/order_receive_item_convert/order_receive_item_convert_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConvertToPurchaseForm extends StatefulWidget {
  const ConvertToPurchaseForm({super.key});

  @override
  State<ConvertToPurchaseForm> createState() => _ConvertToPurchaseFormState();
}

class _ConvertToPurchaseFormState extends State<ConvertToPurchaseForm> {
  final OrderReceiveItemConvertFormController _order1receiveItemConvertFormController =
      Get.put(OrderReceiveItemConvertFormController());

 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_order1receiveItemConvertFormController.itemFormMode.value} new purchase'),
          IconButton(
              onPressed: () {
                _order1receiveItemConvertFormController.itemFormMode('create');
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Form(
          key: _order1receiveItemConvertFormController.newPurchaseItemFormDetailsFormKey,
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: size.width * 0.98,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                        Obx(() => _order1receiveItemConvertFormController.isBranchuser.value ? branch() : SizedBox()),
                  vendordetails(),
                  poDate(),
                  gstType()
                    ],
                  ),
                  Wrap(
                    spacing: 20.w,
                    runSpacing: 15.h,
                    children: [
                      itemDetails(),
                      subItemDetails(),
                      pieces(),
                      grossWeight(),
                      reduceWeight(),
                      netWeight(),
                      calculationType(),
                      Obx(() => _order1receiveItemConvertFormController
                                  .selectedCalculationType.value?.value ==
                              fixedRateCalcType
                          ? fixedRate()
                          : _order1receiveItemConvertFormController
                                      .selectedCalculationType.value?.value ==
                                  weightCalcType
                              ? Wrap(
                                  spacing: 20.w,
                                  runSpacing: 15.h,
                                  children: [
                                    wastageCalculationType(),
                                    wastagePercentage(),
                                    flatWastageCalculationType(),
                                    flatWastageValue(),
                                    makingChargeCalculationType(),
                                    makingChargePerGram(),
                                    flatMakingCharge(),
                                    touch(),
                                  ],
                                )
                              : _order1receiveItemConvertFormController
                                          .selectedCalculationType.value?.value ==
                                      perGramRateCalcType
                                  ? Wrap(
                                      spacing: 20.w,
                                      runSpacing: 15.h,
                                      children: [
                                        perGramWeightType(),
                                        perGramRate(),
                                      ],
                                    )
                                  : _order1receiveItemConvertFormController
                                              .selectedCalculationType.value?.value ==
                                          perPieceRateCalcType
                                      ? perPieceRate()
                                      : SizedBox()),
                      stonePieces(),
                      stoneWeight(),
                      reduceStoneWeight(),
                      stoneAmount(),
                      diamondPieces(),
                      diamondWeight(),
                      reduceDiamondWeight(),
                      diamondAmount(),
                      halmarkCharges(),
                      otherCharges(),
                      totalWeight(),
                      gstAmount(),
                      totalAmount()
                    ],
                  ),
                ],
              ),
            ),
          )),
      actions: [actions(context)],
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 115.w,
              child: PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Save",
                  onPressed: () {
                    _order1receiveItemConvertFormController.submitForm(context);
                  })),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _order1receiveItemConvertFormController.resetForm(context);
                  }))
        ],
      ),
    );
  }

  SizedBox totalAmount() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Total Amount",
            readOnly: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox gstAmount() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "GST Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.gstAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "GST Amount",
            readOnly: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox totalWeight() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.totalWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Total Weight",
            readOnly: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox otherCharges() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Other Charges"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.otherChargesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Other Charges",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox halmarkCharges() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Halmark Charges"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.hallmarkChargesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Halmark Charges",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox diamondAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond Amount"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.diamondAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Diamond Amount",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox reduceDiamondWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Reduce Diamond Weight"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController
                    .selectedDiamondReduceWeight.value,
                options:
                    _order1receiveItemConvertFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController
                      .selectedDiamondReduceWeight(value);
                  _order1receiveItemConvertFormController.calculation(
                      grossWeight: _order1receiveItemConvertFormController
                          .grossWeightController.text,
                      reduceWeight: _order1receiveItemConvertFormController
                          .reduceWeightController.text,
                      stoneWeight: _order1receiveItemConvertFormController
                          .stoneWeightController.text,
                      diamondWeight: _order1receiveItemConvertFormController
                          .diamondWeightController.text,
                      stoneReduceWeight: _order1receiveItemConvertFormController
                                  .selectedDiamondReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      diamondReduceWeight: value!.value == "1" ? true : false,
                      calculationType: _order1receiveItemConvertFormController
                          .selectedCalculationType.value,
                      gstType: _order1receiveItemConvertFormController
                          .selectedGstType.value!);
                },
                hintText: "Reduce Diamond Weight",
              ))
        ],
      ),
    );
  }

  SizedBox diamondWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.diamondWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Diamond Weight",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: value,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox diamondPieces() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond Pieces"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _order1receiveItemConvertFormController.diamondPiecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Diamond Pieces",
          ),
        ],
      ),
    );
  }

  SizedBox stoneAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone Amount"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.stoneAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Stone Amount",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox reduceStoneWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Reduce Stone Weight"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController
                    .selectedStoneReduceWeight.value,
                options:
                    _order1receiveItemConvertFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController
                      .selectedStoneReduceWeight(value);
                  _order1receiveItemConvertFormController.calculation(
                      grossWeight: _order1receiveItemConvertFormController
                          .grossWeightController.text,
                      reduceWeight: _order1receiveItemConvertFormController
                          .reduceWeightController.text,
                      stoneWeight: _order1receiveItemConvertFormController
                          .stoneWeightController.text,
                      diamondWeight: _order1receiveItemConvertFormController
                          .diamondWeightController.text,
                      stoneReduceWeight: value!.value == "1" ? true : false,
                      diamondReduceWeight: _order1receiveItemConvertFormController
                                  .selectedDiamondReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      calculationType: _order1receiveItemConvertFormController
                          .selectedCalculationType.value,
                      gstType: _order1receiveItemConvertFormController
                          .selectedGstType.value!);
                },
                hintText: "Reduce Stone Weight",
              ))
        ],
      ),
    );
  }

  SizedBox stoneWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.stoneWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Stone Weight",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight: value,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox stonePieces() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone Pieces"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _order1receiveItemConvertFormController.stonePiecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Stone Pieces",
          ),
        ],
      ),
    );
  }

  SizedBox perPieceRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Per Piece Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.perPieceRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Per Piece Rate",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox perGramRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Per Gram Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.perGramRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Per Gram Rate",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox perGramWeightType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Per Gram Weight Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController
                    .selectedPerGramCalcuationType.value,
                options:
                    _order1receiveItemConvertFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController
                      .selectedPerGramCalcuationType(value);

                  _order1receiveItemConvertFormController.calculation(
                      grossWeight: _order1receiveItemConvertFormController
                          .grossWeightController.text,
                      reduceWeight: _order1receiveItemConvertFormController
                          .reduceWeightController.text,
                      stoneWeight: _order1receiveItemConvertFormController
                          .stoneWeightController.text,
                      diamondWeight: _order1receiveItemConvertFormController
                          .diamondWeightController.text,
                      stoneReduceWeight: _order1receiveItemConvertFormController
                                  .selectedStoneReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      diamondReduceWeight: _order1receiveItemConvertFormController
                                  .selectedDiamondReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      calculationType: _order1receiveItemConvertFormController
                          .selectedCalculationType.value,
                      gstType: _order1receiveItemConvertFormController
                          .selectedGstType.value!);
                },
                hintText: "Per Gram Weight Type",
              ))
        ],
      ),
    );
  }

  SizedBox touch() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Touch"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.touchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Touch",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox flatMakingCharge() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat MC"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _order1receiveItemConvertFormController.flatMakingChargeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Flat MC",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox makingChargePerGram() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "MC/G"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _order1receiveItemConvertFormController.makingChargePerGramController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "MC/G",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox makingChargeCalculationType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "MC Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController
                    .selectedMakingChargeCalcuationType.value,
                options:
                    _order1receiveItemConvertFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController
                      .selectedMakingChargeCalcuationType(value);
                  _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
                },
                hintText: "MC Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox flatWastageValue() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat Wastage"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.flatWastageController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Flat Wastage",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox flatWastageCalculationType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat Wastage Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController
                    .selectedFlatWastageType.value,
                options: _order1receiveItemConvertFormController
                    .flatWastageTypeDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController.selectedFlatWastageType(value);
                  _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
                },
                hintText: "Flat Wastage Type",
                
              ))
        ],
      ),
    );
  }

  SizedBox wastagePercentage() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Wastage Percent"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _order1receiveItemConvertFormController.wastagePercentageController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Wastage %",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox wastageCalculationType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Wastage Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController
                    .selectedWastageCalcuationType.value,
                options:
                    _order1receiveItemConvertFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController
                      .selectedWastageCalcuationType(value);

                  _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
                },
                hintText: "Wastage Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox fixedRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Fixed Rate",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox calculationType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController
                    .selectedCalculationType.value,
                options: _order1receiveItemConvertFormController
                    .calculationTypeDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController.onCalculationTypeChange(value!);
                },
                hintText: "Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox netWeight() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Net Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.netWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Net Weight",
            readOnly: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox reduceWeight() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Reduce Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Reduce Weight",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: value,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox grossWeight() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gross Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _order1receiveItemConvertFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight: value,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox pieces() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pieces"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _order1receiveItemConvertFormController.piecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Pieces",
            onChanged: (value) {
              _order1receiveItemConvertFormController.calculation(
                  grossWeight:
                      _order1receiveItemConvertFormController.grossWeightController.text,
                  reduceWeight: _order1receiveItemConvertFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _order1receiveItemConvertFormController.stoneWeightController.text,
                  diamondWeight: _order1receiveItemConvertFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _order1receiveItemConvertFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _order1receiveItemConvertFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _order1receiveItemConvertFormController
                      .selectedCalculationType.value,
                  gstType:
                      _order1receiveItemConvertFormController.selectedGstType.value!);
            },
          ),
        ],
      ),
    );
  }

  SizedBox subItemDetails() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _order1receiveItemConvertFormController.subItemSearchController,
                selectedValue:
                    _order1receiveItemConvertFormController.selectedSubItem.value,
                options: _order1receiveItemConvertFormController.subItemDropDown.value,
                onChanged: (value) async {
                  _order1receiveItemConvertFormController.selectedSubItem(value);

                  for (var i
                      in _order1receiveItemConvertFormController.subItemList.value) {
                    if (i.id.toString() == value!.value.toString()) {
                      _order1receiveItemConvertFormController
                          .calculationType(i.calculationType);
                          
                          if (_order1receiveItemConvertFormController.selectedGstType.value!.value == interGstType) {
                            _order1receiveItemConvertFormController.gstPercent(i.interGst);
                          } else if (_order1receiveItemConvertFormController.selectedGstType.value!.value == intraGstType) {
                            _order1receiveItemConvertFormController.gstPercent(i.intraGst);
                          }
                      _order1receiveItemConvertFormController.getSubitemVendorCalculationDetails(value.value.toString(), context, _order1receiveItemConvertFormController.selectedVendor.value!.value, i.calculationType.toString(), i.calculationTypeName.toString());
                      break;
                    }
                  }
                },
                hintText: "Sub Item",
              ))
        ],
      ),
    );
  }



  
   SizedBox branch() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _order1receiveItemConvertFormController.branchSearchController,
                selectedValue:
                    _order1receiveItemConvertFormController.selectedBranch.value,
                options: _order1receiveItemConvertFormController.branchDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }


   SizedBox vendordetails() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _order1receiveItemConvertFormController.vendorSearchController,
                selectedValue:
                    _order1receiveItemConvertFormController.selectedVendor.value,
                options: _order1receiveItemConvertFormController.designerDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController.selectedVendor(value);
                },
                hintText: "Vendor",
              ))
        ],
      ),
    );
  }


    SizedBox poDate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "PO Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _order1receiveItemConvertFormController.poDateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _order1receiveItemConvertFormController.poDateController.clear();
              }
            },
            controller: _order1receiveItemConvertFormController.poDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "PO Date",
          ),
        ],
      ),
    );
  }



  
  SizedBox gstType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "GST Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _order1receiveItemConvertFormController.selectedGstType.value,
                options: _order1receiveItemConvertFormController.gstTypeDropDown.value,
                onChanged: _order1receiveItemConvertFormController.particulars.isNotEmpty ? null : (DropdownModel? value) {
                  _order1receiveItemConvertFormController.selectedGstType(value);
                },
                hintText: "GST Type",
              ))
        ],
      ),
    );
  }

  SizedBox itemDetails() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _order1receiveItemConvertFormController.itemSearchController,
                selectedValue:
                    _order1receiveItemConvertFormController.selectedItem.value,
                options: _order1receiveItemConvertFormController.itemDropDown.value,
                onChanged: (value) {
                  _order1receiveItemConvertFormController.resetForm(context);
                  _order1receiveItemConvertFormController.selectedItem(value);
                  _order1receiveItemConvertFormController.getSubItemList(value!.value,null);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }
}
