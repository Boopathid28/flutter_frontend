import 'dart:math';

import 'package:ausales_application/controller/floor/floor_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FloorTableHeader extends StatefulWidget {
  const FloorTableHeader({super.key});

  @override
  State<FloorTableHeader> createState() => _FloorTableHeaderState();
}

class _FloorTableHeaderState extends State<FloorTableHeader> {
  final FloorListController _floorListController = Get.put(FloorListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          activeStatusFilter(context),
           Obx(() => _floorListController.isBranchuser.value ? branch() : SizedBox(),),
          searchFilter(context)
        ],
      ) : Column(
        children: [
          activeStatusFilter(context),
           SizedBox(height: 7.h,),
           Obx(() => _floorListController.isBranchuser.value ? branch() : SizedBox(),),
          SizedBox(height: 7.h,),
          searchFilter(context)
        ],
      ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
          width: 300.w,
          child: CustomTextInput(
              controller: _floorListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _floorListController.getfloorList(context);
              }),
        );
  }

    SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
        filled: true,
            controller: _floorListController.branchSearchController,
            selectedValue: _floorListController.selectedBranch.value,
            options: _floorListController.branchDropDown.value,
            onChanged: (value) {
              _floorListController.selectedBranch(value);
              _floorListController.getfloorList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _floorListController.selectedActiveStatus.value,
              options: _floorListController.activeStatusFilterList.value,
              onChanged: (value) {
                _floorListController.selectedActiveStatus(value);
                _floorListController.getfloorList(context);
              },
              hintText: "Vendor Status",
            )));
  }
}
