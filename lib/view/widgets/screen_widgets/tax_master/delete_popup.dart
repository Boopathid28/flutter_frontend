import 'package:ausales_application/controller/tax_master/tax_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/tax/tax_models.dart';
import 'package:ausales_application/service/tax_master/tax_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class TaxDeletepopup extends StatelessWidget {
  TaxListData tax;
  TaxDeletepopup({super.key, required this.tax});

  final TaxListController _taxlistController = Get.put(TaxListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${tax.taxName}"),
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
                isLoading: _taxlistController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _taxlistController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await TaxService.deleteTax(menuId: menuId.toString(), taxId: tax.id.toString(), context: context);
                  }
                  _taxlistController.getTaxList(context);
                  _taxlistController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}