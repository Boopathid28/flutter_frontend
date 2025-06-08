import 'package:ausales_application/controller/repair_creation/repair_creation_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewRepairDetailsForm extends StatefulWidget {
  const NewRepairDetailsForm({super.key});

  @override
  State<NewRepairDetailsForm> createState() => _NewRepairDetailsFormState();
}

class _NewRepairDetailsFormState extends State<NewRepairDetailsForm> {
  final RepairCreationFormController _repairCreationFormController =
      Get.put(RepairCreationFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _repairCreationFormController.newRepairFormKey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: size.width * 0.98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Repair Details",
                style: TextPalette.tableHeaderTextStyle,
              ),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              Wrap(
                
                spacing: _repairCreationFormController.isBranchuser.value? 20.w:0,
                runSpacing: 10.h,
                children: [branch(), customerGroup()],
              ),
            ],
          ),
        ));
  }

  SizedBox branch() {
    return _repairCreationFormController.isBranchuser.value
        ? SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7.w,
                ),
                Obx(() => CustomDropdownSearchField(
                      controller:
                          _repairCreationFormController.branchSearchController,
                      selectedValue:
                          _repairCreationFormController.selectedBranch.value,
                      options:
                          _repairCreationFormController.branchDropDown.value,
                      onChanged: (value) {
                        _repairCreationFormController.selectedBranch(value);
                      },
                      hintText: "Branch",
                    ))
              ],
            ),
          )
        : const SizedBox();
  }

  SizedBox customerGroup() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _repairCreationFormController.customerSearchController,
                selectedValue:
                    _repairCreationFormController.selectedCustomerDetails.value,
                options: _repairCreationFormController.customerDropDown.value,
                onChanged: (value) {
                  _repairCreationFormController.selectedCustomerDetails(value);
                },
                hintText: "Customer",
              ))
        ],
      ),
    );
  }
}
