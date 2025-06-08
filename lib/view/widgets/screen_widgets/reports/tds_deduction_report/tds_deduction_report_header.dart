import 'package:ausales_application/controller/reports/tds_deduction_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TdsDeductionReportHeader extends StatefulWidget {
  const TdsDeductionReportHeader({super.key});

  @override
  State<TdsDeductionReportHeader> createState() =>
      _TdsDeductionReportHeaderState();
}

class _TdsDeductionReportHeaderState extends State<TdsDeductionReportHeader> {
  final TdsDeductionReportListController _tdsDeductionReportListController =
      Get.put(TdsDeductionReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _tdsDeductionReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            vendor(context),
            entryDateRangeFilter(context),
            searchFilter(context)
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
                      _tdsDeductionReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _tdsDeductionReportListController.selectedbranch.value,
                  options:
                      _tdsDeductionReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _tdsDeductionReportListController.selectedbranch(value);
                    _tdsDeductionReportListController
                        .gettdsdeductionreportList(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox vendor(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "vendor"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _tdsDeductionReportListController.searchvendorController,
                  filled: true,
                  selectedValue:
                      _tdsDeductionReportListController.selectedvendor.value,
                  options:
                      _tdsDeductionReportListController.vendorFilterList.value,
                  onChanged: (value) {
                    _tdsDeductionReportListController.selectedvendor(value);
                    _tdsDeductionReportListController
                        .gettdsdeductionreportList(context);
                  },
                  hintText: "vendor",
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
              controller:
                  _tdsDeductionReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _tdsDeductionReportListController.datarangefilterController
                    .clear();
                _tdsDeductionReportListController
                    .gettdsdeductionreportList(context);
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
                  _tdsDeductionReportListController.datarangefilterController
                      .text = [startDate, endDate].join(" to ");
                } else {
                  _tdsDeductionReportListController.datarangefilterController
                      .clear();
                }
                _tdsDeductionReportListController
                    .gettdsdeductionreportList(context);
              }),
        ],
      ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search Filter"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _tdsDeductionReportListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _tdsDeductionReportListController
                    .gettdsdeductionreportList(context);
              }),
        ],
      ),
    );
  }
}
