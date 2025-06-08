import 'package:ausales_application/controller/reports/order_item_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_and_billing_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseAndBillingItemWiseReportHeader extends StatefulWidget {
  const PurchaseAndBillingItemWiseReportHeader({super.key});

  @override
  State<PurchaseAndBillingItemWiseReportHeader> createState() =>
      _PurchaseAndBillingItemWiseReportHeaderState();
}

class _PurchaseAndBillingItemWiseReportHeaderState
    extends State<PurchaseAndBillingItemWiseReportHeader> {
  final PurchaseAndBillingItemWiseReportListController _purchaseAndBillingItemWiseReportListController =
      Get.put(PurchaseAndBillingItemWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _purchaseAndBillingItemWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            item(context),
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
                      _purchaseAndBillingItemWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingItemWiseReportListController.selectedbranch.value,
                  options: _purchaseAndBillingItemWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingItemWiseReportListController.selectedbranch(value);
                    _purchaseAndBillingItemWiseReportListController
                        .getpurchaseandbillingitemwisereport(context);
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
                      _purchaseAndBillingItemWiseReportListController.searchitemController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingItemWiseReportListController.selecteditem.value,
                  options:
                      _purchaseAndBillingItemWiseReportListController.itemFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingItemWiseReportListController.selecteditem(value);
                    _purchaseAndBillingItemWiseReportListController
                        .getpurchaseandbillingitemwisereport(context);
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
                  _purchaseAndBillingItemWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _purchaseAndBillingItemWiseReportListController.datarangefilterController.clear();
                _purchaseAndBillingItemWiseReportListController.getpurchaseandbillingitemwisereport(context);
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
                  _purchaseAndBillingItemWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _purchaseAndBillingItemWiseReportListController.datarangefilterController
                      .clear();
                }
                _purchaseAndBillingItemWiseReportListController.getpurchaseandbillingitemwisereport(context);
              }),
        ],
      ),
    );
  }

}
