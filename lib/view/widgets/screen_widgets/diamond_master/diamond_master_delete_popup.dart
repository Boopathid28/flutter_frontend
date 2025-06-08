import 'package:ausales_application/controller/diamond_master/diamond_master_list_controller.dart';
import 'package:ausales_application/controller/stone_master/stone_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/diamond_master/diamond_master_model.dart';
import 'package:ausales_application/service/diamond_master/diamond_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DiamondMasterDeletePopup extends StatelessWidget {
  DiamondMasterListData item;
  DiamondMasterDeletePopup({super.key, required this.item});

  final DiamondMasterListController _diamondMasterListController = Get.put(DiamondMasterListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.diamondName}"),
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
                isLoading: _diamondMasterListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _diamondMasterListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await DiamondMasterService.deleteDiamondMaster(menuId: menuId.toString(), diamondId: item.id.toString(), context: context);
                  }
                  _diamondMasterListController.getDiamondMasterList(context);
                  _diamondMasterListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}