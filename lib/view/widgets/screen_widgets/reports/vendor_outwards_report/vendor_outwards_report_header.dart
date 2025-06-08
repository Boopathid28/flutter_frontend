import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/vendor_inwards_report_list_controller.dart';
import 'package:ausales_application/controller/reports/vendor_outwards_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class VendorOutwardsReportHeader extends StatefulWidget {
  const VendorOutwardsReportHeader({super.key});

  @override
  State<VendorOutwardsReportHeader> createState() =>
      _VendorOutwardsReportHeaderState();
}

class _VendorOutwardsReportHeaderState
    extends State<VendorOutwardsReportHeader> {
  final VendorOutwardsReportController _vendorOutwardsReportController =
      Get.put(VendorOutwardsReportController());

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
        controller: _vendorOutwardsReportController.fromDateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: "default",
        hintText: "Date",
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

            _vendorOutwardsReportController.fromDateController.text = formattedDate;
            _vendorOutwardsReportController.getVendorOutwardsListreport(context);
          }
        },
      ),
    );
  }
}
