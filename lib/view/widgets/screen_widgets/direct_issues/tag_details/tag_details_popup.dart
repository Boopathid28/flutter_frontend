import 'package:ausales_application/controller/approval_issues/aproval_issues_tag_form_controller.dart';
import 'package:ausales_application/controller/direct_issues/direct_issues_tag_form_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DirectTagDetailsPopup extends StatefulWidget {
  const DirectTagDetailsPopup({super.key});

  @override
  State<DirectTagDetailsPopup> createState() =>
      _DirectTagDetailsPopupState();
}

class _DirectTagDetailsPopupState extends State<DirectTagDetailsPopup> {
  final DirectIssuesTagFormController _directIssuesTagFormController =
      Get.put(DirectIssuesTagFormController());

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
                    _directIssuesTagFormController.selectedBranch.value,
                options: _directIssuesTagFormController.branchDropDown.value,
                onChanged: (value) {
                  _directIssuesTagFormController.selectedBranch(value);
                  // _directIssuesTagFormController.getTagnumberList(value!.value);
                },
                hintText: "Branch", controller: _directIssuesTagFormController.branchSearchController,
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
                    _directIssuesTagFormController.selectedTag.value,
                options: _directIssuesTagFormController.tagnumberDropDown.value,
                onChanged: (value) {
                  _directIssuesTagFormController.selectedTag(value);
                  _directIssuesTagFormController.getTagItemList(value!.label, context);
                },
                hintText: "Tag Number", controller: _directIssuesTagFormController.tagSearchController,
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
            isLoading: _directIssuesTagFormController.isTableLoading.value,
            text: "Find",
            onPressed: () {
              _directIssuesTagFormController.getTagItemList(
                  _directIssuesTagFormController.tagnumController.text,
                  context);
            })));
  }
}
