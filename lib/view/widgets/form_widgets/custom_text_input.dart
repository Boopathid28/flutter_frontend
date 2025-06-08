import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/validation_helpler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextInput extends StatelessWidget {
  TextEditingController controller;
  bool filled;
  String? hintText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  int? maxLength;
  bool readOnly;
  bool hideText;
  String validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  Function()? suffixClicked;
  bool hasPrefixIcon;
  bool hasSuffixIcon;
  Function(String value)? onChanged;
  VoidCallback? onTap;
  String inputFormat;
  int minLines;
  int maxLines;

  CustomTextInput(
      {super.key,
      required this.controller,
      this.filled = false,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLength,
      this.readOnly = false,
      this.hideText = false,
      this.validator = "default",
      required this.textInputAction,
      required this.keyboardType,
      this.suffixClicked,
      this.hasPrefixIcon = false,
      this.hasSuffixIcon = false,
      this.onChanged,
      this.inputFormat = "text",
      this.onTap,
      this.minLines = 1,
      this.maxLines = 1,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      onTap: onTap,
      controller: controller,
      onChanged: onChanged,
      validator: (value) {
        var result = "";
        if (validator == "username") {
          result = ValidationHelper.username(value!);
        } else if (validator == "password") {
          result = ValidationHelper.password(value!);
        } else if (validator == "default") {
          result = ValidationHelper.defaultTextField(value!);
        } else if (validator == "default_double_input") {
          result = ValidationHelper.defaultDoubleField(value!);
        }else if (validator == "phone") {
          result = ValidationHelper.phone(value!);
        }else if (validator == "email") {
          result = ValidationHelper.email(value!);
        }else if (validator == "no_validation") {
          result = "";
        }

        if (result.isEmpty) {
          return null;
        } else {
          return result;
        }
      },
      maxLength: maxLength,
      readOnly: readOnly,
      obscureText: hideText,
      cursorColor: ColorPalete.primaryColor,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormat == "double" ? [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
      ] : inputFormat == "integer" ? [
        FilteringTextInputFormatter.digitsOnly
      ] : [],
      decoration: InputDecoration(
          filled: filled,
          fillColor: ColorPalete.inputFilledColor,
          hintText: hintText,
          hintStyle: TextStyle(color: ColorPalete.filledInputPlaceholderColor),
          prefixIcon: hasPrefixIcon
              ? Icon(
                  prefixIcon,
                  color: ColorPalete.filledInputPrefixSuffixColor,
                  size: 20.sp,
                )
              : null,
          suffixIcon: hasSuffixIcon ? IconButton(
            icon: Icon(
              suffixIcon,
              color: ColorPalete.filledInputPrefixSuffixColor,
              size: 20.sp,
            ),
            onPressed: suffixClicked,
          ) : null,
          border: filled ? _filledInput() : _borderInput(),
          focusedBorder: filled ? _filledFocusInput() : _borderFocusInput(),
          enabledBorder: filled ? _filledInput() : _borderInput(),
          contentPadding: Responsive.isDesktop(context) || Responsive.isTablet(context) ?
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w) : EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w)),
    );
  }

  OutlineInputBorder _filledInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputBorderColor,
          width: 1,
        ));
  }

  OutlineInputBorder _borderInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputBorderColor,
          width: 1,
        ));
  }

  OutlineInputBorder _filledFocusInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputBorderColor,
          width: 1,
        ));
  }

  OutlineInputBorder _borderFocusInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputFocusBorderColor,
          width: 1,
        ));
  }
}