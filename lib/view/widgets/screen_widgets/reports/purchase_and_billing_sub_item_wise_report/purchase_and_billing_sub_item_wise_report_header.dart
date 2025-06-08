import 'package:ausales_application/controller/reports/order_sub_item_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_and_billing_sub_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseAndBillingSubItemWiseReportHeader extends StatefulWidget {
  const PurchaseAndBillingSubItemWiseReportHeader({super.key});

  @override
  State<PurchaseAndBillingSubItemWiseReportHeader> createState() =>
      _PurchaseAndBillingSubItemWiseReportHeaderState();
}

class _PurchaseAndBillingSubItemWiseReportHeaderState
    extends State<PurchaseAndBillingSubItemWiseReportHeader> {
  final PurchaseAndBillingSubItemWiseReportListController _purchaseAndBillingSubItemWiseReportListController =
      Get.put(PurchaseAndBillingSubItemWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _purchaseAndBillingSubItemWiseReportListController.isBranchuser.value
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
                      _purchaseAndBillingSubItemWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingSubItemWiseReportListController.selectedbranch.value,
                  options: _purchaseAndBillingSubItemWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingSubItemWiseReportListController.selectedbranch(value);
                    _purchaseAndBillingSubItemWiseReportListController
                        .getpurchaseandbillingsubitemwisereport(context);
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
                      _purchaseAndBillingSubItemWiseReportListController.searchitemController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingSubItemWiseReportListController.selecteditem.value,
                  options:
                      _purchaseAndBillingSubItemWiseReportListController.itemFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingSubItemWiseReportListController.selecteditem(value);
                    _purchaseAndBillingSubItemWiseReportListController
                        .getpurchaseandbillingsubitemwisereport(context);
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
                      _purchaseAndBillingSubItemWiseReportListController.searchsubitemController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingSubItemWiseReportListController.selectedSubitem.value,
                  options:
                      _purchaseAndBillingSubItemWiseReportListController.subitemFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingSubItemWiseReportListController.selectedSubitem(value);
                    _purchaseAndBillingSubItemWiseReportListController
                        .getpurchaseandbillingsubitemwisereport(context);
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
                  _purchaseAndBillingSubItemWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _purchaseAndBillingSubItemWiseReportListController.datarangefilterController.clear();
                _purchaseAndBillingSubItemWiseReportListController.getpurchaseandbillingsubitemwisereport(context);
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
                  _purchaseAndBillingSubItemWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _purchaseAndBillingSubItemWiseReportListController.datarangefilterController
                      .clear();
                }
                _purchaseAndBillingSubItemWiseReportListController.getpurchaseandbillingsubitemwisereport(context);
              }),
        ],
      ),
    );
  }

}
