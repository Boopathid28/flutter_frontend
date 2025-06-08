import 'package:ausales_application/controller/sub_expense_account/Sub_expense_account_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/sub_expense_account/sub_expense_account_models.dart';
import 'package:ausales_application/service/sub_expense_account/sub_expense_account_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SubExpenseDeletePopup extends StatelessWidget {
  SubExpenseAccountListData subexpense;
  SubExpenseDeletePopup({super.key, required this.subexpense});

  final SubExpenseAccountListController _subExpenseAccountListController = Get.put(SubExpenseAccountListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${subexpense.subExpensesName}"),
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
                isLoading: _subExpenseAccountListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _subExpenseAccountListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await SubExpenseAccountService.deleteSubExpenseAccount(menuId: menuId.toString(), subexpenseId: subexpense.id.toString(), context: context);
                  }
                  _subExpenseAccountListController.getSubExpenseAccountList(context);
                  _subExpenseAccountListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}