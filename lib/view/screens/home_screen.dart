import 'package:ausales_application/controller/home_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/home/menu_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.getUserPermission();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: ShorcutKeyboardHandler(
        scaffoldKey: _homeController.scaffoldKey,
        onRefresh: () {
          _homeController.getUserPermission();
        },
        isHome: true,
        child: Scaffold(
          key: _homeController.scaffoldKey,
          backgroundColor: ColorPalete.appBgColor,
          endDrawer: EndMenuDrawerWidget(),
          body: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Responsive.isDesktop(context)
                            ? desktopAppbarHeight
                            : defaultAppbarHeight,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Obx(() => GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: Responsive.isDesktop(context)
                                        ? 4
                                        : Responsive.isTablet(context)
                                            ? 2
                                            : 1, // Number of columns
                                    crossAxisSpacing:
                                        10.w, // Spacing between columns
                                    mainAxisSpacing: 10.h, // Spacing between rows
                                    mainAxisExtent: 100.h),
                            itemCount:
                                _homeController.userMenuPermissionList.length,
                            itemBuilder: (context, index) => MenuGroupCard(
                                item: _homeController
                                    .userMenuPermissionList.value[index],
                                index: index))),
                      ),
                    ],
                  ),
                ),
                HeaderWidget(),
                Positioned(bottom: 0, child: Footer())
              ],
            ),
          ),
        ),
      ),
    );
  }
}