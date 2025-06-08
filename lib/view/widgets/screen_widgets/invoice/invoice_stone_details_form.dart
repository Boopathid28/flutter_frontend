import 'package:ausales_application/controller/invoice/invoice_stone_form_controller.dart';
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

class InvoiceStoneDetailsForm extends StatefulWidget {
  const InvoiceStoneDetailsForm({super.key});

  @override
  State<InvoiceStoneDetailsForm> createState() => _InvoiceStoneDetailsFormState();
}

class _InvoiceStoneDetailsFormState extends State<InvoiceStoneDetailsForm> {
  final InvoiceStoneFormController _invoiceStoneFormController =
      Get.put(InvoiceStoneFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _invoiceStoneFormController.invoiceStoneDetailsFormKey,
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
              _invoiceStoneFormController.resetStoneForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _invoiceStoneFormController.stoneFormMode.value,
            onPressed: () {
              _invoiceStoneFormController.submitInvoiceStoneForm(context);
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
            controller: _invoiceStoneFormController.certAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Cert Amount",
            onChanged: (value) {
              _invoiceStoneFormController.calculateTotalAmount();
            },
          ),
        ],
      ),
    );
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
            controller: _invoiceStoneFormController.stoneAmountController,
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
            controller: _invoiceStoneFormController.stoneWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Carat",
            onChanged: (value) {
              _invoiceStoneFormController.calculateTotalAmount();
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
            controller: _invoiceStoneFormController.stonePiecesController,
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
                    _invoiceStoneFormController.selectedReduceWeight.value,
                options: _invoiceStoneFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _invoiceStoneFormController.selectedReduceWeight(value);
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
                controller: _invoiceStoneFormController.stoneSearchController,
                selectedValue: _invoiceStoneFormController.selectedStone.value,
                options: _invoiceStoneFormController.stoneDropDown.value,
                onChanged: (value) {
                  _invoiceStoneFormController.selectedStone(value);

                  for (var i in _invoiceStoneFormController.stoneList) {
                    if (i.id.toString() == value?.value) {
                      _invoiceStoneFormController.selectedReduceWeight(i.reduceWeight ? DropdownModel(value: "1", label: "Yes") : DropdownModel(value: "0", label: "No"));
                      _invoiceStoneFormController.stoneRate(i.rate);
                      _invoiceStoneFormController.certAmountController.text = i.certificateAmount!.toStringAsFixed(2);
                      break;
                    }
                  }
                  _invoiceStoneFormController.calculateTotalAmount();
                },
                hintText: "Stone",
              ))
        ],
      ),
    );
  }
}
