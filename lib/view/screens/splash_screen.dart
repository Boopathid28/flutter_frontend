import 'dart:developer';

import 'package:ausales_application/core/constants/image_constant.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      String token = await AuthSharedPrefs.getToken();
      String sessionKey = await AuthSharedPrefs.getSessionKey();

      if (token.isNotEmpty && sessionKey.isNotEmpty) {
        navHome();
      } else {
        navLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: ColorPalete.splashBgColor,
      child: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage(ImagesConstant.imgLogo),
              width: Responsive.isDesktop(context) ? 300.w : 100.w,
            ),
          )
        ],
      ),
    );
  }
}
