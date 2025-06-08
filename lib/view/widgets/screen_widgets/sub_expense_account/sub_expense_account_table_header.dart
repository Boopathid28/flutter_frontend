import 'package:ausales_application/controller/sub_expense_account/Sub_expense_account_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubExpenseAccountTableHeader extends StatefulWidget {
  const SubExpenseAccountTableHeader({super.key});

  @override
  State<SubExpenseAccountTableHeader> createState() => _SubExpenseAccountTableHeaderState();
}

class _SubExpenseAccountTableHeaderState extends State<SubExpenseAccountTableHeader> {
  final SubExpenseAccountListController _subExpenseAccountListController  = Get.put(SubExpenseAccountListController());

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
              controller: _subExpenseAccountListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _subExpenseAccountListController.getSubExpenseAccountList(context);
              }),
        );
  }


}
