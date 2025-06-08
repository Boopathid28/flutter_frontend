import 'package:ausales_application/controller/reports/estimation_vendor_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_vendor_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationVendorWiseReportHeader extends StatefulWidget {
  const EstimationVendorWiseReportHeader({super.key});

  @override
  State<EstimationVendorWiseReportHeader> createState() =>
      _EstimationVendorWiseReportHeaderState();
}

class _EstimationVendorWiseReportHeaderState
    extends State<EstimationVendorWiseReportHeader> {
  final EstimationVendorWiseReportListController _estimationVendorWiseReportListController =
      Get.put(EstimationVendorWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _estimationVendorWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            vendor(context),
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
                      _estimationVendorWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _estimationVendorWiseReportListController.selectedbranch.value,
                  options: _estimationVendorWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _estimationVendorWiseReportListController.selectedbranch(value);
                    _estimationVendorWiseReportListController
                        .getestimationvendordesignerwisereport(context);
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
                CustomLabelFilter(label: "Vendor"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _estimationVendorWiseReportListController.searchvendordesignerController,
                  filled: true,
                  selectedValue:
                      _estimationVendorWiseReportListController.selectedvendordesigner.value,
                  options:
                      _estimationVendorWiseReportListController.vendordesignerFilterList.value,
                  onChanged: (value) {
                    _estimationVendorWiseReportListController.selectedvendordesigner(value);
                    _estimationVendorWiseReportListController
                        .getestimationvendordesignerwisereport(context);
                  },
                  hintText: "Vendor",
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
                  _estimationVendorWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _estimationVendorWiseReportListController.datarangefilterController.clear();
                _estimationVendorWiseReportListController.getestimationvendordesignerwisereport(context);
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
                  _estimationVendorWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _estimationVendorWiseReportListController.datarangefilterController
                      .clear();
                }
                _estimationVendorWiseReportListController.getestimationvendordesignerwisereport(context);
              }),
        ],
      ),
    );
  }

}
