import 'package:ausales_application/controller/estimation_history/estimation_history_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationHistoryTableHeader extends StatefulWidget {
  const EstimationHistoryTableHeader({super.key});

  @override
  State<EstimationHistoryTableHeader> createState() =>
      _EstimationHistoryTableHeaderState();
}

class _EstimationHistoryTableHeaderState
    extends State<EstimationHistoryTableHeader> {
  final EstimationHistoryListController _estimationHistoryListController =
      Get.put(EstimationHistoryListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                activeStatusFilter(context),
                Obx(
                  () => _estimationHistoryListController.isBranchuser.value
                      ? branch()
                      : SizedBox(),
                ),
                customer(),
                estimationDateRangeFilter(context),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                activeStatusFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                Obx(
                  () => _estimationHistoryListController.isBranchuser.value
                      ? branch()
                      : SizedBox(),
                ),
                SizedBox(
                  height: 7.h,
                ),
                customer(),
                SizedBox(
                  height: 7.h,
                ),
                estimationDateRangeFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context)
              ],
            ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _estimationHistoryListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _estimationHistoryListController.getEstimationList(context);
          }),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _estimationHistoryListController.branchSearchController,
            selectedValue:
                _estimationHistoryListController.selectedBranch.value,
            options: _estimationHistoryListController.branchDropDown.value,
            onChanged: (value) {
              _estimationHistoryListController.selectedBranch(value);
              _estimationHistoryListController.getEstimationList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox customer() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller:
                _estimationHistoryListController.customerSearchController,
            selectedValue:
                _estimationHistoryListController.selectedCustomer.value,
            options: _estimationHistoryListController.customerDropDown.value,
            onChanged: (value) {
              _estimationHistoryListController.selectedCustomer(value);
              _estimationHistoryListController.getEstimationList(context);
            },
            hintText: "Customer",
          )),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue:
                  _estimationHistoryListController.selectedBillStatus.value,
              options:
                  _estimationHistoryListController.billStatusFilterList.value,
              onChanged: (value) {
                _estimationHistoryListController.selectedBillStatus(value);
                _estimationHistoryListController.getEstimationList(context);
              },
              hintText: "Billing Status",
            )));
  }

  SizedBox estimationDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _estimationHistoryListController
              .estimtaitonEntryDateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _estimationHistoryListController
                .estimtaitonEntryDateFilterController
                .clear();
            _estimationHistoryListController.getEstimationList(context);
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
              var endDate = pickedDate.end.toString().substring(0, 10);
              _estimationHistoryListController
                  .estimtaitonEntryDateFilterController
                  .text = [startDate, endDate].join(" to ");
            } else {
              _estimationHistoryListController
                  .estimtaitonEntryDateFilterController
                  .clear();
            }
            _estimationHistoryListController.getEstimationList(context);
          }),
    );
  }
}
