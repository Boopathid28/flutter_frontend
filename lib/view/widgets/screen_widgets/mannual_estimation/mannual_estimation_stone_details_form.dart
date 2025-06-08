import 'package:ausales_application/controller/estimation/estimation_stone_form_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_stone_form_controller.dart';
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

class MannualEstimationStoneDetailsForm extends StatefulWidget {
  const MannualEstimationStoneDetailsForm({super.key});

  @override
  State<MannualEstimationStoneDetailsForm> createState() => _MannualEstimationStoneDetailsFormState();
}

class _MannualEstimationStoneDetailsFormState extends State<MannualEstimationStoneDetailsForm> {
  final MannualEstimationStoneFormController _mannualEstimationStoneFormController =
      Get.put(MannualEstimationStoneFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _mannualEstimationStoneFormController.estimationStoneDetailsFormKey,
        child: Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: [
            stoneDetails(),
            reduceWeight(),
            stonePieces(),
            stoneWeight(),
            certAmount(),
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
              _mannualEstimationStoneFormController.resetStoneForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _mannualEstimationStoneFormController.stoneFormMode.value,
            onPressed: () {
              _mannualEstimationStoneFormController.submitEstimationStoneForm(context);
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
            controller: _mannualEstimationStoneFormController.stoneAmountController,
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

  SizedBox certAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Cert Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _mannualEstimationStoneFormController.certAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Cert Amount",
            onChanged: (value) {
              _mannualEstimationStoneFormController.calculateTotalAmount();
            },
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
            controller: _mannualEstimationStoneFormController.stoneWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _mannualEstimationStoneFormController.calculateTotalAmount();
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
            controller: _mannualEstimationStoneFormController.stonePiecesController,
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
                    _mannualEstimationStoneFormController.selectedReduceWeight.value,
                options: _mannualEstimationStoneFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _mannualEstimationStoneFormController.selectedReduceWeight(value);
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
                controller: _mannualEstimationStoneFormController.stoneSearchController,
                selectedValue: _mannualEstimationStoneFormController.selectedStone.value,
                options: _mannualEstimationStoneFormController.stoneDropDown.value,
                onChanged: (value) {
                  _mannualEstimationStoneFormController.selectedStone(value);

                  for (var i in _mannualEstimationStoneFormController.stoneList) {
                    if (i.id.toString() == value?.value) {
                      _mannualEstimationStoneFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _mannualEstimationStoneFormController.stoneRate(i.rate);
                      _mannualEstimationStoneFormController.certAmountController.text = i.certificateAmount!.toStringAsFixed(2);
                      break;
                    }
                  }
                  _mannualEstimationStoneFormController.calculateTotalAmount();
                },
                hintText: "Stone",
              ))
        ],
      ),
    );
  }
}
