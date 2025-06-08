import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_form_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPurchaseDetailsForm extends StatefulWidget {
  const NewPurchaseDetailsForm({super.key});

  @override
  State<NewPurchaseDetailsForm> createState() => _NewPurchaseDetailsFormState();
}

class _NewPurchaseDetailsFormState extends State<NewPurchaseDetailsForm> {
  final NewPurchaseFormController _newPurchaseFormController =
      Get.put(NewPurchaseFormController());

  final NewPurchaseItemFormController _newPurchaseItemFormController = Get.put(NewPurchaseItemFormController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _newPurchaseFormController.newPurchaseDetailsFormKey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: size.width * 0.98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Purchase Details",
                style: TextPalette.tableHeaderTextStyle,
              ),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              Wrap(
                spacing: 20.w,
                runSpacing: 10.h,
                children: [
                  Obx(() => _newPurchaseFormController.isBranchuser.value
                      ? branch()
                      : SizedBox()),
                  vendor(),
                  poDate(),
                  gstType(),
                  tdsPercent(),
                  weightRoundOff(),
                  roundOff(),
                  remark()
                ],
              ),
            ],
          ),
        ));
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
                  isLoading: _newPurchaseFormController.isFormSubmit.value,
                  text: "Add",
                  onPressed: () {
                    _newPurchaseFormController.submitForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _newPurchaseFormController.resetForm(context);
                  }))
        ],
      ),
    );
  }

  SizedBox poDate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "PO Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _newPurchaseFormController.poDateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _newPurchaseFormController.poDateController.clear();
              }
            },
            controller: _newPurchaseFormController.poDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "PO Date",
          ),
        ],
      ),
    );
  }

  SizedBox gstType() {
    return SizedBox(
      width: 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "GST Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _newPurchaseItemFormController.selectedGstType.value,
                options: _newPurchaseFormController.gstTypeDropDown.value,
                onChanged: _newPurchaseItemFormController.particulars.isNotEmpty ? null : (DropdownModel? value) {
                  _newPurchaseItemFormController.selectedGstType(value);
                },
                hintText: "GST Type",
              ))
        ],
      ),
    );
  }

  SizedBox vendor() {
    return SizedBox(
      width: 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _newPurchaseFormController.vendorSearchController,
                selectedValue: _newPurchaseFormController.selectedVendor.value,
                options: _newPurchaseFormController.designerDropDown.value,
                onChanged: (value) {
                  _newPurchaseFormController.selectedVendor(value);
                },
                hintText: "Vendor",
              ))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _newPurchaseFormController.branchSearchController,
                selectedValue: _newPurchaseFormController.selectedBranch.value,
                options: _newPurchaseFormController.branchDropDown.value,
                onChanged: (value) {
                  _newPurchaseFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox tdsPercent() {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "TDS %"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _newPurchaseItemFormController.tdsPercentController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "no_validation",
            hintText: "TDS %",
            onChanged: (value) {
              _newPurchaseItemFormController.calculateTdsAmount();
            },
          ),
        ],
      ),
    );
  }

  SizedBox weightRoundOff() {
    return SizedBox(
      width: 120.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Weight Round Off"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'negative',
            controller: _newPurchaseItemFormController.weightRoundOffController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "no_validation",
            hintText: "Weight Round Off",
            onChanged: (value) {
              _newPurchaseItemFormController.calculateWeightRoundOff();
            },
          ),
        ],
      ),
    );
  }

  SizedBox roundOff() {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Round Off"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'negative',
            controller: _newPurchaseItemFormController.roundOffController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "no_validation",
            hintText: "Round Off",
            onChanged: (value) {
              _newPurchaseItemFormController.calculateTdsAmount();
            },
          ),
        ],
      ),
    );
  }

  SizedBox remark() {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remark"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _newPurchaseItemFormController.remarkController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remark",
          ),
        ],
      ),
    );
  }
}
