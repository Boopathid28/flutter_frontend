import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPrimaryButton extends StatelessWidget {
  double btnHeight;
  double btnWidth;
  bool isLoading;
  String text;
  void Function() onPressed;

  BillingPrimaryButton(
      {super.key,
      this.btnHeight = 30.0,
      this.btnWidth = 40,
      required this.isLoading,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalete.primaryBtnColor,
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
                      width: 10.w,
                      height: 10.w,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 4.sp,
                      ),
                    )
                    : Text(
                        text,
                        style: TextStyle(
                          color: ColorPalete.primaryBtnTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 10
                        ),
                      ),
              )),
        ));
  }
}
