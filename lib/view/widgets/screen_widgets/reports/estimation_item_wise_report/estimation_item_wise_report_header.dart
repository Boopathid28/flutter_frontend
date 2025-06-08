import 'package:ausales_application/controller/reports/estimation_item_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationItemWiseReportHeader extends StatefulWidget {
  const EstimationItemWiseReportHeader({super.key});

  @override
  State<EstimationItemWiseReportHeader> createState() =>
      _EstimationItemWiseReportHeaderState();
}

class _EstimationItemWiseReportHeaderState
    extends State<EstimationItemWiseReportHeader> {
  final EstimationItemWiseReportListController _estimationItemWiseReportListController =
      Get.put(EstimationItemWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _estimationItemWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            item(context),
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
                      _estimationItemWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _estimationItemWiseReportListController.selectedbranch.value,
                  options: _estimationItemWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _estimationItemWiseReportListController.selectedbranch(value);
                    _estimationItemWiseReportListController
                        .getestimationitemwisereport(context);
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
                      _estimationItemWiseReportListController.searchitemController,
                  filled: true,
                  selectedValue:
                      _estimationItemWiseReportListController.selecteditem.value,
                  options:
                      _estimationItemWiseReportListController.itemFilterList.value,
                  onChanged: (value) {
                    _estimationItemWiseReportListController.selecteditem(value);
                    _estimationItemWiseReportListController
                        .getestimationitemwisereport(context);
                  },
                  hintText: "Customer",
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
                  _estimationItemWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _estimationItemWiseReportListController.datarangefilterController.clear();
                _estimationItemWiseReportListController.getestimationitemwisereport(context);
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
                  _estimationItemWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _estimationItemWiseReportListController.datarangefilterController
                      .clear();
                }
                _estimationItemWiseReportListController.getestimationitemwisereport(context);
              }),
        ],
      ),
    );
  }

}
