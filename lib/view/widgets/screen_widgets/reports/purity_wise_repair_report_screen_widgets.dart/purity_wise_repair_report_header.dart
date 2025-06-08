import 'package:ausales_application/controller/reports/order_purity_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purity_wise_purchase_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purity_wise_repair_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurityWiseRepairReportHeader extends StatefulWidget {
  const PurityWiseRepairReportHeader({super.key});

  @override
  State<PurityWiseRepairReportHeader> createState() =>
      _PurityWiseRepairReportHeaderState();
}

class _PurityWiseRepairReportHeaderState
    extends State<PurityWiseRepairReportHeader> {
  final PurityWiseRepairReportListController _purityWiseRepairReportListController =
      Get.put(PurityWiseRepairReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _purityWiseRepairReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            purity(context),
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
                      _purityWiseRepairReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _purityWiseRepairReportListController.selectedbranch.value,
                  options: _purityWiseRepairReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _purityWiseRepairReportListController.selectedbranch(value);
                    _purityWiseRepairReportListController
                        .getpuritywiserepairreport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox purity(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Purity"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _purityWiseRepairReportListController.searchpurityController,
                  filled: true,
                  selectedValue:
                      _purityWiseRepairReportListController.selectedpurity.value,
                  options:
                      _purityWiseRepairReportListController.purityFilterList.value,
                  onChanged: (value) {
                    _purityWiseRepairReportListController.selectedpurity(value);
                    _purityWiseRepairReportListController
                        .getpuritywiserepairreport(context);
                  },
                  hintText: "Purity",
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
                  _purityWiseRepairReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _purityWiseRepairReportListController.datarangefilterController.clear();
                _purityWiseRepairReportListController.getpuritywiserepairreport(context);
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
                  _purityWiseRepairReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _purityWiseRepairReportListController.datarangefilterController
                      .clear();
                }
                _purityWiseRepairReportListController.getpuritywiserepairreport(context);
              }),
        ],
      ),
    );
  }

}
