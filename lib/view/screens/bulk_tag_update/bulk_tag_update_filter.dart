import 'package:ausales_application/controller/bulk_tag_udpate/bulk_tag_update_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BulkTagUpdateFilter extends StatefulWidget {
  const BulkTagUpdateFilter({super.key});

  @override
  State<BulkTagUpdateFilter> createState() => _BulkTagUpdateFilterState();
}

class _BulkTagUpdateFilterState extends State<BulkTagUpdateFilter> {
  final BulkTagUpdateController _bulkTagUpdateController =
      Get.put(BulkTagUpdateController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 20.w,
        runSpacing: 15.h,
        children: [
          calculationType(context),
          Obx(() => _bulkTagUpdateController.isBranchuser.value ? branch(context) : SizedBox()),
          metalType(context),
          purity(context),
          item(context),
          subItem(context),
          tagType(context),
          weightType(context),
          fromWeight(context),
          toWeight(context),
          actions(context)
        ],
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 115.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _bulkTagUpdateController.isFilterFormSubmit.value,
                  text: "Fitler",
                  onPressed: () {
                    _bulkTagUpdateController.getTagDetailsList(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _bulkTagUpdateController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox toWeight(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "To Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _bulkTagUpdateController.toWeightController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hintText: "To Weight",
              onChanged: (value) {}),
        ],
      ),
    );
  }

  SizedBox fromWeight(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "From Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _bulkTagUpdateController.fromWeightController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hintText: "From Weight",
              onChanged: (value) {}),
        ],
      ),
    );
  }

  SizedBox tagType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Tag Type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _bulkTagUpdateController.searchMetalController,
                  filled: true,
                  selectedValue: _bulkTagUpdateController.selectedTagType.value,
                  options: _bulkTagUpdateController.tagtypeDropDown.value,
                  onChanged: (value) {
                    _bulkTagUpdateController.selectedTagType(value);
                  },
                  hintText: "Tag Type",
                ),
              ],
            )));
  }

  SizedBox weightType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Weight Type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _bulkTagUpdateController.selectedWeightType.value,
                  options: _bulkTagUpdateController.weighttypeDropDown.value,
                  onChanged: (value) {
                    _bulkTagUpdateController.selectedWeightType(value);
                  },
                  hintText: "Weight Type",
                ),
              ],
            )));
  }

  SizedBox metalType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Metal"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _bulkTagUpdateController.searchMetalController,
                  filled: true,
                  selectedValue: _bulkTagUpdateController.selectedMetal.value,
                  options: _bulkTagUpdateController.metalDropDown.value,
                  onChanged: (value) {
                    _bulkTagUpdateController.selectedMetal(value);
                    _bulkTagUpdateController.getPurityList(value?.value);
                    _bulkTagUpdateController.getTagTypeList(value?.value);

                    if (_bulkTagUpdateController.selectedPurity.value == null) {
                      _bulkTagUpdateController.getItemList(null, value?.value);
                    } else {
                      _bulkTagUpdateController.getItemList(_bulkTagUpdateController.selectedPurity.value?.value, value?.value);
                    }

                    if (_bulkTagUpdateController.selectedPurity.value == null && _bulkTagUpdateController.selectedItem.value == null) {
                      _bulkTagUpdateController.getSubItemList(null, value?.value, null);
                    } else if (_bulkTagUpdateController.selectedPurity.value == null) {
                      _bulkTagUpdateController.getSubItemList(_bulkTagUpdateController.selectedItem.value?.value, value?.value, null);
                    } else if (_bulkTagUpdateController.selectedItem.value == null) {
                      _bulkTagUpdateController.getSubItemList(null, value?.value, _bulkTagUpdateController.selectedPurity.value?.value);
                    } else {
                      _bulkTagUpdateController.getSubItemList(_bulkTagUpdateController.selectedItem.value?.value, value?.value, _bulkTagUpdateController.selectedPurity.value?.value);
                    }
                  },
                  hintText: "Metal",
                ),
              ],
            )));
  }

  SizedBox calculationType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Calculation Type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _bulkTagUpdateController.selectedCalculationType.value,
                  options:
                      _bulkTagUpdateController.calculationTypeDropDown.value,
                  onChanged: (value) {
                    _bulkTagUpdateController.selectedCalculationType(value);
                  },
                  hintText: "Calculation Type",
                ),
              ],
            )));
  }

  SizedBox purity(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Purity"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _bulkTagUpdateController.searchPurityController,
                  filled: true,
                  selectedValue: _bulkTagUpdateController.selectedPurity.value,
                  options: _bulkTagUpdateController.purityDropDown.value,
                  onChanged: (value) {
                    _bulkTagUpdateController.selectedPurity(value);
                    if (_bulkTagUpdateController.selectedMetal.value == null) {
                      _bulkTagUpdateController.getItemList(value?.value, null);
                    } else {
                      _bulkTagUpdateController.getItemList(value?.value, _bulkTagUpdateController.selectedMetal.value?.value);
                    }

                    if (_bulkTagUpdateController.selectedMetal.value == null && _bulkTagUpdateController.selectedItem.value == null) {
                      _bulkTagUpdateController.getSubItemList(null, null, value?.value);
                    } else if (_bulkTagUpdateController.selectedMetal.value == null) {
                      _bulkTagUpdateController.getSubItemList(_bulkTagUpdateController.selectedItem.value?.value, null, value?.value);
                    } else if (_bulkTagUpdateController.selectedItem.value == null) {
                      _bulkTagUpdateController.getSubItemList(null, _bulkTagUpdateController.selectedMetal.value?.value, value?.value);
                    } else {
                      _bulkTagUpdateController.getSubItemList(_bulkTagUpdateController.selectedItem.value?.value, _bulkTagUpdateController.selectedMetal.value?.value, value?.value);
                    }
                  },
                  hintText: "Purity",
                ),
              ],
            )));
  }

  SizedBox item(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _bulkTagUpdateController.searchItemController,
                  filled: true,
                  selectedValue: _bulkTagUpdateController.selectedItem.value,
                  options: _bulkTagUpdateController.itemDropDown.value,
                  onChanged: (value) {
                    _bulkTagUpdateController.selectedItem(value);

                    if (_bulkTagUpdateController.selectedMetal.value == null && _bulkTagUpdateController.selectedPurity.value == null) {
                      _bulkTagUpdateController.getSubItemList(value?.value, null, null);
                    } else if (_bulkTagUpdateController.selectedMetal.value == null) {
                      _bulkTagUpdateController.getSubItemList(value?.value, null, _bulkTagUpdateController.selectedPurity.value?.value);
                    } else if (_bulkTagUpdateController.selectedPurity.value == null) {
                      _bulkTagUpdateController.getSubItemList(value?.value, _bulkTagUpdateController.selectedMetal.value?.value, null);
                    } else {
                      _bulkTagUpdateController.getSubItemList(value?.value, _bulkTagUpdateController.selectedMetal.value?.value, _bulkTagUpdateController.selectedPurity.value?.value);
                    }
                  },
                  hintText: "Item",
                ),
              ],
            )));
  }

  SizedBox subItem(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Sub Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _bulkTagUpdateController.searchSubItemController,
                  filled: true,
                  selectedValue: _bulkTagUpdateController.selectedSubitem.value,
                  options: _bulkTagUpdateController.subitemDropDown.value,
                  onChanged: (value) {
                    _bulkTagUpdateController.selectedSubitem(value);
                  },
                  hintText: "Sub Item",
                ),
              ],
            )));
  }

  SizedBox branch(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Branch"),
              SizedBox(
                height: 7.w,
              ),
              CustomDropdownSearchField(
                filled: true,
                controller: _bulkTagUpdateController.searchBranchController,
                selectedValue: _bulkTagUpdateController.selectedBranch.value,
                options: _bulkTagUpdateController.branchDropDown.value,
                onChanged: (value) {
                  _bulkTagUpdateController.selectedBranch(value);
                },
                hintText: "Branch",
              ),
            ],
          )),
    );
  }
}
