import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/expense/expense_models.dart';
import 'package:ausales_application/service/expense_account/expense_account_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExpenseAccountListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;


  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<ExpenseAccoutListData> tableData = <ExpenseAccoutListData>[].obs;

  Future getExpenseAccountList(BuildContext context) async {
    isTableLoading(true);
    
    FetchExpenseAccoutListPayload payload = FetchExpenseAccoutListPayload(
        search: searchController.text,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? expenseaccountlist =
        await ExpenseAccountService.fetchExpenseAccountList(payload: payload);

    if (expenseaccountlist != null) {
      tableData(expenseaccountlist['data']);
      totalpages(expenseaccountlist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }
}
