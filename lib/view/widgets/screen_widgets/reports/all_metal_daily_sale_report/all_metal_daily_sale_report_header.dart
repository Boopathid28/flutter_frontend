import 'package:ausales_application/controller/reports/all_metal_daily_sale_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllMetalDailySaleReportHeader extends StatefulWidget {
  const AllMetalDailySaleReportHeader({super.key});

  @override
  State<AllMetalDailySaleReportHeader> createState() =>
      _AllMetalDailySaleReportHeaderState();
}

class _AllMetalDailySaleReportHeaderState
    extends State<AllMetalDailySaleReportHeader> {
  final AllMetalDailySaleReportListController _allMetalDailySaleReportListController =
      Get.put(AllMetalDailySaleReportListController());

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
                  _allMetalDailySaleReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _allMetalDailySaleReportListController.datarangefilterController.clear();
                _allMetalDailySaleReportListController.getAllMetalDailySaleReport(context);
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
                  _allMetalDailySaleReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _allMetalDailySaleReportListController.datarangefilterController
                      .clear();
                }
                _allMetalDailySaleReportListController.getAllMetalDailySaleReport(context);
              }),
        ],
      ),
    );
  }


}
