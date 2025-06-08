import 'package:ausales_application/controller/subitem_master/subitem_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:ausales_application/service/subitem_master/subitem_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubitemDeletePopup extends StatelessWidget {
  SubItemListData item;
  SubitemDeletePopup({super.key, required this.item});

  final SubitemMasterListController _subitemMasterListController = Get.put(SubitemMasterListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.subItemName}"),
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
                isLoading: _subitemMasterListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _subitemMasterListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await SubitemMasterService.deleteSubItem(menuId: menuId.toString(), subItemId: item.id.toString(), context: context);
                  }
                  _subitemMasterListController.getSubItemList(context);
                  _subitemMasterListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}