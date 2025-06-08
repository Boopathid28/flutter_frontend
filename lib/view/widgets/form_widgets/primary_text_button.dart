import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryTextButton extends StatelessWidget {
  String text;
  void Function() onPressed;
  double textSize;

  PrimaryTextButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.textSize = 14.0});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: ColorPalete.primaryBtnColor,
              fontWeight: FontWeight.w600,
              fontSize: textSize),
        ));
  }
}
