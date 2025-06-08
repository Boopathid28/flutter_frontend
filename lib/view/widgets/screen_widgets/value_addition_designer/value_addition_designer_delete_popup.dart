import 'package:ausales_application/controller/value_addition_designer/value_addition_designer_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/value_addition_designer/value_addition_designer_models.dart';
import 'package:ausales_application/service/value_addition_designer/value_addition_designer_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionDesignerDeletePopup extends StatelessWidget {
  ValueAdditionListData item;
  ValueAdditionDesignerDeletePopup({super.key, required this.item});

  final ValueAdditionDesignerListController _valueAdditionDesignerListController = Get.put(ValueAdditionDesignerListController());

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
                isLoading: _valueAdditionDesignerListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _valueAdditionDesignerListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await ValueAdditionDesignerService.deleteValueAdditionDesigner(menuId: menuId.toString(), valueadditiondesignerId: item.id.toString(), context: context);
                  }
                  _valueAdditionDesignerListController.getValueAdditionDesignerlist(context);
                  _valueAdditionDesignerListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}