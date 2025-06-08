import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input_with_popup.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/itemtag_form/diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/itemtag_form/stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemtagItemForm extends StatefulWidget {
  const ItemtagItemForm({super.key});

  @override
  State<ItemtagItemForm> createState() => _ItemtagItemFormState();
}

class _ItemtagItemFormState extends State<ItemtagItemForm> {
  final ItemtagFormController _itemtagFormController =
      Get.put(ItemtagFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _itemtagFormController.itemtagDetailsFormKey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: size.width * 0.98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ItemTag Details",
                style: TextPalette.tableHeaderTextStyle,
              ),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              Wrap(
                spacing: 20.w,
                runSpacing: 10.h,
                children: [
                  itemDetails(),
                  subItemDetails(),
                  tagCount(),
                  pieces(),
                  grossWeight(),
                  reduceWeight(),
                  netWeight(),
                  tagType(),
                  touch(),
                  cataloguecoverWeight(),
                  measurementValue(),
                  remarks(),
                  stoneDetails(),
                  diamondDetails(),
                  Obx(() => _itemtagFormController.calculationType.value ==
                          fixedRateCalcType.toString()
                      ? Wrap(
                          spacing: 20.w,
                          runSpacing: 10.h,
                          children: [minFixedRate(), maxFixedRate()],
                        )
                      : _itemtagFormController.calculationType.value ==
                              weightCalcType.toString()
                          ? Wrap(
                              spacing: 20.w,
                              runSpacing: 10.h,
                              children: [
                                wastageCalculationType(),
                                wastagePercentage(),
                                flatWastageCalculationType(),
                                flatWastageValue(),
                                makingChargeCalculationType(),
                                makingChargePerGram(),
                                flatMakingCharge()
                              ],
                            )
                          : _itemtagFormController.calculationType.value ==
                                  perGramRateCalcType
                              ? Wrap(
                                  spacing: 10.w,
                                  runSpacing: 20.h,
                                  children: [
                                    perGramWeightType(),
                                    perGramRate(),
                                  ],
                                )
                              : _itemtagFormController.calculationType.value ==
                                      perPieceRateCalcType
                                  ? Wrap(
                                      spacing: 10.w,
                                      runSpacing: 20.h,
                                      children: [
                                        minPerPieceRate(),
                                        maxPerPieceRate()
                                      ],
                                    )
                                  : SizedBox()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  actions(context),
                ],
              )
            ],
          ),
        ));
  }

  SizedBox diamondDetails() {
    return SizedBox(
      width: Responsive.isMobile(context)
          ? double.infinity
          : Responsive.isMobile(context)
              ? double.infinity
              : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInputWithPopup(
            width: 300.w,
            controller: _itemtagFormController.diamondWeightController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.none,
            validator: "no_validate",
            readOnly: true,
            popupText: "Diamond",
            onPopupPressed: () async {
              await Get.dialog(
                  barrierDismissible: false,
                  DiamondDetailsPopup());
            },
          ),
        ],
      ),
    );
  }

  SizedBox stoneDetails() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInputWithPopup(
            width: 300.w,
            controller: _itemtagFormController.stoneWeightController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.none,
            popupText: "Stone",
            validator: "no_validate",
            readOnly: true,
            onPopupPressed: () async {
              await Get.dialog(
                  barrierDismissible: false,
                  StoneDetailsPopup());
            },
          ),
        ],
      ),
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
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _itemtagFormController.isFormSubmit.value,
                  text: "Add",
                  onPressed: () {
                    _itemtagFormController.submitItemForm(context);
                  }))),
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
                    _itemtagFormController.resetForm(context);
                  }))
        ],
      ),
    );
  }

  SizedBox minPerPieceRate() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Min Per Piece Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagFormController.minPerPieceRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Min Per Piece Rate",
          ),
        ],
      ),
    );
  }

  SizedBox maxPerPieceRate() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Max Per Piece Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagFormController.perPieceRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max Per Piece Rate",
          ),
        ],
      ),
    );
  }

  SizedBox perGramRate() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Per Gram Rate"),
          SizedBox(
            height: 7.w,
          ),
          Wrap(
            spacing: 10.w,
            runSpacing: 20.h,
            children: [minPerGramRate(), maxPerGramRate()],
          )
        ],
      ),
    );
  }

  SizedBox minPerGramRate() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.minPerGramRateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxPerGramRate() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.perGramRateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox perGramWeightType() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Per Gram Weight Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _itemtagFormController.selectedPerGramCalcuationType.value,
                options: _itemtagFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _itemtagFormController.selectedPerGramCalcuationType(value);
                },
                hintText: "Per Gram Weight Type",
              ))
        ],
      ),
    );
  }

  SizedBox flatMakingCharge() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat Making Charge"),
          SizedBox(
            height: 7.w,
          ),
          Wrap(
            spacing: 10.w,
            runSpacing: 20.h,
            children: [minFlatMakingCharge(), maxFlatMakingCharge()],
          )
        ],
      ),
    );
  }

  SizedBox minFlatMakingCharge() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.minFlatMakingChargeController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxFlatMakingCharge() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.flatMakingChargeController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox makingChargePerGram() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Making Charge Per Gram"),
          SizedBox(
            height: 7.w,
          ),
          Wrap(
            spacing: 10.w,
            runSpacing: 20.h,
            children: [minMakingChargePerGram(), maxMakingChargePerGram()],
          )
        ],
      ),
    );
  }

  SizedBox minMakingChargePerGram() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.minMakingChargePerGramController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxMakingChargePerGram() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.makingChargePerGramController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox makingChargeCalculationType() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "MC Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _itemtagFormController
                    .selectedMakingChargeCalcuationType.value,
                options: _itemtagFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _itemtagFormController
                      .selectedMakingChargeCalcuationType(value);
                },
                hintText: "MC Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox flatWastageValue() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat Wastage"),
          SizedBox(
            height: 7.w,
          ),
          Wrap(
            spacing: 10.w,
            runSpacing: 20.h,
            children: [minFlatWastage(), maxFlatWastage()],
          )
        ],
      ),
    );
  }

  SizedBox minFlatWastage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.minFlatWastageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxFlatWastage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.flatWastageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox flatWastageCalculationType() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat Wastage Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _itemtagFormController.selectedFlatWastageType.value,
                options: _itemtagFormController.flatWastageTypeDropDown.value,
                onChanged: (value) {
                  _itemtagFormController.selectedFlatWastageType(value);
                },
                hintText: "Flat Wastage Calculation Type",
              )),
        ],
      ),
    );
  }

  SizedBox wastagePercentage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Wastage Percentage"),
          SizedBox(
            height: 7.w,
          ),
          Wrap(
            spacing: 15.w,
            runSpacing: 20.h,
            children: [minWastagePercentage(), maxWastagePercentage()],
          )
        ],
      ),
    );
  }

  SizedBox minWastagePercentage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.minWastagePercentageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxWastagePercentage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 130.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _itemtagFormController.wastagePercentageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox wastageCalculationType() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Wastage Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _itemtagFormController.selectedWastageCalcuationType.value,
                options: _itemtagFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _itemtagFormController.selectedWastageCalcuationType(value);
                },
                hintText: "Wastage Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox minFixedRate() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Min Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagFormController.minFixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Min Fixed Rate",
          ),
        ],
      ),
    );
  }

  SizedBox maxFixedRate() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Max Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagFormController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max Fixed Rate",
          ),
        ],
      ),
    );
  }

  SizedBox cataloguecoverWeight() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalogue Cover Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagFormController.catalogueCoverWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "no_validation",
            hintText: "Catalogue Cover Weight",
          ),
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _itemtagFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox measurementValue() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Measurement Value"),
          SizedBox(height: 7.h),
          Obx(() => CustomTextInput(
                controller: _itemtagFormController.measurementValueController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: "no_validation",
                hintText: _itemtagFormController.measurementType.value,
              )),
        ],
      ),
    );
  }

  SizedBox tagType() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                isValidate: true,
                controller: _itemtagFormController.tagTypeSearchController,
                selectedValue: _itemtagFormController.selectedTagType.value,
                options: _itemtagFormController.tagTypeDropDown.value,
                onChanged: (value) {
                  _itemtagFormController.selectedTagType(value);
                },
                hintText: "Tag Type",
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
            controller: _itemtagFormController.netWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gram",
            readOnly: true,
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
            controller: _itemtagFormController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gram",
            onChanged: (value) {
              _itemtagFormController.calcNetWeight(
                  grossWeight:
                      _itemtagFormController.grossWeightController.text,
                  reduceWeight: value,
                  reduceStone: _itemtagFormController.reduceStoneWeight.value,
                  reduceDiamond:
                      _itemtagFormController.reduceDiamondWeight.value);
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
          Obx(() => CustomLabel(
              label:
                  "Gross Weight (${_itemtagFormController.itemRemainingGrossWeight.value})")),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gram",
            // readOnly: _itemtagFormController.stockType.value.toString() == pieceStockType ? true : false,
            onChanged: (value) {
              _itemtagFormController.calcNetWeight(
                  grossWeight: value,
                  reduceWeight:
                      _itemtagFormController.reduceWeightController.text,
                  reduceStone: _itemtagFormController.reduceStoneWeight.value,
                  reduceDiamond:
                      _itemtagFormController.reduceDiamondWeight.value);
              if (_itemtagFormController.selectedSubItem.value != null) {
                _itemtagFormController.getSubitemCalculationDetails(
                    _itemtagFormController.selectedSubItem.value!.value
                        .toString(),
                    context,
                    _itemtagFormController.calculationType.toString(),
                    value);
              }
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
          Obx(() => CustomLabel(
              label:
                  "Pieces (${_itemtagFormController.itemRemainingPieces.value})")),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _itemtagFormController.piecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Pieces",
            // readOnly: _itemtagFormController.stockType.value.toString() == weightStockType ? true : false,
          ),
        ],
      ),
    );
  }

  SizedBox touch() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Touch"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagFormController.touchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "no_validation",
            hintText: "Touch",
          ),
        ],
      ),
    );
  }

  SizedBox tagCount() {
    return SizedBox(
      width: 130.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => CustomLabel(
              label:
                  "Tag Count (${_itemtagFormController.itemRemainingTagCount.value})")),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _itemtagFormController.tagCountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Tag Count",
          ),
        ],
      ),
    );
  }

  SizedBox subItemDetails() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _itemtagFormController.subItemDetailSearchController,
                selectedValue: _itemtagFormController.selectedSubItem.value,
                options: _itemtagFormController.subItemDropDown.value,
                onChanged: (value) async {
                  _itemtagFormController.selectedSubItem(value);

                  for (var i in _itemtagFormController.subItemList.value) {
                    if (i.id.toString() == value!.value.toString()) {
                      _itemtagFormController.stockType(i.stockType);
                      _itemtagFormController.calculationType(i.calculationType);
                      _itemtagFormController
                          .measurementType(i.measurementTypeName);
                      _itemtagFormController.getSubitemCalculationDetails(
                          value.value.toString(),
                          context,
                          i.calculationType.toString(),
                          _itemtagFormController.grossWeightController.text);
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
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _itemtagFormController.itemDetailSearchController,
                selectedValue: _itemtagFormController.selectedItem.value,
                options: _itemtagFormController.itemDropDown.value,
                onChanged: (value) {
                  _itemtagFormController.selectedItem(value);
                  _itemtagFormController.getSubItemList(value!.value,context);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }
}
