import 'package:ausales_application/controller/single_tag_update/single_tag_udpdate_stone_form_controller.dart';
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

class TagUpdateStoneDetailsForm extends StatefulWidget {
  const TagUpdateStoneDetailsForm({super.key});

  @override
  State<TagUpdateStoneDetailsForm> createState() => _TagUpdateStoneDetailsFormState();
}

class _TagUpdateStoneDetailsFormState extends State<TagUpdateStoneDetailsForm> {
  final SingleTagUdpdateStoneFormController _singleTagUdpdateStoneFormController =
      Get.put(SingleTagUdpdateStoneFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _singleTagUdpdateStoneFormController.singleTagUpdateStoneDetailsFormKey,
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
              _singleTagUdpdateStoneFormController.resetStoneForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _singleTagUdpdateStoneFormController.stoneFormMode.value,
            onPressed: () {
              _singleTagUdpdateStoneFormController.submitUpdatetagStoneForm(context);
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
            controller: _singleTagUdpdateStoneFormController.stoneAmountController,
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
          CustomLabel(label: "Carat"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _singleTagUdpdateStoneFormController.stoneWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _singleTagUdpdateStoneFormController.calculateTotalAmount();
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
            controller: _singleTagUdpdateStoneFormController.stonePiecesController,
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
                    _singleTagUdpdateStoneFormController.selectedReduceWeight.value,
                options: _singleTagUdpdateStoneFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _singleTagUdpdateStoneFormController.selectedReduceWeight(value);
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
                controller: _singleTagUdpdateStoneFormController.stoneSearchController,
                selectedValue: _singleTagUdpdateStoneFormController.selectedStone.value,
                options: _singleTagUdpdateStoneFormController.stoneDropDown.value,
                onChanged: (value) {
                  _singleTagUdpdateStoneFormController.selectedStone(value);

                  for (var i in _singleTagUdpdateStoneFormController.stoneList) {
                    if (i.id.toString() == value?.value) {
                      _singleTagUdpdateStoneFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _singleTagUdpdateStoneFormController.stoneRate(i.rate);
                      _singleTagUdpdateStoneFormController.certRate(i.certificateAmount);
                      break;
                    }
                  }
                  _singleTagUdpdateStoneFormController.calculateTotalAmount();
                },
                hintText: "Stone",
              ))
        ],
      ),
    );
  }
}
