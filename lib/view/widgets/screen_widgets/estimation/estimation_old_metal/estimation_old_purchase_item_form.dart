import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/estimation/estimation_old_item_form_controller.dart';
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

class EstimationOldPurchaseItemForm extends StatefulWidget {
  const EstimationOldPurchaseItemForm({super.key});

  @override
  State<EstimationOldPurchaseItemForm> createState() => _EstimationOldPurchaseItemFormState();
}

class _EstimationOldPurchaseItemFormState extends State<EstimationOldPurchaseItemForm> {

  final EstimationOldItemFormController _estimationOldItemFormController = Get.put(EstimationOldItemFormController());
  final EstimationController _estimationController = Get.put(EstimationController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Form(
      key: _estimationOldItemFormController.estiamtionOldPurchaseItemFormDetailsFormKey,
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
                        _estimationController.calculateOldMetals();
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
                  text: _estimationOldItemFormController.itemFormMode.value,
                  onPressed: () {
                    _estimationOldItemFormController.submitForm(context);
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
                    _estimationOldItemFormController.resetForm(context);
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
                _estimationOldItemFormController.totalAmountController,
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
  //               _estimationOldItemFormController.gstAmountController,
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
                _estimationOldItemFormController.oldAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Old Amount",
            onChanged: (value) {
              if (_estimationOldItemFormController.selectedMetal.value != null 
              // && _estimationController.selectedGstType.value != null
              ) {
                _estimationOldItemFormController.calculateTotalAmount(
                                      touch:  _estimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.touchWeightController.text,
                  reduceWeight:  _estimationOldItemFormController.reduceWeightController.text.isEmpty ? "0" : _estimationOldItemFormController.reduceWeightController.text,
                  metal: _estimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _estimationController.selectedGstType.value!.value,
                  oldRate: value.isEmpty ? "0" : value,
                  metalRate: _estimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _estimationOldItemFormController.metalRateController.text,
                  metalWeight: _estimationOldItemFormController.grossWeightController.text.isEmpty ? "0" : _estimationOldItemFormController.grossWeightController.text
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
                _estimationOldItemFormController.netWeightController,
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
                _estimationOldItemFormController.dustWeightController,
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
                _estimationOldItemFormController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              if (_estimationOldItemFormController.selectedMetal.value != null 
              // && _estimationController.selectedGstType.value != null
              ) {
                _estimationOldItemFormController.calculateTotalAmount(
                    touch:  _estimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.touchWeightController.text,
                                    reduceWeight:  _estimationOldItemFormController.reduceWeightController.text.isEmpty ? "0" : _estimationOldItemFormController.reduceWeightController.text,
                  metal: _estimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _estimationController.selectedGstType.value!.value,
                  oldRate: _estimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _estimationOldItemFormController.oldAmountController.text,
                  metalRate: value.isEmpty ? "0" : value,
                  metalWeight: _estimationOldItemFormController.grossWeightController.text.isEmpty ? "0" : _estimationOldItemFormController.grossWeightController.text
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
                _estimationOldItemFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              if (_estimationOldItemFormController.selectedMetal.value != null 
              // && _estimationController.selectedGstType.value != null
              ) {
                _estimationOldItemFormController.calculateTotalAmount(
                                      touch:  _estimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.touchWeightController.text,
                  reduceWeight:  _estimationOldItemFormController.reduceWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.reduceWeightController.text,
                  metal: _estimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _estimationController.selectedGstType.value!.value,
                  oldRate: _estimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _estimationOldItemFormController.oldAmountController.text,
                  metalRate: _estimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _estimationOldItemFormController.metalRateController.text,
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
                _estimationOldItemFormController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Reduce Weight",
            onChanged: (value) {
              if (_estimationOldItemFormController.selectedMetal.value != null 
              // && _estimationController.selectedGstType.value != null
              ) {
                _estimationOldItemFormController.calculateTotalAmount(
                                      touch:  _estimationOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.touchWeightController.text,
                  reduceWeight: value.isEmpty ? "0" : value,
                  metal: _estimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _estimationController.selectedGstType.value!.value,
                  oldRate: _estimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _estimationOldItemFormController.oldAmountController.text,
                  metalRate: _estimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _estimationOldItemFormController.metalRateController.text,
                  metalWeight:  _estimationOldItemFormController.grossWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.grossWeightController.text,
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
                _estimationOldItemFormController.touchWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "touch",
            onChanged: (value) {
              if (_estimationOldItemFormController.selectedMetal.value != null 
              // && _estimationController.selectedGstType.value != null
              ) {
                _estimationOldItemFormController.calculateTotalAmount(
                   touch: value.isEmpty ? "0" : value,
                   reduceWeight:  _estimationOldItemFormController.reduceWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.reduceWeightController.text,
                  metal: _estimationOldItemFormController.selectedMetal.value!.value,
                  // gstType: _estimationController.selectedGstType.value!.value,
                  oldRate: _estimationOldItemFormController.oldAmountController.text.isEmpty ? "0" : _estimationOldItemFormController.oldAmountController.text,
                  metalRate: _estimationOldItemFormController.metalRateController.text.isEmpty ? "0" : _estimationOldItemFormController.metalRateController.text,
                  metalWeight:  _estimationOldItemFormController.grossWeightController.text.isEmpty ? "0"  : _estimationOldItemFormController.grossWeightController.text,
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
                controller: _estimationOldItemFormController.metalSearchController,
                selectedValue: _estimationOldItemFormController.selectedMetal.value,
                options: _estimationOldItemFormController.metalDropDown.value,
                onChanged: (value) {
                  _estimationOldItemFormController.onMetalChange(value!);
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
            controller: _estimationOldItemFormController.itemnameController,
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
