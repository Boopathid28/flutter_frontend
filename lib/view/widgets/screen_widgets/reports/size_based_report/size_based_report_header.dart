import 'package:ausales_application/controller/reports/size_based_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SizeBasedReportHeader extends StatefulWidget {
  const SizeBasedReportHeader({super.key});

  @override
  State<SizeBasedReportHeader> createState() => _SizeBasedReportHeaderState();
}

class _SizeBasedReportHeaderState extends State<SizeBasedReportHeader> {
  final SizeBasedReportController _sizeBasedReportController = Get.put(SizeBasedReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          Obx(() => _sizeBasedReportController.isBranchuser.value ? branch(context) : SizedBox()),
          measurementType(context),
          entryDateRangeFilter(context),
          fromWeight(context),
          toWeight(context),
          searchFilter(context),
        ],
      )
    );
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
                  controller: _sizeBasedReportController.branchSearchFilterController,
                  filled: true,
                  selectedValue: _sizeBasedReportController.selectedBranch.value,
                  options: _sizeBasedReportController.branchDropDown.value,
                  onChanged: (value) {
                    _sizeBasedReportController.selectedBranch(value);
                    _sizeBasedReportController.getSizeBasedReportList(context);
                  },
                  hintText: "Branch",
                ),
          ],
        )));
  }

  SizedBox fromWeight(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "From Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _sizeBasedReportController.fromWeightController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hintText: "From Weight",
              onChanged: (value) {
                _sizeBasedReportController.getSizeBasedReportList(context);
              }),
        ],
      ),
    );
  }

  SizedBox toWeight(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "To Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _sizeBasedReportController.toWeightController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hintText: "To Weight",
              onChanged: (value) {
                _sizeBasedReportController.getSizeBasedReportList(context);
              }),
        ],
      ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _sizeBasedReportController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _sizeBasedReportController.getSizeBasedReportList(context);
              }),
        ],
      ),
    );
  }

  SizedBox measurementType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  
          CustomLabelFilter(label: "Measurement Type"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownField(
                  filled: true,
                  selectedValue: _sizeBasedReportController.selectedMeasurementType.value,
                  options: _sizeBasedReportController.measurementTypeDropDown.value,
                  onChanged: (value) {
                    _sizeBasedReportController.selectedMeasurementType(value);
                    _sizeBasedReportController.getSizeBasedReportList(context);
                  },
                  hintText: "Measurement Type",
                ),
          ],
        )));
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Date Filter"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              readOnly: true,
              controller: _sizeBasedReportController.dateFilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _sizeBasedReportController.dateFilterController.clear();
                _sizeBasedReportController.getSizeBasedReportList(context);
              },
              hintText: "Entry Date Range",
              onTap: () async {
                final today = DateTime.now();
                final endYear = today.year + 1;
                DateTimeRange? pickedDate = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear),
                  builder: (context, child) {
                    return Center(
                      child: Container(
                        height: 450.h,
                        width: 400.w,
                        child: child,
                      ),
                    );
                  },
                );
                if (pickedDate != null) {
                  var startDate = pickedDate.start.toString().substring(0, 10);
                  var endDate = pickedDate.end
                      .add(Duration(days: 1))
                      .toString()
                      .substring(0, 10);
                  _sizeBasedReportController.dateFilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _sizeBasedReportController.dateFilterController.clear();
                }
                _sizeBasedReportController.getSizeBasedReportList(context);
              }),
        ],
      ),
    );
  }
}
