import 'package:ausales_application/controller/designer/designer_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DesignerTableHeader extends StatefulWidget {
  const DesignerTableHeader({super.key});

  @override
  State<DesignerTableHeader> createState() => _DesignerTableHeaderState();
}

class _DesignerTableHeaderState extends State<DesignerTableHeader> {
  final DesignerListController _designerListController =
      Get.put(DesignerListController());

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
                      activeStatusFilter(context),
                    ],
                  ),
                ),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                activeStatusFilter(context),
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
          controller: _designerListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _designerListController.getDesignerlist(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _designerListController.selectedActiveStatus.value,
              options: _designerListController.activeStatusFilterList.value,
              onChanged: (value) {
                _designerListController.selectedActiveStatus(value);
                _designerListController.getDesignerlist(context);
              },
              hintText: "Vendor Status",
            )));
  }
}
