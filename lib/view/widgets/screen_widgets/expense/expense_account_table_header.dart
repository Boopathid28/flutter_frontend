import 'package:ausales_application/controller/expense_account/expense_account_list_controller.dart';
import 'package:ausales_application/controller/metal_master/metal_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseAccountTableHeader extends StatefulWidget {
  const ExpenseAccountTableHeader({super.key});

  @override
  State<ExpenseAccountTableHeader> createState() => _ExpenseAccountTableHeaderState();
}

class _ExpenseAccountTableHeaderState extends State<ExpenseAccountTableHeader> {
  final ExpenseAccountListController _expenseAccountListController = Get.put(ExpenseAccountListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          searchFilter(context)
        ],
      ) : Column(
        children: [
          searchFilter(context)
        ],
      ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
          width: 300.w,
          child: CustomTextInput(
              controller: _expenseAccountListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _expenseAccountListController.getExpenseAccountList(context);
              }),
        );
  }


}
