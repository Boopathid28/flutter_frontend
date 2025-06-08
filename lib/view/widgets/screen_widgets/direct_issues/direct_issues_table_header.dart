import 'package:ausales_application/controller/approval_issues/approval_issues_list_controller.dart';
import 'package:ausales_application/controller/direct_issues/direct_issues_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DirectIssuesTableHeader extends StatefulWidget {
  const DirectIssuesTableHeader({super.key});

  @override
  State<DirectIssuesTableHeader> createState() =>
      _DirectIssuesTableHeaderState();
}

class _DirectIssuesTableHeaderState extends State<DirectIssuesTableHeader> {
  final DirectIssuesListController _directIssuesListController =
      Get.put(DirectIssuesListController());

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
          controller: _directIssuesListController.vendorSearchController,
          filled: true,
              selectedValue: _directIssuesListController.selectedVendor.value,
              options: _directIssuesListController.vendorDropDown.value,
              onChanged: (value) {
                _directIssuesListController.selectedVendor(value);
                _directIssuesListController.getdirectissuesList(context);
              },
              hintText: "Vendor Status",
            )));
  }

  SizedBox dateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _directIssuesListController.dateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _directIssuesListController.dateFilterController.clear();
            _directIssuesListController.getdirectissuesList(context);
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
              _directIssuesListController.dateFilterController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _directIssuesListController.dateFilterController.clear();
            }
            _directIssuesListController.getdirectissuesList(context);
          }),
    );
  }
}
