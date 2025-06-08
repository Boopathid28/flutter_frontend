import 'package:ausales_application/controller/reports/order_sub_item_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_sub_item_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseSubItemReportHeader extends StatefulWidget {
  const PurchaseSubItemReportHeader({super.key});

  @override
  State<PurchaseSubItemReportHeader> createState() =>
      _PurchaseSubItemWiseReportHeaderState();
}

class _PurchaseSubItemWiseReportHeaderState
    extends State<PurchaseSubItemReportHeader> {
  final PurchaseSubItemReportController _purchaseSubItemReportController =
      Get.put(PurchaseSubItemReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _purchaseSubItemReportController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            item(context),
            subitem(context),
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
                      _purchaseSubItemReportController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _purchaseSubItemReportController.selectedbranch.value,
                  options: _purchaseSubItemReportController.branchFilterList.value,
                  onChanged: (value) {
                    _purchaseSubItemReportController.selectedbranch(value);
                    _purchaseSubItemReportController
                        .getpurchasesubitemwisereport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox item(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _purchaseSubItemReportController.searchitemController,
                  filled: true,
                  selectedValue:
                      _purchaseSubItemReportController.selecteditem.value,
                  options:
                      _purchaseSubItemReportController.itemFilterList.value,
                  onChanged: (value) {
                    _purchaseSubItemReportController.selecteditem(value);
                    _purchaseSubItemReportController
                        .getpurchasesubitemwisereport(context);
                  },
                  hintText: "Item",
                ),
              ],
            )));
  }

   SizedBox subitem(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Sub Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _purchaseSubItemReportController.searchsubitemController,
                  filled: true,
                  selectedValue:
                      _purchaseSubItemReportController.selectedSubitem.value,
                  options:
                      _purchaseSubItemReportController.subitemFilterList.value,
                  onChanged: (value) {
                    _purchaseSubItemReportController.selectedSubitem(value);
                    _purchaseSubItemReportController
                        .getpurchasesubitemwisereport(context);
                  },
                  hintText: "Sub Item",
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
                  _purchaseSubItemReportController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _purchaseSubItemReportController.datarangefilterController.clear();
                _purchaseSubItemReportController.getpurchasesubitemwisereport(context);
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
                  _purchaseSubItemReportController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _purchaseSubItemReportController.datarangefilterController
                      .clear();
                }
                _purchaseSubItemReportController.getpurchasesubitemwisereport(context);
              }),
        ],
      ),
    );
  }

}
