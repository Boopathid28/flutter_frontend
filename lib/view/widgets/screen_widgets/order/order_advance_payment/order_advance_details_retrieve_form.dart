import 'package:ausales_application/controller/order/order_advance/order_advance_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderAdvanceDetailsRetrieveForm extends StatefulWidget {
  AdvanceRetrieveData data;
  Function() onCompleted;
  List<AdvanceDetails> advanceItemsList;
  OrderAdvanceDetailsRetrieveForm({super.key, required this.data, required this.onCompleted, required this.advanceItemsList});

  @override
  State<OrderAdvanceDetailsRetrieveForm> createState() => _OrderAdvanceDetailsRetrieveFormState();
}

class _OrderAdvanceDetailsRetrieveFormState extends State<OrderAdvanceDetailsRetrieveForm> {

  final OrderAdvancePaymentController _orderAdvancePaymentController = Get.put(OrderAdvancePaymentController());

  @override
  Widget build(BuildContext context) {
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
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Remaining Amount"),
                  Text("₹ ${widget.data.remainingAmount!}")
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Remaining Weight"),
                  Text("${widget.data.remainingWeight!} g")
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Redeem Amount"),
                  BillingTextInput(
                    width: 100,
                    controller: _orderAdvancePaymentController.advanceRedeemAmountController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(_orderAdvancePaymentController.advanceMetalRateController.text.isEmpty ? "0" : _orderAdvancePaymentController.advanceMetalRateController.text);
                      double redeemWeight = double.parse(_orderAdvancePaymentController.advanceRedeemWeightController.text.isEmpty ? "0" : _orderAdvancePaymentController.advanceRedeemWeightController.text);
                      double redeemAmount = double.parse(value.isEmpty ? "0" : value);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _orderAdvancePaymentController.totalAdvanceAmount(totalAmount);
                      _orderAdvancePaymentController.totalAdvanceMetalValue(totalMetalValue);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Redeem Weight in Gram"),
                  BillingTextInput(
                    width: 100,
                    controller: _orderAdvancePaymentController.advanceRedeemWeightController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(_orderAdvancePaymentController.advanceMetalRateController.text.isEmpty ? "0" : _orderAdvancePaymentController.advanceMetalRateController.text);
                      double redeemWeight = double.parse(value.isEmpty ? "0" : value);
                      double redeemAmount = double.parse(_orderAdvancePaymentController.advanceRedeemAmountController.text.isEmpty ? "0" : _orderAdvancePaymentController.advanceRedeemAmountController.text);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _orderAdvancePaymentController.totalAdvanceAmount(totalAmount);
                      _orderAdvancePaymentController.totalAdvanceMetalValue(totalMetalValue);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Metal Rate Per Gram"),
                  BillingTextInput(
                    width: 100,
                    controller: _orderAdvancePaymentController.advanceMetalRateController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(value.isEmpty ? "0" : value);
                      double redeemWeight = double.parse(_orderAdvancePaymentController.advanceRedeemWeightController.text.isEmpty ? "0" : _orderAdvancePaymentController.advanceRedeemWeightController.text);
                      double redeemAmount = double.parse(_orderAdvancePaymentController.advanceRedeemAmountController.text.isEmpty ? "0" : _orderAdvancePaymentController.advanceRedeemAmountController.text);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _orderAdvancePaymentController.totalAdvanceAmount(totalAmount);
                      _orderAdvancePaymentController.totalAdvanceMetalValue(totalMetalValue);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Total Redeem Metal Amount"),
                  Obx(() => Text("₹ ${_orderAdvancePaymentController.totalAdvanceMetalValue.value.toStringAsFixed(2)}"))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Total Redeem Amount"),
                  Obx(() => Text("₹ ${_orderAdvancePaymentController.totalAdvanceAmount.value.toStringAsFixed(2)}"))
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        PrimaryButton(isLoading: false, text: 'Apply', onPressed: () {
          _orderAdvancePaymentController.applyAdvanceDetails(context, widget.data, widget.onCompleted, widget.advanceItemsList);
        })
      ],
    );
  }
}