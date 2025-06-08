import 'package:ausales_application/controller/reports/vendor_wise_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorWiseTableHeader extends StatefulWidget {
  const VendorWiseTableHeader({super.key});

  @override
  State<VendorWiseTableHeader> createState() => _VendorWiseTableHeaderState();
}

class _VendorWiseTableHeaderState extends State<VendorWiseTableHeader> {
  final VendorWiseReportController _vendorWiseReportController =
      Get.put(VendorWiseReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                branchFilterDropDown(),
                itemFilterDropDown(),
                subitemFilterDropDown(),
                purityFilterDropDown(),
                metalFilterDropDown(),
                fromDateInput(context),
                toDateInput(context)
              ],
            )
          : Column(
              children: [
                branchFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                itemFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                subitemFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                purityFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                metalFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                fromDateInput(context),
                SizedBox(
                  height: 10.w,
                ),
                toDateInput(context)
              ],
            ),
    );
  }

  SizedBox branchFilterDropDown() {
    return _vendorWiseReportController.isBranchuser.value
        ? SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
                Obx(
                  () => CustomDropdownField(
                    selectedValue: _vendorWiseReportController.selectedBranch.value,
                    onChanged: (value) {
                      _vendorWiseReportController.selectedBranch(value);
                      _vendorWiseReportController.getVendorWiseReport();
                    },
                    options: _vendorWiseReportController.branchDropDown.value,
                    hintText: 'Select branch',
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  SizedBox metalFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            () => CustomDropdownField(
              isValidate: false,
              selectedValue: _vendorWiseReportController.selectedMetal.value,
              onChanged: (value) {
                _vendorWiseReportController.selectedMetal(value);
                _vendorWiseReportController.getVendorWiseReport();
              },
              options: _vendorWiseReportController.metalDropDown.value,
              hintText: 'Select Metal',
            ),
          ),
        ],
      ),
    );
  }

  SizedBox vendorFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            () => CustomDropdownField(
              isValidate: false,
              selectedValue: _vendorWiseReportController.selectedVendor.value,
              onChanged: (value) {
                _vendorWiseReportController.selectedVendor(value);
                _vendorWiseReportController.getVendorWiseReport();
              },
              options: _vendorWiseReportController.vendorDropDown.value,
              hintText: 'Select Vendor',
            ),
          ),
        ],
      ),
    );
  }

  SizedBox subitemFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Sub Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            () => CustomDropdownField(
              isValidate: false,
              selectedValue: _vendorWiseReportController.selectedSubItem.value,
              onChanged: (value) {
                _vendorWiseReportController.selectedSubItem(value);
                _vendorWiseReportController.getVendorWiseReport();
              },
              options: _vendorWiseReportController.subItemDropDown.value,
              hintText: 'Select subitem',
            ),
          ),
        ],
      ),
    );
  }

  SizedBox itemFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            () => CustomDropdownField(
              isValidate: false,
              selectedValue: _vendorWiseReportController.selectedItem.value,
              onChanged: (value) {
                _vendorWiseReportController.selectedItem(value);
                _vendorWiseReportController.getSubItemList();
                _vendorWiseReportController.getVendorWiseReport();
              },
              options: _vendorWiseReportController.itemDropDown.value,
              hintText: 'Select item',
            ),
          ),
        ],
      ),
    );
  }

  SizedBox purityFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Purity"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            () => CustomDropdownField(
              isValidate: false,
              selectedValue: _vendorWiseReportController.selectedPurity.value,
              onChanged: (value) {
                _vendorWiseReportController.selectedPurity(value);
                _vendorWiseReportController.getVendorWiseReport();
              },
              options: _vendorWiseReportController.purityDropDown.value,
              hintText: 'Select purity',
            ),
          ),
        ],
      ),
    );
  }

  SizedBox fromDateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "From Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _vendorWiseReportController.fromDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "From Date",
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
          
              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          
                _vendorWiseReportController.fromDateController.text = formattedDate;
                _vendorWiseReportController.getVendorWiseReport();
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox toDateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "To Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _vendorWiseReportController.toDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "To Date",
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
          
              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          
                _vendorWiseReportController.toDateController.text = formattedDate;
                _vendorWiseReportController.getVendorWiseReport();
              }
            },
          ),
        ],
      ),
    );
  }
}
