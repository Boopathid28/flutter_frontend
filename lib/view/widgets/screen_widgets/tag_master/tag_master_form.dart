import 'package:ausales_application/controller/tag_master/tag_master_form_controller.dart';
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

class TagMasterForm extends StatefulWidget {
  const TagMasterForm({super.key});

  @override
  State<TagMasterForm> createState() => _TagMasterFormState();
}

class _TagMasterFormState extends State<TagMasterForm> {
  final TagMasterFormController _tagMasterFormController = Get.put(TagMasterFormController());

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
        key: _tagMasterFormController.tagFormKey,
        child: Responsive.isDesktop(context) ? SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10.w,
            children: [
              tagName(),
              tagCode(),
              metal(),
              actions(context)
            ],
          ),
        ) : Responsive.isTablet(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                tagName(),
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
                tagCode(),
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
              ],
            ),
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tagName(),
            SizedBox(
              height: 10.w,
            ),
            tagCode(),
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
                  isLoading: _tagMasterFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _tagMasterFormController.submitTagForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _tagMasterFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _tagMasterFormController.resetForm();
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
                controller: _tagMasterFormController.searchRoleController,
                selectedValue: _tagMasterFormController.selectedMetal.value,
                options: _tagMasterFormController.metalDropDown.value,
                onChanged: (value) {
                  _tagMasterFormController.selectedMetal(value);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }

  tagCode() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _tagMasterFormController.tagCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Tag Code",
          ),
        ],
      ),
    );
  }

  SizedBox tagName() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _tagMasterFormController.tagNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Tag Name",
          ),
        ],
      ),
    );
  }
}
