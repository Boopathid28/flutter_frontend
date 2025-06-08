import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_form_controller.dart';
import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/value_addition_customer/value_addition_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionCustomerFormScreen extends StatefulWidget {
  const ValueAdditionCustomerFormScreen({super.key});

  @override
  State<ValueAdditionCustomerFormScreen> createState() =>
      _ValueAdditionCustomerFormScreenState();
}

class _ValueAdditionCustomerFormScreenState
    extends State<ValueAdditionCustomerFormScreen> {
  final ValueAdditionCustomerFormController
      _valueAdditionCustomerFormController =
      Get.put(ValueAdditionCustomerFormController());

  final ValueAdditionCustomerListController
      _valueAdditionCustomerListController =
      Get.put(ValueAdditionCustomerListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalete.appBgColor,
      appBar: PreferredSize(
        child: HeaderWidget(),
        preferredSize: Size.fromHeight(100.0),
      ),
      bottomNavigationBar: Footer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.w),
              margin: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: ShadowPalette.formElevation,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Form(
                  key: _valueAdditionCustomerFormController
                      .valueadditioncustomerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tag List",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 10.w,
                      ),
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 20.h,
                        children: [
                          subitemdetails(),
                          Obx(() => _valueAdditionCustomerFormController
                                          .selectedCalculation ==
                                      weightCalcType ||
                                  _valueAdditionCustomerFormController
                                          .selectedCalculation ==
                                      perGramRateCalcType
                              ? formweight()
                              : SizedBox()),
                          Obx(() => _valueAdditionCustomerFormController
                                          .selectedCalculation ==
                                      weightCalcType ||
                                  _valueAdditionCustomerFormController
                                          .selectedCalculation ==
                                      perGramRateCalcType
                              ? toweight()
                              : SizedBox()),
                          SizedBox(
                              width: Responsive.isDesktop(context) ||
                                      Responsive.isTablet(context)
                                  ? 115.w
                                  : double.infinity,
                              child: Obx(() => PrimaryButton(
                                  btnHeight: 46.h,
                                  isLoading:
                                      _valueAdditionCustomerFormController
                                          .isFormFind.value,
                                  text: "Find",
                                  onPressed: () {
                                    _valueAdditionCustomerFormController
                                        .getValueAdditionCustomerTagList(
                                            _valueAdditionCustomerFormController
                                                    .selectedSubItem
                                                    .value
                                                    ?.value ??
                                                null,
                                            _valueAdditionCustomerFormController
                                                    .fromweightController
                                                    .text ??
                                                null,
                                            _valueAdditionCustomerFormController
                                                    .toweightController.text ??
                                                null,
                                            context);
                                  }))),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => _valueAdditionCustomerFormController
                                    .selectedCalculation ==
                                fixedRateCalcType
                            ? Wrap(
                                spacing: 10.w,
                                runSpacing: 20.h,
                                children: [minFixedRate(), maxFixedRate()],
                              )
                            : _valueAdditionCustomerFormController
                                        .selectedCalculation ==
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
                                : _valueAdditionCustomerFormController
                                            .selectedCalculation ==
                                        perGramRateCalcType
                                    ? Wrap(
                                        spacing: 10.w,
                                        runSpacing: 20.h,
                                        children: [
                                          perGramWeightType(),
                                          perGramRate(),
                                        ],
                                      )
                                    : _valueAdditionCustomerFormController
                                                .selectedCalculation ==
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
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  actions(context),
                                ],
                              ),
                            )
                          : SizedBox(
                              child: Column(
                                children: [
                                  actions(context),
                                ],
                              ),
                            )
                    ],
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            ValueAdditionTable()
          ],
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
        // width: 250.w,
        child: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  savebtn(context),
                  SizedBox(
                    width: 10.w,
                  ),
                  clearbtn(),
                  SizedBox(
                    width: 10.w,
                  ),
                  closebtn(),
                ],
              )
            : Column(
                children: [
                  savebtn(context),
                  SizedBox(
                    height: 10.w,
                  ),
                  clearbtn(),
                  SizedBox(
                    height: 10.w,
                  ),
                  closebtn(),
                ],
              ));
  }

  SizedBox closebtn() {
    return SizedBox(
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 115.w
            : double.infinity,
        child: PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: "Close",
            onPressed: () {
              Get.back();
              _valueAdditionCustomerFormController.resetForm();
            }));
  }

  SizedBox clearbtn() {
    return SizedBox(
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 115.w
            : double.infinity,
        child: SecondaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: "Clear",
            onPressed: () {
              _valueAdditionCustomerFormController.resetForm();
            }));
  }

  SizedBox savebtn(BuildContext context) {
    return SizedBox(
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 115.w
            : double.infinity,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: _valueAdditionCustomerFormController.isFormSubmit.value,
            text: "Save",
            onPressed: () {
              _valueAdditionCustomerFormController
                  .submitValueadditioncustomerForm(context);
            })));
  }

  SizedBox minPerPieceRate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Min Per Piece Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _valueAdditionCustomerFormController.minPerPieceRateController,
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
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Max Per Piece Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _valueAdditionCustomerFormController.perPieceRateController,
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
      width: 300.w,
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
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller:
            _valueAdditionCustomerFormController.minPerGramRateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxPerGramRate() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _valueAdditionCustomerFormController.perGramRateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox perGramWeightType() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Per Gram Weight Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _valueAdditionCustomerFormController
                    .selectedPerGramCalcuationType.value,
                options: _valueAdditionCustomerFormController
                    .weightTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionCustomerFormController
                      .selectedPerGramCalcuationType(value);
                },
                hintText: "Per Gram Weight Type",
              ))
        ],
      ),
    );
  }

  SizedBox flatMakingCharge() {
    return SizedBox(
      width: 300.w,
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
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller:
            _valueAdditionCustomerFormController.minFlatMakingChargeController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxFlatMakingCharge() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller:
            _valueAdditionCustomerFormController.flatMakingChargeController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox makingChargePerGram() {
    return SizedBox(
      width: 300.w,
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
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _valueAdditionCustomerFormController
            .minMakingChargePerGramController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxMakingChargePerGram() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller:
            _valueAdditionCustomerFormController.makingChargePerGramController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox makingChargeCalculationType() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "MC Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _valueAdditionCustomerFormController
                    .selectedMakingChargeCalcuationType.value,
                options: _valueAdditionCustomerFormController
                    .weightTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionCustomerFormController
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
      width: 300.w,
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
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller:
            _valueAdditionCustomerFormController.minFlatWastageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxFlatWastage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller: _valueAdditionCustomerFormController.flatWastageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox flatWastageCalculationType() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Flat Wastage Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _valueAdditionCustomerFormController
                    .selectedFlatWastageType.value,
                options: _valueAdditionCustomerFormController
                    .flatWastageTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionCustomerFormController
                      .selectedFlatWastageType(value);
                },
                hintText: "Flat Wastage Calculation Type",
              )),
        ],
      ),
    );
  }

  SizedBox wastagePercentage() {
    return SizedBox(
      width: 300.w,
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
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller:
            _valueAdditionCustomerFormController.minWastagePercentageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Min",
      ),
    );
  }

  SizedBox maxWastagePercentage() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 140.w,
      child: CustomTextInput(
        inputFormat: 'double',
        controller:
            _valueAdditionCustomerFormController.wastagePercentageController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(),
        validator: "default",
        hintText: "Max",
      ),
    );
  }

  SizedBox wastageCalculationType() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Wastage Calculation Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _valueAdditionCustomerFormController
                    .selectedWastageCalcuationType.value,
                options: _valueAdditionCustomerFormController
                    .weightTypeDropDown.value,
                onChanged: (value) {
                  _valueAdditionCustomerFormController
                      .selectedWastageCalcuationType(value);
                },
                hintText: "Wastage Calculation Type",
              ))
        ],
      ),
    );
  }

  SizedBox minFixedRate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Min Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _valueAdditionCustomerFormController.minFixedRateController,
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
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Max Fixed Rate"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _valueAdditionCustomerFormController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max Fixed Rate",
          ),
        ],
      ),
    );
  }

  SizedBox formweight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "From Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            readOnly: _valueAdditionCustomerFormController.fromMode == "create"
                ? false
                : true,
            inputFormat: 'double',
            controller:
                _valueAdditionCustomerFormController.fromweightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "From Weight",
          ),
        ],
      ),
    );
  }

  SizedBox toweight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "To Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            readOnly: _valueAdditionCustomerFormController.fromMode == "create"
                ? false
                : true,
            inputFormat: 'double',
            controller: _valueAdditionCustomerFormController.toweightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "To Weight",
          ),
        ],
      ),
    );
  }

  SizedBox subitemdetails() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Item Detail"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                readOnly:
                    _valueAdditionCustomerFormController.fromMode == "create"
                        ? false
                        : true,
                controller: _valueAdditionCustomerFormController
                    .subitemDetailSearchController,
                selectedValue:
                    _valueAdditionCustomerFormController.selectedSubItem.value,
                options:
                    _valueAdditionCustomerFormController.subitemDropDown.value,
                onChanged: (value) {
                  _valueAdditionCustomerFormController.selectedSubItem(value);
                  _valueAdditionCustomerFormController
                      .getCalculationType(value!.value);
                },
                hintText: "Sub Item Detail",
              ))
        ],
      ),
    );
  }
}