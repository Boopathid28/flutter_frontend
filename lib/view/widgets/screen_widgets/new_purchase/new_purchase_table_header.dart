import 'package:ausales_application/controller/new_purchase/new_purchase_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPurchaseTableHeader extends StatefulWidget {
  const NewPurchaseTableHeader({super.key});

  @override
  State<NewPurchaseTableHeader> createState() => _NewPurchaseTableHeaderState();
}

class _NewPurchaseTableHeaderState extends State<NewPurchaseTableHeader> {
  final NewPurchaseListController _newPurchaseListController = Get.put(NewPurchaseListController());

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
                  _newPurchaseListController.isBranchuser.value ? branch() : SizedBox(),
            ),
            vendorFilter(context),
            statusFilter(context)
          ],
        ));
  }

  SizedBox branch() {
    return SizedBox(
     width: 200.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _newPurchaseListController.branchSearchController,
            selectedValue: _newPurchaseListController.selectedBranch.value,
            options: _newPurchaseListController.branchDropDown.value,
            onChanged: (value) {
              _newPurchaseListController.selectedBranch(value);
              _newPurchaseListController.getNewPurchaseList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
     width: 200.w,
      child: CustomTextInput(
          controller: _newPurchaseListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _newPurchaseListController.getNewPurchaseList(context);
          }),
    );
  }

  SizedBox statusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue: _newPurchaseListController.selectedStatus.value,
              options: _newPurchaseListController.statusDropDown.value,
              onChanged: (value) {
                _newPurchaseListController.selectedStatus(value);
                _newPurchaseListController.getNewPurchaseList(context);
              },
              hintText: "Status",
            )));
  }

  SizedBox vendorFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
          controller: _newPurchaseListController.vendorSearchController,
              filled: true,
              selectedValue: _newPurchaseListController.selectedVendor.value,
              options: _newPurchaseListController.vendorDropDown.value,
              onChanged: (value) {
                _newPurchaseListController.selectedVendor(value);
                _newPurchaseListController.getNewPurchaseList(context);
              },
              hintText: "Metal",
            )));
  }

}
