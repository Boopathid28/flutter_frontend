import 'package:ausales_application/controller/reports/customer_summary_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerSummaryReportHeader extends StatefulWidget {
  const CustomerSummaryReportHeader({super.key});

  @override
  State<CustomerSummaryReportHeader> createState() =>
      _CustomerSummaryReportHeaderState();
}

class _CustomerSummaryReportHeaderState
    extends State<CustomerSummaryReportHeader> {
  final CustomerSummaryReportController _customerSummaryReportController =
      Get.put(CustomerSummaryReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            customer(context),
            entryDateRangeFilter(context),
          ],
        ));
  }


  SizedBox customer(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Customer"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _customerSummaryReportController.searchcustomerController,
                  filled: true,
                  selectedValue:
                      _customerSummaryReportController.selectedCustomer.value,
                  options:
                      _customerSummaryReportController.customerFilterList.value,
                  onChanged: (value) {
                    _customerSummaryReportController.selectedCustomer(value);
                    _customerSummaryReportController
                        .getcustomersummaryreport(context);
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
                  _customerSummaryReportController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _customerSummaryReportController.datarangefilterController.clear();
                _customerSummaryReportController.getcustomersummaryreport(context);
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
                  _customerSummaryReportController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _customerSummaryReportController.datarangefilterController
                      .clear();
                }
                _customerSummaryReportController.getcustomersummaryreport(context);
              }),
        ],
      ),
    );
  }

}
