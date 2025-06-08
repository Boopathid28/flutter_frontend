import 'package:ausales_application/controller/direct_issues/direct_issues_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/direct_issues/tag_details/tag_details_form_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DirectIssuesForm extends StatefulWidget {
  const DirectIssuesForm({super.key});

  @override
  State<DirectIssuesForm> createState() => _DirectIssuesFormState();
}

class _DirectIssuesFormState extends State<DirectIssuesForm> {
  final DirectIssuesFormController _directIssuesFormController =
      Get.put(DirectIssuesFormController());

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
          key: _directIssuesFormController.directissuesFormKey,
          child: Wrap(
            runSpacing: 10.h,
            spacing: 10.w,
            children: [
              vendor(),
              Obx(() => _directIssuesFormController.isBranchuser.value == true
                  ? branch()
                  : SizedBox()),
              duedate(),
              remark(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                child: SizedBox(
                  width: 200.w,
                  child: PrimaryButton(
                    isLoading: false,
                    text: "Add Tag Details",
                    onPressed: () async {
                      await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => TagDetailsFormPopup());
                    },
                  ),
                ),
              ),
              actions(context)
            ],
          )),
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
                  isLoading: _directIssuesFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _directIssuesFormController
                        .submitApprovalIssuesForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _directIssuesFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _directIssuesFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _directIssuesFormController.searchbranchController,
                selectedValue:
                    _directIssuesFormController.selectedBranch.value,
                options: _directIssuesFormController.branchDropDown.value,
                onChanged: (value) {
                  _directIssuesFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox remark() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remark"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _directIssuesFormController.remarkController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remark",
          ),
        ],
      ),
    );
  }

  SizedBox vendor() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _directIssuesFormController.searchvendorController,
                selectedValue:
                    _directIssuesFormController.selectedVendor.value,
                options: _directIssuesFormController.vendorDropDown.value,
                onChanged: (value) {
                  _directIssuesFormController.selectedVendor(value);
                },
                hintText: "Vendor",
              ))
        ],
      ),
    );
  }

  SizedBox duedate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Due Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _directIssuesFormController.duedateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _directIssuesFormController.duedateController.clear();
              }
            },
            controller: _directIssuesFormController.duedateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Due Date",
          ),
        ],
      ),
    );
  }
}
