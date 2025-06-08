import 'package:ausales_application/controller/repair_creation/repair_creation_table_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RepairCreationTableHeader extends StatefulWidget {
  const RepairCreationTableHeader({super.key});

  @override
  State<RepairCreationTableHeader> createState() => _RepairCreationTableHeaderState();
}

class _RepairCreationTableHeaderState extends State<RepairCreationTableHeader> {
  final RepairCreationTableListController _repairCreationTableListController =
      Get.put(RepairCreationTableListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [  branchFilterDropDown(),customerGroupFilterDropDown()],
            )
          : Column(
              children: [
                
               branchFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                customerGroupFilterDropDown()
              ],
            ),
    );
  }

    SizedBox branchFilterDropDown() {
    return  _repairCreationTableListController.isBranchuser.value? SizedBox(
      width: 300.w,
      child: Obx(
        ()=> CustomDropdownField(
          
          selectedValue: _repairCreationTableListController.selectedBranch.value,
          onChanged: (value) {
            _repairCreationTableListController.selectedBranch(value);
            _repairCreationTableListController.getRepairCreationTableList();
          },
          options: _repairCreationTableListController.branchDropDown.value,
          hintText: 'Select branch',
        ),
      ),
    ):const SizedBox();
  }


   SizedBox customerGroupFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Obx(
        ()=> CustomDropdownField(
          selectedValue: _repairCreationTableListController.selectedCustomer.value,
          onChanged: (value) {
            _repairCreationTableListController.selectedCustomer(value);
            _repairCreationTableListController.getRepairCreationTableList();
          },
          options: _repairCreationTableListController.customerDropDown.value,
          hintText: 'Select customer',
        ),
      ),
    );
  }




}
