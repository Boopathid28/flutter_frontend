import 'package:ausales_application/controller/estimation_history/estimation_history_list_controller.dart';
import 'package:ausales_application/controller/manual_estimation_history/manual_estimation_history_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManualEstimationHistoryTableHeader extends StatefulWidget {
  const ManualEstimationHistoryTableHeader({super.key});

  @override
  State<ManualEstimationHistoryTableHeader> createState() =>
      _ManualEstimationHistoryTableHeaderState();
}

class _ManualEstimationHistoryTableHeaderState
    extends State<ManualEstimationHistoryTableHeader> {
  final ManualEstimationHistoryListController _manualEstimationHistoryListController =
      Get.put(ManualEstimationHistoryListController());

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
                  () => _manualEstimationHistoryListController.isBranchuser.value
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
                  () => _manualEstimationHistoryListController.isBranchuser.value
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
          controller: _manualEstimationHistoryListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _manualEstimationHistoryListController.getEstimationList(context);
          }),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _manualEstimationHistoryListController.branchSearchController,
            selectedValue:
                _manualEstimationHistoryListController.selectedBranch.value,
            options: _manualEstimationHistoryListController.branchDropDown.value,
            onChanged: (value) {
              _manualEstimationHistoryListController.selectedBranch(value);
              _manualEstimationHistoryListController.getEstimationList(context);
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
                _manualEstimationHistoryListController.customerSearchController,
            selectedValue:
                _manualEstimationHistoryListController.selectedCustomer.value,
            options: _manualEstimationHistoryListController.customerDropDown.value,
            onChanged: (value) {
              _manualEstimationHistoryListController.selectedCustomer(value);
              _manualEstimationHistoryListController.getEstimationList(context);
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
                  _manualEstimationHistoryListController.selectedBillStatus.value,
              options:
                  _manualEstimationHistoryListController.billStatusFilterList.value,
              onChanged: (value) {
                _manualEstimationHistoryListController.selectedBillStatus(value);
                _manualEstimationHistoryListController.getEstimationList(context);
              },
              hintText: "Billing Status",
            )));
  }

  SizedBox estimationDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _manualEstimationHistoryListController
              .estimtaitonEntryDateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _manualEstimationHistoryListController
                .estimtaitonEntryDateFilterController
                .clear();
            _manualEstimationHistoryListController.getEstimationList(context);
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
              _manualEstimationHistoryListController
                  .estimtaitonEntryDateFilterController
                  .text = [startDate, endDate].join(" to ");
            } else {
              _manualEstimationHistoryListController
                  .estimtaitonEntryDateFilterController
                  .clear();
            }
            _manualEstimationHistoryListController.getEstimationList(context);
          }),
    );
  }
}
