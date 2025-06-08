import 'package:ausales_application/controller/value_addition_designer/value_addition_designer_form_controller.dart';
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
 
class ValueAdditionDesignerForm extends StatefulWidget {
  const ValueAdditionDesignerForm({super.key});
 
  @override
  State<ValueAdditionDesignerForm> createState() => _ValueAdditionDesignerFormState();
}
 
class _ValueAdditionDesignerFormState extends State<ValueAdditionDesignerForm> {
  final ValueAdditionDesignerFormController _valueAdditionDesignerFormController =
      Get.put(ValueAdditionDesignerFormController());
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_valueAdditionDesignerFormController.fromMode.value.capitalize} Value Addition Designer',
            style: Responsive.isDesktop(context) || Responsive.isTablet(context) ?  TextPalette.screenTitle : TextStyle(fontSize: 12.sp),
          ),
          IconButton(
              iconSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ?  25.sp : 20.sp ,
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
            key: _valueAdditionDesignerFormController.valueadditionFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10.w,
                  runSpacing: 20.h,
                  children: [
                    designerdetails(),
                    subitemdetails(),
                    calculationType(),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() => _valueAdditionDesignerFormController
                            .selectedCalculationType.value?.value ==
                        fixedRateCalcType
                    ? fixedRate()
                    : _valueAdditionDesignerFormController
                                .selectedCalculationType.value?.value ==
                            weightCalcType
                        ? Wrap(
                            spacing: 10.w,
                            runSpacing: 20.h,
                            children: [
                              touch(),
                              wastageCalculationType(),
                              wastagePercentage(),
                              flatWastageCalculation(),
                              makingChargeCalculationType(),
                              makingChargePerGram(),
                              flatMakingCharge()
                            ],
                          )
                        : _valueAdditionDesignerFormController
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
                            : _valueAdditionDesignerFormController
                                        .selectedCalculationType.value?.value ==
                                    perPieceRateCalcType
                                ? perPieceRate()
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
                  isLoading: _valueAdditionDesignerFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _valueAdditionDesignerFormController.submitValueadditiondesignerForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _valueAdditionDesignerFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _valueAdditionDesignerFormController.resetForm();
                  }))
        ],
      ),
    );
  }
 
  SizedBox perPieceRate() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Per Piece Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _valueAdditionDesignerFormController.perPieceRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Per Piece Rate",
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
          CustomTextInput(
            inputFormat: 'double',
            controller: _valueAdditionDesignerFormController.perGramRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Per Gram Rate",
          ),
        ],
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
                    _valueAdditionDesignerFormController.selectedPerGramCalcuationType.value,
                options: _valueAdditionDesignerFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionDesignerFormController.selectedPerGramCalcuationType(value);
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
          CustomTextInput(
            inputFormat: 'double',
            controller: _valueAdditionDesignerFormController.flatMakingChargeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Flat Making Charge",
          ),
        ],
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
          CustomTextInput(
            inputFormat: 'double',
            controller: _valueAdditionDesignerFormController.makingChargePerGramController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Making Charge Per Gram",
          ),
        ],
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
                selectedValue: _valueAdditionDesignerFormController
                    .selectedMakingChargeCalcuationType.value,
                options: _valueAdditionDesignerFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionDesignerFormController
                      .selectedMakingChargeCalcuationType(value);
                },
                hintText: "MC Calculation Type",
              ))
        ],
      ),
    );
  }
 
  SizedBox flatWastageCalculation() {
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
            runSpacing: 20.h,
            children: [flatWastageCalculationType(), flatWastageValue()],
          ),
        ],
      ),
    );
  }
 
  SizedBox flatWastageValue() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 185.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _valueAdditionDesignerFormController.flatWastageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Flat Wastage",
      ),
    );
  }
 
  SizedBox flatWastageCalculationType() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 150.w,
      child: Obx(() => CustomDropdownField(
            selectedValue: _valueAdditionDesignerFormController.selectedFlatWastageType.value,
            options: _valueAdditionDesignerFormController.flatWastageTypeDropDown.value,
            onChanged: (value) {
              _valueAdditionDesignerFormController.selectedFlatWastageType(value);
            },
            hintText: "Flat Wastage Calculation Type",
          )),
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
          CustomTextInput(
            inputFormat: 'double',
            controller: _valueAdditionDesignerFormController.wastagePercentageController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Wastage Percentage",
          ),
        ],
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
                    _valueAdditionDesignerFormController.selectedWastageCalcuationType.value,
                options: _valueAdditionDesignerFormController.weightTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionDesignerFormController.selectedWastageCalcuationType(value);
                },
                hintText: "Wastage Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox touch() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Touch"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _valueAdditionDesignerFormController.touchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Touch",
          ),
        ],
      ),
    );
  }
 
  SizedBox fixedRate() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _valueAdditionDesignerFormController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Fixed Rate",
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
                    _valueAdditionDesignerFormController.selectedCalculationType.value,
                options: _valueAdditionDesignerFormController.calculationTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionDesignerFormController.selectedCalculationType(value);
                },
                hintText: "Calculation Type",
              ))
        ],
      ),
    );
  }



 
  SizedBox designerdetails() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor Detail"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _valueAdditionDesignerFormController.designerSearchController,
                selectedValue: _valueAdditionDesignerFormController.selectedDesigner.value,
                options: _valueAdditionDesignerFormController.designerDropDown.value,
                onChanged: (value) {
                  _valueAdditionDesignerFormController.selectedDesigner(value);
                },
                hintText: "Vendor Detail",
              ))
        ],
      ),
    );
  }


   SizedBox subitemdetails() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Item Detail"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _valueAdditionDesignerFormController.subitemDetailSearchController,
                selectedValue: _valueAdditionDesignerFormController.selectedSubItem.value,
                options: _valueAdditionDesignerFormController.subitemDropDown.value,
                onChanged: (value) {
                  _valueAdditionDesignerFormController.selectedSubItem(value);
                },
                hintText: "Sub Item Detail",
              ))
        ],
      ),
    );
  }
}