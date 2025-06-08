import 'package:ausales_application/controller/expense_account/expense_account_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/expense/expense_models.dart';
import 'package:ausales_application/service/expense_account/expense_account_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class ExpenseDeletePopup extends StatelessWidget {
  ExpenseAccoutListData expense;
  ExpenseDeletePopup({super.key, required this.expense});

  final ExpenseAccountListController _expenseAccountListController = Get.put(ExpenseAccountListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${expense.expensesName}"),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 200.w,
              child: CancelButton(
                isLoading: false, 
                text: "No", 
                onPressed: () {
                  Get.back();
                }
              ),
            ),
            SizedBox(width: 15.w,),
            SizedBox(
              width: 200.w,
              child: Obx(() => PrimaryButton(
                isLoading: _expenseAccountListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _expenseAccountListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await ExpenseAccountService.deleteExpense(menuId: menuId.toString(), expenseId: expense.id.toString(), context: context);
                  }
                  _expenseAccountListController.getExpenseAccountList(context);
                  _expenseAccountListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}