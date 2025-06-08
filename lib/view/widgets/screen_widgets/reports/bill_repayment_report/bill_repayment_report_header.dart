import 'package:ausales_application/controller/reports/bill_repayment_report_controller.dart';
import 'package:ausales_application/controller/reports/cash_purchase_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BillRepaymentReportHeader extends StatefulWidget {
  const BillRepaymentReportHeader({super.key});

  @override
  State<BillRepaymentReportHeader> createState() =>
      _BillRepaymentReportHeaderState();
}

class _BillRepaymentReportHeaderState
    extends State<BillRepaymentReportHeader> {
  final BillRepaymentReportController _billRepaymentReportController =
      Get.put(BillRepaymentReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            dateInput(context),
          ],
        ));
  }

  SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
        controller: _billRepaymentReportController.fromDateController,
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
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            _billRepaymentReportController.fromDateController.text =
                formattedDate;
            _billRepaymentReportController.getBillRepaymentReport();
          }
        },
      ),
    );
  }


}
