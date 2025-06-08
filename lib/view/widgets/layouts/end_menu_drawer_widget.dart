import 'package:ausales_application/controller/home_controller.dart';
import 'package:ausales_application/controller/layout/end_drawer_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/layouts/menu_card.dart';
import 'package:ausales_application/view/widgets/layouts/menu_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EndMenuDrawerWidget extends StatefulWidget {
  const EndMenuDrawerWidget({super.key});

  @override
  State<EndMenuDrawerWidget> createState() => _EndMenuDrawerWidgetState();
}

class _EndMenuDrawerWidgetState extends State<EndMenuDrawerWidget> {
  final EndDrawerController _endDrawerController =
      Get.put(EndDrawerController());

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 400.w
            : 300.w,
        child: Stack(
          children: [
            Positioned(
              top: 175.h,
              child: SizedBox(
                width: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? 400.w
                    : 300.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Container(
                    height: size.height * 0.75,
                    child: Obx(() => _endDrawerController.menuGroupClicked.value
                        ? ListView.builder(
                            itemCount: _endDrawerController
                                .activeMenuGroup.value.menuList!.length,
                            itemBuilder: (context, index) => MenuCard(
                                  item: _endDrawerController
                                      .activeMenuGroup.value.menuList![index],
                                ))
                        : ListView.builder(
                            itemCount:
                                _homeController.userMenuPermissionList.length,
                            itemBuilder: (context, index) => MenuGroupCard(
                                item: _homeController
                                    .userMenuPermissionList.value[index],
                                index: index))),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _endDrawerController.menuGroupClicked(false);
                          _endDrawerController.activeMenuIndex(0);
                          _endDrawerController.activeMenuGroup(null);
                          Scaffold.of(context).closeEndDrawer();
                        },
                        child: Container(
                          margin: EdgeInsets.all(15.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.close,
                                size: 25.sp,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Esc",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
                              )
                            ],
                          ),
                        )),
                    Container(
                      width: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 400.w
                          : 300.w,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: CustomTextInput(
                          hintText: "Search",
                          filled: true,
                          hasPrefixIcon: true,
                          prefixIcon: Icons.search,
                          controller: _endDrawerController.menuSearchController,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.text),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Row(
                          children: [
                            Obx(() => Visibility(
                                  visible: _endDrawerController
                                      .menuGroupClicked.value,
                                  child: GestureDetector(
                                      onTap: () {
                                        _endDrawerController
                                            .menuGroupClicked(false);
                                        _endDrawerController.activeMenuIndex(0);
                                        _endDrawerController
                                            .activeMenuGroup(null);
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 18.sp,
                                      )),
                                )),
                            SizedBox(
                              width: 20.w,
                            ),
                            Obx(
                              () => Visibility(
                                visible:
                                    _endDrawerController.menuGroupClicked.value,
                                child: Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '$baseMediaUrl/${_endDrawerController.activeMenuGroup.value.menuGroupIcon}'),
                                      width: 25.w,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                        _endDrawerController.activeMenuGroup
                                                .value.menuGroupName ??
                                            "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
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
