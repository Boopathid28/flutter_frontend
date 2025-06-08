import 'package:ausales_application/controller/user_role/userrole_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/user_role/user_role_models.dart';
import 'package:ausales_application/service/user_role/user_role_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class UserRoleDeletepopup extends StatelessWidget {
  UserRoleListData userrole;
  UserRoleDeletepopup({super.key, required this.userrole});

  final UserroleListController _userroleListController = Get.put(UserroleListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${userrole.roleName}"),
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
                isLoading: _userroleListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _userroleListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await UserRoleService.deleteUserRole(menuId: menuId.toString(), userroleId: userrole.id.toString(), context: context);
                  }
                  _userroleListController.getUserRole();
                  _userroleListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}