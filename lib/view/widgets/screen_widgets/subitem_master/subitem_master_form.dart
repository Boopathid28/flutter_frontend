import 'package:ausales_application/controller/subitem_master/subitem_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
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

class SubitemMasterForm extends StatefulWidget {
  const SubitemMasterForm({super.key});

  @override
  State<SubitemMasterForm> createState() => _SubitemMasterFormState();
}

class _SubitemMasterFormState extends State<SubitemMasterForm> {
  final SubitemFormController _subitemFormController =
      Get.put(SubitemFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_subitemFormController.fromMode.value.capitalize} Sub Item',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              iconSize: 25.sp,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _subitemFormController.subitemFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10.w,
                  runSpacing: 20.h,
                  children: [
                    itemMaster(),
                    subitemName(),
                    subitemCode(),
                    hsnCode(),
                    stockType(),
                    measurementType(),
                    calculationType(),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() => _subitemFormController
                            .selectedCalculationType.value?.value ==
                        fixedRateCalcType
                    ? Wrap(
                      spacing: 10.w,
                      runSpacing: 20.h,
                      children: [
                        minFixedRate(),
                        maxFixedRate()
                      ],
                    )
                    : _subitemFormController
                                .selectedCalculationType.value?.value ==
                            weightCalcType
                        ? Wrap(
                            spacing: 10.w,
                            runSpacing: 20.h,
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
                        : _subitemFormController
                                    .selectedCalculationType.value?.value ==
                                perGramRateCalcType
                            ? Wrap(
                                spacing: 10.w,
                                runSpacing: 20.h,
                                children: [
                                  perGramWeightType(),
                                  perGramRate(),
                                ],
                              )
                            : _subitemFormController
                                        .selectedCalculationType.value?.value ==
                                    perPieceRateCalcType
                                ? Wrap(
                                spacing: 10.w,
                                runSpacing: 20.h,
                                  children: [
                                    minPerPieceRate(),
                                    maxPerPieceRate()
                                  ],
                                )
                                : SizedBox())
              ],
            ),
          ),
        ),
      ),
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
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _subitemFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _subitemFormController.submitSubitemForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _subitemFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _subitemFormController.resetForm();
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
            controller: _subitemFormController.minPerPieceRateController,
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
            controller: _subitemFormController.perPieceRateController,
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
            children: [
              minPerGramRate(),
              maxPerGramRate()
            ],
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
        controller: _subitemFormController.minPerGramRateController,
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
        controller: _subitemFormController.perGramRateController,
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
                    _subitemFormController.selectedPerGramCalcuationType.value,
                options: _subitemFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _subitemFormController.selectedPerGramCalcuationType(value);
                },
                hintText: "Per Gram Weight Type",
              ))
        ],
      ),
    );
  }

  SizedBox flatMakingCharge() {
    return SizedBox(
      width: 335.w,
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
            children: [
              minFlatMakingCharge(),
              maxFlatMakingCharge()
            ],
          )
        ],
      ),
    );
  }

  SizedBox minFlatMakingCharge() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.minFlatMakingChargeController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxFlatMakingCharge() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.flatMakingChargeController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox makingChargePerGram() {
    return SizedBox(
      width: 335.w,
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
            children: [
              minMakingChargePerGram(),
              maxMakingChargePerGram()
            ],
          )
        ],
      ),
    );
  }

  SizedBox minMakingChargePerGram() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.minMakingChargePerGramController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxMakingChargePerGram() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.makingChargePerGramController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox makingChargeCalculationType() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "MC Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _subitemFormController
                    .selectedMakingChargeCalcuationType.value,
                options: _subitemFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _subitemFormController
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
      width: 335.w,
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
            children: [
              minFlatWastage(),
              maxFlatWastage()
            ],
          )
        ],
      ),
    );
  }
  
  SizedBox minFlatWastage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.minFlatWastageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxFlatWastage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.flatWastageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox flatWastageCalculationType() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat Wastage Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _subitemFormController.selectedFlatWastageType.value,
                options: _subitemFormController.flatWastageTypeDropDown.value,
                onChanged: (value) {
                  _subitemFormController.selectedFlatWastageType(value);
                },
                hintText: "Flat Wastage Calculation Type",
              )),
        ],
      ),
    );
  }

  SizedBox wastagePercentage() {
    return SizedBox(
      width: 335.w,
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
            children: [
              minWastagePercentage(),
              maxWastagePercentage()
            ],
          )
        ],
      ),
    );
  }
  
  SizedBox minWastagePercentage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.minWastagePercentageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxWastagePercentage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 160.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _subitemFormController.wastagePercentageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox wastageCalculationType() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Wastage Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _subitemFormController.selectedWastageCalcuationType.value,
                options: _subitemFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _subitemFormController.selectedWastageCalcuationType(value);
                },
                hintText: "Wastage Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox minFixedRate() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Min Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _subitemFormController.minFixedRateController,
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
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Max Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _subitemFormController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max Fixed Rate",
          ),
        ],
      ),
    );
  }

  SizedBox calculationType() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _subitemFormController.selectedCalculationType.value,
                options: _subitemFormController.calculationTypeDropDown.value,
                onChanged: (value) {
                  _subitemFormController.selectedCalculationType(value);
                },
                hintText: "Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox measurementType() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Measurement Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _subitemFormController.selectedMeasurementType.value,
                options: _subitemFormController.measurementTypeDropDown.value,
                onChanged: (value) {
                  _subitemFormController.selectedMeasurementType(value);
                },
                isValidate: false,
                hintText: "Measurement Type",
              ))
        ],
      ),
    );
  }

  SizedBox stockType() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stock Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _subitemFormController.selectedStockType.value,
                options: _subitemFormController.stockTypeDropDown.value,
                onChanged: (value) {
                  _subitemFormController.selectedCalculationType.value = null;
                  _subitemFormController.selectedStockType(value);
                  _subitemFormController.getCalculationTypeList(
                      value: value!.value);
                },
                hintText: "Stock Type",
              ))
        ],
      ),
    );
  }

  SizedBox hsnCode() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "HSN Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _subitemFormController.hsnCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "no_validation",
            hintText: "HSN Code",
          ),
        ],
      ),
    );
  }

  SizedBox subitemCode() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Subitem Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _subitemFormController.subItemCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Subitem Code",
          ),
        ],
      ),
    );
  }

  SizedBox subitemName() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Subitem Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _subitemFormController.subItemNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Subitem Name",
          ),
        ],
      ),
    );
  }

  SizedBox itemMaster() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item Detail"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _subitemFormController.itemDetailSearchController,
                selectedValue: _subitemFormController.selectedItem.value,
                options: _subitemFormController.itemDropDown.value,
                onChanged: (value) {
                  _subitemFormController.selectedItem(value);
                },
                hintText: "Item Detail",
              ))
        ],
      ),
    );
  }
}
