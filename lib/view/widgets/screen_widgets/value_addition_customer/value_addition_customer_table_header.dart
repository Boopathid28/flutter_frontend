import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionCustomerTableHeader extends StatefulWidget {
  const ValueAdditionCustomerTableHeader({super.key});

  @override
  State<ValueAdditionCustomerTableHeader> createState() =>
      _ValueAdditionCustomerTableHeaderState();
}

class _ValueAdditionCustomerTableHeaderState extends State<ValueAdditionCustomerTableHeader> {
  final ValueAdditionCustomerListController _valueAdditionCustomerListController =
      Get.put(ValueAdditionCustomerListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 600.w,
                  child: Row(
                    children: [
                      subitemFilter(context),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                subitemFilter(context),
              ],
            ),
    );
  }


    SizedBox subitemFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _valueAdditionCustomerListController.subitemSearchFilterController,
              filled: true,
              selectedValue: _valueAdditionCustomerListController.selectedSubitem.value,
              options: _valueAdditionCustomerListController.subitemFilterList.value,
              onChanged: (value) {
                _valueAdditionCustomerListController.selectedSubitem(value);
                _valueAdditionCustomerListController.getValueAdditionCustomerlist(context);
              },
              hintText: "Sub Item Status",
            )));
  }
}
