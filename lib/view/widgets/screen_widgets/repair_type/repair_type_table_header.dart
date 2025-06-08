import 'package:ausales_application/controller/repair_type/repair_type_controller.dart';
import 'package:ausales_application/controller/subitem_master/subitem_master_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RepairTypeTableHeader extends StatefulWidget {
  const RepairTypeTableHeader({super.key});

  @override
  State<RepairTypeTableHeader> createState() => _RepairTypeTableHeaderState();
}

class _RepairTypeTableHeaderState extends State<RepairTypeTableHeader> {
  final RepairTypeController _repairTypeController =
      Get.put(RepairTypeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [activeStatusFilter(), searchFilter(context)],
            )
          : Column(
              children: [
                activeStatusFilter(),
                SizedBox(
                  height: 10.w,
                ),
                searchFilter(context),
              ],
            ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child:  CustomTextInput(
            controller: _repairTypeController.searchController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            filled: true,
            prefixIcon: Icons.search,
            hasPrefixIcon: true,
            hintText: "Search",
            onChanged: (value) {
              _repairTypeController.getAllRepairTypes();
            }),
      
    );
  }

  SizedBox activeStatusFilter() {
    return SizedBox(
      width: 300.w,
      child: Obx(
        ()=> CustomDropdownField(
          selectedValue: _repairTypeController.selectedActiveStatus.value,
          onChanged: (value) {
            _repairTypeController.selectedActiveStatus(value);
            _repairTypeController.getAllRepairTypes();
          },
          options: _repairTypeController.activeStatusFilterList,
          hintText: '',
        ),
      ),
    );
  }
}
