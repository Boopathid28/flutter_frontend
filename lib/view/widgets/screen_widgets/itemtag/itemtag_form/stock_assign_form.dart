import 'dart:developer';

import 'package:ausales_application/controller/itemtag/itemtag_form/stock_assign_form_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockAssignForm extends StatefulWidget {
  const StockAssignForm({super.key});

  @override
  State<StockAssignForm> createState() => _StockAssignFormState();
}

class _StockAssignFormState extends State<StockAssignForm> {
  final StockAssignFormListController _stockAssignFormListController = Get.put(StockAssignFormListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Stock Assign",
            style: TextStyle(fontSize: 16.sp),
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width:300.w ,
        child: SingleChildScrollView(
          child: Form(
            key: _stockAssignFormListController.stockassignDetailsFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 20.h,
              children: [
                catalogType(),
                box()
              ],
            ),
          ),
        ),
      ),
      actions: [actions(context)],
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
                  isLoading: _stockAssignFormListController.isFormSubmit.value,
                  text: "Assign",
                  onPressed: () {
                    _stockAssignFormListController.submitStockAssignForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _stockAssignFormListController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _stockAssignFormListController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox catalogType() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalog Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _stockAssignFormListController.selectedCatalogType.value,
                options: _stockAssignFormListController.catalogTypeDropDown.value,
                onChanged: (value) {
                  _stockAssignFormListController.selectedCatalogType(value);
                  _stockAssignFormListController.getCatalogdropdownList(value?.value);
                },
                hintText: "Catalog Type",
              ))
        ],
      ),
    );
  }


  SizedBox box() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalog"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _stockAssignFormListController.selectedCatalog.value,
                options: _stockAssignFormListController.catalogDropdown.value,
                onChanged: (value) {
                  _stockAssignFormListController.selectedCatalog(value);
                },
                hintText: "Catalog",
              ))
        ],
      ),
    );
  }

}
