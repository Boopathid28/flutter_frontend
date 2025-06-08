import 'package:ausales_application/controller/reports/vendor_item_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/vendor_subitem_wise_sales_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorItemWiseSalesReportTableHeader extends StatefulWidget {
  const VendorItemWiseSalesReportTableHeader({super.key});

  @override
  State<VendorItemWiseSalesReportTableHeader> createState() => _VendorItemWiseSalesReportTableHeaderState();
}

class _VendorItemWiseSalesReportTableHeaderState extends State<VendorItemWiseSalesReportTableHeader> {

  final VendorItemWiseSalesReportController _vendorItemWiseSalesReportController =
      Get.put(VendorItemWiseSalesReportController());

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
                toDateInput(context),
                searchInput()
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
                toDateInput(context),
                 SizedBox(
                  height: 10.w,
                ),searchInput()
              ],
            ),
    );
  }

  SizedBox branchFilterDropDown() {
    return _vendorItemWiseSalesReportController.isBranchuser.value
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
                    selectedValue: _vendorItemWiseSalesReportController.selectedBranch.value,
                    onChanged: (value) {
                      _vendorItemWiseSalesReportController.selectedBranch(value);
                      _vendorItemWiseSalesReportController.getVendorItemWiseSalesReport();
                    },
                    options: _vendorItemWiseSalesReportController.branchDropDown.value,
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
              selectedValue: _vendorItemWiseSalesReportController.selectedVendor.value,
              onChanged: (value) {
                _vendorItemWiseSalesReportController.selectedVendor(value);
                _vendorItemWiseSalesReportController.getVendorItemWiseSalesReport();
              },
              options: _vendorItemWiseSalesReportController.vendorDropDown.value,
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
            controller: _vendorItemWiseSalesReportController.fromDateController,
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
          
                _vendorItemWiseSalesReportController.fromDateController.text = formattedDate;
                _vendorItemWiseSalesReportController.getVendorItemWiseSalesReport();
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
            controller: _vendorItemWiseSalesReportController.toDateController,
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
          
                _vendorItemWiseSalesReportController.toDateController.text = formattedDate;
                _vendorItemWiseSalesReportController.getVendorItemWiseSalesReport();
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox searchInput() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _vendorItemWiseSalesReportController.searchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validator",
            hintText: "Search",
            onChanged: (value) {
              _vendorItemWiseSalesReportController.getVendorItemWiseSalesReport();
            },
          ),
        ],
      ),
    );
  }
  
}
