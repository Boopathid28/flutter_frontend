import 'package:ausales_application/controller/reports/manual_estimation_billing_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManualEstimationBillingReportHeader extends StatefulWidget {
  const ManualEstimationBillingReportHeader({super.key});

  @override
  State<ManualEstimationBillingReportHeader> createState() =>
      _ManualEstimationBillingReportHeaderState();
}

class _ManualEstimationBillingReportHeaderState
    extends State<ManualEstimationBillingReportHeader> {
  final ManualEstimationBillingReportListController _manualEstimationBillingReportListController =
      Get.put(ManualEstimationBillingReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _manualEstimationBillingReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            searchFilter(context),
            entryDateRangeFilter(context),
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
                      _manualEstimationBillingReportListController.branchSearchFilterController,
                  filled: true,
                  selectedValue:
                      _manualEstimationBillingReportListController.selectedBranch.value,
                  options: _manualEstimationBillingReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _manualEstimationBillingReportListController.selectedBranch(value);
                    _manualEstimationBillingReportListController
                        .getManualEstimationBillingReportList(context);
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
              controller: _manualEstimationBillingReportListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _manualEstimationBillingReportListController.getManualEstimationBillingReportList(context);
              }),
        ],
      ),
    );
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
              controller:
                  _manualEstimationBillingReportListController.dateFilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _manualEstimationBillingReportListController.dateFilterController.clear();
                _manualEstimationBillingReportListController.getManualEstimationBillingReportList(context);
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
                  _manualEstimationBillingReportListController.dateFilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _manualEstimationBillingReportListController.dateFilterController
                      .clear();
                }
                _manualEstimationBillingReportListController.getManualEstimationBillingReportList(context);
              }),
        ],
      ),
    );
  }

}
