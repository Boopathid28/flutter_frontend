import 'package:ausales_application/controller/metal_entries/metal_entries_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalEntriesForm extends StatefulWidget {
  const MetalEntriesForm({super.key});

  @override
  State<MetalEntriesForm> createState() => _MetalEntriesFormState();
}

class _MetalEntriesFormState extends State<MetalEntriesForm> {
  final MetalEntriesFormController _metalEntriesFormController = Get.put(MetalEntriesFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Form(
        key: _metalEntriesFormController.metalEntriesFormKey,
        child: Wrap(
            spacing: 10.w,
            children: [
              Obx(() => _metalEntriesFormController.isBranchuser.value ? branch() : SizedBox()),
              metal(),
              touch(),
              weight(),
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
                  isLoading: _metalEntriesFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _metalEntriesFormController.submitMetalEntriesForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _metalEntriesFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _metalEntriesFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox metal() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _metalEntriesFormController.selectedMetal.value,
                options: _metalEntriesFormController.metalDropDown.value,
                onChanged: (value) {
                  _metalEntriesFormController.selectedMetal(value);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _metalEntriesFormController.searchBranchController,
                selectedValue: _metalEntriesFormController.selectedBranch.value,
                options: _metalEntriesFormController.branchDropDown.value,
                onChanged: (value) {
                  _metalEntriesFormController.selectedBranch(value);
                },
                hintText: "Branch", 
              ))
        ],
      ),
    );
  }

  SizedBox touch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Touch"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _metalEntriesFormController.touchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Touch",
          ),
        ],
      ),
    );
  }

  SizedBox weight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _metalEntriesFormController.weightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Weight",
          ),
        ],
      ),
    );
  }

}
