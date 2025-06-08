import 'package:ausales_application/controller/reports/order_bill_report_list_controller.dart';
import 'package:ausales_application/controller/reports/order_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class OrderBillReportHeader extends StatefulWidget {
  const OrderBillReportHeader({super.key});

  @override
  State<OrderBillReportHeader> createState() =>
      _OrderBillReportHeaderState();
}

class _OrderBillReportHeaderState
    extends State<OrderBillReportHeader> {
  final OrderBillReportListController _orderBillReportListController =
      Get.put(OrderBillReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _orderBillReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            customer(context),
            dateInput(context),
          ],
        ));
  }

  SizedBox branch(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Branch"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _orderBillReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _orderBillReportListController.selectedbranch.value,
                  options: _orderBillReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _orderBillReportListController.selectedbranch(value);
                    _orderBillReportListController
                        .getorderbillreport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
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
                      _orderBillReportListController.searchCustomerController,
                  filled: true,
                  selectedValue:
                      _orderBillReportListController.selectedcustomer.value,
                  options:
                      _orderBillReportListController.customerFilterList.value,
                  onChanged: (value) {
                    _orderBillReportListController.selectedcustomer(value);
                    _orderBillReportListController
                        .getorderbillreport(context);
                  },
                  hintText: "Customer",
                ),
              ],
            )));
  }

   SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomLabelFilter(label: "Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _orderBillReportListController.fromDateController,
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
          
                _orderBillReportListController.fromDateController.text = formattedDate;
                _orderBillReportListController.getorderbillreport(context);
              }
            },
          ),
        ],
      ),
    );
  }

}
