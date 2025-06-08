import 'package:ausales_application/controller/lot/lot_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:ausales_application/service/lot/lot_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LotDeletePopup extends StatelessWidget {
  LotListData lot;
  LotDeletePopup({super.key, required this.lot});

  final LotListController _lotListController = Get.put(LotListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${lot.lotNumber}"),
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
                isLoading: _lotListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _lotListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await LotService.deleteLot(menuId: menuId.toString(), lotId: lot.id.toString(), context: context);
                  }
                  _lotListController.getLotList(context);
                  _lotListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}