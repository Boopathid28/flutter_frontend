import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/user/user_model.dart';
import 'package:ausales_application/service/user/user_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class DeletePopup extends StatelessWidget {
  UserListData user;
  DeletePopup({super.key, required this.user});

  final UserListController _userListController = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${user.username}"),
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
                isLoading: _userListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _userListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await UserService.deleteUser(menuId: menuId.toString(), userId: user.id.toString(), context: context);
                  }
                  _userListController.getUserList(context);
                  _userListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}