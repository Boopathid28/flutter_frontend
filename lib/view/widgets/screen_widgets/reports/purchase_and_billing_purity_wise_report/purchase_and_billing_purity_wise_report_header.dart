import 'package:ausales_application/controller/reports/order_purity_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_and_billing_purity_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseAndBillingPurityWiseReportHeader extends StatefulWidget {
  const PurchaseAndBillingPurityWiseReportHeader({super.key});

  @override
  State<PurchaseAndBillingPurityWiseReportHeader> createState() =>
      _PurchaseAndBillingPurityWiseReportHeaderState();
}

class _PurchaseAndBillingPurityWiseReportHeaderState
    extends State<PurchaseAndBillingPurityWiseReportHeader> {
  final PurchaseAndBillingPurityWiseReportListController _purchaseAndBillingPurityWiseReportListController =
      Get.put(PurchaseAndBillingPurityWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _purchaseAndBillingPurityWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            purity(context),
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
                      _purchaseAndBillingPurityWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingPurityWiseReportListController.selectedbranch.value,
                  options: _purchaseAndBillingPurityWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingPurityWiseReportListController.selectedbranch(value);
                    _purchaseAndBillingPurityWiseReportListController
                        .getpurchaseandbillingpuritywisereport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox purity(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Purity"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _purchaseAndBillingPurityWiseReportListController.searchpurityController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingPurityWiseReportListController.selectedpurity.value,
                  options:
                      _purchaseAndBillingPurityWiseReportListController.purityFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingPurityWiseReportListController.selectedpurity(value);
                    _purchaseAndBillingPurityWiseReportListController
                        .getpurchaseandbillingpuritywisereport(context);
                  },
                  hintText: "Purity",
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
                  _purchaseAndBillingPurityWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _purchaseAndBillingPurityWiseReportListController.datarangefilterController.clear();
                _purchaseAndBillingPurityWiseReportListController.getpurchaseandbillingpuritywisereport(context);
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
                  _purchaseAndBillingPurityWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _purchaseAndBillingPurityWiseReportListController.datarangefilterController
                      .clear();
                }
                _purchaseAndBillingPurityWiseReportListController.getpurchaseandbillingpuritywisereport(context);
              }),
        ],
      ),
    );
  }

}
