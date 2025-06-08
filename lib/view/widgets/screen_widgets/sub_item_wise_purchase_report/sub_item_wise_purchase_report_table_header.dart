import 'package:ausales_application/controller/sub_item_wise_purchase_report/sub_item_wise_purchase_report_controller.dart';
import 'package:ausales_application/controller/tax_master/tax_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubItemWisePurchaseReportTableHeader extends StatefulWidget {
  const SubItemWisePurchaseReportTableHeader({super.key});

  @override
  State<SubItemWisePurchaseReportTableHeader> createState() => _SubItemWisePurchaseReportTableHeaderState();
}

class _SubItemWisePurchaseReportTableHeaderState extends State<SubItemWisePurchaseReportTableHeader> {
  final SubItemWisePurchaseReportController _subItemWisePurchaseReportController = Get.put(SubItemWisePurchaseReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          Obx(() => _subItemWisePurchaseReportController.isBranchuser.value ? branch(context) : SizedBox()),
          itemFilter(context),
          subitemFilter(context),
          entryDateRangeFilter(context)
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
                  controller: _subItemWisePurchaseReportController.searchbranchController,
                  filled: true,
                  selectedValue: _subItemWisePurchaseReportController.selectedbranch.value,
                  options: _subItemWisePurchaseReportController.branchFilterList.value,
                  onChanged: (value) {
                    _subItemWisePurchaseReportController.selectedbranch(value);
                    _subItemWisePurchaseReportController.getsubitemwisepurchasereportList(context);
                  },
                  hintText: "Branch",
                ),
          ],
        )));
  }


  SizedBox itemFilter(BuildContext context) {
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
                  controller: _subItemWisePurchaseReportController.searchitemController,
                  filled: true,
                  selectedValue: _subItemWisePurchaseReportController.selecteditem.value,
                  options: _subItemWisePurchaseReportController.itemFilterList.value,
                  onChanged: (value) {
                    _subItemWisePurchaseReportController.selecteditem(value);
                    _subItemWisePurchaseReportController.getsubitemwisepurchasereportList(context);
                  },
                  hintText: "Item",
                ),
          ],
        )));
  }

  SizedBox subitemFilter(BuildContext context) {
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
                  controller: _subItemWisePurchaseReportController.searchsubitemController,
                  filled: true,
                  selectedValue: _subItemWisePurchaseReportController.selectedsubitem.value,
                  options: _subItemWisePurchaseReportController.subitemFilterList.value,
                  onChanged: (value) {
                    _subItemWisePurchaseReportController.selectedsubitem(value);
                    _subItemWisePurchaseReportController.getsubitemwisepurchasereportList(context);
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
              controller: _subItemWisePurchaseReportController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _subItemWisePurchaseReportController.datarangefilterController.clear();
                _subItemWisePurchaseReportController.getsubitemwisepurchasereportList(context);
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
                  _subItemWisePurchaseReportController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _subItemWisePurchaseReportController.datarangefilterController.clear();
                }
                _subItemWisePurchaseReportController.getsubitemwisepurchasereportList(context);
              }),
        ],
      ),
    );
  }
}
