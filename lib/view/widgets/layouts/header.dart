import 'package:ausales_application/controller/home_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/image_constant.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/auth_service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final HomeController _homeController = Get.put(HomeController());
  final HeaderController _headerController = Get.put(HeaderController());

  @override
  void initState() {
    super.initState();
    _homeController.getUserPermission();
    _headerController.getMetalRates();
    _headerController.getIsBranchUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal:
                Responsive.isDesktop(context) || Responsive.isTablet(context)
                    ? 25.w
                    : 5.w,
            vertical:
                Responsive.isDesktop(context) || Responsive.isTablet(context)
                    ? 15.h
                    : 5.h),
        height: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? desktopAppbarHeight
            : defaultAppbarHeight,
        decoration: const BoxDecoration(
          color: Color(0xffC23449),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                navHome();
              },
              child: Image(
                image: const AssetImage(ImagesConstant.imgLogo),
                width: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? 150.w
                    : 50.w,
              ),
            ),
            Obx(() => _headerController.displayRates.length > 2
                ? SizedBox(
                    width: 500.w,
                    child: TextScroll(
                      '${_headerController.metalDisplayRate.value}',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorPalete.appBgColor,
                          letterSpacing: 2),
                      intervalSpaces: 10,
                      velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                    ),
                  )
                : SizedBox(
                    height: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? desktopAppbarHeight
                        : defaultAppbarHeight,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _headerController.minDisplayRates.length,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 15.w,
                      ),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              '${_headerController.minDisplayRates.value[index].metalName}:',
                              style: TextStyle(
                                  color: ColorPalete.appBgColor,
                                  fontSize: Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)
                                      ? 14.sp
                                      : 5.sp),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '${_headerController.minDisplayRates.value[index].rate}',
                              style: TextStyle(
                                  color: ColorPalete.metalRatesColor,
                                  fontSize: Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)
                                      ? 14.sp
                                      : 5.sp),
                            ),
                          ],
                        );
                      },
                    ),
                  )),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: ColorPalete.appBgColor,
                  size: 20.sp,
                ),
                SizedBox(width: 15.w),
                GestureDetector(
                    onTap: () async {
                      await LoginService.logoutUser(context: context);
                    },
                    child: Icon(
                      Icons.logout,
                      color: ColorPalete.appBgColor,
                      size: 20.sp,
                    )),
                SizedBox(width: 15.w),
                GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Icon(Icons.menu,
                        color: ColorPalete.appBgColor,
                        size: Responsive.isDesktop(context) ||
                                Responsive.isTablet(context)
                            ? 20.sp
                            : 15.sp)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
