import 'package:ausales_application/controller/item_master/item_master_list_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemMasterTableHeader extends StatefulWidget {
  const ItemMasterTableHeader({super.key});

  @override
  State<ItemMasterTableHeader> createState() => _ItemMasterTableHeaderState();
}

class _ItemMasterTableHeaderState extends State<ItemMasterTableHeader> {
  final ItemMasterListController _itemMasterListController =
      Get.put(ItemMasterListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 700.w,
                  child: Row(
                    children: [
                      activeStatusFilter(context),
                      SizedBox(
                        width: 7.h,
                      ),
                      metalFilter(context),
                      SizedBox(
                        width: 7.h,
                      ),
                      purityFilter(context)
                    ],
                  ),
                ),
                searchFilter(context)
              ],
            )
          : Responsive.isTablet(context)
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        activeStatusFilter(context),
                        SizedBox(
                          width: 7.h,
                        ),
                        metalFilter(context),
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        purityFilter(context),
                        SizedBox(
                          width: 7.h,
                        ),
                        searchFilter(context),
                      ],
                    ),
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
                    purityFilter(context),
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
          controller: _itemMasterListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _itemMasterListController.getItemList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue:
                  _itemMasterListController.selectedActiveStatus.value,
              options: _itemMasterListController.activeStatusFilterList.value,
              onChanged: (value) {
                _itemMasterListController.selectedActiveStatus(value);
                _itemMasterListController.getItemList(context);
              },
              hintText: "Active Status",
            )));
  }

  SizedBox metalFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _itemMasterListController.metalSearchFilterController,
              filled: true,
              selectedValue: _itemMasterListController.selectedMetal.value,
              options: _itemMasterListController.metalFilterList.value,
              onChanged: (value) {
                _itemMasterListController.selectedMetal(value);
                _itemMasterListController.getItemList(context);
              },
              hintText: "Metal",
            )));
  }

  SizedBox purityFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller:
                  _itemMasterListController.puritySearchFilterController,
              filled: true,
              selectedValue: _itemMasterListController.selectedPurity.value,
              options: _itemMasterListController.purityFilterList.value,
              onChanged: (value) {
                _itemMasterListController.selectedPurity(value);
                _itemMasterListController.getItemList(context);
              },
              hintText: "Purity",
            )));
  }
}
