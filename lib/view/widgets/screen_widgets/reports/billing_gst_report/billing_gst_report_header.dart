import 'package:ausales_application/controller/reports/billing_gst_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BillingGstReportHeader extends StatefulWidget {
  const BillingGstReportHeader({super.key});

  @override
  State<BillingGstReportHeader> createState() => _BillingGstReportHeaderState();
}

class _BillingGstReportHeaderState extends State<BillingGstReportHeader> {
  final BillingGstReportController _billingGstReportController =
      Get.put(BillingGstReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _billingGstReportController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            customer(context),
            gstType(context),
            entryDateRangeFilter(context),
            searchFilter(context),
          ],
        ));
  }

  SizedBox branch(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Branch"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _billingGstReportController.branchSearchFilterController,
                  filled: true,
                  selectedValue:
                      _billingGstReportController.selectedBranch.value,
                  options: _billingGstReportController.branchDropDown.value,
                  onChanged: (value) {
                    _billingGstReportController.selectedBranch(value);
                    _billingGstReportController
                        .getBillingGstReportList(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _billingGstReportController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _billingGstReportController.getBillingGstReportList(context);
              }),
        ],
      ),
    );
  }

  SizedBox customer(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Customer"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _billingGstReportController
                      .customerSearchFilterController,
                  filled: true,
                  selectedValue:
                      _billingGstReportController.selectedCustomer.value,
                  options: _billingGstReportController.customerDropDown.value,
                  onChanged: (value) {
                    _billingGstReportController.selectedCustomer(value);
                    _billingGstReportController
                        .getBillingGstReportList(context);
                  },
                  hintText: "Customer",
                ),
              ],
            )));
  }

  SizedBox gstType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "GST Type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _billingGstReportController.selectedGstType.value,
                  options: _billingGstReportController.gstTypeDropDown.value,
                  onChanged: (value) {
                    _billingGstReportController.selectedGstType(value);
                    _billingGstReportController
                        .getBillingGstReportList(context);
                  },
                  hintText: "GST Type",
                ),
              ],
            )));
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Date Filter"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              readOnly: true,
              controller: _billingGstReportController.dateFilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _billingGstReportController.dateFilterController.clear();
                _billingGstReportController.getBillingGstReportList(context);
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
                  var endDate = pickedDate.end
                      .add(Duration(days: 1))
                      .toString()
                      .substring(0, 10);
                  _billingGstReportController.dateFilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _billingGstReportController.dateFilterController.clear();
                }
                _billingGstReportController.getBillingGstReportList(context);
              }),
        ],
      ),
    );
  }
}
