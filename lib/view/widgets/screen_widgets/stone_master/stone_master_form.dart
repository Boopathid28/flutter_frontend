import 'package:ausales_application/controller/stone_master/stone_master_form_controller.dart';
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

class StoneMasterForm extends StatefulWidget {
  const StoneMasterForm({super.key});

  @override
  State<StoneMasterForm> createState() => _StoneMasterFormState();
}

class _StoneMasterFormState extends State<StoneMasterForm> {
  final StoneMasterFormController _stoneMasterFormController = Get.put(StoneMasterFormController());

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
        key: _stoneMasterFormController.stoneFormKey,
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10.w,
            children: [
              stoneName(),
              stoneCode(),
              stoneRate(),
              stoneCertificateAmount(),
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
                  isLoading: _stoneMasterFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _stoneMasterFormController.submitStoneForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _stoneMasterFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _stoneMasterFormController.resetForm();
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
                controller: _stoneMasterFormController.reduceWeightSearchController,
                selectedValue: _stoneMasterFormController.selectedReduceWeight.value,
                options: _stoneMasterFormController.reduceWeightDropDown.value,
                onChanged: (value) {
                  _stoneMasterFormController.selectedReduceWeight(value);
                },
                hintText: "Reduce Weight",
              ))
        ],
      ),
    );
  }

  stoneCertificateAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Certificate Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _stoneMasterFormController.stoneCertificateRateController,
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

  stoneRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone Rate"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _stoneMasterFormController.stoneRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            inputFormat: 'double',
            hintText: "Stone Rate",
          ),
        ],
      ),
    );
  }

  stoneCode() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _stoneMasterFormController.stoneCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Stone Code",
          ),
        ],
      ),
    );
  }

  SizedBox stoneName() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _stoneMasterFormController.stoneNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Stone Name",
          ),
        ],
      ),
    );
  }
}
