import 'package:ausales_application/controller/reports/all_metal_daily_sale_report_list_controller.dart';
import 'package:ausales_application/controller/reports/vendor_crdr_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorCrdrReportHeader extends StatefulWidget {
  const VendorCrdrReportHeader({super.key});

  @override
  State<VendorCrdrReportHeader> createState() =>
      _VendorCrdrReportHeaderState();
}

class _VendorCrdrReportHeaderState
    extends State<VendorCrdrReportHeader> {
  final VendorCrdrReportController _vendorCrdrReportController =
      Get.put(VendorCrdrReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            entryDateRangeFilter(context),
          ],
        ));
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
                  _vendorCrdrReportController.datefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _vendorCrdrReportController.datefilterController.clear();
                _vendorCrdrReportController.getVendorCrdrReport(context);
              },
              hintText: "Entry Date Range",
              onTap: () async {
                final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _vendorCrdrReportController.datefilterController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _vendorCrdrReportController.datefilterController.clear();
              }
                _vendorCrdrReportController.getVendorCrdrReport(context);
              }),
        ],
      ),
    );
  }


}
