import 'package:ausales_application/controller/designer/designer_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/designer/designer_model.dart';
import 'package:ausales_application/service/designer/designer_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DesignerDeletePopup extends StatelessWidget {
  DesignerListData item;
  DesignerDeletePopup({super.key, required this.item});

  final DesignerListController _designerListController = Get.put(DesignerListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.designerName}"),
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
                isLoading: _designerListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _designerListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await DesignerService.deleteDesigner(menuId: menuId.toString(), designerId: item.id.toString(), context: context);
                  }
                  _designerListController.getDesignerlist(context);
                  _designerListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}