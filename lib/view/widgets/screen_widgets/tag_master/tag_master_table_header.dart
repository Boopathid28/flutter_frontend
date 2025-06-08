import 'package:ausales_application/controller/tag_master/tag_master_list_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagMasterTableHeader extends StatefulWidget {
  const TagMasterTableHeader({super.key});

  @override
  State<TagMasterTableHeader> createState() =>
      _TagMasterTableHeaderState();
}

class _TagMasterTableHeaderState extends State<TagMasterTableHeader> {
  final TagMasterListController _tagMasterListController =
      Get.put(TagMasterListController());

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
                      SizedBox(
                        width: 7.h,
                      ),
                      metalFilter(context)
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
          controller: _tagMasterListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _tagMasterListController.getTagMasterList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _tagMasterListController.selectedActiveStatus.value,
              options: _tagMasterListController.activeStatusFilterList.value,
              onChanged: (value) {
                _tagMasterListController.selectedActiveStatus(value);
                _tagMasterListController.getTagMasterList(context);
              },
              hintText: "Purity Status",
            )));
  }

  SizedBox metalFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _tagMasterListController.metalSearchFilterController,
              filled: true,
              selectedValue: _tagMasterListController.selectedMetal.value,
              options: _tagMasterListController.metalFilterList.value,
              onChanged: (value) {
                _tagMasterListController.selectedMetal(value);
                _tagMasterListController.getTagMasterList(context);
              },
              hintText: "Metal",
            )));
  }
}
