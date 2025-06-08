import 'package:ausales_application/controller/reports/estimation_metal_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationMetalWiseReportHeader extends StatefulWidget {
  const EstimationMetalWiseReportHeader({super.key});

  @override
  State<EstimationMetalWiseReportHeader> createState() =>
      _EstimationMetalWiseReportHeaderState();
}

class _EstimationMetalWiseReportHeaderState
    extends State<EstimationMetalWiseReportHeader> {
  final EstimationMetalWiseReportListController _estimationMetalWiseReportListController =
      Get.put(EstimationMetalWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _estimationMetalWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            metal(context),
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
                      _estimationMetalWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _estimationMetalWiseReportListController.selectedbranch.value,
                  options: _estimationMetalWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _estimationMetalWiseReportListController.selectedbranch(value);
                    _estimationMetalWiseReportListController
                        .getestimationmetalwisereport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox metal(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Metal"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _estimationMetalWiseReportListController.searchMetalController,
                  filled: true,
                  selectedValue:
                      _estimationMetalWiseReportListController.selectedmetal.value,
                  options:
                      _estimationMetalWiseReportListController.metalFilterList.value,
                  onChanged: (value) {
                    _estimationMetalWiseReportListController.selectedmetal(value);
                    _estimationMetalWiseReportListController
                        .getestimationmetalwisereport(context);
                  },
                  hintText: "Metal",
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
                  _estimationMetalWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _estimationMetalWiseReportListController.datarangefilterController.clear();
                _estimationMetalWiseReportListController.getestimationmetalwisereport(context);
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
                  _estimationMetalWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _estimationMetalWiseReportListController.datarangefilterController
                      .clear();
                }
                _estimationMetalWiseReportListController.getestimationmetalwisereport(context);
              }),
        ],
      ),
    );
  }

}
