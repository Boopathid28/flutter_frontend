import 'package:ausales_application/controller/reports/item_wise_sales_report_controller.dart';
import 'package:ausales_application/controller/reports/purity_wise_sales_report_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItemWiseSalesReportTabelHeader extends StatefulWidget {
  const ItemWiseSalesReportTabelHeader({super.key});

  @override
  State<ItemWiseSalesReportTabelHeader> createState() => _ItemWiseSalesReportTabelHeaderState();
}

class _ItemWiseSalesReportTabelHeaderState extends State<ItemWiseSalesReportTabelHeader> {

  final ItemWiseSalesReportController _itemWiseSalesReportController =
      Get.put(ItemWiseSalesReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                branchFilterDropDown(),
                fromDateInput(context),
                toDateInput(context),
                searchInput()
              ],
            )
          : Column(
              children: [
                branchFilterDropDown(),
                SizedBox(
                  height: 10.w,
                ),
               
                fromDateInput(context),
                SizedBox(
                  height: 10.w,
                ),
                toDateInput(context),
                 SizedBox(
                  height: 10.w,
                ),searchInput()
              ],
            ),
    );
  }

  SizedBox branchFilterDropDown() {
    return _itemWiseSalesReportController.isBranchuser.value
        ? SizedBox(
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
                Obx(
                  () => CustomDropdownField(
                    selectedValue: _itemWiseSalesReportController.selectedBranch.value,
                    onChanged: (value) {
                      _itemWiseSalesReportController.selectedBranch(value);
                      _itemWiseSalesReportController.getItemWiseSalesReport();
                    },
                    options: _itemWiseSalesReportController.branchDropDown.value,
                    hintText: 'Select branch',
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
  

  SizedBox fromDateInput(BuildContext context) {
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
            controller: _itemWiseSalesReportController.fromDateController,
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
          
                _itemWiseSalesReportController.fromDateController.text = formattedDate;
                _itemWiseSalesReportController.getItemWiseSalesReport();
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox toDateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "To Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _itemWiseSalesReportController.toDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "To Date",
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
          
                _itemWiseSalesReportController.toDateController.text = formattedDate;
                _itemWiseSalesReportController.getItemWiseSalesReport();
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox searchInput() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _itemWiseSalesReportController.searchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validator",
            hintText: "Search",
            onChanged: (value) {
              _itemWiseSalesReportController.getItemWiseSalesReport();
            },
          ),
        ],
      ),
    );
  }
  
}
