import 'package:ausales_application/responsive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
          height: 40.h,
          width: size.width,
          color: Color(0xffC23449),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Powered by ',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: Responsive.isDesktop(context) ? 14.sp : 8.sp),
                  children: [
                    TextSpan(
                      text: 'Atts',
                      style: TextStyle(
                        color: Colors.blue, // Highlight the clickable text
                        fontSize: Responsive.isDesktop(context) ? 14.sp : 8.sp,
                        decoration: TextDecoration.underline, // Optionally add underline
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          const url = 'https://atts.in';
                          // Uncomment the following line if you need to launch the URL
                          // if (await canLaunch(url)) launch(url);
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "© 2024 ATTS PVT LMT · by Technical Team.",
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: Responsive.isDesktop(context) ? 14.sp : 8.sp),
              ),
            ],
          ),
        );
  }
}