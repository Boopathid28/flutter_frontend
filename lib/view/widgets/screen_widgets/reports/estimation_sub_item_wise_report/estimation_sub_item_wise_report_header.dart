import 'package:ausales_application/controller/reports/estimation_sub_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationSubItemWiseReportHeader extends StatefulWidget {
  const EstimationSubItemWiseReportHeader({super.key});

  @override
  State<EstimationSubItemWiseReportHeader> createState() =>
      _EstimationSubItemWiseReportHeaderState();
}

class _EstimationSubItemWiseReportHeaderState
    extends State<EstimationSubItemWiseReportHeader> {
  final EstimationSubItemWiseReportListController _estimationSubItemWiseReportListController =
      Get.put(EstimationSubItemWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _estimationSubItemWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            item(context),
            subitem(context),
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
                      _estimationSubItemWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _estimationSubItemWiseReportListController.selectedbranch.value,
                  options: _estimationSubItemWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _estimationSubItemWiseReportListController.selectedbranch(value);
                    _estimationSubItemWiseReportListController
                        .getestimationsubitemwisereport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox item(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _estimationSubItemWiseReportListController.searchitemController,
                  filled: true,
                  selectedValue:
                      _estimationSubItemWiseReportListController.selecteditem.value,
                  options:
                      _estimationSubItemWiseReportListController.itemFilterList.value,
                  onChanged: (value) {
                    _estimationSubItemWiseReportListController.selecteditem(value);
                    _estimationSubItemWiseReportListController
                        .getestimationsubitemwisereport(context);
                  },
                  hintText: "Item",
                ),
              ],
            )));
  }

   SizedBox subitem(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Sub Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _estimationSubItemWiseReportListController.searchsubitemController,
                  filled: true,
                  selectedValue:
                      _estimationSubItemWiseReportListController.selectedSubitem.value,
                  options:
                      _estimationSubItemWiseReportListController.subitemFilterList.value,
                  onChanged: (value) {
                    _estimationSubItemWiseReportListController.selectedSubitem(value);
                    _estimationSubItemWiseReportListController
                        .getestimationsubitemwisereport(context);
                  },
                  hintText: "Sub Item",
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
                  _estimationSubItemWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _estimationSubItemWiseReportListController.datarangefilterController.clear();
                _estimationSubItemWiseReportListController.getestimationsubitemwisereport(context);
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
                  _estimationSubItemWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _estimationSubItemWiseReportListController.datarangefilterController
                      .clear();
                }
                _estimationSubItemWiseReportListController.getestimationsubitemwisereport(context);
              }),
        ],
      ),
    );
  }

}
