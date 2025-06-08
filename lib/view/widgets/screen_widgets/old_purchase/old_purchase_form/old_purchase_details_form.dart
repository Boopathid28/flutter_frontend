import 'dart:developer';

import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_form_controller.dart';
import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_item_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldPurchaseDetailsForm extends StatefulWidget {
  const OldPurchaseDetailsForm({super.key});

  @override
  State<OldPurchaseDetailsForm> createState() => _OldPurchaseDetailsFormState();
}

class _OldPurchaseDetailsFormState extends State<OldPurchaseDetailsForm> {
  final OldPurchaseFormController _oldPurchaseFormController =
      Get.put(OldPurchaseFormController());

  final OldPurchaseItemFormController _oldPurchaseItemFormController =
      Get.put(OldPurchaseItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _oldPurchaseFormController.oldPurchaseDetailsFormKey,
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
                "Customer Details",
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
                  Obx(() => _oldPurchaseFormController.isBranchuser.value
                      ? branch()
                      : SizedBox()),
                  // gstType(),
                  customerMobile(),
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
                  isLoading: _oldPurchaseFormController.isFormSubmit.value,
                  text: "Add",
                  onPressed: () {
                    _oldPurchaseFormController.submitForm(context,false);
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
                    _oldPurchaseFormController.resetForm(context);
                  }))
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
                selectedValue:
                    _oldPurchaseItemFormController.selectedGstType.value,
                options: _oldPurchaseFormController.gstTypeDropDown.value,
                onChanged: _oldPurchaseItemFormController.particulars.isNotEmpty
                    ? null
                    : (DropdownModel? value) {
                        if (_oldPurchaseItemFormController
                            .particulars.isEmpty) {
                          _oldPurchaseItemFormController.selectedGstType(value);
                          if (_oldPurchaseItemFormController
                                  .selectedMetal.value !=
                              null) {
                            _oldPurchaseItemFormController.calculateTotalAmount(
                              dustWeight: _oldPurchaseItemFormController
                                      .dustWeightController.text.isEmpty
                                  ? "0"
                                  : _oldPurchaseItemFormController
                                      .dustWeightController.text,
                              metal: _oldPurchaseItemFormController
                                  .selectedMetal.value!.value,
                              // gstType: value!.value,
                              oldRate: _oldPurchaseItemFormController
                                      .oldAmountController.text.isEmpty
                                  ? "0"
                                  : _oldPurchaseItemFormController
                                      .oldAmountController.text,
                              metalRate: _oldPurchaseItemFormController
                                      .metalRateController.text.isEmpty
                                  ? "0"
                                  : _oldPurchaseItemFormController
                                      .metalRateController.text,
                              metalWeight: _oldPurchaseItemFormController
                                      .grossWeightController.text.isEmpty
                                  ? "0"
                                  : _oldPurchaseItemFormController
                                      .grossWeightController.text,
                            );
                          }
                        }
                      },
                hintText: "GST Type",
              ))
        ],
      ),
    );
  }

  SizedBox customerMobile() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer Mobile"),
          SizedBox(height: 7.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: CustomTextInput(
                  maxLength: 10,
                  inputFormat: 'integer',
                  controller:
                      _oldPurchaseFormController.customerMobileController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: "phone",
                  hintText: "Customer Mobile",
                  onChanged: (value) {
                    _oldPurchaseFormController.findCustomer(value, context);
                  },
                ),
              ),
              Obx(() => _oldPurchaseFormController.isVerifyCustomerLoading.value
                  ? CircularProgressIndicator()
                  : _oldPurchaseFormController.isValidCustomer.value
                      ? IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.person,
                            size: 30.sp,
                            color: Colors.green,
                          ))
                      : IconButton(
                          onPressed: () async {
                            await Get.dialog(
                                barrierDismissible: false,
                                CustomerCreationCommonPopup(
                                      onSubmit: _oldPurchaseFormController
                                          .submitCustomerCreationForm,
                                    ));
                          },
                          icon: Icon(Icons.add,
                              size: 30.sp, color: ColorPalete.primaryColor))),
              Obx(() => Text(_oldPurchaseFormController
                      .customerDetails.value.customerName ??
                  ""))
            ],
          ),
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
                controller: _oldPurchaseFormController.branchSearchController,
                selectedValue: _oldPurchaseFormController.selectedBranch.value,
                options: _oldPurchaseFormController.branchDropDown.value,
                onChanged: (value) {
                  _oldPurchaseFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
