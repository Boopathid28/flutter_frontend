import 'package:ausales_application/controller/customer/customer_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerTableHeader extends StatefulWidget {
  const CustomerTableHeader({super.key});

  @override
  State<CustomerTableHeader> createState() =>
      _CustomerTableHeaderState();
}

class _CustomerTableHeaderState extends State<CustomerTableHeader> {
  final CustomerListController _customerListController =
      Get.put(CustomerListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 700.w,
                  child: Row(
                    children: [
                      activeStatusFilter(context),
                      SizedBox(
                        width: 7.h,
                      ),
                      customergroup(context)
                    ],
                  ),
                ),
                searchFilter(context)
              ],
            )
          : Wrap(
            spacing: 10.w,
            runSpacing: 10.w,
              children: [
                activeStatusFilter(context),
                 SizedBox(
                  height: 7.h,
                ), 
                customergroup(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context),
              ],
            ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _customerListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _customerListController.getcustomerlist(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _customerListController.selectedActiveStatus.value,
              options: _customerListController.activeStatusFilterList.value,
              onChanged: (value) {
                _customerListController.selectedActiveStatus(value);
                _customerListController.getcustomerlist(context);
              },
              hintText: "Active Status",
            )));
  }

  SizedBox customergroup(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
          controller: _customerListController.customerGroupController,
          filled: true,
              selectedValue: _customerListController.selectedCustomergroup.value,
              options: _customerListController.customergroupFilterList.value,
              onChanged: (value) {
                _customerListController.selectedCustomergroup(value);
                _customerListController.getcustomerlist(context);
              },
              hintText: "Customer Group",
            )));
  }
}
