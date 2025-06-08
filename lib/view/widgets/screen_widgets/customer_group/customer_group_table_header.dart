import 'package:ausales_application/controller/customer_group/customer_group_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerGroupTableHeader extends StatefulWidget {
  const CustomerGroupTableHeader({super.key});

  @override
  State<CustomerGroupTableHeader> createState() => _CustomerGroupTableHeaderState();
}

class _CustomerGroupTableHeaderState extends State<CustomerGroupTableHeader> {
  final CustomerGroupListController _customerGroupListController = Get.put(CustomerGroupListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          activeStatusFilter(context),
          searchFilter(context)
        ],
      ) : Column(
        children: [
          activeStatusFilter(context),
          SizedBox(height: 7.h,),
          searchFilter(context)
        ],
      ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
          width: 300.w,
          child: CustomTextInput(
              controller: _customerGroupListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _customerGroupListController.getcustomergrouplist(context);
              }),
        );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
          filled: true,
              selectedValue: _customerGroupListController.selectedActiveStatus.value,
              options: _customerGroupListController.activeStatusFilterList.value,
              onChanged: (value) {
                _customerGroupListController.selectedActiveStatus(value);
                _customerGroupListController.getcustomergrouplist(context);
              },
              hintText: "Vendor Status",
            )));
  }
}
