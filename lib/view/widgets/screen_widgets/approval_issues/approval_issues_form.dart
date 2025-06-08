import 'package:ausales_application/controller/approval_issues/approval_issues_form_controller.dart';
import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/approval_issues/tag_details/tag_details_form_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/approval_issues/tag_details/tag_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApprovalIssuesForm extends StatefulWidget {
  const ApprovalIssuesForm({super.key});

  @override
  State<ApprovalIssuesForm> createState() => _ApprovalIssuesFormState();
}

class _ApprovalIssuesFormState extends State<ApprovalIssuesForm> {
  final ApprovalIssuesFormController _approvalIssuesFormController =
      Get.put(ApprovalIssuesFormController());

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
          key: _approvalIssuesFormController.approvalissuesFormKey,
          child: Wrap(
            runSpacing: 10.h,
            spacing: 10.w,
            children: [
              vendor(),
              Obx(() => _approvalIssuesFormController.isBranchuser.value == true
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
                      await Get.dialog(
                          barrierDismissible: false,
                          TagDetailsFormPopup());
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
                  isLoading: _approvalIssuesFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _approvalIssuesFormController
                        .submitApprovalIssuesForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _approvalIssuesFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _approvalIssuesFormController.resetForm();
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
                    _approvalIssuesFormController.searchbranchController,
                selectedValue:
                    _approvalIssuesFormController.selectedBranch.value,
                options: _approvalIssuesFormController.branchDropDown.value,
                onChanged: (value) {
                  _approvalIssuesFormController.selectedBranch(value);
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
            controller: _approvalIssuesFormController.remarkController,
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
                    _approvalIssuesFormController.searchvendorController,
                selectedValue:
                    _approvalIssuesFormController.selectedVendor.value,
                options: _approvalIssuesFormController.vendorDropDown.value,
                onChanged: (value) {
                  _approvalIssuesFormController.selectedVendor(value);
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
                _approvalIssuesFormController.duedateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _approvalIssuesFormController.duedateController.clear();
              }
            },
            controller: _approvalIssuesFormController.duedateController,
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
