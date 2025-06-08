import 'package:ausales_application/controller/single_tag_update/single_tag_update_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input_with_popup.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/single_tag_update/tag_update_diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/single_tag_update/tag_update_stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SingleTagUpdateScreen extends StatefulWidget {
  @override
  State<SingleTagUpdateScreen> createState() => _SingleTagUpdateScreenState();
}

class _SingleTagUpdateScreenState extends State<SingleTagUpdateScreen> {
  final SingleTagUpdateController _singleTagUpdateController =
      Get.put(SingleTagUpdateController());

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _singleTagUpdateController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _singleTagUpdateController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
              child: HeaderWidget(),
              preferredSize: Size.fromHeight(100.0),
            ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      "Single Tag Update",
                      style: TextPalette.screenTitle,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                color: Colors.white,
                width: double.infinity,
                child: Wrap(
                  spacing: 20.w,
                  runSpacing: 15.h,
                  children: [
                    Obx(
                        () => _singleTagUpdateController.isBranchuser.value
                            ? branch()
                            : SizedBox(),
                      ),
                    tagNumber(),
                    actions(context),
                  ],
                ),
              ),

              Obx(() => _singleTagUpdateController.isGetDetailsLoading.value ? Center(child: CircularProgressIndicator()) : Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 20.w,
                      runSpacing: 15.h,
                      children: [
                        tagType(),
                        measurementValue(),
                        huid(),
                        pieces(),
                        grossWeight(),
                        reduceWeight(),
                        netWeight(),
                        catalogueCoverWeight(),
                        remarks(),
                        stoneDetails(),
                        diamondDetails()
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(() => _singleTagUpdateController.calculationType.value == fixedRateCalcType ? Wrap(
                      spacing: 20.w,
                      runSpacing: 15.h,
                      children: [
                        minFixedRate(),
                        maxFixedRate()
                      ],
                    ) : _singleTagUpdateController.calculationType.value == perGramRateCalcType ? Wrap(
                      spacing: 20.w,
                      runSpacing: 15.h,
                      children: [
                        perGramWeightType(),
                        minPerGramRate(),
                        maxPerGramRate()
                      ],
                    ) : _singleTagUpdateController.calculationType.value == perPieceRateCalcType ? Wrap(
                      spacing: 20.w,
                      runSpacing: 15.h,
                      children: [
                        minPerPieceRate(),
                        maxPerPieceRate()
                      ],
                    ) : _singleTagUpdateController.calculationType.value == weightCalcType ? Wrap(
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
                        ) : SizedBox())
                  ],
                ),
              )),

              
              
              SizedBox(
                height: defaultBottombarHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _singleTagUpdateController.isFormSubmit.value,
                  text: "Update",
                  onPressed: () {
                    _singleTagUpdateController.updateTagDetails(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _singleTagUpdateController.resetForm();
                    _singleTagUpdateController.resetFilterForm();
                  }))
        ],
      ),
    );
  }

  SizedBox diamondDetails() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond"),
            SizedBox(
              height: 7.w,
            ),
          CustomTextInputWithPopup(
            width: 300.w,
            controller: _singleTagUpdateController.diamondWeightController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.none,
            validator: "no_validate",
            readOnly: true,
            popupText: "Diamond",
            onPopupPressed: () async {
          await Get.dialog( 
                barrierDismissible: false,
                TagUpdateDiamondDetailsPopup()
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox stoneDetails() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone"),
            SizedBox(
              height: 7.w,
            ),
          CustomTextInputWithPopup(
            width: 300.w,
            controller: _singleTagUpdateController.stoneWeightController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.none,
            popupText: "Stone",
            validator: "no_validate",
            readOnly: true,
            onPopupPressed: () async {
              await Get.dialog(
                barrierDismissible: false,
                TagUpdateStoneDetailsPopup()
              );
            },
          ),
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
            controller: _singleTagUpdateController.minPerPieceRateController,
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
            controller: _singleTagUpdateController.perPieceRateController,
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
                selectedValue:
                    _singleTagUpdateController.selectedPerGramCalcuationType.value,
                options: _singleTagUpdateController.weightTypeDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateController.selectedPerGramCalcuationType(value);
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
            controller: _singleTagUpdateController.minPerGramRateController,
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
            controller: _singleTagUpdateController.perGramRateController,
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
        controller: _singleTagUpdateController.minFlatMakingChargeController,
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
        controller: _singleTagUpdateController.flatMakingChargeController,
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
        controller: _singleTagUpdateController.minMakingChargePerGramController,
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
        controller: _singleTagUpdateController.makingChargePerGramController,
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
                selectedValue: _singleTagUpdateController
                    .selectedMakingChargeCalcuationType.value,
                options: _singleTagUpdateController.mcWeightTypeDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateController
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
        controller: _singleTagUpdateController.minFlatWastageController,
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
        controller: _singleTagUpdateController.flatWastageController,
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
                    _singleTagUpdateController.selectedFlatWastageType.value,
                options: _singleTagUpdateController.flatWastageTypeDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateController.selectedFlatWastageType(value);
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
        controller: _singleTagUpdateController.minWastagePercentageController,
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
        controller: _singleTagUpdateController.wastagePercentageController,
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
                    _singleTagUpdateController.selectedWastageCalcuationType.value,
                options: _singleTagUpdateController.weightTypeDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateController.selectedWastageCalcuationType(value);
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
            controller: _singleTagUpdateController.minFixedRateController,
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
            controller: _singleTagUpdateController.fixedRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Max Fixed Rate",
          ),
        ],
      ),
    );
  }

  SizedBox netWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Net Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _singleTagUpdateController.netWeightController,
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

  SizedBox catalogueCoverWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalogue Cover Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _singleTagUpdateController.catalogueCoverWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Catalogue Cover Weight",
          ),
        ],
      ),
    );
  }

  SizedBox reduceWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Reduce Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _singleTagUpdateController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gram",
            onChanged:(value) {
              _singleTagUpdateController.calcNetWeight(
                grossWeight: _singleTagUpdateController.grossWeightController.text,
                reduceWeight: value,
                reduceStone: _singleTagUpdateController.reduceStoneWeight.value,
                reduceDiamond: _singleTagUpdateController.reduceDiamondWeight.value,
              );
            },
          ),
        ],
      ),
    );
  }


   SizedBox grossWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gross Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _singleTagUpdateController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged:(value) {
              _singleTagUpdateController.calcNetWeight(
                grossWeight: value,
                reduceWeight: _singleTagUpdateController.tagDetailsData.value.reduceWeight!.toString(),
                reduceStone: _singleTagUpdateController.reduceStoneWeight.value,
                reduceDiamond: _singleTagUpdateController.reduceDiamondWeight.value,
              );
            },
          ),
        ],
      ),
    );
  }


  
   SizedBox pieces() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pieces"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _singleTagUpdateController.piecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Pieces",
          ),
        ],
      ),
    );
  }

  SizedBox huid() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "HUID"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _singleTagUpdateController.huidController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "HUID",
          ),
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _singleTagUpdateController.remarksController,
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
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Measurement Value"),
          SizedBox(height: 7.h),
          Obx(() => CustomTextInput(
                controller: _singleTagUpdateController.measurementValueController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: "no_validation",
                hintText: _singleTagUpdateController.measurementType.value,
              )),
        ],
      ),
    );
  }

  SizedBox tagType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                isValidate: true,
                controller: _singleTagUpdateController.tagTypeSearchController,
                selectedValue: _singleTagUpdateController.selectedTagType.value,
                options: _singleTagUpdateController.tagTypeDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateController.selectedTagType(value);
                },
                hintText: "Tag Type",
              ))
        ],
      ),
    );
  }

  SizedBox tagNumber() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Number"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
            filled: true,
                controller: _singleTagUpdateController.tagSearchController,
                selectedValue: _singleTagUpdateController.selectedTag.value,
                options: _singleTagUpdateController.tagDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateController.selectedTag(value);
                  _singleTagUpdateController.getTagDetails(context, value!.label);
                },
                hintText: "Tag Number",
              ))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
            filled: true,
                controller: _singleTagUpdateController.branchSearchController,
                selectedValue: _singleTagUpdateController.selectedBranch.value,
                options: _singleTagUpdateController.branchDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateController.selectedBranch(value);
                  _singleTagUpdateController.getTagList(value?.value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
