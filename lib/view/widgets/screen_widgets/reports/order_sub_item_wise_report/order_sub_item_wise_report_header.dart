import 'package:ausales_application/controller/reports/order_sub_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderSubItemWiseReportHeader extends StatefulWidget {
  const OrderSubItemWiseReportHeader({super.key});

  @override
  State<OrderSubItemWiseReportHeader> createState() =>
      _OrderSubItemWiseReportHeaderState();
}

class _OrderSubItemWiseReportHeaderState
    extends State<OrderSubItemWiseReportHeader> {
  final OrderSubItemWiseReportListController _orderSubItemWiseReportListController =
      Get.put(OrderSubItemWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _orderSubItemWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            item(context),
            subitem(context),
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
                      _orderSubItemWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _orderSubItemWiseReportListController.selectedbranch.value,
                  options: _orderSubItemWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _orderSubItemWiseReportListController.selectedbranch(value);
                    _orderSubItemWiseReportListController
                        .getordersubitemwisereport(context);
                  },
                  hintText: "Branch",
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
                      _orderSubItemWiseReportListController.searchitemController,
                  filled: true,
                  selectedValue:
                      _orderSubItemWiseReportListController.selecteditem.value,
                  options:
                      _orderSubItemWiseReportListController.itemFilterList.value,
                  onChanged: (value) {
                    _orderSubItemWiseReportListController.selecteditem(value);
                    _orderSubItemWiseReportListController
                        .getordersubitemwisereport(context);
                  },
                  hintText: "Item",
                ),
              ],
            )));
  }

   SizedBox subitem(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Sub Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _orderSubItemWiseReportListController.searchsubitemController,
                  filled: true,
                  selectedValue:
                      _orderSubItemWiseReportListController.selectedSubitem.value,
                  options:
                      _orderSubItemWiseReportListController.subitemFilterList.value,
                  onChanged: (value) {
                    _orderSubItemWiseReportListController.selectedSubitem(value);
                    _orderSubItemWiseReportListController
                        .getordersubitemwisereport(context);
                  },
                  hintText: "Sub Item",
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
                  _orderSubItemWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _orderSubItemWiseReportListController.datarangefilterController.clear();
                _orderSubItemWiseReportListController.getordersubitemwisereport(context);
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
                  _orderSubItemWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _orderSubItemWiseReportListController.datarangefilterController
                      .clear();
                }
                _orderSubItemWiseReportListController.getordersubitemwisereport(context);
              }),
        ],
      ),
    );
  }

}
