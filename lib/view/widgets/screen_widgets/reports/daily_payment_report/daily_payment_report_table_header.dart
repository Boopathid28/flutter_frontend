import 'package:ausales_application/controller/reports/daily_payment_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyPaymentReportTableHeader extends StatefulWidget {
  const DailyPaymentReportTableHeader({super.key});

  @override
  State<DailyPaymentReportTableHeader> createState() =>
      _DailyPaymentReportTableHeaderState();
}

class _DailyPaymentReportTableHeaderState
    extends State<DailyPaymentReportTableHeader> {
  final DailyPaymentReportController _dailyPaymentReportController =
      Get.put(DailyPaymentReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [dateInput(context)],
        ));
  }

  SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
        controller: _dailyPaymentReportController.fromDateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: "default",
        hintText: "From Date",
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            _dailyPaymentReportController.fromDateController.text =
                formattedDate;
            _dailyPaymentReportController.getDailyPaymentReport();
          }
        },
      ),
    );
  }
}
