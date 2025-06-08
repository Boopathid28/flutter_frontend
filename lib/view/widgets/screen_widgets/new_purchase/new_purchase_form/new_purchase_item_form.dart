import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_form_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_item_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPurchaseItemForm extends StatefulWidget {
  const NewPurchaseItemForm({super.key});

  @override
  State<NewPurchaseItemForm> createState() => _NewPurchaseItemFormState();
}

class _NewPurchaseItemFormState extends State<NewPurchaseItemForm> {
  final NewPurchaseItemFormController _newPurchaseItemFormController =
      Get.put(NewPurchaseItemFormController());

  final NewPurchaseFormController _newPurchaseFormController =
      Get.put(NewPurchaseFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_newPurchaseItemFormController.itemFormMode.value} Item'),
          IconButton(
              onPressed: () {
                _newPurchaseItemFormController.itemFormMode('create');
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Form(
          key: _newPurchaseItemFormController.newPurchaseItemFormDetailsFormKey,
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: size.width * 0.98,
            child: SingleChildScrollView(
              child: Wrap(
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
                  Obx(() => _newPurchaseItemFormController
                              .selectedCalculationType.value?.value ==
                          fixedRateCalcType
                      ? fixedRate()
                      : _newPurchaseItemFormController
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
                          : _newPurchaseItemFormController
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
                              : _newPurchaseItemFormController
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
                    _newPurchaseItemFormController.submitForm(context);
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
                    _newPurchaseItemFormController.resetForm(context);
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
            controller: _newPurchaseItemFormController.totalAmountController,
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
            controller: _newPurchaseItemFormController.gstAmountController,
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
            controller: _newPurchaseItemFormController.totalWeightController,
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
            controller: _newPurchaseItemFormController.otherChargesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Other Charges",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.hallmarkChargesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Halmark Charges",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.diamondAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Diamond Amount",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                selectedValue: _newPurchaseItemFormController
                    .selectedDiamondReduceWeight.value,
                options:
                    _newPurchaseItemFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController
                      .selectedDiamondReduceWeight(value);
                  _newPurchaseItemFormController.calculation(
                      grossWeight: _newPurchaseItemFormController
                          .grossWeightController.text,
                      reduceWeight: _newPurchaseItemFormController
                          .reduceWeightController.text,
                      stoneWeight: _newPurchaseItemFormController
                          .stoneWeightController.text,
                      diamondWeight: _newPurchaseItemFormController
                          .diamondWeightController.text,
                      stoneReduceWeight: _newPurchaseItemFormController
                                  .selectedDiamondReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      diamondReduceWeight: value!.value == "1" ? true : false,
                      calculationType: _newPurchaseItemFormController
                          .selectedCalculationType.value,
                      gstType: _newPurchaseItemFormController
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
            controller: _newPurchaseItemFormController.diamondWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Diamond Weight",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: value,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.diamondPiecesController,
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
            controller: _newPurchaseItemFormController.stoneAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Stone Amount",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                selectedValue: _newPurchaseItemFormController
                    .selectedStoneReduceWeight.value,
                options:
                    _newPurchaseItemFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController
                      .selectedStoneReduceWeight(value);
                  _newPurchaseItemFormController.calculation(
                      grossWeight: _newPurchaseItemFormController
                          .grossWeightController.text,
                      reduceWeight: _newPurchaseItemFormController
                          .reduceWeightController.text,
                      stoneWeight: _newPurchaseItemFormController
                          .stoneWeightController.text,
                      diamondWeight: _newPurchaseItemFormController
                          .diamondWeightController.text,
                      stoneReduceWeight: value!.value == "1" ? true : false,
                      diamondReduceWeight: _newPurchaseItemFormController
                                  .selectedDiamondReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      calculationType: _newPurchaseItemFormController
                          .selectedCalculationType.value,
                      gstType: _newPurchaseItemFormController
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
            controller: _newPurchaseItemFormController.stoneWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Stone Weight",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight: value,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.stonePiecesController,
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
            controller: _newPurchaseItemFormController.perPieceRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Per Piece Rate",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.perGramRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Per Gram Rate",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                selectedValue: _newPurchaseItemFormController
                    .selectedPerGramCalcuationType.value,
                options:
                    _newPurchaseItemFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController
                      .selectedPerGramCalcuationType(value);

                  _newPurchaseItemFormController.calculation(
                      grossWeight: _newPurchaseItemFormController
                          .grossWeightController.text,
                      reduceWeight: _newPurchaseItemFormController
                          .reduceWeightController.text,
                      stoneWeight: _newPurchaseItemFormController
                          .stoneWeightController.text,
                      diamondWeight: _newPurchaseItemFormController
                          .diamondWeightController.text,
                      stoneReduceWeight: _newPurchaseItemFormController
                                  .selectedStoneReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      diamondReduceWeight: _newPurchaseItemFormController
                                  .selectedDiamondReduceWeight.value.value ==
                              "1"
                          ? true
                          : false,
                      calculationType: _newPurchaseItemFormController
                          .selectedCalculationType.value,
                      gstType: _newPurchaseItemFormController
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
            controller: _newPurchaseItemFormController.touchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Touch",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                _newPurchaseItemFormController.flatMakingChargeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Flat MC",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                _newPurchaseItemFormController.makingChargePerGramController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "MC/G",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                selectedValue: _newPurchaseItemFormController
                    .selectedMakingChargeCalcuationType.value,
                options:
                    _newPurchaseItemFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController
                      .selectedMakingChargeCalcuationType(value);
                  _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.flatWastageController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Flat Wastage",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                selectedValue: _newPurchaseItemFormController
                    .selectedFlatWastageType.value,
                options: _newPurchaseItemFormController
                    .flatWastageTypeDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController.selectedFlatWastageType(value);
                  _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                _newPurchaseItemFormController.wastagePercentageController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Wastage %",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                selectedValue: _newPurchaseItemFormController
                    .selectedWastageCalcuationType.value,
                options:
                    _newPurchaseItemFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController
                      .selectedWastageCalcuationType(value);

                  _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Fixed Rate",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                selectedValue: _newPurchaseItemFormController
                    .selectedCalculationType.value,
                options: _newPurchaseItemFormController
                    .calculationTypeDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController.onCalculationTypeChange(value!);
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
            controller: _newPurchaseItemFormController.netWeightController,
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
            controller: _newPurchaseItemFormController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Reduce Weight",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: value,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight: value,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
            controller: _newPurchaseItemFormController.piecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Pieces",
            onChanged: (value) {
              _newPurchaseItemFormController.calculation(
                  grossWeight:
                      _newPurchaseItemFormController.grossWeightController.text,
                  reduceWeight: _newPurchaseItemFormController
                      .reduceWeightController.text,
                  stoneWeight:
                      _newPurchaseItemFormController.stoneWeightController.text,
                  diamondWeight: _newPurchaseItemFormController
                      .diamondWeightController.text,
                  stoneReduceWeight: _newPurchaseItemFormController
                              .selectedStoneReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  diamondReduceWeight: _newPurchaseItemFormController
                              .selectedDiamondReduceWeight.value.value ==
                          "1"
                      ? true
                      : false,
                  calculationType: _newPurchaseItemFormController
                      .selectedCalculationType.value,
                  gstType:
                      _newPurchaseItemFormController.selectedGstType.value!);
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
                    _newPurchaseItemFormController.subItemSearchController,
                selectedValue:
                    _newPurchaseItemFormController.selectedSubItem.value,
                options: _newPurchaseItemFormController.subItemDropDown.value,
                onChanged: (value) async {
                  _newPurchaseItemFormController.selectedSubItem(value);

                  for (var i
                      in _newPurchaseItemFormController.subItemList.value) {
                    if (i.id.toString() == value!.value.toString()) {
                      _newPurchaseItemFormController
                          .calculationType(i.calculationType);
                          
                          if (_newPurchaseItemFormController.selectedGstType.value!.value == interGstType) {
                            _newPurchaseItemFormController.gstPercent(i.interGst);
                          } else if (_newPurchaseItemFormController.selectedGstType.value!.value == intraGstType) {
                            _newPurchaseItemFormController.gstPercent(i.intraGst);
                          }
                      _newPurchaseItemFormController.getSubitemVendorCalculationDetails(value.value.toString(), context, _newPurchaseFormController.selectedVendor.value!.value, i.calculationType.toString(), i.calculationTypeName.toString());
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
                controller: _newPurchaseItemFormController.itemSearchController,
                selectedValue:
                    _newPurchaseItemFormController.selectedItem.value,
                options: _newPurchaseItemFormController.itemDropDown.value,
                onChanged: (value) {
                  _newPurchaseItemFormController.resetForm(context);
                  _newPurchaseItemFormController.selectedItem(value);
                  _newPurchaseItemFormController.getSubItemList(value!.value);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }
}
