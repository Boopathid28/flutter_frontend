import 'package:ausales_application/controller/purity_master/purity_master_form_controller.dart';
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

class PurityMasterForm extends StatefulWidget {
  const PurityMasterForm({super.key});

  @override
  State<PurityMasterForm> createState() => _PurityMasterFormState();
}

class _PurityMasterFormState extends State<PurityMasterForm> {
  final PurityMasterFormController _purityMasterFormController = Get.put(PurityMasterFormController());

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
        key: _purityMasterFormController.purityFormKey,
        child: Responsive.isDesktop(context) ? SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10.w,
            children: [
              purityName(),
              purityCode(),
              purityPercent(),
              metal(),
              actions(context)
            ],
          ),
        ) : Responsive.isTablet(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                purityName(),
                SizedBox(
                  height: 10.w,
                ),
                metal(),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                purityCode(),
                SizedBox(
                  height: 10.w,
                ),
                actions(context)
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                purityPercent(),
              ],
            ),
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            purityName(),
            SizedBox(
              height: 10.w,
            ),
            purityCode(),
            SizedBox(
              height: 10.w,
            ),
            purityPercent(),
            SizedBox(
              height: 10.w,
            ),
            metal(),
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
                  isLoading: _purityMasterFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _purityMasterFormController.submitPurityForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _purityMasterFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _purityMasterFormController.resetForm();
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
                controller: _purityMasterFormController.searchRoleController,
                selectedValue: _purityMasterFormController.selectedMetal.value,
                options: _purityMasterFormController.metalDropDown.value,
                onChanged: (value) {
                  _purityMasterFormController.selectedMetal(value);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }

  purityPercent() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purity Percent"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _purityMasterFormController.purityPercentController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Purity Percent",
          ),
        ],
      ),
    );
  }

  purityCode() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purity Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _purityMasterFormController.purityCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Purity Code",
          ),
        ],
      ),
    );
  }

  SizedBox purityName() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "PurityName"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _purityMasterFormController.purityNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "PurityName",
          ),
        ],
      ),
    );
  }
}
