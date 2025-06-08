import 'package:ausales_application/controller/lot/lot_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LotItemForm extends StatefulWidget {
  const LotItemForm({super.key});

  @override
  State<LotItemForm> createState() => _LotItemFormState();
}

class _LotItemFormState extends State<LotItemForm> {
  final LotItemFormController _lotItemFormController =
      Get.put(LotItemFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _lotItemFormController.lotItemFormKey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(color: Colors.white),
          width: 300.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lot Item Details",
                style: TextPalette.tableHeaderTextStyle,
              ),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              itemDetails(),
              SizedBox(
                height: 7.h,
              ),
              tagCount(),
              SizedBox(
                height: 7.h,
              ),
              pieces(),
              SizedBox(
                height: 7.h,
              ),
              grossWeight(),
              SizedBox(
                height: 7.h,
              ),
              remarks(),
              SizedBox(
                height: 37.h,
              ),
              actions(context)
            ],
          ),
        ));
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Row(
        children: [
          Obx(() => PrimaryButton(
              btnHeight: 46.h,
              btnWidth: 130.w,
              isLoading: _lotItemFormController.isFormSubmit.value,
              text: "${_lotItemFormController.fromMode.value.capitalize} Item",
              onPressed: () {
                _lotItemFormController.submitLotItemForm(context);
              })),
          SizedBox(
            width: 10.w,
          ),
          SecondaryButton(
              btnHeight: 46.h,
              btnWidth: 130.w,
              isLoading: false,
              text: "Clear",
              onPressed: () {
                _lotItemFormController.resetForm();
              })
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            minLines: 4,
            maxLines: 4,
            controller: _lotItemFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validate",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox grossWeight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gross Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _lotItemFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
          ),
        ],
      ),
    );
  }

  SizedBox pieces() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pieces"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _lotItemFormController.piecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Pieces",
          ),
        ],
      ),
    );
  }

  SizedBox tagCount() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Count"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _lotItemFormController.tagCountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Tag Count",
          ),
        ],
      ),
    );
  }

  SizedBox itemDetails() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _lotItemFormController.itemDetailSearchController,
                selectedValue: _lotItemFormController.selectedItem.value,
                options: _lotItemFormController.itemDropDown.value,
                onChanged: (value) {
                  _lotItemFormController.selectedItem(value);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }
}
