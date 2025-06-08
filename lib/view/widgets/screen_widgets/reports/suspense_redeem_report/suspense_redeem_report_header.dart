import 'package:ausales_application/controller/reports/suspense_redeem_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseRedeemReportHeader extends StatefulWidget {
  const SuspenseRedeemReportHeader({super.key});

  @override
  State<SuspenseRedeemReportHeader> createState() =>
      _SuspenseRedeemReportHeaderState();
}

class _SuspenseRedeemReportHeaderState
    extends State<SuspenseRedeemReportHeader> {
  final SuspenseRedeemListController _suspenseRedeemListController =
      Get.put(SuspenseRedeemListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _suspenseRedeemListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            customer(context),
            entryDateRangeFilter(context),
            searchFilter(context)
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
                      _suspenseRedeemListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _suspenseRedeemListController.selectedbranch.value,
                  options: _suspenseRedeemListController.branchFilterList.value,
                  onChanged: (value) {
                    _suspenseRedeemListController.selectedbranch(value);
                    _suspenseRedeemListController
                        .getsuspenseredeemreport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
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
                      _suspenseRedeemListController.searchcustomerController,
                  filled: true,
                  selectedValue:
                      _suspenseRedeemListController.selectedcustomer.value,
                  options:
                      _suspenseRedeemListController.customerFilterList.value,
                  onChanged: (value) {
                    _suspenseRedeemListController.selectedcustomer(value);
                    _suspenseRedeemListController
                        .getsuspenseredeemreport(context);
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
                  _suspenseRedeemListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _suspenseRedeemListController.datarangefilterController.clear();
                _suspenseRedeemListController.getsuspenseredeemreport(context);
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
                  _suspenseRedeemListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _suspenseRedeemListController.datarangefilterController
                      .clear();
                }
                _suspenseRedeemListController.getsuspenseredeemreport(context);
              }),
        ],
      ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search Filter"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _suspenseRedeemListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _suspenseRedeemListController.getsuspenseredeemreport(context);
              }),
        ],
      ),
    );
  }
}
