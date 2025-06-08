import 'package:ausales_application/controller/reports/order_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderReportTableHeader extends StatefulWidget {
  const OrderReportTableHeader({super.key});

  @override
  State<OrderReportTableHeader> createState() =>
      _OrderReportTableHeaderState();
}

class _OrderReportTableHeaderState
    extends State<OrderReportTableHeader> {
  final OrderReportListController _orderReportListController =
      Get.put(OrderReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [customer(context),dateInput(context)],
        ));
  }


   SizedBox customer(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Customer"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _orderReportListController.searchcustomerController,
                  filled: true,
                  selectedValue:
                      _orderReportListController.selectedCustomer.value,
                  options:
                      _orderReportListController.customerFilterList.value,
                  onChanged: (value) {
                    _orderReportListController.selectedCustomer(value);
                    _orderReportListController
                        .getOrderReport();
                  },
                  hintText: "Customer",
                ),
              ],
            )));
  }

  SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Date"),
                SizedBox(
                  height: 7.w,
                ),
          CustomTextInput(
            controller: _orderReportListController.fromDateController,
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
          
                _orderReportListController.fromDateController.text =
                    formattedDate;
                _orderReportListController.getOrderReport();
              }
            },
          ),
        ],
      ),
    );
  }
}
