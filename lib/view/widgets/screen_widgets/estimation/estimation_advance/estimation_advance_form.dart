import 'package:ausales_application/controller/estimation/estimation_advance_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationAdvanceForm extends StatefulWidget {
  const EstimationAdvanceForm({super.key});

  @override
  State<EstimationAdvanceForm> createState() => _EstimationAdvanceFormState();
}

class _EstimationAdvanceFormState extends State<EstimationAdvanceForm> {
  final EstimationAdvanceFormController _estimationAdvanceFormController =
      Get.put(EstimationAdvanceFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Advance",
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
                _estimationAdvanceFormController.resetForm();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Form(
            key: _estimationAdvanceFormController.estimationAdvanceFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                advancepupose(),
                totaladvanceweight(),
                purity(),
                totaladvanceamount(),
                remark(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
            width: Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? 115.w
                : double.infinity,
            child: Obx(() => PrimaryButton(
                btnHeight: 46.h,
                isLoading: _estimationAdvanceFormController.isFormSubmit.value,
                text: "Save",
                onPressed: () {
                  _estimationAdvanceFormController.CreateAdvance(context);
                })))
      ],
    );
  }

  SizedBox purity() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Advance Weight Purity"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _estimationAdvanceFormController.searchpuritycontroller,
                selectedValue: _estimationAdvanceFormController.selectedPurity.value,
                options: _estimationAdvanceFormController.puritydropdown.value,
                onChanged: (value) {
                  _estimationAdvanceFormController.selectedPurity(value);
                },
                hintText: "Advance Weight Purity",
                isValidate:
                    _estimationAdvanceFormController.totalweight.value ? true : false,
              ))
        ],
      ),
    );
  }

  SizedBox totaladvanceamount() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Advance Amount"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _estimationAdvanceFormController.advanceamountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "no_validation",
            hintText: "Total Advance Amount",
          ),
        ],
      ),
    );
  }

  SizedBox totaladvanceweight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Advance Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _estimationAdvanceFormController.advanceweightcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "no_validation",
            hintText: "Total Advance Weight",
            onChanged: (value) {
              if(value.length > 0) {
              _estimationAdvanceFormController.totalweight(true);
              } else {
              _estimationAdvanceFormController.totalweight(false);
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox remark() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remark"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _estimationAdvanceFormController.remarkcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remark",
          ),
        ],
      ),
    );
  }

  SizedBox advancepupose() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Advance Purpose"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _estimationAdvanceFormController.searchadvancepurposecontroller,
                selectedValue: _estimationAdvanceFormController.selectedAdvancePurpose.value,
                options: _estimationAdvanceFormController.advancedropdown.value,
                onChanged: (value) {
                  _estimationAdvanceFormController.selectedAdvancePurpose(value);
                },
                hintText: "Advance Purpose",
                isValidate: true,
              ))
        ],
      ),
    );
  }
}
