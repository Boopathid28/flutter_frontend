import 'package:ausales_application/controller/diamond_master/diamond_master_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DiamondMasterForm extends StatefulWidget {
  const DiamondMasterForm({super.key});

  @override
  State<DiamondMasterForm> createState() => _DiamondMasterFormState();
}

class _DiamondMasterFormState extends State<DiamondMasterForm> {
  final DiamondMasterFormController _diamondMasterFormController = Get.put(DiamondMasterFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Form(
        key: _diamondMasterFormController.diamondFormKey,
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10.w,
            children: [
              diamondName(),
              diamondCode(),
              diamondRate(),
              diamondCertificateAmount(),
              reduceWeight(),
              actions(context)
            ],
          ),
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
                  isLoading: _diamondMasterFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _diamondMasterFormController.submitDiamondForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _diamondMasterFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _diamondMasterFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox reduceWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Reduce Weight"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _diamondMasterFormController.reduceWeightSearchController,
                selectedValue: _diamondMasterFormController.selectedReduceWeight.value,
                options: _diamondMasterFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _diamondMasterFormController.selectedReduceWeight(value);
                },
                hintText: "Reduce Weight",
              ))
        ],
      ),
    );
  }

  diamondCertificateAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Certificate Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _diamondMasterFormController.diamondCertificateRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            inputFormat: 'double',
            hintText: "Certificate Amount",
          ),
        ],
      ),
    );
  }

  diamondRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond Rate"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _diamondMasterFormController.diamondRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            inputFormat: 'double',
            hintText: "Diamond Rate",
          ),
        ],
      ),
    );
  }

  diamondCode() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _diamondMasterFormController.diamondCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Diamond Code",
          ),
        ],
      ),
    );
  }

  SizedBox diamondName() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _diamondMasterFormController.diamondNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Diamond Name",
          ),
        ],
      ),
    );
  }
}
