import 'dart:developer';

import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
class CustomMultiDropdownSearchField extends StatelessWidget {
  TextEditingController controller;
  List<DropdownModel> selectedValue;
  void Function(DropdownModel? value)? onChanged;
  List<DropdownModel> options;
  bool filled;
  String? hintText;
  bool isValidate;
  bool readOnly;
  String displayValue;
  void Function(DropdownModel? value) onOptionTap;

  CustomMultiDropdownSearchField({
    super.key,
    required this.controller,
    required this.selectedValue,
    required this.onChanged,
    required this.options,
    required this.displayValue,
    this.filled = false,
    this.isValidate = true,
    this.hintText,
    this.readOnly = false,
    required this.onOptionTap
  });

 
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<DropdownModel>(
      isExpanded: true,
      value: selectedValue.isEmpty ? null : selectedValue.last,
      selectedItemBuilder: (context) {
            return selectedValue.map(
              (item) {
                return Container(
                  width: double.infinity,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    displayValue.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                );
              },
            ).toList();
          },
      onChanged: readOnly ? null : onChanged,
      validator: (value) {
        if (value == null && isValidate) {
          return "This field is required";
        } else {
          return null;
        }
      },
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
          enabled: false,
          child: StatefulBuilder(builder: (context, stateValue) {
            final isSelected = selectedValue.contains(value);
            return  InkWell(
                    onTap: () {
                      return onOptionTap(value);
                    },
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        value.label,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
          },),
        );
      }).toList(),
      dropdownSearchData: DropdownSearchData(
        searchController: controller,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: "Search $hintText",
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return item.value!.label
              .toString()
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        },
      ),
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