import 'package:ausales_application/controller/reports/customer_cr_dr_report_list_controller.dart';
import 'package:ausales_application/controller/reports/daily_payment_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerCrDrReportTableHeader extends StatefulWidget {
  const CustomerCrDrReportTableHeader({super.key});

  @override
  State<CustomerCrDrReportTableHeader> createState() =>
      _CustomerCrDrReportTableHeaderState();
}

class _CustomerCrDrReportTableHeaderState
    extends State<CustomerCrDrReportTableHeader> {
  final CustomerCrDrReportListController _customerCrDrReportListController =
      Get.put(CustomerCrDrReportListController());

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
        controller: _customerCrDrReportListController.fromDateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: "default",
        hintText: "From Date",
        readOnly: true,
        filled: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            _customerCrDrReportListController.fromDateController.text =
                formattedDate;
            _customerCrDrReportListController.getCustomerCRDRReport();
          }
        },
      ),
    );
  }
}
