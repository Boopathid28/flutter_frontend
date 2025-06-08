import 'package:ausales_application/controller/suspense/suspense_form_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseItemForm extends StatefulWidget {
  const SuspenseItemForm({super.key});

  @override
  State<SuspenseItemForm> createState() => _SuspenseItemFormState();
}

class _SuspenseItemFormState extends State<SuspenseItemForm> {
  final SuspenseItemFormController _suspenseItemFormController =
      Get.put(SuspenseItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _suspenseItemFormController.itemDetailsFormKey,
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  addButton(context),
                  SizedBox(
                    width: 10.w,
                  ),
                  clearButton(context)
                ],
              )
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
              _suspenseItemFormController.resetItemForm(context);
            }));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _suspenseItemFormController.itemdetailsFormMode.value,
            onPressed: () {
              _suspenseItemFormController.submitItemdetailsForm(context);
            })));
  }

  SizedBox totalAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            readOnly: true,
            controller: _suspenseItemFormController.totalAmountController,
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
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _suspenseItemFormController.metalWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Weight",
            onChanged: (value) {
              _suspenseItemFormController.calculateTotalAmount(
                  metalweight:
                      _suspenseItemFormController.metalWeightController.text,
                  metalAmount:
                      _suspenseItemFormController.metalAmountController.text);
            },
          ),
        ],
      ),
    );
  }

  SizedBox metalamount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _suspenseItemFormController.metalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Metal Amount",
            onChanged: (value) {
              _suspenseItemFormController.calculateTotalAmount(
                  metalweight:
                      _suspenseItemFormController.metalWeightController.text,
                  metalAmount:
                      _suspenseItemFormController.metalAmountController.text);
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
                controller: _suspenseItemFormController.subItemSearchController,
                selectedValue: _suspenseItemFormController.selectedSubItem.value,
                options: _suspenseItemFormController.subItemDropDown.value,
                onChanged: (value) {
                  _suspenseItemFormController.selectedSubItem(value);
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
                controller: _suspenseItemFormController.itemSearchController,
                selectedValue: _suspenseItemFormController.selectedItem.value,
                options: _suspenseItemFormController.itemDropDown.value,
                onChanged: (value) {
                  _suspenseItemFormController.selectedItem(value);
                  _suspenseItemFormController.getSubItemList(_suspenseItemFormController.selectedMetal.value?.value, value?.value, null);
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
                controller: _suspenseItemFormController.metalSearchController,
                selectedValue: _suspenseItemFormController.selectedMetal.value,
                options: _suspenseItemFormController.metalDropDown.value,
                onChanged: (value) {
                  _suspenseItemFormController.selectedMetal(value);
                  _suspenseItemFormController.getItemList(value?.value, null);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
