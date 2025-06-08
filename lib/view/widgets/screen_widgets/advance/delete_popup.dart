import 'package:ausales_application/controller/advance/advance_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/service/advance/advance_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class AdvanceDeletePopup extends StatelessWidget {
  AdvanceListData advance;
  AdvanceDeletePopup({super.key, required this.advance});

  final AdvanceListController _advanceListController = Get.put(AdvanceListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${advance.advanceId}"),
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
                isLoading: _advanceListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _advanceListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await AdvanceService.deleteAdvance(menuId: menuId.toString(), advanceId: advance.id.toString(), context: context);
                  }
                  _advanceListController.getAdvanceList(context);
                  _advanceListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}