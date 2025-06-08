import 'package:ausales_application/controller/reports/item_closing_report_controller.dart';
import 'package:ausales_application/controller/reports/order_item_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemClosingReportHeader extends StatefulWidget {
  const ItemClosingReportHeader({super.key});

  @override
  State<ItemClosingReportHeader> createState() =>
      _ItemClosingReportHeaderState();
}

class _ItemClosingReportHeaderState
    extends State<ItemClosingReportHeader> {
  final ItemClosingReportController _itemClosingReportController =
      Get.put(ItemClosingReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _itemClosingReportController.isBranchuser.value
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
                      _itemClosingReportController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _itemClosingReportController.selectedbranch.value,
                  options: _itemClosingReportController.branchFilterList.value,
                  onChanged: (value) {
                    _itemClosingReportController.selectedbranch(value);
                    _itemClosingReportController
                        .getitemclosingreport(context);
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
                      _itemClosingReportController.searchitemController,
                  filled: true,
                  selectedValue:
                      _itemClosingReportController.selecteditem.value,
                  options:
                      _itemClosingReportController.itemFilterList.value,
                  onChanged: (value) {
                    _itemClosingReportController.selecteditem(value);
                    _itemClosingReportController
                        .getitemclosingreport(context);
                  },
                  hintText: "Item",
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
                  _itemClosingReportController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _itemClosingReportController.datarangefilterController.clear();
                _itemClosingReportController.getitemclosingreport(context);
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
                  _itemClosingReportController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _itemClosingReportController.datarangefilterController
                      .clear();
                }
                _itemClosingReportController.getitemclosingreport(context);
              }),
        ],
      ),
    );
  }

}
