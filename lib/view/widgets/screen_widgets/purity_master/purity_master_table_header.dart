import 'package:ausales_application/controller/purity_master/purity_master_list_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurityMasterTableHeader extends StatefulWidget {
  const PurityMasterTableHeader({super.key});

  @override
  State<PurityMasterTableHeader> createState() =>
      _PurityMasterTableHeaderState();
}

class _PurityMasterTableHeaderState extends State<PurityMasterTableHeader> {
  final PurityMasterListController _purityMasterListController =
      Get.put(PurityMasterListController());

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
          controller: _purityMasterListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _purityMasterListController.getPurityMasterList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _purityMasterListController.selectedActiveStatus.value,
              options: _purityMasterListController.activeStatusFilterList.value,
              onChanged: (value) {
                _purityMasterListController.selectedActiveStatus(value);
                _purityMasterListController.getPurityMasterList(context);
              },
              hintText: "Purity Status",
            )));
  }

  SizedBox metalFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _purityMasterListController.metalSearchFilterController,
              filled: true,
              selectedValue: _purityMasterListController.selectedMetal.value,
              options: _purityMasterListController.metalFilterList.value,
              onChanged: (value) {
                _purityMasterListController.selectedMetal(value);
                _purityMasterListController.getPurityMasterList(context);
              },
              hintText: "Vendor Status",
            )));
  }
}
