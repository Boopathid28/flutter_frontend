import 'dart:math';

import 'package:ausales_application/controller/order/order_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderTableHeader extends StatefulWidget {
  const OrderTableHeader({super.key});

  @override
  State<OrderTableHeader> createState() => _OrderTableHeaderState();
}

class _OrderTableHeaderState extends State<OrderTableHeader> {
  final OrderListController _orderListController =
      Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [customer(), searchFilter(context)],
        ));
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
          SizedBox(height: 10.h),
          CustomTextInput(
              controller: _orderListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _orderListController.getorderList(context);
              }),
        ],
      ),
    );
  }

  SizedBox customer() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Customer"),
              SizedBox(height: 10.h),
              CustomDropdownSearchField(
                filled: true,
                controller: _orderListController.customerSearchController,
                selectedValue: _orderListController.selectedCustomer.value,
                options: _orderListController.customerDropDown.value,
                onChanged: (value) {
                  _orderListController.selectedCustomer(value);
                  _orderListController.getorderList(context);
                },
                hintText: "Customer",
              ),
            ],
          )),
    );
  }

}
