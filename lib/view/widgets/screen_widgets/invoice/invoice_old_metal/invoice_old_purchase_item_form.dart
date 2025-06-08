import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_old_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceOldPurchaseItemForm extends StatefulWidget {
  const InvoiceOldPurchaseItemForm({super.key});

  @override
  State<InvoiceOldPurchaseItemForm> createState() => _InvoiceOldPurchaseItemFormState();
}

class _InvoiceOldPurchaseItemFormState extends State<InvoiceOldPurchaseItemForm> {

  final InvoiceOldItemFormController _invoiceOldItemFormController = Get.put(InvoiceOldItemFormController());
  final InvoiceController _invoiceController = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Form(
      key: _invoiceOldItemFormController.invoiceOldPurchaseItemFormDetailsFormKey,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      "Item Details",
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),

                  Row(
                    children: [
                      Obx(() => PrimaryButton(btnWidth: 150, isLoading: _invoiceController.isOldMetalSubmitLoading.value, text: 'Done', onPressed: () {
                        _invoiceOldItemFormController.createOldMetal(context);
                      })),
                      SizedBox(width:10.w),
                      SecondaryButton(btnWidth: 100.w , isLoading: false, text: "close", onPressed: (){
                        Get.back();
                      })
                    ],
                  )
                ],
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
                  dustWeight(),
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
                  text: _invoiceOldItemFormController.itemFormMode.value,
                  onPressed: () {
                    _invoiceOldItemFormController.submitForm(context);
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
                    _invoiceOldItemFormController.resetForm(context);
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
                _invoiceOldItemFormController.totalAmountController,
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
  //               _invoiceOldItemFormController.gstAmountController,
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
                _invoiceOldItemFormController.oldAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Old Amount",
            onChanged: (value) {
              if (_invoiceOldItemFormController.selectedMetal.value != null
              //  && _invoiceController.selectedGstType.value != null
               ) {
                _invoiceOldItemFormController.calculateTotalAmount(
                  touch:  _invoiceOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.touchWeightController.text,
                  reduceWeight:  _invoiceOldItemFormController.reduceWeightController.text.isEmpty ? "0" : _invoiceOldItemFormController.reduceWeightController.text,
                  metal: _invoiceOldItemFormController.selectedMetal.value!.value,
                  // gstType: _invoiceController.selectedGstType.value!.value,
                  oldRate: value.isEmpty ? "0" : value,
                  metalRate: _invoiceOldItemFormController.metalRateController.text.isEmpty ? "0" : _invoiceOldItemFormController.metalRateController.text,
                  metalWeight: _invoiceOldItemFormController.grossWeightController.text.isEmpty ? "0" : _invoiceOldItemFormController.grossWeightController.text
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
                _invoiceOldItemFormController.netWeightController,
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
                _invoiceOldItemFormController.dustWeightController,
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
                _invoiceOldItemFormController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              if (_invoiceOldItemFormController.selectedMetal.value != null
              //  && _invoiceController.selectedGstType.value != null
               ) {
                _invoiceOldItemFormController.calculateTotalAmount(
                  metal: _invoiceOldItemFormController.selectedMetal.value!.value,
                  touch:  _invoiceOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.touchWeightController.text,
                  reduceWeight:  _invoiceOldItemFormController.reduceWeightController.text.isEmpty ? "0" : _invoiceOldItemFormController.reduceWeightController.text,
                  // gstType: _invoiceController.selectedGstType.value!.value,
                  oldRate: _invoiceOldItemFormController.oldAmountController.text.isEmpty ? "0" : _invoiceOldItemFormController.oldAmountController.text,
                  metalRate: value.isEmpty ? "0" : value,
                  metalWeight: _invoiceOldItemFormController.grossWeightController.text.isEmpty ? "0" : _invoiceOldItemFormController.grossWeightController.text
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
                _invoiceOldItemFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              if (_invoiceOldItemFormController.selectedMetal.value != null
              //  && _invoiceController.selectedGstType.value != null
               ) {
                _invoiceOldItemFormController.calculateTotalAmount(
                  metal: _invoiceOldItemFormController.selectedMetal.value!.value,
                  touch:  _invoiceOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.touchWeightController.text,
                  reduceWeight:  _invoiceOldItemFormController.reduceWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.reduceWeightController.text,
                  // gstType: _invoiceController.selectedGstType.value!.value,
                  oldRate: _invoiceOldItemFormController.oldAmountController.text.isEmpty ? "0" : _invoiceOldItemFormController.oldAmountController.text,
                  metalRate: _invoiceOldItemFormController.metalRateController.text.isEmpty ? "0" : _invoiceOldItemFormController.metalRateController.text,
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
                _invoiceOldItemFormController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Reduce Weight",
            onChanged: (value) {
              if (_invoiceOldItemFormController.selectedMetal.value != null
              //  && _invoiceController.selectedGstType.value != null
               ) {
                _invoiceOldItemFormController.calculateTotalAmount(
                                      touch:  _invoiceOldItemFormController.touchWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.touchWeightController.text,
                  reduceWeight: value.isEmpty ? "0" : value,
                  metal: _invoiceOldItemFormController.selectedMetal.value!.value,
                  // gstType: _invoiceController.selectedGstType.value!.value,
                  oldRate: _invoiceOldItemFormController.oldAmountController.text.isEmpty ? "0" : _invoiceOldItemFormController.oldAmountController.text,
                  metalRate: _invoiceOldItemFormController.metalRateController.text.isEmpty ? "0" : _invoiceOldItemFormController.metalRateController.text,
                  metalWeight:  _invoiceOldItemFormController.grossWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.grossWeightController.text,
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
                _invoiceOldItemFormController.touchWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "touch",
            onChanged: (value) {
              if (_invoiceOldItemFormController.selectedMetal.value != null
              //  && _invoiceController.selectedGstType.value != null
               ) {
                _invoiceOldItemFormController.calculateTotalAmount(
                   touch: value.isEmpty ? "0" : value,
                   reduceWeight:  _invoiceOldItemFormController.reduceWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.reduceWeightController.text,
                  metal: _invoiceOldItemFormController.selectedMetal.value!.value,
                  // gstType: _invoiceController.selectedGstType.value!.value,
                  oldRate: _invoiceOldItemFormController.oldAmountController.text.isEmpty ? "0" : _invoiceOldItemFormController.oldAmountController.text,
                  metalRate: _invoiceOldItemFormController.metalRateController.text.isEmpty ? "0" : _invoiceOldItemFormController.metalRateController.text,
                  metalWeight:  _invoiceOldItemFormController.grossWeightController.text.isEmpty ? "0"  : _invoiceOldItemFormController.grossWeightController.text,
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
            controller: _invoiceOldItemFormController.itemnameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Item Name",
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
                controller: _invoiceOldItemFormController.metalSearchController,
                selectedValue: _invoiceOldItemFormController.selectedMetal.value,
                options: _invoiceOldItemFormController.metalDropDown.value,
                onChanged: (value) {
                  _invoiceOldItemFormController.onMetalChange(value!);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
