import 'package:ausales_application/controller/tax_master/tax_form_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TaxFormPopup extends StatefulWidget {
  const TaxFormPopup({super.key});

  @override
  State<TaxFormPopup> createState() => _TaxFormPopupState();
}

class _TaxFormPopupState extends State<TaxFormPopup> {
  final TaxFormController _taxFormController = Get.put(TaxFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? Row(
                  children: [
                    Text(
                      "${_taxFormController.fromMode.value.capitalize} Tax",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Text("(Note: Only One Tax Can Be Created For Each Metal)",
                        style: TextStyle(fontSize: 16.sp,
                          color: Colors.red,
                        )),
                  ],
                )
              : Responsive.isMobile(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_taxFormController.fromMode} Tax",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            Text(
                                "(Note: Only One Tax Can Be Created For Each Metal)",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 7.sp)),
                          ],
                        ),
                        closeicon()
                      ],
                    )
                  : SizedBox(),
          Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? closeicon()
              : SizedBox()
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _taxFormController.taxFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 20.h,
              children: [
                taxname(),
                taxcode(),
                metalname(),
                purchaseigst(),
                purchasecgst(),
                purchasesgst(),
                salesigst(),
                salescgst(),
                salessgst(),
              ],
            ),
          ),
        ),
      ),
      actions: [actions(context)],
    );
  }


    IconButton closeicon() {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.close));
  }

  SizedBox metalname() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _taxFormController.searchtaxController,
                selectedValue: _taxFormController.selectedMetal.value,
                options: _taxFormController.metalDropDown.value,
                onChanged: (value) {
                  _taxFormController.selectedMetal(value);
                },
                hintText: "Metal name",
              ))
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
                  isLoading: _taxFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _taxFormController.submitTaxForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _taxFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _taxFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox taxcode() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tax code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.taxCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Tax Code",
          ),
        ],
      ),
    );
  }

  SizedBox purchaseigst() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purchase IGST"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.purchaseigstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: "default_double_input",
            hintText: "Purchase Igst",
            inputFormat: "double",
          ),
        ],
      ),
    );
  }

  SizedBox purchasecgst() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purchase CGST"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.purchasecgstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: "default_double_input",
            hintText: "Purchase Cgst",
            inputFormat: "double",
          ),
        ],
      ),
    );
  }

  SizedBox purchasesgst() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purchase SGST"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.purchasesgstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: "default_double_input",
            hintText: "Purchase Sgst",
            inputFormat: "double",
          ),
        ],
      ),
    );
  }

  SizedBox salessgst() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sales SGST"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.salessgstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: "default_double_input",
            hintText: "Sales Sgst",
            inputFormat: "double",
          ),
        ],
      ),
    );
  }

  SizedBox salesigst() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sales IGST"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.salesigstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: "default_double_input",
            hintText: "Sales Igst",
            inputFormat: "double",
          ),
        ],
      ),
    );
  }

  SizedBox salescgst() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sales CGST"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.salescgstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: "default_double_input",
            hintText: "Sales Cgst",
            inputFormat: "double",
          ),
        ],
      ),
    );
  }

  SizedBox taxname() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tax Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _taxFormController.taxNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Tax Name",
          ),
        ],
      ),
    );
  }
}
