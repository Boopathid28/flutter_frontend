import 'package:ausales_application/controller/bulk_tag_udpate/bulk_tag_update_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BulTagUpdateForm extends StatefulWidget {
  const BulTagUpdateForm({super.key});

  @override
  State<BulTagUpdateForm> createState() => _BulTagUpdateFormState();
}

class _BulTagUpdateFormState extends State<BulTagUpdateForm> {
  final BulkTagUpdateController _bulkTagUpdateController =
      Get.put(BulkTagUpdateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Obx(() => _bulkTagUpdateController
                    .selectedCalculationType.value?.value ==
                fixedRateCalcType
            ? Wrap(
                spacing: 20.w,
                runSpacing: 15.h,
                children: [minFixedRate(), maxFixedRate(), actions(context)],
              )
            : _bulkTagUpdateController.selectedCalculationType.value?.value ==
                    perGramRateCalcType
                ? Wrap(
                    spacing: 20.w,
                    runSpacing: 15.h,
                    children: [
                      perGramWeightType(),
                      minPerGramRate(),
                      maxPerGramRate(),
                      actions(context)
                    ],
                  )
                : _bulkTagUpdateController
                            .selectedCalculationType.value?.value ==
                        perPieceRateCalcType
                    ? Wrap(
                        spacing: 20.w,
                        runSpacing: 15.h,
                        children: [minPerPieceRate(), maxPerPieceRate(), actions(context)],
                      )
                    : _bulkTagUpdateController
                                .selectedCalculationType.value?.value ==
                            weightCalcType
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
                              flatMakingCharge(),
                              actions(context)
                            ],
                          )
                        : SizedBox()),
                        
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
                  isLoading: _bulkTagUpdateController.isUpdateFormSubmit.value,
                  text: "Update",
                  onPressed: () {
                    _bulkTagUpdateController.updateTagdetails(context);
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
                    _bulkTagUpdateController.resetUpdateForm();
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
            filled: true,
            controller: _bulkTagUpdateController.minPerPieceRateController,
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
            filled: true,
            controller: _bulkTagUpdateController.perPieceRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max Per Piece Rate",
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
            filled: true,
                selectedValue: _bulkTagUpdateController
                    .selectedPerGramCalcuationType.value,
                options: _bulkTagUpdateController.weighttypeDropDown.value,
                onChanged: (value) {
                  _bulkTagUpdateController.selectedPerGramCalcuationType(value);
                },
                hintText: "Per Gram Weight Type",
              ))
        ],
      ),
    );
  }

  SizedBox minPerGramRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        children: [
          CustomLabel(label: "Min Per Gram Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            filled: true,
            controller: _bulkTagUpdateController.minPerGramRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Min",
          ),
        ],
      ),
    );
  }

  SizedBox maxPerGramRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        children: [
          CustomLabel(label: "Max Per Gram Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            filled: true,
            controller: _bulkTagUpdateController.perGramRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max",
          ),
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
        filled: true,
        controller: _bulkTagUpdateController.minFlatMakingChargeController,
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
        filled: true,
        controller: _bulkTagUpdateController.flatMakingChargeController,
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
        filled: true,
        controller: _bulkTagUpdateController.minMakingChargePerGramController,
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
        filled: true,
        controller: _bulkTagUpdateController.makingChargePerGramController,
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
            filled: true,
                selectedValue: _bulkTagUpdateController
                    .selectedMakingChargeCalcuationType.value,
                options: _bulkTagUpdateController.weighttypeDropDown.value,
                onChanged: (value) {
                  _bulkTagUpdateController
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
        filled: true,
        controller: _bulkTagUpdateController.minFlatWastageController,
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
        filled: true,
        controller: _bulkTagUpdateController.flatWastageController,
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
            filled: true,
                selectedValue:
                    _bulkTagUpdateController.selectedFlatWastageType.value,
                options: _bulkTagUpdateController.flatWastageTypeDropDown.value,
                onChanged: (value) {
                  _bulkTagUpdateController.selectedFlatWastageType(value);
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
        filled: true,
        controller: _bulkTagUpdateController.minWastagePercentageController,
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
        filled: true,
        inputFormat: 'double',
        controller: _bulkTagUpdateController.wastagePercentageController,
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
            filled: true,
                selectedValue: _bulkTagUpdateController
                    .selectedWastageCalcuationType.value,
                options: _bulkTagUpdateController.weighttypeDropDown.value,
                onChanged: (value) {
                  _bulkTagUpdateController.selectedWastageCalcuationType(value);
                },
                hintText: "Wastage Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox minFixedRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Min Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            filled: true,
            controller: _bulkTagUpdateController.minFixedRateController,
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
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Max Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            filled: true,
            controller: _bulkTagUpdateController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max Fixed Rate",
          ),
        ],
      ),
    );
  }
}
