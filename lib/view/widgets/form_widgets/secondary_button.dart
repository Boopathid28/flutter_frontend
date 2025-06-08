import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatelessWidget {
  double btnHeight;
  double btnWidth;
  bool isLoading;
  String text;
  void Function()? onPressed;

  SecondaryButton(
      {super.key,
      this.btnHeight = 45.0,
      this.btnWidth = double.infinity,
      required this.isLoading,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalete.secondartBtnColor,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r))),
        child: Ink(
          decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(10.r)),
          child: Container(
              width: btnWidth,
              height: btnHeight,
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4.sp,
                        ),
                      )
                    : Text(
                        text,
                        style: TextStyle(
                            color: ColorPalete.secondartBtnTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: Responsive.isDesktop(context) ? 13.sp : 10.sp),
                      ),
              )),
        ));
  }
}
