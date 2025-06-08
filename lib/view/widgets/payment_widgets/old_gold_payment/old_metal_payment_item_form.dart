import 'package:ausales_application/controller/payment_controllers/old_metal_payment_controller.dart';
import 'package:ausales_application/model/payment/old_gold_payment_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldMetalPaymentItemForm extends StatefulWidget {
  String branch;
  String customer;
  String gstType;
  RxList<OldItemPaymentDetails> itemsList;
  OldMetalPaymentItemForm(
      {super.key,
      required this.branch,
      required this.customer,
      required this.itemsList,
      required this.gstType});

  @override
  State<OldMetalPaymentItemForm> createState() =>
      _OldMetalPaymentItemFormState();
}

class _OldMetalPaymentItemFormState extends State<OldMetalPaymentItemForm> {
  final OldMetalPaymentController _oldMetalPaymentController =
      Get.put(OldMetalPaymentController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _oldMetalPaymentController.oldMetalPaymentFormKey,
        child: Wrap(
          spacing: 20.w,
          runSpacing: 10.h,
          children: [
            metal(),
            item(),
            metalWeight(),
            reduceWeight(),
            touch(),
            metalRate(),
            netWeight(),
            dustWeight(),
            // oldAmount(),
            // gstAmount(),
            totalAmount(),
            actions(context)
          ],
        ));
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 200.w,
      height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => PrimaryButton(
                  btnWidth: 95.w,
                  isLoading: false,
                  text: _oldMetalPaymentController.formMode.value,
                  onPressed: () {
                    _oldMetalPaymentController.addItemInList(context, widget.itemsList);
                  })),
              SecondaryButton(
                  btnWidth: 95.w,
                  isLoading: false,
                  text: 'Clear',
                  onPressed: () {
                    _oldMetalPaymentController.resetOldMetalItemForm();
                  })
            ],
          ),
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
            controller: _oldMetalPaymentController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Total Amount",
            readOnly: true,
            onChanged: (value) {},
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
  //           controller: _oldMetalPaymentController.gstAmountController,
  //           textInputAction: TextInputAction.next,
  //           keyboardType: TextInputType.numberWithOptions(),
  //           validator: "default",
  //           hintText: "Gst Amount",
  //           readOnly: true,
  //           onChanged: (value) {},
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
            controller: _oldMetalPaymentController.oldAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Old Amount",
            onChanged: (value) {
              if (_oldMetalPaymentController.selectedMetal.value != null) {
                _oldMetalPaymentController.calculateTotalAmount(
                    touch: _oldMetalPaymentController
                            .touchWeightController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController.touchWeightController.text,
                    reduceWeight: _oldMetalPaymentController
                            .reduceWeightController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController
                            .reduceWeightController.text,
                    metal:
                        _oldMetalPaymentController.selectedMetal.value!.value,
                    // gstType: widget.gstType,
                    oldRate: value.isEmpty ? "0" : value,
                    metalRate: _oldMetalPaymentController
                            .metalRateController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController.metalRateController.text,
                    metalWeight: _oldMetalPaymentController
                            .grossWeightController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController
                            .grossWeightController.text);
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
            controller: _oldMetalPaymentController.netWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Net Weight",
            readOnly: true,
            onChanged: (value) {},
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
            controller: _oldMetalPaymentController.dustWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Dust Weight",
            readOnly: true,
            onChanged: (value) {},
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
            controller: _oldMetalPaymentController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              if (_oldMetalPaymentController.selectedMetal.value != null) {
                _oldMetalPaymentController.calculateTotalAmount(
                    touch: _oldMetalPaymentController
                            .touchWeightController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController.touchWeightController.text,
                    reduceWeight: _oldMetalPaymentController
                            .reduceWeightController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController
                            .reduceWeightController.text,
                    metal:
                        _oldMetalPaymentController.selectedMetal.value!.value,
                    // gstType: widget.gstType,
                    oldRate: _oldMetalPaymentController
                            .oldAmountController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController.oldAmountController.text,
                    metalRate: value.isEmpty ? "0" : value,
                    metalWeight: _oldMetalPaymentController
                            .grossWeightController.text.isEmpty
                        ? "0"
                        : _oldMetalPaymentController
                            .grossWeightController.text);
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
            controller: _oldMetalPaymentController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              if (_oldMetalPaymentController.selectedMetal.value != null) {
                _oldMetalPaymentController.calculateTotalAmount(
                  touch: _oldMetalPaymentController
                          .touchWeightController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.touchWeightController.text,
                  reduceWeight: _oldMetalPaymentController
                          .reduceWeightController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.reduceWeightController.text,
                  metal: _oldMetalPaymentController.selectedMetal.value!.value,
                  // gstType: widget.gstType,
                  oldRate: _oldMetalPaymentController
                          .oldAmountController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.oldAmountController.text,
                  metalRate: _oldMetalPaymentController
                          .metalRateController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.metalRateController.text,
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
            controller: _oldMetalPaymentController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Reduce Weight",
            onChanged: (value) {
              if (_oldMetalPaymentController.selectedMetal.value != null) {
                _oldMetalPaymentController.calculateTotalAmount(
                  touch: _oldMetalPaymentController
                          .touchWeightController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.touchWeightController.text,
                  reduceWeight: value.isEmpty ? "0" : value,
                  metal: _oldMetalPaymentController.selectedMetal.value!.value,
                  // gstType: widget.gstType,
                  oldRate: _oldMetalPaymentController
                          .oldAmountController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.oldAmountController.text,
                  metalRate: _oldMetalPaymentController
                          .metalRateController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.metalRateController.text,
                  metalWeight: _oldMetalPaymentController
                          .grossWeightController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.grossWeightController.text,
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
            controller: _oldMetalPaymentController.touchWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "touch",
            onChanged: (value) {
              if (_oldMetalPaymentController.selectedMetal.value != null) {
                _oldMetalPaymentController.calculateTotalAmount(
                  touch: value.isEmpty ? "0" : value,
                  reduceWeight: _oldMetalPaymentController
                          .reduceWeightController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.reduceWeightController.text,
                  metal: _oldMetalPaymentController.selectedMetal.value!.value,
                  // gstType: widget.gstType,
                  oldRate: _oldMetalPaymentController
                          .oldAmountController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.oldAmountController.text,
                  metalRate: _oldMetalPaymentController
                          .metalRateController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.metalRateController.text,
                  metalWeight: _oldMetalPaymentController
                          .grossWeightController.text.isEmpty
                      ? "0"
                      : _oldMetalPaymentController.grossWeightController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
  

  SizedBox item() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _oldMetalPaymentController.itemController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Item",
            onChanged: (value) {
              
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
                controller: _oldMetalPaymentController.metalSearchController,
                selectedValue: _oldMetalPaymentController.selectedMetal.value,
                options: _oldMetalPaymentController.metalDropDown.value,
                onChanged: (value) {
                  _oldMetalPaymentController.onMetalChange(
                      value!, widget.gstType);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
