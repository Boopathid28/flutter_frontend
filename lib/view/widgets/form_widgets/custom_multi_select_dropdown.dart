import 'dart:developer';

import 'package:ausales_application/model/drop_down_model.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CustomMultiSelectDropdown extends StatelessWidget {
  List<DropdownModel>  selectedValue;
  List<DropdownModel> options;
  bool filled;
  String? hintText;
  bool isValidate;
  bool readOnly;
  void Function(DropdownModel? value) onOptionTap;
  CustomMultiSelectDropdown(
      {super.key,
      required this.selectedValue,
      required this.options,
      this.filled = false,
      this.isValidate = true,
      this.hintText,
      this.readOnly = false,
      required this.onOptionTap});

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
        onOptionSelected: (selectedOptions) {
          selectedValue= selectedOptions.map((item) {
            return DropdownModel(label: item.label, value: item.value);
          },).toList();
        },
        options: <ValueItem>[
          for (var item in options)
            ValueItem(label: item.label, value: item.value)
        ],
        selectionType:SelectionType.multi,
        selectedOptionIcon: const Icon(Icons.check_circle),
        
        );
  }
}
