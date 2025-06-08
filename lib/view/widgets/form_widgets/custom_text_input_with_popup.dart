import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/validation_helpler.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextInputWithPopup extends StatelessWidget {
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
  String popupText;
  void Function() onPopupPressed;
  double width;
  Color filledColor;

  CustomTextInputWithPopup(
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
      required this.popupText,
      required this.onPopupPressed,
      this.width = double.infinity,
      this.filledColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? EdgeInsets.symmetric(horizontal: 5.w)
                      : EdgeInsets.symmetric(horizontal: 5.w),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: filled ? filledColor : Colors.transparent,
        border: Border.all(
          width: 1,
          color: ColorPalete.inputBorderColor,
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200.w,
            child: TextFormField(
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
                } else if (validator == "phone") {
                  result = ValidationHelper.phone(value!);
                } else if (validator == "email") {
                  result = ValidationHelper.email(value!);
                } else if (validator == "no_validation") {
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
              inputFormatters: inputFormat == "double"
                  ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))]
                  : inputFormat == "integer"
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : [],
              decoration: InputDecoration(
                  
                  fillColor: ColorPalete.inputFilledColor,
                  hintText: hintText,
                  hintStyle:
                      TextStyle(color: ColorPalete.filledInputPlaceholderColor),
                  prefixIcon: hasPrefixIcon
                      ? Icon(
                          prefixIcon,
                          color: ColorPalete.filledInputPrefixSuffixColor,
                          size: 20.sp,
                        )
                      : null,
                  suffixIcon: hasSuffixIcon
                      ? IconButton(
                          icon: Icon(
                            suffixIcon,
                            color: ColorPalete.filledInputPrefixSuffixColor,
                            size: 20.sp,
                          ),
                          onPressed: suffixClicked,
                        )
                      : null,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,),
            ),
          ),
          PrimaryButton(
              btnWidth: 60.w,
              btnHeight: 25.h,
              isLoading: false,
              text: popupText,
              onPressed: onPopupPressed)
        ],
      ),
    );
  }

}
