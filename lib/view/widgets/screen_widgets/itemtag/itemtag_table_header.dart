import 'package:ausales_application/controller/itemtag/itemtag_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemtagTableHeader extends StatefulWidget {
  const ItemtagTableHeader({super.key});

  @override
  State<ItemtagTableHeader> createState() => _ItemtagTableHeaderState();
}

class _ItemtagTableHeaderState extends State<ItemtagTableHeader> {
  final ItemtagListController _itemtagListController =
      Get.put(ItemtagListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 5.w,
          runSpacing: 10.h,
          children: [
            searchFilter(context),
            Obx(
              () => _itemtagListController.isBranchuser.value
                  ? branch()
                  : SizedBox(),
            ),
            entryDateRangeFilter(context),
          ],
        ));
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _itemtagListController.branchSearchFilterController,
            selectedValue: _itemtagListController.selectedBranch.value,
            options: _itemtagListController.branchDropDown.value,
            onChanged: (value) {
              _itemtagListController.selectedBranch(value);
              _itemtagListController.getItemTagList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _itemtagListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _itemtagListController.getItemTagList(context);
          }),
    );
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _itemtagListController.tagEntryDateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _itemtagListController.tagEntryDateFilterController.clear();
            _itemtagListController.getItemTagList(context);
          },
          hintText: "Entry Date Range",
          onTap: () async {
            final today = DateTime.now();
            final endYear = today.year + 1;
            DateTimeRange? pickedDate = await showDateRangePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(endYear),
              builder: (context, child) {
                return Center(
                  child: Container(
                    height: 450.h,
                    width: 400.w,
                    child: child,
                  ),
                );
              },
            );
            if (pickedDate != null) {
              var startDate = pickedDate.start.toString().substring(0, 10);
              var endDate = pickedDate.end.toString().substring(0, 10);
              _itemtagListController.tagEntryDateFilterController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _itemtagListController.tagEntryDateFilterController.clear();
            }
            _itemtagListController.getItemTagList(context);
          }),
    );
  }
}
