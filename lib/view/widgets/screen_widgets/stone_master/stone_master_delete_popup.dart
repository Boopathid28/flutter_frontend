import 'package:ausales_application/controller/stone_master/stone_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/stone_master/stone_master_model.dart';
import 'package:ausales_application/service/stone_master/stone_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoneMasterDeletePopup extends StatelessWidget {
  StoneMasterListData item;
  StoneMasterDeletePopup({super.key, required this.item});

  final StoneMasterListController _stoneMasterListController = Get.put(StoneMasterListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.stoneName}"),
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
                isLoading: _stoneMasterListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _stoneMasterListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await StoneMasterService.deleteStoneMaster(menuId: menuId.toString(), stoneId: item.id.toString(), context: context);
                  }
                  _stoneMasterListController.getStoneMasterList(context);
                  _stoneMasterListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}