import 'package:ausales_application/controller/invoice/invoice_diamond_form_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_diamond_form_controller.dart';
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

class ManualInvoiceDiamondDetailsForm extends StatefulWidget {
  const ManualInvoiceDiamondDetailsForm({super.key});

  @override
  State<ManualInvoiceDiamondDetailsForm> createState() => _ManualInvoiceDiamondDetailsFormState();
}

class _ManualInvoiceDiamondDetailsFormState extends State<ManualInvoiceDiamondDetailsForm> {
  final ManualInvoiceDiamondFormController _manualInvoiceDiamondFormController =
      Get.put(ManualInvoiceDiamondFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _manualInvoiceDiamondFormController.manualinvoiceDiamondDetailsFormKey,
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
              _manualInvoiceDiamondFormController.resetManualDiamondForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _manualInvoiceDiamondFormController.diamondFormMode.value,
            onPressed: () {
              _manualInvoiceDiamondFormController.submitManualItemtagStoneForm(context);
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
            controller: _manualInvoiceDiamondFormController.certAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Cert Amount",
            onChanged: (value) {
              _manualInvoiceDiamondFormController.calculateManualTotalAmount();
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
            controller: _manualInvoiceDiamondFormController.diamondAmountController,
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
            controller: _manualInvoiceDiamondFormController.diamondWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _manualInvoiceDiamondFormController.calculateManualTotalAmount();
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
            controller: _manualInvoiceDiamondFormController.diamondPiecesController,
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
                    _manualInvoiceDiamondFormController.selectedReduceWeight.value,
                options: _manualInvoiceDiamondFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _manualInvoiceDiamondFormController.selectedReduceWeight(value);
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
                controller: _manualInvoiceDiamondFormController.diamondSearchController,
                selectedValue: _manualInvoiceDiamondFormController.selectedDiamond.value,
                options: _manualInvoiceDiamondFormController.diamondDropDown.value,
                onChanged: (value) {
                  _manualInvoiceDiamondFormController.selectedDiamond(value);

                  for (var i in _manualInvoiceDiamondFormController.diamondList) {
                    if (i.id.toString() == value?.value) {
                      _manualInvoiceDiamondFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _manualInvoiceDiamondFormController.diamondRate(i.rate);
                      _manualInvoiceDiamondFormController.certAmountController.text = i.certificateAmount!.toStringAsFixed(2);
                      break;
                    }
                  }
                  _manualInvoiceDiamondFormController.calculateManualTotalAmount();
                },
                hintText: "Diamond",
              ))
        ],
      ),
    );
  }
}
