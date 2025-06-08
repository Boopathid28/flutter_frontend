import 'package:ausales_application/controller/order/stone_diamond_form_controller.dart/order_diamond_form_controller.dart';
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
  final OrderDiamondFormController _orderDiamondFormController =
      Get.put(OrderDiamondFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _orderDiamondFormController.orderDiamondDetailsFormKey,
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
              _orderDiamondFormController.resetDiamondForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _orderDiamondFormController.diamondFormMode.value,
            onPressed: () {
              _orderDiamondFormController.submitOrderDiamondForm(context);
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
            controller: _orderDiamondFormController.diamondAmountController,
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
            controller: _orderDiamondFormController.diamondWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _orderDiamondFormController.calculateTotalAmount();
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
            controller: _orderDiamondFormController.diamondPiecesController,
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
                    _orderDiamondFormController.selectedReduceWeight.value,
                options: _orderDiamondFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _orderDiamondFormController.selectedReduceWeight(value);
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
                controller: _orderDiamondFormController.diamondSearchController,
                selectedValue: _orderDiamondFormController.selectedDiamond.value,
                options: _orderDiamondFormController.diamondDropDown.value,
                onChanged: (value) {
                  _orderDiamondFormController.selectedDiamond(value);

                  for (var i in _orderDiamondFormController.diamondList) {
                    if (i.id.toString() == value?.value) {
                      _orderDiamondFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _orderDiamondFormController.diamondRate(i.rate);
                      _orderDiamondFormController.certRate(i.certificateAmount);
                      break;
                    }
                  }
                  _orderDiamondFormController.calculateTotalAmount();
                },
                hintText: "Diamond",
              ))
        ],
      ),
    );
  }
}
