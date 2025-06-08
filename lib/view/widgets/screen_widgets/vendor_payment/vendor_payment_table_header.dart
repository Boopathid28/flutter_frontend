import 'package:ausales_application/controller/vendor_payment/vendor_payment_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentTableHeader extends StatefulWidget {
  const VendorPaymentTableHeader({super.key});

  @override
  State<VendorPaymentTableHeader> createState() => _VendorPaymentTableHeaderState();
}

class _VendorPaymentTableHeaderState extends State<VendorPaymentTableHeader> {
  final VendorPaymentListController _vendorPaymentListController =
      Get.put(VendorPaymentListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 5.w,
          runSpacing: 10.h,
          children: [
            searchFilter(context),
            vendor(),
            entryDateRangeFilter(context),
            Obx(() => _vendorPaymentListController.isBranchuser.value ? branch() : SizedBox())
          ],
        ));
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _vendorPaymentListController.searchBranchController,
            selectedValue: _vendorPaymentListController.selectedBranch.value,
            options: _vendorPaymentListController.branchDropDown.value,
            onChanged: (value) {
              _vendorPaymentListController.selectedBranch(value);
              _vendorPaymentListController.getVendorPaymentList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox vendor() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _vendorPaymentListController.searchVendorController,
            selectedValue: _vendorPaymentListController.selectedVendor.value,
            options: _vendorPaymentListController.vendorDropDown.value,
            onChanged: (value) {
              _vendorPaymentListController.selectedVendor(value);
              _vendorPaymentListController.getVendorPaymentList(context);
            },
            hintText: "Vendor",
          )),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _vendorPaymentListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _vendorPaymentListController.getVendorPaymentList(context);
          }),
    );
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _vendorPaymentListController.dateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _vendorPaymentListController.dateFilterController.clear();
            _vendorPaymentListController.getVendorPaymentList(context);
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
              _vendorPaymentListController.dateFilterController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _vendorPaymentListController.dateFilterController.clear();
            }
            _vendorPaymentListController.getVendorPaymentList(context);
          }),
    );
  }
}
