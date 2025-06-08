import 'package:ausales_application/controller/stock_assign/stock_assign_form_controller.dart';
import 'package:ausales_application/controller/stock_assign/stock_assign_list_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockAssignCatalogFilter extends StatefulWidget {
  const StockAssignCatalogFilter({super.key});

  @override
  State<StockAssignCatalogFilter> createState() => _StockAssignCatalogFilterState();
}

class _StockAssignCatalogFilterState extends State<StockAssignCatalogFilter> {

  final StockAssignPopupFormController _stockAssignPopupFormController =
      Get.put(StockAssignPopupFormController());

  final StockAssignListController _stockAssignListController =
      Get.put(StockAssignListController());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Wrap(
        runSpacing: 10.h,
        spacing: 10.w,
        children: [
          Obx(
            () => _stockAssignListController.isBranchuser.value
                ? branch()
                : SizedBox(),
          ),
          floor(),
          Counter(),
          catalogType(), 
          box(),
        ],
      ),
    );
  }

  SizedBox box() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalog"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _stockAssignListController.selectedCatalog.value,
                options: _stockAssignListController.catalogDropdown.value,
                onChanged: (value) {
                  _stockAssignListController.selectedCatalog(value);
                  _stockAssignListController.getstockList(context);
                },
                hintText: "Catalog",
              ))
        ],
      ),
    );
  }

  SizedBox catalogType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalog Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _stockAssignListController.selectedCatalogType.value,
                options: _stockAssignListController.catalogTypeDropDown.value,
                onChanged: (value) {
                  _stockAssignListController.selectedCatalogType(value);
                  _stockAssignListController.getCatalogdropdownList(_stockAssignListController.selectedCounter.value?.value, value?.value);
                },
                hintText: "Catalog Type",
              ))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _stockAssignListController.selectedBranch.value,
                options: _stockAssignListController.branchDropDown.value,
                onChanged: (value) {
                  _stockAssignListController.selectedBranch(value);
                  _stockAssignListController.getFloordropdown(value!.value);
                  _stockAssignPopupFormController
                      .getTagnumberList(value!.value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox floor() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Floor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _stockAssignListController.selectedFloor.value,
                options: _stockAssignListController.floorDropDown.value,
                onChanged: (value) {
                  _stockAssignListController.selectedFloor(value);
                  _stockAssignListController.getCounterdropdown(value!.value);
                      _stockAssignListController.selectedCounter(null);
                      _stockAssignListController.selectedCatalog(null);
                },
                hintText: "Floor",
              ))
        ],
      ),
    );
  }

  SizedBox Counter() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Counter"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _stockAssignListController.selectedCounter.value,
                options: _stockAssignListController.counterDropDown.value,
                onChanged: (value) {
                  _stockAssignListController.selectedCounter(value);
                  _stockAssignListController.getCatalogdropdownList(value?.value, _stockAssignListController.selectedCatalogType.value?.value);
                },
                hintText: "Counter",
              ))
        ],
      ),
    );
  }
}
