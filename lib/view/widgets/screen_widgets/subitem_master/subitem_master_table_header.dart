import 'package:ausales_application/controller/designer/designer_list_controller.dart';
import 'package:ausales_application/controller/subitem_master/subitem_master_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubitemMasterTableHeader extends StatefulWidget {
  const SubitemMasterTableHeader({super.key});

  @override
  State<SubitemMasterTableHeader> createState() =>
      _SubitemMasterTableHeaderState();
}

class _SubitemMasterTableHeaderState extends State<SubitemMasterTableHeader> {
  final SubitemMasterListController _subitemMasterListController =
      Get.put(SubitemMasterListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 5.w,
              runSpacing: 10.h,
              children: [
                activeStatusFilter(context),
                      metalFilter(context),
                      purityFilter(context),
                      itemFilter(context),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                activeStatusFilter(context),
                SizedBox(
                  width: 7.w,
                ),
                metalFilter(context),
                SizedBox(
                  width: 7.w,
                ),
                purityFilter(context),
                SizedBox(
                  width: 7.w,
                ),
                itemFilter(context),
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
          controller: _subitemMasterListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _subitemMasterListController.getSubItemList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue:
                  _subitemMasterListController.selectedActiveStatus.value,
              options:
                  _subitemMasterListController.activeStatusFilterList.value,
              onChanged: (value) {
                _subitemMasterListController.selectedActiveStatus(value);
                _subitemMasterListController.getSubItemList(context);
              },
              hintText: "Subitem Status",
            )));
  }

  SizedBox metalFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller:
                  _subitemMasterListController.metalSearchFilterController,
              filled: true,
              selectedValue:
                  _subitemMasterListController.selectedMetal.value,
              options:
                  _subitemMasterListController.metalFilterList.value,
              onChanged: (value) {
                _subitemMasterListController.selectedMetal(value);
                _subitemMasterListController.getSubItemList(context);
              },
              hintText: "Metal",
            )));
  }

  SizedBox purityFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller:
                  _subitemMasterListController.puritySearchFilterController,
              filled: true,
              selectedValue:
                  _subitemMasterListController.selectedPurity.value,
              options:
                  _subitemMasterListController.purityFilterList.value,
              onChanged: (value) {
                _subitemMasterListController.selectedPurity(value);
                _subitemMasterListController.getSubItemList(context);
              },
              hintText: "Purity",
            )));
  }

  SizedBox itemFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller:
                  _subitemMasterListController.itemSearchFilterController,
              filled: true,
              selectedValue:
                  _subitemMasterListController.selectedItem.value,
              options:
                  _subitemMasterListController.itemFilterList.value,
              onChanged: (value) {
                _subitemMasterListController.selectedItem(value);
                _subitemMasterListController.getSubItemList(context);
              },
              hintText: "Item",
            )));
  }
}
