import 'package:ausales_application/controller/old_metal_rate/old_metal_rate_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/old_metal_rate/old_metal_rate_models.dart';
import 'package:ausales_application/service/old_metal_rate/old_metal_rate_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class OldMetalRateDeletePopup extends StatelessWidget {
  OldMetalRateListData oldMetalRate;
  OldMetalRateDeletePopup({super.key, required this.oldMetalRate});

  final OldMetalRateListController _oldMetalRateListController = Get.put(OldMetalRateListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${oldMetalRate.metalDetailsName}"),
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
                isLoading: _oldMetalRateListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _oldMetalRateListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await OldMetalRateService.deleteOldMetalRate(menuId: menuId.toString(),metalId:oldMetalRate.id.toString(), context: context );

                  }
                  _oldMetalRateListController.getOldMetalRateList(context);
                  _oldMetalRateListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}