import 'package:ausales_application/controller/estimation/estimation_stone_form_controller.dart';
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

class EstimationStoneDetailsForm extends StatefulWidget {
  const EstimationStoneDetailsForm({super.key});

  @override
  State<EstimationStoneDetailsForm> createState() => _EstimationStoneDetailsFormState();
}

class _EstimationStoneDetailsFormState extends State<EstimationStoneDetailsForm> {
  final EstimationStoneFormController _estimationStoneFormController =
      Get.put(EstimationStoneFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _estimationStoneFormController.estimationStoneDetailsFormKey,
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
              _estimationStoneFormController.resetStoneForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _estimationStoneFormController.stoneFormMode.value,
            onPressed: () {
              _estimationStoneFormController.submitEstimationStoneForm(context);
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
            controller: _estimationStoneFormController.stoneAmountController,
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
            controller: _estimationStoneFormController.certAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Cert Amount",
            onChanged: (value) {
              _estimationStoneFormController.calculateTotalAmount();
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
            controller: _estimationStoneFormController.stoneWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _estimationStoneFormController.calculateTotalAmount();
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
            controller: _estimationStoneFormController.stonePiecesController,
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
                    _estimationStoneFormController.selectedReduceWeight.value,
                options: _estimationStoneFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _estimationStoneFormController.selectedReduceWeight(value);
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
                controller: _estimationStoneFormController.stoneSearchController,
                selectedValue: _estimationStoneFormController.selectedStone.value,
                options: _estimationStoneFormController.stoneDropDown.value,
                onChanged: (value) {
                  _estimationStoneFormController.selectedStone(value);

                  for (var i in _estimationStoneFormController.stoneList) {
                    if (i.id.toString() == value?.value) {
                      _estimationStoneFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _estimationStoneFormController.stoneRate(i.rate);
                      _estimationStoneFormController.certAmountController.text = i.certificateAmount!.toStringAsFixed(2);
                      break;
                    }
                  }
                  _estimationStoneFormController.calculateTotalAmount();
                },
                hintText: "Stone",
              ))
        ],
      ),
    );
  }
}
