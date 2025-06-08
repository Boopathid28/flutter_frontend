import 'package:ausales_application/controller/reports/daily_stock_subitem_wise_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyStockSubitemWiseReportTableHeader extends StatefulWidget {
  const DailyStockSubitemWiseReportTableHeader({super.key});

  @override
  State<DailyStockSubitemWiseReportTableHeader> createState() => _DailyStockSubitemWiseReportTableHeaderState();
}

class _DailyStockSubitemWiseReportTableHeaderState extends State<DailyStockSubitemWiseReportTableHeader> {
  final DailyStockSubitemItemWiseReportController _dailyStockSubitemItemWiseReportController =
      Get.put(DailyStockSubitemItemWiseReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [  branchFilterDropDown(),itemFilterDropDown(),subItemFilterDropDown(),dateInput(context)],
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
                subItemFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
                dateInput(context)
              ],
            ),
    );
  }

    SizedBox branchFilterDropDown() {
    return  _dailyStockSubitemItemWiseReportController.isBranchuser.value? SizedBox(
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
              
              selectedValue: _dailyStockSubitemItemWiseReportController.selectedBranch.value,
              onChanged: (value) {
                _dailyStockSubitemItemWiseReportController.selectedBranch(value);
                _dailyStockSubitemItemWiseReportController.getDailyStockSubitemItemWiseReport();
              },
              options: _dailyStockSubitemItemWiseReportController.branchDropDown.value,
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
      child: Obx(
        ()=> CustomDropdownField(
          selectedValue: _dailyStockSubitemItemWiseReportController.selectedItem.value,
          onChanged: (value) {
            _dailyStockSubitemItemWiseReportController.selectedItem(value);
            _dailyStockSubitemItemWiseReportController.getDailyStockSubitemItemWiseReport();
            _dailyStockSubitemItemWiseReportController.getSubItemList();
          },
          options: _dailyStockSubitemItemWiseReportController.itemDropDown.value,
          hintText: 'Select Item',
        ),
      ),
    );
  }


   SizedBox subItemFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Obx(
        ()=> CustomDropdownField(
          isValidate: false,
          selectedValue: _dailyStockSubitemItemWiseReportController.selectedSubItem.value,
          onChanged: (value) {
            _dailyStockSubitemItemWiseReportController.selectedSubItem(value);
            _dailyStockSubitemItemWiseReportController.getDailyStockSubitemItemWiseReport();
          },
          options: _dailyStockSubitemItemWiseReportController.subItemDropDown.value,
          hintText: 'Select Subitem',
        ),
      ),
    );
  }

  SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
        controller: _dailyStockSubitemItemWiseReportController.fromDateController,
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

            _dailyStockSubitemItemWiseReportController.fromDateController.text = formattedDate;
            _dailyStockSubitemItemWiseReportController.getDailyStockSubitemItemWiseReport();
          }
        },
      ),
    );
  }


}
