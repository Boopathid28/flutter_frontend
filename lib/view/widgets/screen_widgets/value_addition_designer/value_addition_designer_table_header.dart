import 'package:ausales_application/controller/value_addition_designer/value_addition_designer_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionDesignerTableHeader extends StatefulWidget {
  const ValueAdditionDesignerTableHeader({super.key});

  @override
  State<ValueAdditionDesignerTableHeader> createState() =>
      _ValueAdditionDesignerTableHeaderState();
}

class _ValueAdditionDesignerTableHeaderState extends State<ValueAdditionDesignerTableHeader> {
  final ValueAdditionDesignerListController _valueAdditionDesignerListController =
      Get.put(ValueAdditionDesignerListController());

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
                      subitemFilter(context),
                        SizedBox(
                  width: 10.h,
                ),
                      designerFilter(context)
                    ],
                  ),
                ),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                subitemFilter(context),
                 SizedBox(
                  height: 7.h,
                ),
                designerFilter(context),
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
          controller: _valueAdditionDesignerListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _valueAdditionDesignerListController.getValueAdditionDesignerlist(context);
          }),
    );
  }


    SizedBox subitemFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _valueAdditionDesignerListController.subitemSearchFilterController,
              filled: true,
              selectedValue: _valueAdditionDesignerListController.selectedSubitem.value,
              options: _valueAdditionDesignerListController.subitemFilterList.value,
              onChanged: (value) {
                _valueAdditionDesignerListController.selectedSubitem(value);
                _valueAdditionDesignerListController.getValueAdditionDesignerlist(context);
              },
              hintText: "Sub Item Status",
            )));
  }


  SizedBox designerFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _valueAdditionDesignerListController.designerSearchFilterController,
              filled: true,
              selectedValue: _valueAdditionDesignerListController.selectedDesigner.value,
              options: _valueAdditionDesignerListController.designerFilterList.value,
              onChanged: (value) {
                _valueAdditionDesignerListController.selectedDesigner(value);
                _valueAdditionDesignerListController.getValueAdditionDesignerlist(context);
              },
              hintText: "Vendor Status",
            )));
  }
}
