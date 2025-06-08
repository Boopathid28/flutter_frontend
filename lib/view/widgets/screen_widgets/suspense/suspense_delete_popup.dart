import 'package:ausales_application/controller/suspense/suspense_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/service/suspense/suspense_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseDeletePopup extends StatelessWidget {
  SuspenseListData item;
  SuspenseDeletePopup({super.key, required this.item});

  final SuspenseListController _suspenseListController = Get.put(SuspenseListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete ${item.suspenseId}"),
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
                isLoading: _suspenseListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _suspenseListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await SuspenseService.deleteSuspense(menuId: menuId.toString(), suspenseId: item.id.toString(), context: context);
                  }
                  _suspenseListController.getsuspenseList(context);
                  _suspenseListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}