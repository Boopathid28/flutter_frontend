import 'package:ausales_application/controller/reports/metal_wise_repair_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalWiseRepairReportHeader extends StatefulWidget {
  const MetalWiseRepairReportHeader({super.key});

  @override
  State<MetalWiseRepairReportHeader> createState() =>
      _MetalWiseRepairReportHeaderState();
}

class _MetalWiseRepairReportHeaderState
    extends State<MetalWiseRepairReportHeader> {
  final MetalWiseRepairReportListController _metalWiseRepairReportListController =
      Get.put(MetalWiseRepairReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _metalWiseRepairReportListController.isBranchuser.value
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
                      _metalWiseRepairReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _metalWiseRepairReportListController.selectedbranch.value,
                  options: _metalWiseRepairReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _metalWiseRepairReportListController.selectedbranch(value);
                    _metalWiseRepairReportListController
                        .getmetalwiserepairreport(context);
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
                      _metalWiseRepairReportListController.searchMetalController,
                  filled: true,
                  selectedValue:
                      _metalWiseRepairReportListController.selectedmetal.value,
                  options:
                      _metalWiseRepairReportListController.metalFilterList.value,
                  onChanged: (value) {
                    _metalWiseRepairReportListController.selectedmetal(value);
                    _metalWiseRepairReportListController
                        .getmetalwiserepairreport(context);
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
                  _metalWiseRepairReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _metalWiseRepairReportListController.datarangefilterController.clear();
                _metalWiseRepairReportListController.getmetalwiserepairreport(context);
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
                  _metalWiseRepairReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _metalWiseRepairReportListController.datarangefilterController
                      .clear();
                }
                _metalWiseRepairReportListController.getmetalwiserepairreport(context);
              }),
        ],
      ),
    );
  }

}
