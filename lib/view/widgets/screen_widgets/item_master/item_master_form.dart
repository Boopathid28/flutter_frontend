import 'package:ausales_application/controller/item_master/item_master_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemMasterForm extends StatefulWidget {
  const ItemMasterForm({super.key});

  @override
  State<ItemMasterForm> createState() => _ItemMasterFormState();
}

class _ItemMasterFormState extends State<ItemMasterForm> {
  final ItemMasterFormController _itemMasterFormController = Get.put(ItemMasterFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Form(
        key: _itemMasterFormController.itemFormKey,
        child: Responsive.isDesktop(context) ? SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10.w,
            children: [
              Itemname(),
              itemcode(),
              Huid(),
              Purity(),
              actions(context)
            ],
          ),
        ) : Responsive.isTablet(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Itemname(),
                SizedBox(
                  height: 10.w,
                ),
                itemcode(),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                Huid(),
                SizedBox(
                  height: 10.w,
                ),
                Purity()
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                actions(context)
              ],
            ),
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Itemname(),
            SizedBox(
              height: 10.w,
            ),
            itemcode(),
            SizedBox(
              height: 10.w,
            ),
            Huid(),
            SizedBox(
              height: 10.w,
            ),
            Purity(),
            SizedBox(
              height: 10.w,
            ),
            actions(context)
          ],
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _itemMasterFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _itemMasterFormController.submitItemForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _itemMasterFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _itemMasterFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox Purity() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purity"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _itemMasterFormController.searchPurityController,
                selectedValue: _itemMasterFormController.selectedPurity.value,
                options: _itemMasterFormController.purityDropDown.value,
                onChanged: (value) {
                  _itemMasterFormController.selectedPurity(value);
                },
                hintText: "Purity",
              ))
        ],
      ),
    );
  }

  SizedBox Itemname() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _itemMasterFormController.itemNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Item Name",
          ),
        ],
      ),
    );
  }

  SizedBox itemcode() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _itemMasterFormController.itemCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Item Code",
          ),
        ],
      ),
    );
  }

  SizedBox Huid() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Huid Charge"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _itemMasterFormController.huidChargeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: "default_double_input",
            hintText: "Huid Charge",
             inputFormat: "double",
          ),
        ],
      ),
    );
  }
}
