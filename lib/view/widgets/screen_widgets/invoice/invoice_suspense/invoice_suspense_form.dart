import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_suspense_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceSuspenseForm extends StatefulWidget {
  const InvoiceSuspenseForm({super.key});

  @override
  State<InvoiceSuspenseForm> createState() => _InvoiceSuspenseFormState();
}

class _InvoiceSuspenseFormState extends State<InvoiceSuspenseForm> {
  final InvoiceSuspenseFormController _invoiceSuspenseFormController =
      Get.put(InvoiceSuspenseFormController());

  final InvoiceController _invoiceController =
      Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _invoiceSuspenseFormController.itemDetailsFormKey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: size.width * 0.98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Item Details",
                style: TextPalette.tableHeaderTextStyle,
              ),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              Wrap(
                spacing: 20.w,
                runSpacing: 10.h,
                children: [
                  Metal(),
                  itemDetails(),
                  subItemDetails(),
                  metalamount(),
                  metalWeight(),
                  totalAmount(),
                  addButton(context),
                  clearButton(context),
                  remarks(),
                ],
              ),
            ],
          ),
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
              _invoiceSuspenseFormController.resetItemForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _invoiceSuspenseFormController.itemdetailsFormMode.value,
            onPressed: () {
              _invoiceSuspenseFormController.submitItemdetailsForm(context);
            })));
  }

  SizedBox totalAmount() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            readOnly: true,
            controller: _invoiceSuspenseFormController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Total Amount",
          ),
        ],
      ),
    );
  }

  SizedBox metalWeight() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _invoiceSuspenseFormController.metalWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Weight",
            onChanged: (value) {
              _invoiceSuspenseFormController.calculateTotalAmount(
                  metalweight:
                      _invoiceSuspenseFormController.metalWeightController.text,
                  metalAmount:
                      _invoiceSuspenseFormController.metalAmountController.text);
            },
          ),
        ],
      ),
    );
  }

  SizedBox metalamount() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _invoiceSuspenseFormController.metalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Metal Amount",
            onChanged: (value) {
              _invoiceSuspenseFormController.calculateTotalAmount(
                  metalweight:
                      _invoiceSuspenseFormController.metalWeightController.text,
                  metalAmount:
                      _invoiceSuspenseFormController.metalAmountController.text);
            },
          ),
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _invoiceController.suspenseRemarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox subItemDetails() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _invoiceSuspenseFormController.subItemSearchController,
                selectedValue: _invoiceSuspenseFormController.selectedSubItem.value,
                options: _invoiceSuspenseFormController.subItemDropDown.value,
                onChanged: (value) {
                  _invoiceSuspenseFormController.selectedSubItem(value);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }

  SizedBox itemDetails() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _invoiceSuspenseFormController.itemSearchController,
                selectedValue: _invoiceSuspenseFormController.selectedItem.value,
                options: _invoiceSuspenseFormController.itemDropDown.value,
                onChanged: (value) {
                  _invoiceSuspenseFormController.selectedItem(value);
                  _invoiceSuspenseFormController.getSubItemList(_invoiceSuspenseFormController.selectedMetal.value?.value, value?.value, null);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }

  SizedBox Metal() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _invoiceSuspenseFormController.metalSearchController,
                selectedValue: _invoiceSuspenseFormController.selectedMetal.value,
                options: _invoiceSuspenseFormController.metalDropDown.value,
                onChanged: (value) {
                  _invoiceSuspenseFormController.selectedMetal(value);
                  _invoiceSuspenseFormController.getItemList(value?.value, null);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
