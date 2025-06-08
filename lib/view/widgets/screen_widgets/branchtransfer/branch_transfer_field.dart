import 'dart:developer';

import 'package:ausales_application/controller/branchtransfer/branch_transfer_form.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BranchTransferField extends StatefulWidget {
  const BranchTransferField({super.key});

  @override
  State<BranchTransferField> createState() => _BranchTransferFieldState();
}

class _BranchTransferFieldState extends State<BranchTransferField> {
  final BranchTransferFormController _branchTransferFormController =
      Get.put(BranchTransferFormController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(
              () => _branchTransferFormController.isBranchuser.value
                  ? formbranch()
                  : SizedBox(),
            ),
            tobranch(),
            tagnumber(),
          ],
        ),
      ),
    );
  }

  SizedBox formbranch() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Form Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                selectedValue:
                    _branchTransferFormController.selectedFormBranch.value,
                options: _branchTransferFormController.branchDropDown.value,
                onChanged: (value) {
                  _branchTransferFormController.selectedFormBranch(value);
                  _branchTransferFormController.getTagnumberList(value!.value);
                },
                hintText: "Form Branch",
                controller:
                    _branchTransferFormController.frombranchSearchController,
              ))
        ],
      ),
    );
  }

  SizedBox tobranch() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "To Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                selectedValue:
                    _branchTransferFormController.selectedToBranch.value,
                options: _branchTransferFormController.branchDropDown.value,
                onChanged: (value) {
                  _branchTransferFormController.selectedToBranch(value);
                },
                hintText: "To Branch",
                controller:
                    _branchTransferFormController.tobranchSearchController,
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
                selectedValue: _branchTransferFormController.selectedTag.value,
                options: _branchTransferFormController.tagnumberDropDown.value,
                onChanged: (value) {
                  _branchTransferFormController.selectedTag(value);
                  _branchTransferFormController.getTagItemList(
                      value!.label, context);
                },
                hintText: "Tag Number",
                controller: _branchTransferFormController.tagSearchController,
              ))
        ],
      ),
    );
  }
}
