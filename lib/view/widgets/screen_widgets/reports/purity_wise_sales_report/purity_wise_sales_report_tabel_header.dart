import 'package:ausales_application/controller/reports/metal_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/purity_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/vendor_subitem_wise_sales_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PurityWiseSalesReportTabelHeader extends StatefulWidget {
  const PurityWiseSalesReportTabelHeader({super.key});

  @override
  State<PurityWiseSalesReportTabelHeader> createState() => _PurityWiseSalesReportTabelHeaderState();
}

class _PurityWiseSalesReportTabelHeaderState extends State<PurityWiseSalesReportTabelHeader> {

  final PurityWiseSalesReportController _purityWiseSalesReportController =
      Get.put(PurityWiseSalesReportController());

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
    return _purityWiseSalesReportController.isBranchuser.value
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
                    selectedValue: _purityWiseSalesReportController.selectedBranch.value,
                    onChanged: (value) {
                      _purityWiseSalesReportController.selectedBranch(value);
                      _purityWiseSalesReportController.getPurityWiseSalesReport();
                    },
                    options: _purityWiseSalesReportController.branchDropDown.value,
                    hintText: 'Select branch',
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
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
            controller: _purityWiseSalesReportController.fromDateController,
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
          
                _purityWiseSalesReportController.fromDateController.text = formattedDate;
                _purityWiseSalesReportController.getPurityWiseSalesReport();
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
            controller: _purityWiseSalesReportController.toDateController,
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
          
                _purityWiseSalesReportController.toDateController.text = formattedDate;
                _purityWiseSalesReportController.getPurityWiseSalesReport();
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
            controller: _purityWiseSalesReportController.searchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validator",
            hintText: "Search",
            onChanged: (value) {
              _purityWiseSalesReportController.getPurityWiseSalesReport();
            },
          ),
        ],
      ),
    );
  }
  
}
