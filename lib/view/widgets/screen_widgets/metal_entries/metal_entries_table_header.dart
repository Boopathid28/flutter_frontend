import 'package:ausales_application/controller/metal_entries/metal_entries_list_controller.dart';
import 'package:ausales_application/controller/purity_master/purity_master_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/create_itemtag_branch_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalEntriesTableHeader extends StatefulWidget {
  const MetalEntriesTableHeader({super.key});

  @override
  State<MetalEntriesTableHeader> createState() =>
      _MetalEntriesTableHeaderState();
}

class _MetalEntriesTableHeaderState extends State<MetalEntriesTableHeader> {
  final MetalEntriesListController _metalEntriesListController =
      Get.put(MetalEntriesListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 600.w,
                  child: Row(
                    children: [
                      Obx(() => _metalEntriesListController.isBranchuser.value ? branchFilter(context) : SizedBox()),
                      SizedBox(
                        width: 7.h,
                      ),
                      metalFilter(context),

                    ],
                  ),
                ),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                Obx(() => _metalEntriesListController.isBranchuser.value ? branchFilter(context) : SizedBox()),
                
                SizedBox(
                  height: 7.h,
                ),
                metalFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context),
              ],
            ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _metalEntriesListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _metalEntriesListController.getMetalEntriesList(context);
          }),
    );
  }

  SizedBox metalFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _metalEntriesListController.metalSearchFilterController,
              filled: true,
              selectedValue: _metalEntriesListController.selectedMetal.value,
              options: _metalEntriesListController.metalFilterList.value,
              onChanged: (value) {
                _metalEntriesListController.selectedMetal(value);
                _metalEntriesListController.getMetalEntriesList(context);
              },
              hintText: "Metal",
            )));
  }

  SizedBox branchFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _metalEntriesListController.branchSearchFilterController,
              filled: true,
              selectedValue: _metalEntriesListController.selectedBranch.value,
              options: _metalEntriesListController.branchFilterList.value,
              onChanged: (value) {
                _metalEntriesListController.selectedBranch(value);
                _metalEntriesListController.getMetalEntriesList(context);
              },
              hintText: "Branch",
            )));
  }
}
