import 'package:ausales_application/controller/metal_master/metal_list_controller.dart';
import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/metal_master/metal_models.dart';
import 'package:ausales_application/model/user/user_model.dart';
import 'package:ausales_application/service/metal_master/metal_service.dart';
import 'package:ausales_application/service/user/user_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class MetalDeletePopup extends StatelessWidget {
  MetalListData metal;
  MetalDeletePopup({super.key, required this.metal});

  final MetalListController _metalListController = Get.put(MetalListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${metal.metalName}"),
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
                isLoading: _metalListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _metalListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await MetalService.deleteMetal(menuId: menuId.toString(), metalId: metal.id.toString(), context: context);
                  }
                  _metalListController.getMetalList(context);
                  _metalListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}