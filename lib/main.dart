import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io' show Platform;
import 'package:paged_datatable/paged_datatable.dart';

void main() async {
  if (Platform.isAndroid || Platform.isIOS) {
    runApp(MyApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize the window manager
    await windowManager.ensureInitialized();

    // Set the window options
    WindowOptions windowOptions = const WindowOptions(
      size: Size(800, 600), // Initial window size
      center: true, // Center the window
      // backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    // Apply the window options
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.maximize(); // Maximimize the window
    });

    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Responsive.isMobile(context)
            ? const Size(360, 800)
            : Responsive.isTablet(context)
                ? const Size(1024, 768)
                : const Size(1536, 864),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return ToastificationWrapper(
            child: GetMaterialApp(
              title: "Ausales",
              localizationsDelegates: const [
                // GlobalMaterialLocalizations.delegate,
                // GlobalCupertinoLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate,
                PagedDataTableLocalization.delegate
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: false,
                fontFamily: "Inter"
              ),
              home: SplashScreen(),
            ),
          );
        });
  }
}
