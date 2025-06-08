import 'package:ausales_application/controller/company_ledger/company_ledger_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_models.dart';
import 'package:ausales_application/service/company_ledger/company_ledger_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CompanyLedgerDeletePopup extends StatelessWidget {
  CompanyLedgerListData comany;
  CompanyLedgerDeletePopup({super.key, required this.comany});

  final CompanyLedgerListController _companyLedgerListController = Get.put(CompanyLedgerListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete ${comany.expenseId}"),
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
                isLoading: _companyLedgerListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _companyLedgerListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await CompanyLedgerService.deleteCompanyLedger(menuId: menuId.toString(), companyId: comany.id.toString(), context: context);
                  }
                  _companyLedgerListController.getcompanyledgerList(context);
                  _companyLedgerListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}