import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/over_all_day_book_list_controller.dart';
import 'package:ausales_application/controller/reports/overall_daily_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DayBookReportHeader extends StatefulWidget {
  const DayBookReportHeader({super.key});

  @override
  State<DayBookReportHeader> createState() =>
      _DayBookReportHeaderState();
}

class _DayBookReportHeaderState extends State<DayBookReportHeader> {
  final OverAllDayBookListController _overAllDayBookListController =
      Get.put(OverAllDayBookListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            fromDateInput(context),
          ],
        ));
  }

 

  SizedBox fromDateInput(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Form Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _overAllDayBookListController.fromDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "From Date",
            filled: true,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                _overAllDayBookListController.fromDateController.text =
                    formattedDate;
               
              }
            },
          ),
        ],
      ),
    );
  }

}
