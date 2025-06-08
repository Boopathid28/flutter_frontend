import 'package:ausales_application/controller/expense_account/expense_account_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/expense/expense_models.dart';
import 'package:ausales_application/service/expense_account/expense_account_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseAccountFormController extends GetxController {
  final ExpenseAccountListController _expenseAccountListController = Get.put(ExpenseAccountListController());

  final expenseFormKey = GlobalKey<FormState>();

  Rx<ExpenseAccoutListData?> currentExpense = Rx<ExpenseAccoutListData?>(null);

  TextEditingController expenseNameController = TextEditingController();
  
  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  Future submitExpenseForm(BuildContext context) async {
    if (expenseFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        if (fromMode.value == "create") {
          final CreateExpenseAccountPayload payload = CreateExpenseAccountPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
expensesName: expenseNameController.text
          );

          await ExpenseAccountService.createExpenseAccount(context: context, payload: payload);
          _expenseAccountListController.getExpenseAccountList(context);
        } else {
          final UpdateExpenseAccountpayload payload = UpdateExpenseAccountpayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              expensesName:expenseNameController.text,
              id: currentExpense.value?.id,
              );

          await ExpenseAccountService.updateExpenseAccount(context: context, payload: payload);
          _expenseAccountListController.getExpenseAccountList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    expenseFormKey.currentState!.reset();
    fromMode("create");
  }
}
