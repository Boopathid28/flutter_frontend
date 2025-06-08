import 'package:ausales_application/controller/reports/daily_stock_purity_wise_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyStockPurityWiseReportTableHeader extends StatefulWidget {
  const DailyStockPurityWiseReportTableHeader({super.key});

  @override
  State<DailyStockPurityWiseReportTableHeader> createState() => _DailyStockPurityWiseReportTableHeaderState();
}

class _DailyStockPurityWiseReportTableHeaderState extends State<DailyStockPurityWiseReportTableHeader> {

  final DailyStockPurityWiseReportController _dailyStockPurityWiseReportController =
      Get.put(DailyStockPurityWiseReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [  branchFilterDropDown(),purityFilterDropDown(),dateInput(context)],
            )
          : Column(
              children: [
                
               branchFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                
                purityFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                dateInput(context)
              ],
            ),
    );
  }

    SizedBox branchFilterDropDown() {
    return  _dailyStockPurityWiseReportController.isBranchuser.value? SizedBox(
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
              
              selectedValue: _dailyStockPurityWiseReportController.selectedBranch.value,
              onChanged: (value) {
                _dailyStockPurityWiseReportController.selectedBranch(value);
                _dailyStockPurityWiseReportController.getDailyStockPurityWiseReport();
              },
              options: _dailyStockPurityWiseReportController.branchDropDown.value,
              hintText: 'Select branch',
            ),
          ),
        ],
      ),
    ):const SizedBox();
  }




   SizedBox purityFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomLabelFilter(label: "Purity"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            ()=> CustomDropdownField(
              isValidate: false,
              selectedValue: _dailyStockPurityWiseReportController.selectedPurity.value,
              onChanged: (value) {
                _dailyStockPurityWiseReportController.selectedPurity(value);
                _dailyStockPurityWiseReportController.getDailyStockPurityWiseReport();
              },
              options: _dailyStockPurityWiseReportController.purityDropDown.value,
              hintText: 'Select Purity',
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
            controller: _dailyStockPurityWiseReportController.fromDateController,
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
          
                _dailyStockPurityWiseReportController.fromDateController.text = formattedDate;
                _dailyStockPurityWiseReportController.getDailyStockPurityWiseReport();
              }
            },
          ),
        ],
      ),
    );
  }


}
