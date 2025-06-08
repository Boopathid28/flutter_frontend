import 'package:ausales_application/controller/lot/lot_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LotTableHeader extends StatefulWidget {
  const LotTableHeader({super.key});

  @override
  State<LotTableHeader> createState() => _LotTableHeaderState();
}

class _LotTableHeaderState extends State<LotTableHeader> {
  final LotListController _lotListController = Get.put(LotListController());

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
              () =>
                  _lotListController.isBranchuser.value ? branch() : SizedBox(),
            ),
            entryDateRangeFilter(context),
            entryTypeFilter(context),
            designerFilter(context),
            lotStatusFilter(context)
          ],
        ));
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _lotListController.branchSearchController,
            selectedValue: _lotListController.selectedBranch.value,
            options: _lotListController.branchDropDown.value,
            onChanged: (value) {
              _lotListController.selectedBranch(value);
              _lotListController.getLotList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _lotListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _lotListController.getLotList(context);
          }),
    );
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _lotListController.entryDateRangeController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _lotListController.entryDateRangeController.clear();
            _lotListController.getLotList(context);
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
                });
            if (pickedDate != null) {
              var startDate = pickedDate.start.toString().substring(0, 10);
              var endDate = pickedDate.end.toString().substring(0, 10);
              _lotListController.entryDateRangeController.text =
                  [startDate, endDate].join(" to ");
            } else {
              _lotListController.entryDateRangeController.clear();
            }
            _lotListController.getLotList(context);
          }),
    );
  }

  SizedBox designerFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _lotListController.designerController,
              filled: true,
              selectedValue: _lotListController.selectedDesigner.value,
              options: _lotListController.designerDropDown.value,
              onChanged: (value) {
                _lotListController.selectedDesigner(value);
                _lotListController.getLotList(context);
              },
              hintText: "Metal",
            )));
  }

  SizedBox entryTypeFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue: _lotListController.selectedEntryType.value,
              options: _lotListController.entryTypeDropDown.value,
              onChanged: (value) {
                _lotListController.selectedEntryType(value);
                _lotListController.getLotList(context);
              },
              hintText: "Metal",
            )));
  }

  SizedBox lotStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue: _lotListController.selectedLotStatus.value,
              options: _lotListController.lotStatusDropDown.value,
              onChanged: (value) {
                _lotListController.selectedLotStatus(value);
                _lotListController.getLotList(context);
              },
              hintText: "Metal",
            )));
  }
}
