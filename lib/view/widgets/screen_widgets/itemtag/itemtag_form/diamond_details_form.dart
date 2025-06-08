import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_diamond_form_controller.dart';
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

class DiamondDetailsForm extends StatefulWidget {
  const DiamondDetailsForm({super.key});

  @override
  State<DiamondDetailsForm> createState() => _DiamondDetailsFormState();
}

class _DiamondDetailsFormState extends State<DiamondDetailsForm> {
  final ItemtagDiamondFormController _itemtagDiamondFormController =
      Get.put(ItemtagDiamondFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _itemtagDiamondFormController.itemtagDiamondDetailsFormKey,
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
              _itemtagDiamondFormController.resetDiamondForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _itemtagDiamondFormController.diamondFormMode.value,
            onPressed: () {
              _itemtagDiamondFormController.submitItemtagStoneForm(context);
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
            controller: _itemtagDiamondFormController.diamondAmountController,
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
          CustomLabel(label: "Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _itemtagDiamondFormController.diamondWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Weight",
            onChanged: (value) {
              _itemtagDiamondFormController.calculateTotalAmount();
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
            controller: _itemtagDiamondFormController.diamondPiecesController,
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
                    _itemtagDiamondFormController.selectedReduceWeight.value,
                options: _itemtagDiamondFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _itemtagDiamondFormController.selectedReduceWeight(value);
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
                controller: _itemtagDiamondFormController.diamondSearchController,
                selectedValue: _itemtagDiamondFormController.selectedDiamond.value,
                options: _itemtagDiamondFormController.diamondDropDown.value,
                onChanged: (value) {
                  _itemtagDiamondFormController.selectedDiamond(value);

                  for (var i in _itemtagDiamondFormController.diamondList) {
                    if (i.id.toString() == value?.value) {
                      _itemtagDiamondFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _itemtagDiamondFormController.diamondRate(i.rate);
                      _itemtagDiamondFormController.certRate(i.certificateAmount);
                      break;
                    }
                  }
                  _itemtagDiamondFormController.calculateTotalAmount();
                },
                hintText: "Diamond",
              ))
        ],
      ),
    );
  }
}
