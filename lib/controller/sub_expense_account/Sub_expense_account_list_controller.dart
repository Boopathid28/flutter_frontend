import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/expense/expense_models.dart';
import 'package:ausales_application/model/sub_expense_account/sub_expense_account_models.dart';
import 'package:ausales_application/service/expense_account/expense_account_service.dart';
import 'package:ausales_application/service/sub_expense_account/sub_expense_account_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SubExpenseAccountListController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;


  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;

  RxList<SubExpenseAccountListData> tableData = <SubExpenseAccountListData>[].obs;

  Future getSubExpenseAccountList(BuildContext context) async {
    isTableLoading(true);
    
    FetchSubExpenseAccountListPayload payload = FetchSubExpenseAccountListPayload(
        search: searchController.text,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? subexpenseaccountlist =
        await SubExpenseAccountService.fetchSubExpenseAccountList(payload: payload);

    if (subexpenseaccountlist != null) {
      tableData(subexpenseaccountlist['data']);
      totalpages(subexpenseaccountlist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }
}
