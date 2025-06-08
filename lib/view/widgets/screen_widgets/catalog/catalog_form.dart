import 'package:ausales_application/controller/catalog/catalog_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CatalogForm extends StatefulWidget {
  const CatalogForm({super.key});

  @override
  State<CatalogForm> createState() => _CatalogFormState();
}

class _CatalogFormState extends State<CatalogForm> {
  final CatalogFormController _catalogFormController = Get.put(CatalogFormController());

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
      child: Form(
        key: _catalogFormController.catalogFormKey,
        child: Wrap(
                    spacing: 10.w,
                    runSpacing: 20.h,
                    children: [
                      counter(),
                      catalogType(),
                     catalogWeight(),
                      catalogNumber(),
                      actions(context),
                    ],
                  ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _catalogFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _catalogFormController.submitCatalogForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _catalogFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _catalogFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox catalogWeight() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalog Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _catalogFormController.catalogweightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Catalog Weight",
          ),
        ],
      ),
    );
  }

  SizedBox catalogNumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalog Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _catalogFormController.catalognumberController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Catalog Number",
          ),
        ],
      ),
    );
  }

  SizedBox catalogType() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Catalog Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _catalogFormController.selectedCatalogType.value,
                options: _catalogFormController.catalogTypeDropDown.value,
                onChanged: (value) {
                  _catalogFormController.selectedCatalogType(value);
                },
                hintText: "Catalog Type",
              ))
        ],
      ),
    );
  }

  SizedBox counter() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Counter"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _catalogFormController.searchCounterController,
                selectedValue: _catalogFormController.selectedCounter.value,
                options: _catalogFormController.counterDropDown.value,
                onChanged: (value) {
                  _catalogFormController.selectedCounter(value);
                },
                hintText: "Counter",
              ))
        ],
      ),
    );
  }
}
