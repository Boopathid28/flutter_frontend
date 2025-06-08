import 'package:ausales_application/controller/reports/billing_gst_report_controller.dart';
import 'package:ausales_application/controller/reports/purchase_item_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseitemReportHeader extends StatefulWidget {
  const PurchaseitemReportHeader({super.key});

  @override
  State<PurchaseitemReportHeader> createState() =>
      _PurchaseitemReportHeaderState();
}

class _PurchaseitemReportHeaderState extends State<PurchaseitemReportHeader> {
  final PurchaseItemReportController _purchaseitemReportController =
      Get.put(PurchaseItemReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _purchaseitemReportController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            itemFilterDropDown(),
            entryDateRangeFilter(context),
            // searchFilter(context),
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
                  controller: _purchaseitemReportController
                      .branchSearchFilterController,
                  filled: true,
                  selectedValue:
                      _purchaseitemReportController.selectedBranch.value,
                  options: _purchaseitemReportController.branchDropDown.value,
                  onChanged: (value) {
                    _purchaseitemReportController.selectedBranch(value);
                    _purchaseitemReportController
                        .getPurchaseItemReportList(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox itemFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
              CustomDropdownField(
                selectedValue: _purchaseitemReportController.selectedItem.value,
                onChanged: (value) {
                  _purchaseitemReportController.selectedItem(value);
                  _purchaseitemReportController
                      .getPurchaseItemReportList(context);
                },
                options: _purchaseitemReportController.itemDropDown.value,
                hintText: 'Select Item',
              ),
            ],
          )),
    );
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
              controller: _purchaseitemReportController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _purchaseitemReportController
                    .getPurchaseItemReportList(context);
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
              controller: _purchaseitemReportController.dateFilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _purchaseitemReportController.dateFilterController.clear();
                _purchaseitemReportController
                    .getPurchaseItemReportList(context);
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
                  _purchaseitemReportController.dateFilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _purchaseitemReportController.dateFilterController.clear();
                }
                _purchaseitemReportController
                    .getPurchaseItemReportList(context);
              }),
        ],
      ),
    );
  }
}
