import 'dart:math';

import 'package:ausales_application/controller/advance/advance_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvanceTableHeader extends StatefulWidget {
  const AdvanceTableHeader({super.key});

  @override
  State<AdvanceTableHeader> createState() => _AdvanceTableHeaderState();
}

class _AdvanceTableHeaderState extends State<AdvanceTableHeader> {
  final AdvanceListController _advanceListController =
      Get.put(AdvanceListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            cancelledStatusFilter(context),
            redeemStatusFilter(context),
            customer(),
            advancepurpose(),
            Obx(
              () => _advanceListController.isBranchuser.value
                  ? branch()
                  : SizedBox(),
            ),
            searchFilter(context)
          ],
        ));
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomLabelFilter(label: "Search"),
              SizedBox(height: 10.h),
          CustomTextInput(
              controller: _advanceListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _advanceListController.getAdvanceList(context);
              }),
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
     width: 200.w,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Branch"),
              SizedBox(height: 10.h),
              CustomDropdownSearchField(
                filled: true,
                controller: _advanceListController.branchSearchController,
                selectedValue: _advanceListController.selectedBranch.value,
                options: _advanceListController.branchDropDown.value,
                onChanged: (value) {
                  _advanceListController.selectedBranch(value);
                  _advanceListController.getAdvanceList(context);
                },
                hintText: "Branch",
              ),
            ],
          )),
    );
  }

  SizedBox customer() {
    return SizedBox(
     width: 200.w,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Customer"),
              SizedBox(height: 10.h),
              CustomDropdownSearchField(
                filled: true,
                controller: _advanceListController.customerSearchController,
                selectedValue: _advanceListController.selectedcustomer.value,
                options: _advanceListController.customerDropDown.value,
                onChanged: (value) {
                  _advanceListController.selectedcustomer(value);
                  _advanceListController.getAdvanceList(context);
                },
                hintText: "Customer",
              ),
            ],
          )),
    );
  }

  SizedBox advancepurpose() {
    return SizedBox(
     width: 200.w,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Advance Purpose"),
              SizedBox(height: 10.h),
              CustomDropdownSearchField(
                filled: true,
                controller:
                    _advanceListController.advancepurposeSearchController,
                selectedValue: _advanceListController.selectedadvance.value,
                options: _advanceListController.advanceDropDown.value,
                onChanged: (value) {
                  _advanceListController.selectedadvance(value);
                  _advanceListController.getAdvanceList(context);
                },
                hintText: "Advance Purpose",
              ),
            ],
          )),
    );
  }

  SizedBox cancelledStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Cancel Status"),
                SizedBox(height: 10.h),
                CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _advanceListController.selectedCancelStatus.value,
                  options: _advanceListController.cancelStatusFilterList.value,
                  onChanged: (value) {
                    _advanceListController.selectedCancelStatus(value);
                    _advanceListController.getAdvanceList(context);
                  },
                  hintText: "Cancelled Status",
                ),
              ],
            )));
  }

  SizedBox redeemStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Redeem Status"),
                SizedBox(height: 10.h),
                CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _advanceListController.selectedRedeemStatus.value,
                  options: _advanceListController.redeemStatusList.value,
                  onChanged: (value) {
                    _advanceListController.selectedRedeemStatus(value);
                    _advanceListController.getAdvanceList(context);
                  },
                  hintText: "Cancelled Status",
                ),
              ],
            )));
  }
}
