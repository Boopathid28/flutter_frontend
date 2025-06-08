import 'package:ausales_application/controller/reports/daily_stock_metal_wise_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyStockMetalWiseReportTableHeader extends StatefulWidget {
  const DailyStockMetalWiseReportTableHeader({super.key});

  @override
  State<DailyStockMetalWiseReportTableHeader> createState() => _DailyStockMetalWiseReportTableHeaderState();
}

class _DailyStockMetalWiseReportTableHeaderState extends State<DailyStockMetalWiseReportTableHeader> {
  final DailyStockMetalWiseReportController _dailyStockDesignerWiseReportController =
      Get.put(DailyStockMetalWiseReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [  branchFilterDropDown(),metalFilterDropDown(),dateInput(context)],
            )
          : Column(
              children: [
                
               branchFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                
                metalFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                dateInput(context)
              ],
            ),
    );
  }

    SizedBox branchFilterDropDown() {
    return  _dailyStockDesignerWiseReportController.isBranchuser.value? SizedBox(
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
              
              selectedValue: _dailyStockDesignerWiseReportController.selectedBranch.value,
              onChanged: (value) {
                _dailyStockDesignerWiseReportController.selectedBranch(value);
                _dailyStockDesignerWiseReportController.getDailyStockMetalWiseReport();
              },
              options: _dailyStockDesignerWiseReportController.branchDropDown.value,
              hintText: 'Select branch',
            ),
          ),
        ],
      ),
    ):const SizedBox();
  }




   SizedBox metalFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomLabelFilter(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            ()=> CustomDropdownField(
              isValidate: false,
              selectedValue: _dailyStockDesignerWiseReportController.selectedMetal.value,
              onChanged: (value) {
                _dailyStockDesignerWiseReportController.selectedMetal(value);
                _dailyStockDesignerWiseReportController.getDailyStockMetalWiseReport();
              },
              options: _dailyStockDesignerWiseReportController.metalDropDown.value,
              hintText: 'Select Metal',
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
           CustomLabelFilter(label: "Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _dailyStockDesignerWiseReportController.fromDateController,
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
          
                _dailyStockDesignerWiseReportController.fromDateController.text = formattedDate;
                _dailyStockDesignerWiseReportController.getDailyStockMetalWiseReport();
              }
            },
          ),
        ],
      ),
    );
  }


}
