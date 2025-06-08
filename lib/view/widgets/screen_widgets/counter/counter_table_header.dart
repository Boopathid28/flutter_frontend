import 'dart:math';

import 'package:ausales_application/controller/counter/counter_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CounterTableHeader extends StatefulWidget {
  const CounterTableHeader({super.key});

  @override
  State<CounterTableHeader> createState() => _CounterTableHeaderState();
}

class _CounterTableHeaderState extends State<CounterTableHeader> {
  final CounterListController _counterListController = Get.put(CounterListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          activeStatusFilter(context),
           Obx(() => _counterListController.isBranchuser.value ? branch() : SizedBox(),),
          searchFilter(context)
        ],
      ) : Column(
        children: [
          activeStatusFilter(context),
           SizedBox(height: 7.h,),
           Obx(() => _counterListController.isBranchuser.value ? branch() : SizedBox(),),
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
              controller: _counterListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _counterListController.getcounterList(context);
              }),
        );
  }

    SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
        filled: true,
            controller: _counterListController.branchSearchController,
            selectedValue: _counterListController.selectedBranch.value,
            options: _counterListController.branchDropDown.value,
            onChanged: (value) {
              _counterListController.selectedBranch(value);
              _counterListController.getcounterList(context);
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
              selectedValue: _counterListController.selectedActiveStatus.value,
              options: _counterListController.activeStatusFilterList.value,
              onChanged: (value) {
                _counterListController.selectedActiveStatus(value);
                _counterListController.getcounterList(context);
              },
              hintText: "Vendor Status",
            )));
  }
}
