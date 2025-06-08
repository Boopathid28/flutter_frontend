import 'package:ausales_application/controller/old_metal_rate/old_metal_rate_form_controller.dart';
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

class OldMetalRateForm extends StatefulWidget {
  const OldMetalRateForm({super.key});

  @override
  State<OldMetalRateForm> createState() => _OldMetalRateFormState();
}

class _OldMetalRateFormState extends State<OldMetalRateForm> {
  final OldMetalRateFormController _oldMetalRateFormController =
      Get.put(OldMetalRateFormController());

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
        key: _oldMetalRateFormController.oldMetalRateFormKey,
        child: Responsive.isDesktop(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  metalRate(),
                  SizedBox(
                    width: 10.w,
                  ),
                  metal(),
                  SizedBox(
                    width: 10.w,
                  ),
                  actions(context)
                ],
              )
            : Responsive.isTablet(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          metalRate(),
                          SizedBox(
                            height: 10.h,
                          ),
                          metal(),
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        children: [actions(context)],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      metalRate(),
                      SizedBox(
                        height: 10.w,
                      ),
                      metal(),
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
                  isLoading: _oldMetalRateFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _oldMetalRateFormController.submitOldMetalrateForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _oldMetalRateFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _oldMetalRateFormController.resetForm();
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
          Obx(() => CustomDropdownSearchField(
                controller: _oldMetalRateFormController.searchMetalController,
                selectedValue: _oldMetalRateFormController.selectedMetal.value,
                options: _oldMetalRateFormController.oldMetalDropDown.value,
                onChanged: (value) {
                  _oldMetalRateFormController.selectedMetal(value);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }

  SizedBox metalRate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Rate"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _oldMetalRateFormController.oldMetalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Metal Rate",
          ),
        ],
      ),
    );
  }
}
