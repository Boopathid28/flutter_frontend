import 'package:ausales_application/controller/purification/purification_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/purification/purification_models.dart';
import 'package:ausales_application/service/purification/purification_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class PurificationDeletePopup extends StatelessWidget {
  PurificationListData purification;
  PurificationDeletePopup({super.key, required this.purification});

  final PurificationListController _purificationListController = Get.put(PurificationListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${purification.purificationId}"),
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
                isLoading: _purificationListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _purificationListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await PurificationService.deletePurification(menuId: menuId.toString(), purificationId: purification.id.toString(), context: context);
                  }
                  _purificationListController.getPurificationList(context);
                  _purificationListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}