import 'package:ausales_application/controller/reports/subitem_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/suspense_pending_report_controller.dart';
import 'package:ausales_application/model/reports/suspense_pending_report_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SuspensePendingReportTableHeader extends StatefulWidget {
  const SuspensePendingReportTableHeader({super.key});

  @override
  State<SuspensePendingReportTableHeader> createState() => _SuspensePendingReportTableHeaderState();
}

class _SuspensePendingReportTableHeaderState extends State<SuspensePendingReportTableHeader> {

  final SuspensePendingReportController _suspensePendingReportController =
      Get.put(SuspensePendingReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                branchFilterDropDown(),
                customerhFilterDropDown(),
                dateRangeFilter(context),
              ],
            )
    );
  }

  SizedBox branchFilterDropDown() {
    return _suspensePendingReportController.isBranchuser.value
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
                  () => CustomDropdownSearchField(
                    filled: true,
                    controller: _suspensePendingReportController.searchBranchController,
                    selectedValue: _suspensePendingReportController.selectedBranch.value,
                    onChanged: (value) {
                      _suspensePendingReportController.selectedBranch(value);
                      _suspensePendingReportController.getSuspensePendingReport();
                    },
                    options: _suspensePendingReportController.branchDropDown.value,
                    hintText: 'Select branch',
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
  

  SizedBox customerhFilterDropDown() {
    return SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Customer"),
          SizedBox(
            height: 7.w,
          ),
                Obx(
                  () => CustomDropdownSearchField(
                    filled: true,
                    controller: _suspensePendingReportController.searchCustomerController,
                    selectedValue: _suspensePendingReportController.selectedCustomer.value,
                    onChanged: (value) {
                      _suspensePendingReportController.selectedCustomer(value);
                      _suspensePendingReportController.getSuspensePendingReport();
                    },
                    options: _suspensePendingReportController.customerDropDown.value,
                    hintText: 'Select customer',
                  ),
                ),
              ],
            ),
          );
  }

  SizedBox dateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _suspensePendingReportController.reportDateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _suspensePendingReportController.reportDateFilterController.clear();
            _suspensePendingReportController.getSuspensePendingReport();
          },
          hintText: "Entry Date Range",
          onTap: () async {
            final today = DateTime.now();
            final endYear = today.year + 1;
            DateTimeRange? pickedDate = await showDateRangePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(endYear),
              builder: (context, child) {
                return Center(
                  child: Container(
                    height: 450.h,
                    width: 400.w,
                    child: child,
                  ),
                );
              },
            );
            if (pickedDate != null) {
              var startDate = pickedDate.start.toString().substring(0, 10);
              var endDate = pickedDate.end.toString().substring(0, 10);
              _suspensePendingReportController.reportDateFilterController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _suspensePendingReportController.reportDateFilterController.clear();
            }
            _suspensePendingReportController.getSuspensePendingReport();
          }),
    );
  }

  
  
}
