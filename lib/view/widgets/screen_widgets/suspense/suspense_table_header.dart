import 'package:ausales_application/controller/suspense/suspense_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseTableHeader extends StatefulWidget {
  const SuspenseTableHeader({super.key});

  @override
  State<SuspenseTableHeader> createState() => _SuspenseTableHeaderState();
}

class _SuspenseTableHeaderState extends State<SuspenseTableHeader> {
  final SuspenseListController _suspenseListController =
      Get.put(SuspenseListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                Obx(() => _suspenseListController.isBranchuser.value ? branch(context) : SizedBox()),
                customer(context),
                entryDateRangeFilter(context),
                cancelledStatusFilter(context),
                redeemStatusFilter(context),
                searchFilter(context),
              ],
            )
          : Column(
              children: [
                customer(context),
                SizedBox(
                  height: 7.h,
                ),
                cancelledStatusFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                redeemStatusFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                entryDateRangeFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context),
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
                  controller: _suspenseListController.searchCustomerController,
                  filled: true,
                  selectedValue: _suspenseListController.selectedCustomer.value,
                  options: _suspenseListController.customerFilterList.value,
                  onChanged: (value) {
                    _suspenseListController.selectedCustomer(value);
                    _suspenseListController.getsuspenseList(context);
                  },
                  hintText: "Customer",
                ),
              ],
            )));
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
                  controller: _suspenseListController.branchSearchController,
                  filled: true,
                  selectedValue: _suspenseListController.selectedBranch.value,
                  options: _suspenseListController.branchDropDown.value,
                  onChanged: (value) {
                    _suspenseListController.selectedBranch(value);
                    _suspenseListController.getsuspenseList(context);
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
              controller: _suspenseListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _suspenseListController.getsuspenseList(context);
              }),
        ],
      ),
    );
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
              controller: _suspenseListController.suspenseDateController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _suspenseListController.suspenseDateController.clear();
                _suspenseListController.getsuspenseList(context);
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
                  _suspenseListController.suspenseDateController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _suspenseListController.suspenseDateController.clear();
                }
                _suspenseListController.getsuspenseList(context);
              }),
        ],
      ),
    );
  }

  SizedBox cancelledStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Cancelled Status"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _suspenseListController.selectedCancelledStatus.value,
                  options:
                      _suspenseListController.cancelledStatusFilterList.value,
                  onChanged: (value) {
                    _suspenseListController.selectedCancelledStatus(value);
                    _suspenseListController.getsuspenseList(context);
                  },
                  hintText: "Cancelled Status",
                ),
              ],
            )));
  }

  SizedBox redeemStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Redeem Status"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _suspenseListController.selectedRedeemStatus.value,
                  options: _suspenseListController.redeemStatusFilterList.value,
                  onChanged: (value) {
                    _suspenseListController.selectedRedeemStatus(value);
                    _suspenseListController.getsuspenseList(context);
                  },
                  hintText: "Redeem Status",
                ),
              ],
            )));
  }
}
