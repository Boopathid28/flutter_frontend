import 'package:ausales_application/controller/user_role/userrole_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/user_role/user_role_card.dart';
import 'package:ausales_application/view/widgets/screen_widgets/user_role/user_role_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserRoleScreen extends StatefulWidget {
  const UserRoleScreen({super.key});

  @override
  State<UserRoleScreen> createState() => _UserRoleScreenState();
}

class _UserRoleScreenState extends State<UserRoleScreen> {
  final UserroleListController _userroleListController =
      Get.put(UserroleListController());

  @override
  void initState() {
    super.initState();
    _userroleListController.getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _userroleListController.scaffoldKey,
      onRefresh: () {
        _userroleListController.getUserRole();
      },
      isHome: true,
      child: Scaffold(
        key: _userroleListController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
          appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        endDrawer: EndMenuDrawerWidget(),
        bottomNavigationBar: Footer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      "Users",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          // UserroleListController.getUserList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              UserRoleForm(),
              // UserTableHeader(),
              // height(context),
              card(context),
              SizedBox(
                height: defaultBottombarHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox height(BuildContext context) {
    return SizedBox(
      height: Responsive.isDesktop(context)
          ? desktopAppbarHeight
          : defaultAppbarHeight,
    );
  }

  Padding card(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Obx(() => GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context)
                  ? 4
                  : Responsive.isTablet(context)
                      ? 2
                      : 1, // Number of columns
              crossAxisSpacing: 10.w, // Spacing between columns
              mainAxisSpacing: 10.h, // Spacing between rows
              mainAxisExtent: 100.h),
          itemCount: _userroleListController.userroleList.length,
          itemBuilder: (context, index) => UserRoleCard(
              item: _userroleListController.userroleList.value[index],
              index: index))),
    );
  }
}
