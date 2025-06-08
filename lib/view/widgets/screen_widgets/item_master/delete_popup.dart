import 'package:ausales_application/controller/item_master/item_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/item_master/item_master_models.dart';
import 'package:ausales_application/service/item_master/item_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemMasterDeletePopup extends StatelessWidget {
  ItemListData item;
  ItemMasterDeletePopup({super.key, required this.item});

  final ItemMasterListController _itemMasterListController = Get.put(ItemMasterListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.itemName}"),
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
                isLoading: _itemMasterListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _itemMasterListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await ProductItemService.deleteItem(menuId: menuId.toString(), itemId: item.id.toString(), context: context);
                  }
                  _itemMasterListController.getItemList(context);
                  _itemMasterListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}