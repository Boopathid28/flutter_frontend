import 'package:ausales_application/controller/reports/daily_sale_report_list_controller.dart';
import 'package:ausales_application/controller/reports/estimation_item_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailySaleReportHeader extends StatefulWidget {
  const DailySaleReportHeader({super.key});

  @override
  State<DailySaleReportHeader> createState() =>
      _DailySaleReportHeaderState();
}

class _DailySaleReportHeaderState
    extends State<DailySaleReportHeader> {
  final DailySaleReportListController _dailySaleReportListController =
      Get.put(DailySaleReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            metal(),
            entryDateRangeFilter(context),
          ],
        ));
  }




  SizedBox metal() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _dailySaleReportListController.searchmetalController,
                selectedValue: _dailySaleReportListController.selectedmetal.value,
                options: _dailySaleReportListController.metalFilterList.value,
                onChanged: (value) {
                  _dailySaleReportListController.selectedmetal(value);
                  _dailySaleReportListController.getdailysalereport(context);
                },
                filled: true,
                hintText: "Metal",
              ))
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
              controller:
                  _dailySaleReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _dailySaleReportListController.datarangefilterController.clear();
                _dailySaleReportListController.getdailysalereport(context);
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
                  _dailySaleReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _dailySaleReportListController.datarangefilterController
                      .clear();
                }
                _dailySaleReportListController.getdailysalereport(context);
              }),
        ],
      ),
    );
  }


}
