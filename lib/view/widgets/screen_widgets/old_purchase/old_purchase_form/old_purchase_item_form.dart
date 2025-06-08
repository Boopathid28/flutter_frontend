import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_form_controller.dart';
import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_item_form_controller.dart';
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

class OldPurchaseItemForm extends StatefulWidget {
  const OldPurchaseItemForm({super.key});

  @override
  State<OldPurchaseItemForm> createState() => _OldPurchaseItemFormState();
}

class _OldPurchaseItemFormState extends State<OldPurchaseItemForm> {

  final OldPurchaseItemFormController _oldPurchaseItemFormController = Get.put(OldPurchaseItemFormController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Form(
      key: _oldPurchaseItemFormController.oldPurchaseItemFormDetailsFormKey,
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
                "Item Details",
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
                  metal(),
                  itemname(),
                  puritypercent(),
                  metalWeight(),
                  dustWeight(),
                  metalRate(),
                  netWeight(),
                  // gstAmount(),
                  totalAmount(),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  actions(context),
                ],
              )
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
                  isLoading: false,
                  text: _oldPurchaseItemFormController.itemFormMode.value,
                  onPressed: () {
                    _oldPurchaseItemFormController.submitForm(context);
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
                    _oldPurchaseItemFormController.resetForm(context);
                  }))
        ],
      ),
    );
  }

  SizedBox totalAmount() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Total Amount",
            readOnly: true,
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

   SizedBox puritypercent() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purity Percent"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.purityPercentController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Purity Percent",
          ),
        ],
      ),
    );
  }

  SizedBox gstAmount() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gst Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.gstAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gst Amount",
            readOnly: true,
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox oldAmount() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Old Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.oldAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Old Amount",
            onChanged: (value) {
              if (_oldPurchaseItemFormController.selectedMetal.value != null) {
                _oldPurchaseItemFormController.calculateTotalAmount(
                  dustWeight: _oldPurchaseItemFormController.dustWeightController.text.isEmpty ? "0" : _oldPurchaseItemFormController.dustWeightController.text,
                  metal: _oldPurchaseItemFormController.selectedMetal.value!.value,
                  // gstType: _oldPurchaseItemFormController.selectedGstType.value!.value,
                  oldRate: value.isEmpty ? "0" : value,
                  metalRate: _oldPurchaseItemFormController.metalRateController.text.isEmpty ? "0" : _oldPurchaseItemFormController.metalRateController.text,
                  metalWeight: _oldPurchaseItemFormController.grossWeightController.text.isEmpty ? "0" : _oldPurchaseItemFormController.grossWeightController.text
                );
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox netWeight() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Net Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.netWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Net Weight",
            readOnly: true,
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox dustWeight() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Dust Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.dustWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Dust Weight",
            readOnly: false,
          onChanged: (value) {
              if (_oldPurchaseItemFormController.selectedMetal.value != null) {
                _oldPurchaseItemFormController.calculateTotalAmount(
                     dustWeight : value.isEmpty ? "0" : value,
                  metal: _oldPurchaseItemFormController.selectedMetal.value!.value,
                  // gstType: _oldPurchaseItemFormController.selectedGstType.value!.value,
               oldRate: _oldPurchaseItemFormController.oldAmountController.text.isEmpty ? "0" : _oldPurchaseItemFormController.oldAmountController.text,
                  metalRate: _oldPurchaseItemFormController.metalRateController.text.isEmpty ? "0" : _oldPurchaseItemFormController.metalRateController.text,
                  metalWeight: _oldPurchaseItemFormController.grossWeightController.text.isEmpty ? "0" : _oldPurchaseItemFormController.grossWeightController.text
                );
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox itemname() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'text',
            controller:
                _oldPurchaseItemFormController.itemNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Item Name",
          ),
        ],
      ),
    );
  }

  SizedBox metalRate() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Rate"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              if (_oldPurchaseItemFormController.selectedMetal.value != null) {
                _oldPurchaseItemFormController.calculateTotalAmount(
                  dustWeight: _oldPurchaseItemFormController.dustWeightController.text.isEmpty ? "0" : _oldPurchaseItemFormController.dustWeightController.text,
                  metal: _oldPurchaseItemFormController.selectedMetal.value!.value,
                  // gstType: _oldPurchaseItemFormController.selectedGstType.value!.value,
                  oldRate: _oldPurchaseItemFormController.oldAmountController.text.isEmpty ? "0" : _oldPurchaseItemFormController.oldAmountController.text,
                  metalRate: value.isEmpty ? "0" : value,
                  metalWeight: _oldPurchaseItemFormController.grossWeightController.text.isEmpty ? "0" : _oldPurchaseItemFormController.grossWeightController.text
                );
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox metalWeight() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gross Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _oldPurchaseItemFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              if (_oldPurchaseItemFormController.selectedMetal.value != null) {
                _oldPurchaseItemFormController.calculateTotalAmount(
                  dustWeight: _oldPurchaseItemFormController.dustWeightController.text.isEmpty ? "0" : _oldPurchaseItemFormController.dustWeightController.text,
                  metal: _oldPurchaseItemFormController.selectedMetal.value!.value,
                  // gstType: _oldPurchaseItemFormController.selectedGstType.value!.value,
                  oldRate: _oldPurchaseItemFormController.oldAmountController.text.isEmpty ? "0" : _oldPurchaseItemFormController.oldAmountController.text,
                  metalRate: _oldPurchaseItemFormController.metalRateController.text.isEmpty ? "0" : _oldPurchaseItemFormController.metalRateController.text,
                  metalWeight: value.isEmpty ? "0" : value,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox metal() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          // Obx(() => CustomDropdownSearchField(
          //       controller: _oldPurchaseItemFormController.metalSearchController,
          //       selectedValue: _oldPurchaseItemFormController.selectedMetal.value,
          //       options: _oldPurchaseItemFormController.metalDropDown.value,
          //       onChanged: (value) {
          //         _oldPurchaseItemFormController.onMetalChange(value!);
          //       },
          //       hintText: "Metal",
          //     )),


               Obx(() => CustomDropdownField(
                selectedValue:
                    _oldPurchaseItemFormController.selectedMetal.value,
                options: _oldPurchaseItemFormController.metalDropDown.value,
                onChanged: _oldPurchaseItemFormController.particulars.isNotEmpty
                    ? null
                    : (DropdownModel? value) {
                        if (_oldPurchaseItemFormController
                            .particulars.isEmpty) {
                          _oldPurchaseItemFormController.selectedMetal(value);
                          if (_oldPurchaseItemFormController
                                  .selectedMetal.value !=
                              null) {
                                _oldPurchaseItemFormController.onMetalChange(value!);
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
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
