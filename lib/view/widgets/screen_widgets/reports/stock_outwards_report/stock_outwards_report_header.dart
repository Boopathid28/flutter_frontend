import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/stock_outwards_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockOutwardsReportHeader extends StatefulWidget {
  const StockOutwardsReportHeader({super.key});

  @override
  State<StockOutwardsReportHeader> createState() =>
      _StockOutwardsReportHeaderState();
}

class _StockOutwardsReportHeaderState
    extends State<StockOutwardsReportHeader> {
  final StockOutwardsReportController _stockOutwardsReportController =
      Get.put(StockOutwardsReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _stockOutwardsReportController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            metal(context),
            item(context),
            designer(context),
            entryDateRangeFilter(context),
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
                      _stockOutwardsReportController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _stockOutwardsReportController.selectedbranch.value,
                  options: _stockOutwardsReportController.branchFilterList.value,
                  onChanged: (value) {
                    _stockOutwardsReportController.selectedbranch(value);
                    _stockOutwardsReportController
                        .getstockoutwardsreport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
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
                      _stockOutwardsReportController.searchMetalController,
                  filled: true,
                  selectedValue:
                      _stockOutwardsReportController.selectedmetal.value,
                  options:
                      _stockOutwardsReportController.metalFilterList.value,
                  onChanged: (value) {
                    _stockOutwardsReportController.selectedmetal(value);
                    _stockOutwardsReportController
                        .getstockoutwardsreport(context);
                  },
                  hintText: "Metal",
                ),
              ],
            )));
  }
  SizedBox item(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _stockOutwardsReportController.searchItemController,
                  filled: true,
                  selectedValue:
                      _stockOutwardsReportController.selecteditem.value,
                  options:
                      _stockOutwardsReportController.itemFilterList.value,
                  onChanged: (value) {
                    _stockOutwardsReportController.selecteditem(value);
                    _stockOutwardsReportController
                        .getstockoutwardsreport(context);
                  },
                  hintText: "Item",
                ),
              ],
            )));
  }


   SizedBox designer(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Designer"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _stockOutwardsReportController.searchDesignerController,
                  filled: true,
                  selectedValue:
                      _stockOutwardsReportController.selecteddesigner.value,
                  options:
                      _stockOutwardsReportController.designerFilterList.value,
                  onChanged: (value) {
                    _stockOutwardsReportController.selecteddesigner(value);
                    _stockOutwardsReportController
                        .getstockoutwardsreport(context);
                  },
                  hintText: "Designer",
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
              controller:
                  _stockOutwardsReportController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _stockOutwardsReportController.datarangefilterController.clear();
                _stockOutwardsReportController.getstockoutwardsreport(context);
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
                  _stockOutwardsReportController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _stockOutwardsReportController.datarangefilterController
                      .clear();
                }
                _stockOutwardsReportController.getstockoutwardsreport(context);
              }),
        ],
      ),
    );
  }

}
