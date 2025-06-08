import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_stone_form_controller.dart';
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

class StoneDetailsForm extends StatefulWidget {
  const StoneDetailsForm({super.key});

  @override
  State<StoneDetailsForm> createState() => _StoneDetailsFormState();
}

class _StoneDetailsFormState extends State<StoneDetailsForm> {
  final ItemtagStoneFormController _itemtagStoneFormController =
      Get.put(ItemtagStoneFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _itemtagStoneFormController.itemtagStoneDetailsFormKey,
        child: Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: [
            stoneDetails(),
            reduceWeight(),
            stonePieces(),
            stoneWeight(),
            stoneAmount(),
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
              _itemtagStoneFormController.resetStoneForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _itemtagStoneFormController.stoneFormMode.value,
            onPressed: () {
              _itemtagStoneFormController.submitItemtagStoneForm(context);
            })));
  }

  SizedBox stoneAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagStoneFormController.stoneAmountController,
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

  SizedBox stoneWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagStoneFormController.stoneWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Weight",
            onChanged: (value) {
              _itemtagStoneFormController.calculateTotalAmount();
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
          CustomLabel(label: "Pieces"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _itemtagStoneFormController.stonePiecesController,
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
                    _itemtagStoneFormController.selectedReduceWeight.value,
                options: _itemtagStoneFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _itemtagStoneFormController.selectedReduceWeight(value);
                },
                hintText: "Reduce Weight",
              ))
        ],
      ),
    );
  }

  SizedBox stoneDetails() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _itemtagStoneFormController.stoneSearchController,
                selectedValue: _itemtagStoneFormController.selectedStone.value,
                options: _itemtagStoneFormController.stoneDropDown.value,
                onChanged: (value) {
                  _itemtagStoneFormController.selectedStone(value);

                  for (var i in _itemtagStoneFormController.stoneList) {
                    if (i.id.toString() == value?.value) {
                      _itemtagStoneFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _itemtagStoneFormController.stoneRate(i.rate);
                      _itemtagStoneFormController.certRate(i.certificateAmount);
                      break;
                    }
                  }
                  _itemtagStoneFormController.calculateTotalAmount();
                },
                hintText: "Stone",
              ))
        ],
      ),
    );
  }
}
