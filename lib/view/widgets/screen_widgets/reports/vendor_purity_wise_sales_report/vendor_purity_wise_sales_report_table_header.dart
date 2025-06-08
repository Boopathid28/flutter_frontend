import 'package:ausales_application/controller/reports/vendor_metal_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/vendor_purity_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/vendor_wise_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorPurityWiseSalesReportTableHeader extends StatefulWidget {
  const VendorPurityWiseSalesReportTableHeader({super.key});

  @override
  State<VendorPurityWiseSalesReportTableHeader> createState() => _VendorPurityWiseSalesReportTableHeaderState();
}

class _VendorPurityWiseSalesReportTableHeaderState extends State<VendorPurityWiseSalesReportTableHeader> {

  final VendorPurityWiseSalesReportController _vendorPurityWiseSalesReportController =
      Get.put(VendorPurityWiseSalesReportController());

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
    return _vendorPurityWiseSalesReportController.isBranchuser.value
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
                    selectedValue: _vendorPurityWiseSalesReportController.selectedBranch.value,
                    onChanged: (value) {
                      _vendorPurityWiseSalesReportController.selectedBranch(value);
                      _vendorPurityWiseSalesReportController.getVendorPurityWisesalesReport();
                    },
                    options: _vendorPurityWiseSalesReportController.branchDropDown.value,
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
              selectedValue: _vendorPurityWiseSalesReportController.selectedVendor.value,
              onChanged: (value) {
                _vendorPurityWiseSalesReportController.selectedVendor(value);
                _vendorPurityWiseSalesReportController.getVendorPurityWisesalesReport();
              },
              options: _vendorPurityWiseSalesReportController.vendorDropDown.value,
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
            controller: _vendorPurityWiseSalesReportController.fromDateController,
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
          
                _vendorPurityWiseSalesReportController.fromDateController.text = formattedDate;
                _vendorPurityWiseSalesReportController.getVendorPurityWisesalesReport();
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
            controller: _vendorPurityWiseSalesReportController.toDateController,
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
          
                _vendorPurityWiseSalesReportController.toDateController.text = formattedDate;
                _vendorPurityWiseSalesReportController.getVendorPurityWisesalesReport();
              }
            },
          ),
        ],
      ),
    );
  }
}
