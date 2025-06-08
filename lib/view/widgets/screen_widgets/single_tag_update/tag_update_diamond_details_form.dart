import 'package:ausales_application/controller/single_tag_update/single_tag_update_diamond_form_controller.dart';
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

class TagUpdateDiamondDetailsForm extends StatefulWidget {
  const TagUpdateDiamondDetailsForm({super.key});

  @override
  State<TagUpdateDiamondDetailsForm> createState() => _TagUpdateDiamondDetailsFormState();
}

class _TagUpdateDiamondDetailsFormState extends State<TagUpdateDiamondDetailsForm> {
  final SingleTagUpdateDiamondFormController _singleTagUpdateDiamondFormController =
      Get.put(SingleTagUpdateDiamondFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _singleTagUpdateDiamondFormController.singleTagUpdateDiamondDetailsFormKey,
        child: Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: [
            diamondDetails(),
            reduceWeight(),
            diamondPieces(),
            diamondWeight(),
            diamondAmount(),
            addButton(context),
            clearButton(context)
          ],
        ));
  }

  SizedBox clearButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: SecondaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: "Clear",
            onPressed: () {
              _singleTagUpdateDiamondFormController.resetDiamondForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _singleTagUpdateDiamondFormController.diamondFormMode.value,
            onPressed: () {
              _singleTagUpdateDiamondFormController.submitUpdatetagStoneForm(context);
            })));
  }

  SizedBox diamondAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _singleTagUpdateDiamondFormController.diamondAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Amount",
            readOnly: true,
          ),
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
          CustomLabel(label: "Carat"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _singleTagUpdateDiamondFormController.diamondWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _singleTagUpdateDiamondFormController.calculateTotalAmount();
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
          CustomLabel(label: "Pieces"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _singleTagUpdateDiamondFormController.diamondPiecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Pieces",
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
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _singleTagUpdateDiamondFormController.selectedReduceWeight.value,
                options: _singleTagUpdateDiamondFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateDiamondFormController.selectedReduceWeight(value);
                },
                hintText: "Reduce Weight",
              ))
        ],
      ),
    );
  }

  SizedBox diamondDetails() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _singleTagUpdateDiamondFormController.diamondSearchController,
                selectedValue: _singleTagUpdateDiamondFormController.selectedDiamond.value,
                options: _singleTagUpdateDiamondFormController.diamondDropDown.value,
                onChanged: (value) {
                  _singleTagUpdateDiamondFormController.selectedDiamond(value);

                  for (var i in _singleTagUpdateDiamondFormController.diamondList) {
                    if (i.id.toString() == value?.value) {
                      _singleTagUpdateDiamondFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _singleTagUpdateDiamondFormController.diamondRate(i.rate);
                      _singleTagUpdateDiamondFormController.certRate(i.certificateAmount);
                      break;
                    }
                  }
                  _singleTagUpdateDiamondFormController.calculateTotalAmount();
                },
                hintText: "Diamond",
              ))
        ],
      ),
    );
  }
}
