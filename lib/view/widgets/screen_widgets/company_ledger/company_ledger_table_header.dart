import 'package:ausales_application/controller/company_ledger/company_ledger_list_controller.dart';
import 'package:ausales_application/controller/counter/counter_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
 
class CompanyLedgerTableHeader extends StatefulWidget {
  const CompanyLedgerTableHeader({super.key});
 
  @override
  State<CompanyLedgerTableHeader> createState() =>
      _CompanyLedgerTableHeaderState();
}
 
class _CompanyLedgerTableHeaderState extends State<CompanyLedgerTableHeader> {
  final CompanyLedgerListController _companyLedgerListController =
      Get.put(CompanyLedgerListController());
 
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            cancelledStatusFilter(context),
            entryDateRangeFilter(context),
            expensetype(),
            Obx(
              () => _companyLedgerListController.isBranchuser.value
                  ? branch()
                  : SizedBox(),
            ),
            searchFilter(context)
          ],
        ));
  }
 
  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
            SizedBox(height: 10.h),
          CustomTextInput(
              controller: _companyLedgerListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _companyLedgerListController.getcompanyledgerList(context);
              }),
        ],
      ),
    );
  }
 
  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Branch"),
            SizedBox(height: 10.h),
          CustomDropdownSearchField(
                filled: true,
                controller: _companyLedgerListController.branchSearchController,
                selectedValue: _companyLedgerListController.selectedBranch.value,
                options: _companyLedgerListController.branchDropDown.value,
                onChanged: (value) {
                  _companyLedgerListController.selectedBranch(value);
                  _companyLedgerListController.getcompanyledgerList(context);
                },
                hintText: "Branch",
              ),
        ],
      )),
    );
  }
 
  SizedBox expensetype() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Expense Type"),
            SizedBox(height: 10.h),
          CustomDropdownSearchField(
                filled: true,
                controller: _companyLedgerListController.expenseSearchController,
                selectedValue: _companyLedgerListController.selectedExpensetype.value,
                options: _companyLedgerListController.expensetypeDropDown.value,
                onChanged: (value) {
                  _companyLedgerListController.selectedExpensetype(value);
                  _companyLedgerListController.getcompanyledgerList(context);
                },
                hintText: "Expense type",
              ),
        ],
      )),
    );
  }
 
  SizedBox cancelledStatusFilter(BuildContext context) {
    return SizedBox(
        width: 300.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Cancelled Status"),
            SizedBox(height: 10.h),
            CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _companyLedgerListController.selectedCancelledStatus.value,
                  options:
                      _companyLedgerListController.cancelledStatusFilterList.value,
                  onChanged: (value) {
                    _companyLedgerListController.selectedCancelledStatus(value);
                    _companyLedgerListController.getcompanyledgerList(context);
                  },
                  hintText: "Cancelled Status",
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
                  _companyLedgerListController.companyledgerDateController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _companyLedgerListController.companyledgerDateController
                    .clear();
                _companyLedgerListController.getcompanyledgerList(context);
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
                  _companyLedgerListController.companyledgerDateController
                      .text = [startDate, endDate].join(" to ");
                } else {
                  _companyLedgerListController.companyledgerDateController
                      .clear();
                }
                _companyLedgerListController.getcompanyledgerList(context);
              }),
        ],
      ),
    );
  }
}