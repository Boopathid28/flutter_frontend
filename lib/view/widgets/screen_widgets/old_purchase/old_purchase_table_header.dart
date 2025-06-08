import 'package:ausales_application/controller/lot/lot_list_controller.dart';
import 'package:ausales_application/controller/old_purchase/old_purchase_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldPurchaseTableHeader extends StatefulWidget {
  const OldPurchaseTableHeader({super.key});

  @override
  State<OldPurchaseTableHeader> createState() => _OldPurchaseTableHeaderState();
}

class _OldPurchaseTableHeaderState extends State<OldPurchaseTableHeader> {
  final OldPurchaseListController _oldPurchaseListController = Get.put(OldPurchaseListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 5.w,
          runSpacing: 10.h,
          children: [
            searchFilter(context),
            Obx(
              () =>
                  _oldPurchaseListController.isBranchuser.value ? branch() : SizedBox(),
            ),
            entryDateRangeFilter(context),
            customerFilter(context),
            statusFilter(context)
          ],
        ));
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _oldPurchaseListController.branchSearchController,
            selectedValue: _oldPurchaseListController.selectedBranch.value,
            options: _oldPurchaseListController.branchDropDown.value,
            onChanged: (value) {
              _oldPurchaseListController.selectedBranch(value);
              _oldPurchaseListController.getOldPurchaseList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _oldPurchaseListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _oldPurchaseListController.getOldPurchaseList(context);
          }),
    );
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _oldPurchaseListController.entryDateRangeController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _oldPurchaseListController.entryDateRangeController.clear();
            _oldPurchaseListController.getOldPurchaseList(context);
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
                });
            if (pickedDate != null) {
              var startDate = pickedDate.start.toString().substring(0, 10);
              var endDate = pickedDate.end.toString().substring(0, 10);
              _oldPurchaseListController.entryDateRangeController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _oldPurchaseListController.entryDateRangeController.clear();
            }
            _oldPurchaseListController.getOldPurchaseList(context);
          }),
    );
  }

  SizedBox statusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue: _oldPurchaseListController.selectedStatus.value,
              options: _oldPurchaseListController.statusDropDown.value,
              onChanged: (value) {
                _oldPurchaseListController.selectedStatus(value);
                _oldPurchaseListController.getOldPurchaseList(context);
              },
              hintText: "Metal",
            )));
  }

  SizedBox customerFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue: _oldPurchaseListController.selectedCustomer.value,
              options: _oldPurchaseListController.customerDropDown.value,
              onChanged: (value) {
                _oldPurchaseListController.selectedCustomer(value);
                _oldPurchaseListController.getOldPurchaseList(context);
              },
              hintText: "Metal",
            )));
  }

}
