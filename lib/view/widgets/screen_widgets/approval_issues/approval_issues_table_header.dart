import 'package:ausales_application/controller/approval_issues/approval_issues_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApprovalIssuesHeader extends StatefulWidget {
  const ApprovalIssuesHeader({super.key});

  @override
  State<ApprovalIssuesHeader> createState() =>
      _ApprovalIssuesHeaderState();
}

class _ApprovalIssuesHeaderState extends State<ApprovalIssuesHeader> {
  final ApprovalIssuesListController _approvalIssuesListController =
      Get.put(ApprovalIssuesListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child:Wrap(
        spacing: 20.w,
        runSpacing: 15.h,
              children: [
                vendorFilter(context),
                dateRangeFilter(context),
              ],
            )
    );
  }

  SizedBox vendorFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
          controller: _approvalIssuesListController.vendorSearchController,
          filled: true,
              selectedValue: _approvalIssuesListController.selectedVendor.value,
              options: _approvalIssuesListController.vendorDropDown.value,
              onChanged: (value) {
                _approvalIssuesListController.selectedVendor(value);
                _approvalIssuesListController.getapprovalissuesList(context);
              },
              hintText: "Vendor Status",
            )));
  }

  SizedBox dateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _approvalIssuesListController.dateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _approvalIssuesListController.dateFilterController.clear();
            _approvalIssuesListController.getapprovalissuesList(context);
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
              _approvalIssuesListController.dateFilterController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _approvalIssuesListController.dateFilterController.clear();
            }
            _approvalIssuesListController.getapprovalissuesList(context);
          }),
    );
  }
}
