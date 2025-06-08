import 'package:ausales_application/controller/tax_master/tax_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TaxTableHeader extends StatefulWidget {
  const TaxTableHeader({super.key});

  @override
  State<TaxTableHeader> createState() => _TaxTableHeaderState();
}

class _TaxTableHeaderState extends State<TaxTableHeader> {
  final TaxListController _taxListController = Get.put(TaxListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [metalFilter(context), searchFilter(context)],
            )
          : Column(
              children: [
                metalFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context)
              ],
            ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
          width: 300.w,
          child: CustomTextInput(
              controller: _taxListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _taxListController.getTaxList(context);
              }),
        );
  }

  SizedBox metalFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _taxListController.metalSearchController,
              filled: true,
              selectedValue: _taxListController.selectedMetal.value,
              options: _taxListController.metalFilterList.value,
              onChanged: (value) {
                _taxListController.selectedMetal(value);
                _taxListController.getTaxList(context);
              },
              hintText: "Metal",
            )));
  }
}
