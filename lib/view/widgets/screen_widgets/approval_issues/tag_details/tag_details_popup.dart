import 'package:ausales_application/controller/approval_issues/aproval_issues_tag_form_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagDetailsPopup extends StatefulWidget {
  const TagDetailsPopup({super.key});

  @override
  State<TagDetailsPopup> createState() =>
      _TagDetailsPopupState();
}

class _TagDetailsPopupState extends State<TagDetailsPopup> {
  final AprovalIssuesTagFormController _aprovalIssuesTagFormController =
      Get.put(AprovalIssuesTagFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      child:SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  tagnumber(),
                ],
              ),
            ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                selectedValue:
                    _aprovalIssuesTagFormController.selectedBranch.value,
                options: _aprovalIssuesTagFormController.branchDropDown.value,
                onChanged: (value) {
                  _aprovalIssuesTagFormController.selectedBranch(value);
                  // _aprovalIssuesTagFormController.getTagnumberList(value!.value);
                },
                hintText: "Branch", controller: _aprovalIssuesTagFormController.branchSearchController,
              ))
        ],
      ),
    );
  }

   SizedBox tagnumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Number"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                selectedValue:
                    _aprovalIssuesTagFormController.selectedTag.value,
                options: _aprovalIssuesTagFormController.tagnumberDropDown.value,
                onChanged: (value) {
                  _aprovalIssuesTagFormController.selectedTag(value);
                  _aprovalIssuesTagFormController.getTagItemList(value!.label, context);
                },
                hintText: "Tag Number", controller: _aprovalIssuesTagFormController.tagSearchController,
              ))
        ],
      ),
    );
  }

  SizedBox find(BuildContext context) {
    return SizedBox(
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 115.w
            : double.infinity,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: _aprovalIssuesTagFormController.isTableLoading.value,
            text: "Find",
            onPressed: () {
              _aprovalIssuesTagFormController.getTagItemList(
                  _aprovalIssuesTagFormController.tagnumController.text,
                  context);
            })));
  }
}
