import 'package:ausales_application/controller/reports/order_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderItemWiseReportHeader extends StatefulWidget {
  const OrderItemWiseReportHeader({super.key});

  @override
  State<OrderItemWiseReportHeader> createState() =>
      _OrderItemWiseReportHeaderState();
}

class _OrderItemWiseReportHeaderState
    extends State<OrderItemWiseReportHeader> {
  final OrderItemWiseReportListController _orderItemWiseReportListController =
      Get.put(OrderItemWiseReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _orderItemWiseReportListController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            item(context),
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
                      _orderItemWiseReportListController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _orderItemWiseReportListController.selectedbranch.value,
                  options: _orderItemWiseReportListController.branchFilterList.value,
                  onChanged: (value) {
                    _orderItemWiseReportListController.selectedbranch(value);
                    _orderItemWiseReportListController
                        .getorderitemwisereport(context);
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
                      _orderItemWiseReportListController.searchitemController,
                  filled: true,
                  selectedValue:
                      _orderItemWiseReportListController.selecteditem.value,
                  options:
                      _orderItemWiseReportListController.itemFilterList.value,
                  onChanged: (value) {
                    _orderItemWiseReportListController.selecteditem(value);
                    _orderItemWiseReportListController
                        .getorderitemwisereport(context);
                  },
                  hintText: "Customer",
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
                  _orderItemWiseReportListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _orderItemWiseReportListController.datarangefilterController.clear();
                _orderItemWiseReportListController.getorderitemwisereport(context);
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
                  _orderItemWiseReportListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _orderItemWiseReportListController.datarangefilterController
                      .clear();
                }
                _orderItemWiseReportListController.getorderitemwisereport(context);
              }),
        ],
      ),
    );
  }

}
