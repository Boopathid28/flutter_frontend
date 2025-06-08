import 'package:ausales_application/controller/reports/order_vendor_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_and_billing_vendor_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseAndBillingVendorWiseReportHeader extends StatefulWidget {
  const PurchaseAndBillingVendorWiseReportHeader({super.key});

  @override
  State<PurchaseAndBillingVendorWiseReportHeader> createState() =>
      _PurchaseAndBillingVendorWiseReportHeaderState();
}

class _PurchaseAndBillingVendorWiseReportHeaderState
    extends State<PurchaseAndBillingVendorWiseReportHeader> {
  final PurchaseAndBillingVendorWiseReportListController _purchaseAndBillingVendorWiseReportListController =
      Get.put(PurchaseAndBillingVendorWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _purchaseAndBillingVendorWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            vendor(context),
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
                      _purchaseAndBillingVendorWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingVendorWiseReportListController.selectedbranch.value,
                  options: _purchaseAndBillingVendorWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingVendorWiseReportListController.selectedbranch(value);
                    _purchaseAndBillingVendorWiseReportListController
                        .getpurchaseandbillingvendordesignerwisereport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox vendor(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Vendor"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _purchaseAndBillingVendorWiseReportListController.searchvendordesignerController,
                  filled: true,
                  selectedValue:
                      _purchaseAndBillingVendorWiseReportListController.selectedvendordesigner.value,
                  options:
                      _purchaseAndBillingVendorWiseReportListController.vendordesignerFilterList.value,
                  onChanged: (value) {
                    _purchaseAndBillingVendorWiseReportListController.selectedvendordesigner(value);
                    _purchaseAndBillingVendorWiseReportListController
                        .getpurchaseandbillingvendordesignerwisereport(context);
                  },
                  hintText: "Vendor",
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
                  _purchaseAndBillingVendorWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _purchaseAndBillingVendorWiseReportListController.datarangefilterController.clear();
                _purchaseAndBillingVendorWiseReportListController.getpurchaseandbillingvendordesignerwisereport(context);
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
                  _purchaseAndBillingVendorWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _purchaseAndBillingVendorWiseReportListController.datarangefilterController
                      .clear();
                }
                _purchaseAndBillingVendorWiseReportListController.getpurchaseandbillingvendordesignerwisereport(context);
              }),
        ],
      ),
    );
  }

}
