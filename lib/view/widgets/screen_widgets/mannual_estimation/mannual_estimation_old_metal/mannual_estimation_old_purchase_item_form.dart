import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/estimation/estimation_old_item_form_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_old_item_form_controller.dart';
import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MannualEstimationOldPurchaseItemForm extends StatefulWidget {
  const MannualEstimationOldPurchaseItemForm({super.key});

  @override
  State<MannualEstimationOldPurchaseItemForm> createState() => _MannualEstimationOldPurchaseItemFormState();
}

class _MannualEstimationOldPurchaseItemFormState extends State<MannualEstimationOldPurchaseItemForm> {

  final MannualEstimationOldItemFormController _mannualEstimationOldItemFormController = Get.put(MannualEstimationOldItemFormController());
  final MannualEstimationController _mannualEstimationController = Get.put(MannualEstimationController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Form(
      key: _mannualEstimationOldItemFormController.estiamtionOldPurchaseItemFormDetailsFormKey,
        child: Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Old Metal Details",
                    style: TextPalette.screenTitle,
                  ),
                  Row(
                    children: [
                      PrimaryButton(btnWidth: 100.w, isLoading: false, text: "Done", onPressed: () {
                        _mannualEstimationController.calculateOldMetals();
                        Get.back();
                      }),
                      SizedBox(width:10.w),
                      SecondaryButton(btnWidth: 100.w , isLoading: false, text: "close", onPressed: (){
                        Get.back();
                      })
                    ],
                  )
                ],
              ),
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
                  metalWeight(),
                  reduceWeight(),
                  touch(),
                  metalRate(),
                  netWeight(),
                  dustWeight(),
                  // oldAmount(),
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
                  text: _mannualEstimationOldItemFormController.itemFormMode.value,
                  onPressed: () {
                    _mannualEstimationOldItemFormController.submitForm(context);
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
                    _mannualEstimationOldItemFormController.resetForm(context);
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
                _mannualEstimationOldItemFormController.totalAmountController,
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

  // SizedBox gstAmount() {
  //   return SizedBox(
  //     width: 150.w,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         CustomLabel(label: "Gst Amount"),
  //         SizedBox(height: 7.h),
  //         CustomTextInput(
  //           inputFormat: 'double',
  //           controller:
  //               _mannualEstimationOldItemFormController.gstAmountController,
  //           textInputAction: TextInputAction.next,
  //           keyboardType: TextInputType.numberWithOptions(),
  //           validator: "default",
  //           hintText: "Gst Amount",
  //           readOnly: true,
  //           onChanged: (value) {
              
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                _mannualEstimationOldItemFormController.oldAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Old Amount",
            onChanged: (value) {
              if (_mannualEstimationOldItemFormController.selectedMetal.value != null 
              // && _mannualEstimationController.selectedGstType.value != null
              ) {
                _mannualEstimationOldItemFormController.calculateTotalAmount(
                                      touch:  _mannualEstimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.touchWeightController.text,
                  reduceWeight:  _mannualEstimationOldItemFormController.reduceWeightController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.reduceWeightController.text,
                  metal: _mannualEstimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _mannualEstimationController.selectedGstType.value!.value,
                  oldRate: value.isEmpty ? "0" : value,
                  metalRate: _mannualEstimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.metalRateController.text,
                  metalWeight: _mannualEstimationOldItemFormController.grossWeightController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.grossWeightController.text
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
                _mannualEstimationOldItemFormController.netWeightController,
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
                _mannualEstimationOldItemFormController.dustWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Dust Weight",
            readOnly: true,
            onChanged: (value) {
              
            },
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
                _mannualEstimationOldItemFormController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              if (_mannualEstimationOldItemFormController.selectedMetal.value != null 
              // && _mannualEstimationController.selectedGstType.value != null
              ) {
                _mannualEstimationOldItemFormController.calculateTotalAmount(
                    touch:  _mannualEstimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.touchWeightController.text,
                                    reduceWeight:  _mannualEstimationOldItemFormController.reduceWeightController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.reduceWeightController.text,
                  metal: _mannualEstimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _mannualEstimationController.selectedGstType.value!.value,
                  oldRate: _mannualEstimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.oldAmountController.text,
                  metalRate: value.isEmpty ? "0" : value,
                  metalWeight: _mannualEstimationOldItemFormController.grossWeightController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.grossWeightController.text
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
                _mannualEstimationOldItemFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              if (_mannualEstimationOldItemFormController.selectedMetal.value != null 
              // && _mannualEstimationController.selectedGstType.value != null
              ) {
                _mannualEstimationOldItemFormController.calculateTotalAmount(
                                      touch:  _mannualEstimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.touchWeightController.text,
                  reduceWeight:  _mannualEstimationOldItemFormController.reduceWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.reduceWeightController.text,
                  metal: _mannualEstimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _mannualEstimationController.selectedGstType.value!.value,
                  oldRate: _mannualEstimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.oldAmountController.text,
                  metalRate: _mannualEstimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.metalRateController.text,
                  metalWeight: value.isEmpty ? "0" : value,
                );
              }
            },
          ),
        ],
      ),
    );
  }


   SizedBox reduceWeight() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Reduce Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _mannualEstimationOldItemFormController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Reduce Weight",
            onChanged: (value) {
              if (_mannualEstimationOldItemFormController.selectedMetal.value != null 
              // && _mannualEstimationController.selectedGstType.value != null
              ) {
                _mannualEstimationOldItemFormController.calculateTotalAmount(
                                      touch:  _mannualEstimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.touchWeightController.text,
                  reduceWeight: value.isEmpty ? "0" : value,
                  metal: _mannualEstimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _mannualEstimationController.selectedGstType.value!.value,
                  oldRate: _mannualEstimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.oldAmountController.text,
                  metalRate: _mannualEstimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.metalRateController.text,
                  metalWeight:  _mannualEstimationOldItemFormController.grossWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.grossWeightController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }


  SizedBox touch() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "touch"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller:
                _mannualEstimationOldItemFormController.touchWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "touch",
            onChanged: (value) {
              if (_mannualEstimationOldItemFormController.selectedMetal.value != null 
              // && _mannualEstimationController.selectedGstType.value != null
              ) {
                _mannualEstimationOldItemFormController.calculateTotalAmount(
                   touch: value.isEmpty ? "0" : value,
                   reduceWeight:  _mannualEstimationOldItemFormController.reduceWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.reduceWeightController.text,
                  metal: _mannualEstimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _mannualEstimationController.selectedGstType.value!.value,
                  oldRate: _mannualEstimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.oldAmountController.text,
                  metalRate: _mannualEstimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _mannualEstimationOldItemFormController.metalRateController.text,
                  metalWeight:  _mannualEstimationOldItemFormController.grossWeightController.text.isEmpty ? "0"  : _mannualEstimationOldItemFormController.grossWeightController.text,
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
          Obx(() => CustomDropdownSearchField(
                controller: _mannualEstimationOldItemFormController.metalSearchController,
                selectedValue: _mannualEstimationOldItemFormController.selectedMetal.value,
                options: _mannualEstimationOldItemFormController.metalDropDown.value,
                onChanged: (value) {
                  _mannualEstimationOldItemFormController.onMetalChange(value!);
                },
                hintText: "Metal",
              ))
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
            controller: _mannualEstimationOldItemFormController.itemnameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Item Name",
          ),
        ],
      ),
    );
  }
}
