import 'package:ausales_application/controller/reports/approval_pending_report_controller.dart';
import 'package:ausales_application/controller/reports/approval_received_report_controller.dart';
import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApprovalReceivedReportHeader extends StatefulWidget {
  const ApprovalReceivedReportHeader({super.key});

  @override
  State<ApprovalReceivedReportHeader> createState() =>
      _ApprovalReceivedReportHeaderState();
}

class _ApprovalReceivedReportHeaderState
    extends State<ApprovalReceivedReportHeader> {
  final ApprovalReceivedReportController _approvalReceivedReportController =
      Get.put(ApprovalReceivedReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _approvalReceivedReportController.isBranchuser.value
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
                      _approvalReceivedReportController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _approvalReceivedReportController.selectedbranch.value,
                  options: _approvalReceivedReportController.branchFilterList.value,
                  onChanged: (value) {
                    _approvalReceivedReportController.selectedbranch(value);
                    _approvalReceivedReportController
                        .getApprovalReceivedreport(context);
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
              controller: _approvalReceivedReportController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _approvalReceivedReportController.getApprovalReceivedreport(context);
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
                  _approvalReceivedReportController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _approvalReceivedReportController.datarangefilterController.clear();
                _approvalReceivedReportController.getApprovalReceivedreport(context);
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
                  _approvalReceivedReportController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _approvalReceivedReportController.datarangefilterController
                      .clear();
                }
                _approvalReceivedReportController.getApprovalReceivedreport(context);
              }),
        ],
      ),
    );
  }

}
