import 'package:ausales_application/controller/order/order_old_metal_payment_controller.dart';
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

class OrderOldMetalPaymentItemForm extends StatefulWidget {
  RxList<OldItemPaymentDetails> itemsList;
  OrderOldMetalPaymentItemForm({super.key, required this.itemsList});

  @override
  State<OrderOldMetalPaymentItemForm> createState() =>
      _OrderOldMetalPaymentItemFormState();
}

class _OrderOldMetalPaymentItemFormState
    extends State<OrderOldMetalPaymentItemForm> {
  final OrderOldMetalPaymentController _orderOldMetalPaymentController =
      Get.put(OrderOldMetalPaymentController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _orderOldMetalPaymentController.oldMetalPaymentFormKey,
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
                  text: _orderOldMetalPaymentController.formMode.value,
                  onPressed: () {
                    _orderOldMetalPaymentController.addItemInList(
                        context, widget.itemsList);
                  })),
              SecondaryButton(
                  btnWidth: 95.w,
                  isLoading: false,
                  text: 'Clear',
                  onPressed: () {
                    _orderOldMetalPaymentController.resetOldMetalItemForm();
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
            controller: _orderOldMetalPaymentController.totalAmountController,
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
  //           controller: _orderOldMetalPaymentController.gstAmountController,
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
            controller: _orderOldMetalPaymentController.oldAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Old Amount",
            onChanged: (value) {
              if (_orderOldMetalPaymentController.selectedMetal.value != null) {
                _orderOldMetalPaymentController.calculateTotalAmount(
                    touch: _orderOldMetalPaymentController
                            .touchWeightController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
                            .touchWeightController.text,
                    reduceWeight: _orderOldMetalPaymentController
                            .reduceWeightController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
                            .reduceWeightController.text,
                    metal: _orderOldMetalPaymentController
                        .selectedMetal.value!.value,
                    oldRate: value.isEmpty ? "0" : value,
                    metalRate: _orderOldMetalPaymentController
                            .metalRateController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
                            .metalRateController.text,
                    metalWeight: _orderOldMetalPaymentController
                            .grossWeightController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
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
            controller: _orderOldMetalPaymentController.netWeightController,
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
            controller: _orderOldMetalPaymentController.dustWeightController,
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
            controller: _orderOldMetalPaymentController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              if (_orderOldMetalPaymentController.selectedMetal.value != null) {
                _orderOldMetalPaymentController.calculateTotalAmount(
                    touch: _orderOldMetalPaymentController
                            .touchWeightController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
                            .touchWeightController.text,
                    reduceWeight: _orderOldMetalPaymentController
                            .reduceWeightController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
                            .reduceWeightController.text,
                    metal: _orderOldMetalPaymentController
                        .selectedMetal.value!.value,
                    oldRate: _orderOldMetalPaymentController
                            .oldAmountController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
                            .oldAmountController.text,
                    metalRate: value.isEmpty ? "0" : value,
                    metalWeight: _orderOldMetalPaymentController
                            .grossWeightController.text.isEmpty
                        ? "0"
                        : _orderOldMetalPaymentController
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
            controller: _orderOldMetalPaymentController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              if (_orderOldMetalPaymentController.selectedMetal.value != null) {
                _orderOldMetalPaymentController.calculateTotalAmount(
                  touch: _orderOldMetalPaymentController
                          .touchWeightController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .touchWeightController.text,
                  reduceWeight: _orderOldMetalPaymentController
                          .reduceWeightController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .reduceWeightController.text,
                  metal: _orderOldMetalPaymentController
                      .selectedMetal.value!.value,
                  oldRate: _orderOldMetalPaymentController
                          .oldAmountController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .oldAmountController.text,
                  metalRate: _orderOldMetalPaymentController
                          .metalRateController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .metalRateController.text,
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
            controller: _orderOldMetalPaymentController.reduceWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Reduce Weight",
            onChanged: (value) {
              if (_orderOldMetalPaymentController.selectedMetal.value != null) {
                _orderOldMetalPaymentController.calculateTotalAmount(
                  touch: _orderOldMetalPaymentController
                          .touchWeightController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .touchWeightController.text,
                  reduceWeight: value.isEmpty ? "0" : value,
                  metal: _orderOldMetalPaymentController
                      .selectedMetal.value!.value,
                  oldRate: _orderOldMetalPaymentController
                          .oldAmountController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .oldAmountController.text,
                  metalRate: _orderOldMetalPaymentController
                          .metalRateController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .metalRateController.text,
                  metalWeight: _orderOldMetalPaymentController
                          .grossWeightController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .grossWeightController.text,
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
            controller: _orderOldMetalPaymentController.touchWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "touch",
            onChanged: (value) {
              if (_orderOldMetalPaymentController.selectedMetal.value != null) {
                _orderOldMetalPaymentController.calculateTotalAmount(
                  touch: value.isEmpty ? "0" : value,
                  reduceWeight: _orderOldMetalPaymentController
                          .reduceWeightController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .reduceWeightController.text,
                  metal: _orderOldMetalPaymentController
                      .selectedMetal.value!.value,
                  oldRate: _orderOldMetalPaymentController
                          .oldAmountController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .oldAmountController.text,
                  metalRate: _orderOldMetalPaymentController
                          .metalRateController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .metalRateController.text,
                  metalWeight: _orderOldMetalPaymentController
                          .grossWeightController.text.isEmpty
                      ? "0"
                      : _orderOldMetalPaymentController
                          .grossWeightController.text,
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
            controller: _orderOldMetalPaymentController.itemController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Item",
            onChanged: (value) {},
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
                controller:
                    _orderOldMetalPaymentController.metalSearchController,
                selectedValue:
                    _orderOldMetalPaymentController.selectedMetal.value,
                options: _orderOldMetalPaymentController.metalDropDown.value,
                onChanged: (value) {
                  _orderOldMetalPaymentController.onMetalChange(value!);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
