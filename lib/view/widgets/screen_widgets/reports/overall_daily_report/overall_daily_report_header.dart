import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
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

class OverallDailyReportHeader extends StatefulWidget {
  const OverallDailyReportHeader({super.key});

  @override
  State<OverallDailyReportHeader> createState() =>
      _OverallDailyReportHeaderState();
}

class _OverallDailyReportHeaderState extends State<OverallDailyReportHeader> {
  final OverallDailyReportController _overallDailyReportController =
      Get.put(OverallDailyReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            metal(context),
            fromDateInput(context),
            paymentMethods(),
            paymentProviders()
          ],
        ));
  }

  SizedBox metal(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Metal"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _overallDailyReportController.searchmetalController,
                  filled: true,
                  selectedValue:
                      _overallDailyReportController.selectedmetal.value,
                  options: _overallDailyReportController.metalFilterList.value,
                  onChanged: (value) {
                    _overallDailyReportController.selectedmetal(value);
                    _overallDailyReportController
                        .getoverallDailyreport(context);
                  },
                  hintText: "Metal",
                ),
              ],
            )));
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
            controller: _overallDailyReportController.fromDateController,
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

                _overallDailyReportController.fromDateController.text =
                    formattedDate;
                _overallDailyReportController.getoverallDailyreport(context);
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox paymentProviders() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Provider"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                filled: true,
                selectedValue:
                    _overallDailyReportController.selectedPaymentProvider.value,
                options:
                    _overallDailyReportController.paymentProviderDropDown.value,
                onChanged: (value) {
                  _overallDailyReportController.selectedPaymentProvider(value);
                  _overallDailyReportController.getoverallDailyreport(context);
                },
                hintText: "Provider",
              ))
        ],
      ),
    );
  }

  SizedBox paymentMethods() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Methods"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                filled: true,
                selectedValue:
                    _overallDailyReportController.selectedPaymentMethod.value,
                options:
                    _overallDailyReportController.paymentMethodDropDown.value,
                onChanged: (value) {
                  _overallDailyReportController.selectedPaymentMethod(value);
                  _overallDailyReportController.getPaymentProvidersList(
                      method: value!.value);
                  _overallDailyReportController.getoverallDailyreport(context);
                },
                hintText: "Payment Methods",
              ))
        ],
      ),
    );
  }
}
