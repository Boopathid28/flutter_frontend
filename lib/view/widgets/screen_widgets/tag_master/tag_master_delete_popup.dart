import 'package:ausales_application/controller/tag_master/tag_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/tag_master/tag_master_model.dart';
import 'package:ausales_application/service/tag_master/tag_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagMasterDeletePopup extends StatelessWidget {
  TagMasterListData item;
  TagMasterDeletePopup({super.key, required this.item});

  final TagMasterListController _tagMasterListController = Get.put(TagMasterListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.tagName}"),
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
                isLoading: _tagMasterListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _tagMasterListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await TagMasterService.deleteTagMaster(menuId: menuId.toString(), tagId: item.id.toString(), context: context);
                  }
                  _tagMasterListController.getTagMasterList(context);
                  _tagMasterListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}