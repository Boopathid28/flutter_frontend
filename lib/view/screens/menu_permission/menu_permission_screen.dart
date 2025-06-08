import 'package:ausales_application/controller/menu_permission/menu_permission_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/menu_permission/menu_permission_table_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuPermissionScreen extends StatefulWidget {
  const MenuPermissionScreen({super.key});

  @override
  State<MenuPermissionScreen> createState() => _MenuPermissionScreenState();
}

class _MenuPermissionScreenState extends State<MenuPermissionScreen> {
  final MenuPermissionController _menuPermissionController =
      Get.put(MenuPermissionController());

  @override
  Widget build(BuildContext context) {
    return ShorcutKeyboardHandler(
      scaffoldKey: _menuPermissionController.scaffoldKey,
      onRefresh: () {
        _menuPermissionController.getMenuPermissionList(_menuPermissionController.selectedUserRole.value!.value);
      },
      child: Scaffold(
          key: _menuPermissionController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
         endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [pageTitle(), userrole()],
                      )
                    : Column(
                        children: [
                          pageTitle(),
                          SizedBox(
                            height: 5.h,
                          ),
                          userrole()
                        ],
                      ),
              ),
              SizedBox(
                height: 10.h,
              ),
              MenuPermissionTableList()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox pageTitle() {
    return SizedBox(
      child: Row(
        children: [
          Text(
            "Menu Permission",
            style: TextPalette.screenTitle,
          ),
          SizedBox(
            width: 10.w,
          ),
          IconButton(
              onPressed: () {
                _menuPermissionController.getMenuPermissionList(
                    _menuPermissionController.selectedUserRole.value!.value
                        .toString());
                _menuPermissionController.getUserRoleList();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
    );
  }

  SizedBox userrole() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
        filled: true,
            controller: _menuPermissionController.searchRoleController,
            selectedValue: _menuPermissionController.selectedUserRole.value,
            options: _menuPermissionController.userRoleDropDown.value,
            onChanged: (value) {
              _menuPermissionController.selectedUserRole(value);
              _menuPermissionController
                  .getMenuPermissionList(value!.value.toString());
            },
            hintText: "User role",
          )),
    );
  }
}
