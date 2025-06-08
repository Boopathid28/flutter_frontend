import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
class CustomDropdownField extends StatelessWidget {
  DropdownModel? selectedValue;
  void Function(DropdownModel? value)? onChanged;
  List<DropdownModel> options;
  bool filled;
  String? hintText;
  bool isValidate;
 
  CustomDropdownField({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.options,
    this.filled = false,
    this.isValidate = true,
    this.hintText,
  });
 
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<DropdownModel>(
      isExpanded: true,
      value: selectedValue,
      onChanged: onChanged,
      validator: (value) {
        if (value == null && isValidate) {
          return "This field is required";
        } else {
          return null;
        }
      },
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200.h
      ),
      decoration: InputDecoration(
          filled: filled,
          fillColor: ColorPalete.inputFilledColor,
          hintText: hintText,
          hintStyle: TextStyle(color: ColorPalete.filledInputPlaceholderColor),
          border: filled ? _filledInput() : _borderInput(),
          focusedBorder: filled ? _filledFocusInput() : _borderFocusInput(),
          enabledBorder: filled ? _filledInput() : _borderInput(),
          contentPadding: Responsive.isDesktop(context) || Responsive.isTablet(context) ?
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w) : EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w)),
      hint: Text(hintText!),
      items:
          options.map<DropdownMenuItem<DropdownModel>>((DropdownModel value) {
        return DropdownMenuItem<DropdownModel>(
          value: value,
          child: Text(value.label),
        );
      }).toList(),
    ));
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