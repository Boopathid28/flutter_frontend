import 'package:ausales_application/controller/vendor_discount/vendor_discount_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorDiscountTableHeader extends StatefulWidget {
  const VendorDiscountTableHeader({super.key});

  @override
  State<VendorDiscountTableHeader> createState() =>
      _VendorDiscountTableHeaderState();
}

class _VendorDiscountTableHeaderState extends State<VendorDiscountTableHeader> {
  final VendorDiscountListController _vendorDiscountListController =
      Get.put(VendorDiscountListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child:Wrap(
        spacing: 20.w,
        runSpacing: 15.h,
              children: [
                activeStatusFilter(context),
                Obx(() => _vendorDiscountListController.isBranchuser.value ? branch(context) : SizedBox()),
                vendorFilter(context),
                dateRangeFilter(context),
                searchFilter(context),
              ],
            )
    );
  }


  SizedBox branch(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _vendorDiscountListController.branchSearchController,
              filled: true,
              selectedValue: _vendorDiscountListController.selectedBranch.value,
              options: _vendorDiscountListController.branchDropDown.value,
              onChanged: (value) {
                _vendorDiscountListController.selectedBranch(value);
                _vendorDiscountListController.getVendorDiscountList(context);
              },
              hintText: "Branch",
            )));
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _vendorDiscountListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _vendorDiscountListController.getVendorDiscountList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _vendorDiscountListController.selectedActiveStatus.value,
              options: _vendorDiscountListController.activeStatusFilterList.value,
              onChanged: (value) {
                _vendorDiscountListController.selectedActiveStatus(value);
                _vendorDiscountListController.getVendorDiscountList(context);
              },
              hintText: "Vendor Status",
            )));
  }

  SizedBox vendorFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
          controller: _vendorDiscountListController.vendorSearchController,
          filled: true,
              selectedValue: _vendorDiscountListController.selectedVendor.value,
              options: _vendorDiscountListController.vendorDropDown.value,
              onChanged: (value) {
                _vendorDiscountListController.selectedVendor(value);
                _vendorDiscountListController.getVendorDiscountList(context);
              },
              hintText: "Vendor Status",
            )));
  }

  SizedBox dateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _vendorDiscountListController.dateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _vendorDiscountListController.dateFilterController.clear();
            _vendorDiscountListController.getVendorDiscountList(context);
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
              var endDate = pickedDate.end.toString().substring(0, 10);
              _vendorDiscountListController.dateFilterController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _vendorDiscountListController.dateFilterController.clear();
            }
            _vendorDiscountListController.getVendorDiscountList(context);
          }),
    );
  }
}
