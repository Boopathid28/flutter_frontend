import 'package:ausales_application/controller/estimation/estimation_diamond_form_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_diamond_form_controller.dart';
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

class MannualEstimationDiamondDetailsForm extends StatefulWidget {
  const MannualEstimationDiamondDetailsForm({super.key});

  @override
  State<MannualEstimationDiamondDetailsForm> createState() => _MannualEstimationDiamondDetailsFormState();
}

class _MannualEstimationDiamondDetailsFormState extends State<MannualEstimationDiamondDetailsForm> {
  final MannualEstimationDiamondFormController _mannualEstimationDiamondFormController =
      Get.put(MannualEstimationDiamondFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _mannualEstimationDiamondFormController.estimationDiamondDetailsFormKey,
        child: Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: [
            diamondDetails(),
            reduceWeight(),
            diamondPieces(),
            diamondWeight(),
            certAmount(),
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
              _mannualEstimationDiamondFormController.resetDiamondForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _mannualEstimationDiamondFormController.diamondFormMode.value,
            onPressed: () {
              _mannualEstimationDiamondFormController.submitItemtagStoneForm(context);
            })));
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
            controller: _mannualEstimationDiamondFormController.certAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Cert Amount",
            onChanged: (value) {
              _mannualEstimationDiamondFormController.calculateTotalAmount();
            },
          ),
        ],
      ),
    );
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
            controller: _mannualEstimationDiamondFormController.diamondAmountController,
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
            controller: _mannualEstimationDiamondFormController.diamondWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _mannualEstimationDiamondFormController.calculateTotalAmount();
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
            controller: _mannualEstimationDiamondFormController.diamondPiecesController,
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
                    _mannualEstimationDiamondFormController.selectedReduceWeight.value,
                options: _mannualEstimationDiamondFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _mannualEstimationDiamondFormController.selectedReduceWeight(value);
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
                controller: _mannualEstimationDiamondFormController.diamondSearchController,
                selectedValue: _mannualEstimationDiamondFormController.selectedDiamond.value,
                options: _mannualEstimationDiamondFormController.diamondDropDown.value,
                onChanged: (value) {
                  _mannualEstimationDiamondFormController.selectedDiamond(value);

                  for (var i in _mannualEstimationDiamondFormController.diamondList) {
                    if (i.id.toString() == value?.value) {
                      _mannualEstimationDiamondFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _mannualEstimationDiamondFormController.diamondRate(i.rate);
                      _mannualEstimationDiamondFormController.certAmountController.text = i.certificateAmount!.toStringAsFixed(2);
                      break;
                    }
                  }
                  _mannualEstimationDiamondFormController.calculateTotalAmount();
                },
                hintText: "Diamond",
              ))
        ],
      ),
    );
  }
}
