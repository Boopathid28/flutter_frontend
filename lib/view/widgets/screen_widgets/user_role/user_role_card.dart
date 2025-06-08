import 'package:ausales_application/controller/user_role/userrole_form_controller.dart';
import 'package:ausales_application/controller/user_role/userrole_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/user_role/user_role_models.dart';
import 'package:ausales_application/service/user_role/user_role_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/screen_widgets/user_role/delete_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UserRoleCard extends StatelessWidget {
  UserRoleListData item;
  int index;
  UserRoleCard({super.key, required this.item, required this.index});

  final UserroleFormController _userroleFormController =
      Get.put(UserroleFormController());

  final UserroleListController _userroleListController =
      Get.put(UserroleListController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      color: Colors.white,
      child: SizedBox(
        height: 20.h,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.roleName!,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                    Tooltip(
                      message: "update user role status",
                      child: CustomSwitch(
                          value: item.isActive,
                          onChanged: (index) async {
                            int? menuId = await HomeSharedPrefs.getCurrentMenu();
                            if (menuId != null) {
                              await UserRoleService.updateUserRoleStatus(
                                  menuId: menuId.toString(),
                                  userRoleId: item.id.toString(),
                                  context: context);
                            }
                            _userroleListController.getUserRole();
                          }),
                    ),
                    Row(
                      children: [
                        Tooltip(
                          message: "edit user role",
                          child: IconButton(
                              onPressed: () {
                                _userroleFormController.roleNameController.text =
                                    item.roleName!;
                                _userroleFormController.currentUser(item);
                                _userroleFormController.fromMode("update");
                              },
                              icon: Icon(Icons.edit)),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Tooltip(
                          message: "delete user role",
                          child: GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) =>
                                        UserRoleDeletepopup(userrole: item));
                              },
                              child: Icon(Icons.delete)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
