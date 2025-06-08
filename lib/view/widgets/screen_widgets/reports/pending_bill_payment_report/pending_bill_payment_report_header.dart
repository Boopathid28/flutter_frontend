import 'package:ausales_application/controller/reports/pending_bill_payment_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PendingBillPaymentReportHeader extends StatefulWidget {
  const PendingBillPaymentReportHeader({super.key});

  @override
  State<PendingBillPaymentReportHeader> createState() => _PendingBillPaymentReportHeaderState();
}

class _PendingBillPaymentReportHeaderState extends State<PendingBillPaymentReportHeader> {
  final PendingBillPaymentReportController _pendingBillPaymentReportController = Get.put(PendingBillPaymentReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          Obx(() => _pendingBillPaymentReportController.isBranchuser.value ? branch(context) : SizedBox()),
          customer(context),
          entryDateRangeFilter(context),
          searchFilter(context),
        ],
      )
    );
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
                  controller: _pendingBillPaymentReportController.branchSearchFilterController,
                  filled: true,
                  selectedValue: _pendingBillPaymentReportController.selectedBranch.value,
                  options: _pendingBillPaymentReportController.branchDropDown.value,
                  onChanged: (value) {
                    _pendingBillPaymentReportController.selectedBranch(value);
                    _pendingBillPaymentReportController.getPendingBillPaymentReportList(context);
                  },
                  hintText: "Branch",
                ),
          ],
        )));
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _pendingBillPaymentReportController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _pendingBillPaymentReportController.getPendingBillPaymentReportList(context);
              }),
        ],
      ),
    );
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
                  controller: _pendingBillPaymentReportController.customerSearchFilterController,
                  filled: true,
                  selectedValue: _pendingBillPaymentReportController.selectedCustomer.value,
                  options: _pendingBillPaymentReportController.customerDropDown.value,
                  onChanged: (value) {
                    _pendingBillPaymentReportController.selectedCustomer(value);
                    _pendingBillPaymentReportController.getPendingBillPaymentReportList(context);
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
              controller: _pendingBillPaymentReportController.dateFilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _pendingBillPaymentReportController.dateFilterController.clear();
                _pendingBillPaymentReportController.getPendingBillPaymentReportList(context);
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
                  _pendingBillPaymentReportController.dateFilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _pendingBillPaymentReportController.dateFilterController.clear();
                }
                _pendingBillPaymentReportController.getPendingBillPaymentReportList(context);
              }),
        ],
      ),
    );
  }
}
