import 'package:ausales_application/controller/stone_master/stone_master_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoneMasterTableHeader extends StatefulWidget {
  const StoneMasterTableHeader({super.key});

  @override
  State<StoneMasterTableHeader> createState() =>
      _StoneMasterTableHeaderState();
}

class _StoneMasterTableHeaderState extends State<StoneMasterTableHeader> {
  final StoneMasterListController _stoneMasterListController =
      Get.put(StoneMasterListController());

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
                      reduceWeightFilter(context)
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
                reduceWeightFilter(context),
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
          controller: _stoneMasterListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _stoneMasterListController.getStoneMasterList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _stoneMasterListController.selectedActiveStatus.value,
              options: _stoneMasterListController.activeStatusFilterList.value,
              onChanged: (value) {
                _stoneMasterListController.selectedActiveStatus(value);
                _stoneMasterListController.getStoneMasterList(context);
              },
              hintText: "Vendor Status",
            )));
  }

  SizedBox reduceWeightFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _stoneMasterListController.selectedReduceWeight.value,
              options: _stoneMasterListController.reduceWeightFilterList.value,
              onChanged: (value) {
                _stoneMasterListController.selectedReduceWeight(value);
                _stoneMasterListController.getStoneMasterList(context);
              },
              hintText: "Reduce Weight",
            )));
  }
}
