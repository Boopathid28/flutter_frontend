import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:flutter/material.dart';



class CustomCheckbox extends StatelessWidget {

  bool value;
  Function(bool? value)? onChange;

  CustomCheckbox({
    super.key,
    required this.value,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChange,
      shape: const CircleBorder(),
      activeColor: ColorPalete.primaryColor,
      side: const BorderSide(width: 0.5),
    );
  }
}
