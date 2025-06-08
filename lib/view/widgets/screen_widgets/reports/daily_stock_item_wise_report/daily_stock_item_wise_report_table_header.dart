import 'package:ausales_application/controller/reports/daily_stock_item_wise_report_controller.dart';
import 'package:ausales_application/controller/reports/daily_stock_subitem_wise_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyStockItemWiseReportTableHeader extends StatefulWidget {
  const DailyStockItemWiseReportTableHeader({super.key});

  @override
  State<DailyStockItemWiseReportTableHeader> createState() => _DailyStockItemWiseReportTableHeaderState();
}

class _DailyStockItemWiseReportTableHeaderState extends State<DailyStockItemWiseReportTableHeader> {
  final DailyStockItemWiseReportController _dailyStockItemWiseReportController =
      Get.put(DailyStockItemWiseReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [  branchFilterDropDown(),itemFilterDropDown(),dateInput(context)],
            )
          : Column(
              children: [
                
               branchFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                itemFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                
                dateInput(context)
              ],
            ),
    );
  }

    SizedBox branchFilterDropDown() {
    return  _dailyStockItemWiseReportController.isBranchuser.value? SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomLabelFilter(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            ()=> CustomDropdownField(
              
              selectedValue: _dailyStockItemWiseReportController.selectedBranch.value,
              onChanged: (value) {
                _dailyStockItemWiseReportController.selectedBranch(value);
                _dailyStockItemWiseReportController.getDailyStockItemWiseReport();
              },
              options: _dailyStockItemWiseReportController.branchDropDown.value,
              hintText: 'Select branch',
            ),
          ),
        ],
      ),
    ):const SizedBox();
  }


   SizedBox itemFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomLabelFilter(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            ()=> CustomDropdownField(
              selectedValue: _dailyStockItemWiseReportController.selectedItem.value,
              onChanged: (value) {
                _dailyStockItemWiseReportController.selectedItem(value);
                _dailyStockItemWiseReportController.getDailyStockItemWiseReport();
              },
              options: _dailyStockItemWiseReportController.itemDropDown.value,
              hintText: 'Select Item',
            ),
          ),
        ],
      ),
    );
  }



  SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "From Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _dailyStockItemWiseReportController.fromDateController,
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
          
                _dailyStockItemWiseReportController.fromDateController.text = formattedDate;
                _dailyStockItemWiseReportController.getDailyStockItemWiseReport();
              }
            },
          ),
        ],
      ),
    );
  }


}
