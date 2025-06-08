import 'package:ausales_application/controller/old_purchase/old_purchase_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/service/old_purchase/old_purchase_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldPurchaseCancelPopup extends StatelessWidget {
  FetchOldPurchaseListResponse oldItem;
  OldPurchaseCancelPopup({super.key, required this.oldItem});

  final OldPurchaseListController _oldPurchaseListController =
      Get.put(OldPurchaseListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
          Text("Are you sure want to cancel the ${oldItem.oldGoldBillNumber}"),
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
                  isLoading: _oldPurchaseListController.isDeleteLoading.value,
                  text: "Yes",
                  onPressed: () async {
                    _oldPurchaseListController.isDeleteLoading(true);
                    int? menuId = await HomeSharedPrefs.getCurrentMenu();
                    if (menuId != null) {
                      await OldPurchaseService.cancelOldPurchase(
                          menuId: menuId.toString(),
                          oldPurchaseId: oldItem.id.toString(),
                          context: context);
                    }
                    _oldPurchaseListController.getOldPurchaseList(context);
                    _oldPurchaseListController.isDeleteLoading(false);
                  })),
            )
          ],
        )
      ],
    );
  }
}
