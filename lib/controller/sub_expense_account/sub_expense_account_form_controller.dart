import 'package:ausales_application/controller/sub_expense_account/Sub_expense_account_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/sub_expense_account/sub_expense_account_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/sub_expense_account/sub_expense_account_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubExpenseAccountFormController extends GetxController {
  final SubExpenseAccountListController _subexpenseAccountListController =
      Get.put(SubExpenseAccountListController());

  final subexpenseFormKey = GlobalKey<FormState>();

  Rx<SubExpenseAccountListData?> currentsubExpense = Rx<SubExpenseAccountListData?>(null);

  TextEditingController subexpenseNameController = TextEditingController();
  TextEditingController searchsubexpenseController = TextEditingController();

  Rx<DropdownModel?> selectedExpense = Rx<DropdownModel?>(null);

  RxList<DropdownModel> expensedropdown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    getExpenseDropdown();
  }

  Future getExpenseDropdown() async {
    expensedropdown([]);
    final List<ExpenseDropDown> tempList =
        await DropdownService.expenseDropDown();
    tempList.forEach((item) {
      expensedropdown.add(
          DropdownModel(label: item.expensesName!, value: item.id.toString()));
    });
  }

  Future submitSubExpenseForm(BuildContext context) async {
    if (subexpenseFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        if (fromMode.value == "create") {
          final CreateSubExpenseAccountPayload payload =
              CreateSubExpenseAccountPayload(
                  menuId: await HomeSharedPrefs.getCurrentMenu(),
                  expenses: selectedExpense.value!.value,
                  subExpensesName: subexpenseNameController.text);

          await SubExpenseAccountService.createSubExpenseAccount(
              context: context, payload: payload);
          _subexpenseAccountListController.getSubExpenseAccountList(context);
        } else {
          final UpdateSubExpenseAccountPayload payload =
              UpdateSubExpenseAccountPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            subExpensesName: subexpenseNameController.text,
            expenses: selectedExpense.value!.value,
            id: currentsubExpense.value?.id,
          );

          await SubExpenseAccountService.updateSubExpenseAccount(
              context: context, payload: payload);
          _subexpenseAccountListController.getSubExpenseAccountList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    subexpenseFormKey.currentState!.reset();
    subexpenseNameController.clear();
    selectedExpense.value = null;
    fromMode("create");
  }
}
