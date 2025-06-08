import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLabelFilter extends StatelessWidget {

  String label;

  CustomLabelFilter({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(
      color: ColorPalete.formLabelTextColor,
      fontSize: Responsive.isDesktop(context) ? 16.sp : 10.sp
    ),);
  }
}