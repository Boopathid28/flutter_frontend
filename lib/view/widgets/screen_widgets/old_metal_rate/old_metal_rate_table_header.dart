
import 'package:ausales_application/controller/old_metal_rate/old_metal_rate_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldMetalRateTableHeader extends StatefulWidget {
  const OldMetalRateTableHeader({super.key});

  @override
  State<OldMetalRateTableHeader> createState() => _OldMetalRateTableHeaderState();
}

class _OldMetalRateTableHeaderState extends State<OldMetalRateTableHeader> {
  final OldMetalRateListController _oldMetalRateListController = Get.put(OldMetalRateListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          oldMetalFilter(),
          //  Obx(() => _oldMetalRateListController.isBranchuser.value ? branch() : SizedBox(),),
          // searchFilter(context)
        ],
      ) : Column(
        children: [
          metalTypeFilter(context),
           SizedBox(height: 7.h,),
          //  Obx(() => _oldMetalRateListController.isBranchuser.value ? branch() : SizedBox(),),
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
              controller: _oldMetalRateListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _oldMetalRateListController.getOldMetalRateList(context);
              }),
        );
  }

    SizedBox oldMetalFilter() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
        filled: true,
            controller: _oldMetalRateListController.searchMetalController,
            selectedValue: _oldMetalRateListController.selectedMetalTypeFilter.value,
            options: _oldMetalRateListController.oldMetalDropDown,
            onChanged: (value) {
              _oldMetalRateListController.selectedMetalTypeFilter(value);
              _oldMetalRateListController.getOldMetalRateList(context);
            },
            hintText: "Metal",
          )),
    );
  }

  SizedBox metalTypeFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _oldMetalRateListController.selectedMetalTypeFilter.value,
              options: _oldMetalRateListController.oldMetalDropDown,
              onChanged: (value) {
                _oldMetalRateListController.selectedMetalTypeFilter(value);
                _oldMetalRateListController.getOldMetalRateList(context);
              },
              hintText: "Vendor Status",
            )));
  }
}
