import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingLabel extends StatelessWidget {

  String label;

  BillingLabel({
    super.key,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(
      color: ColorPalete.formLabelTextColor,
      fontSize: Responsive.isDesktop(context) ? 10.sp : 7.sp
    ),);
  }
}