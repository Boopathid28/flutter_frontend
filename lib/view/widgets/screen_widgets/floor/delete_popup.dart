import 'package:ausales_application/controller/floor/floor_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/floor/floor_models.dart';
import 'package:ausales_application/service/floor/floor_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class FloorDeletepopup extends StatelessWidget {
  FloorListData floor;
  FloorDeletepopup({super.key, required this.floor});

  final FloorListController _floorListController = Get.put(FloorListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${floor.floorName}"),
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
                isLoading: _floorListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _floorListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await FloorService.deleteFloor(menuId: menuId.toString(), floorId: floor.id.toString(), context: context);
                  }
                  _floorListController.getfloorList(context);
                  _floorListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}