import 'package:ausales_application/controller/reports/vendor_metal_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/vendor_wise_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorMetalWiseSalesReportTableHeader extends StatefulWidget {
  const VendorMetalWiseSalesReportTableHeader({super.key});

  @override
  State<VendorMetalWiseSalesReportTableHeader> createState() => _VendorMetalWiseSalesReportTableHeaderState();
}

class _VendorMetalWiseSalesReportTableHeaderState extends State<VendorMetalWiseSalesReportTableHeader> {
  final VendorMetalWiseSalesReportController _vendorMetalWiseSalesReportController =
      Get.put(VendorMetalWiseSalesReportController());

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
                vendorFilterDropDown(),
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
                vendorFilterDropDown(),
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
    return _vendorMetalWiseSalesReportController.isBranchuser.value
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
                    selectedValue: _vendorMetalWiseSalesReportController.selectedBranch.value,
                    onChanged: (value) {
                      _vendorMetalWiseSalesReportController.selectedBranch(value);
                      _vendorMetalWiseSalesReportController.getVendorMetalWisesalesReport();
                    },
                    options: _vendorMetalWiseSalesReportController.branchDropDown.value,
                    hintText: 'Select branch',
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
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
              selectedValue: _vendorMetalWiseSalesReportController.selectedVendor.value,
              onChanged: (value) {
                _vendorMetalWiseSalesReportController.selectedVendor(value);
                _vendorMetalWiseSalesReportController.getVendorMetalWisesalesReport();
              },
              options: _vendorMetalWiseSalesReportController.vendorDropDown.value,
              hintText: 'Select Vendor',
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
            controller: _vendorMetalWiseSalesReportController.fromDateController,
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
          
                _vendorMetalWiseSalesReportController.fromDateController.text = formattedDate;
                _vendorMetalWiseSalesReportController.getVendorMetalWisesalesReport();
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
            controller: _vendorMetalWiseSalesReportController.toDateController,
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
          
                _vendorMetalWiseSalesReportController.toDateController.text = formattedDate;
                _vendorMetalWiseSalesReportController.getVendorMetalWisesalesReport();
              }
            },
          ),
        ],
      ),
    );
  }
}
