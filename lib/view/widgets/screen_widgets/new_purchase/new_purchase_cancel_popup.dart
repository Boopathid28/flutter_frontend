import 'package:ausales_application/controller/new_purchase/new_purchase_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/new_purchase/new_purchase_model.dart';
import 'package:ausales_application/service/new_purchase/new_purchase_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPurchaseCancelPopup extends StatelessWidget {
  FetchNewPurchaseListResponse newPurchaseItem;
  NewPurchaseCancelPopup({super.key, required this.newPurchaseItem});

  final NewPurchaseListController _newPurchaseListController =
      Get.put(NewPurchaseListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
          Text("Are you sure want to cancel the ${newPurchaseItem.poId}"),
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
                  }),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              width: 200.w,
              child: Obx(() => PrimaryButton(
                  isLoading: _newPurchaseListController.isDeleteLoading.value,
                  text: "Yes",
                  onPressed: () async {
                    _newPurchaseListController.isDeleteLoading(true);
                    int? menuId = await HomeSharedPrefs.getCurrentMenu();
                    if (menuId != null) {
                      await NewPurchaseService.cancelNewPurchase(
                          menuId: menuId.toString(),
                          newPurchaseId: newPurchaseItem.id.toString(),
                          context: context);
                    }
                    _newPurchaseListController.getNewPurchaseList(context);
                    _newPurchaseListController.isDeleteLoading(false);
                  })),
            )
          ],
        )
      ],
    );
  }
}
