import 'package:ausales_application/controller/payment_controllers/advance_payment_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvanceDetailsRetrieveForm extends StatefulWidget {
  AdvanceRetrieveData data;
  Function() onCompleted;
  List<AdvancePaymentItemModel> advanceItemsList;
  AdvanceDetailsRetrieveForm({super.key, required this.data, required this.onCompleted, required this.advanceItemsList});

  @override
  State<AdvanceDetailsRetrieveForm> createState() => _AdvanceDetailsRetrieveFormState();
}

class _AdvanceDetailsRetrieveFormState extends State<AdvanceDetailsRetrieveForm> {

  final AdvancePaymentController _advancePaymentController = Get.put(AdvancePaymentController());

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
                    controller: _advancePaymentController.advanceRedeemAmountController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(_advancePaymentController.advanceMetalRateController.text.isEmpty ? "0" : _advancePaymentController.advanceMetalRateController.text);
                      double redeemWeight = double.parse(_advancePaymentController.advanceRedeemWeightController.text.isEmpty ? "0" : _advancePaymentController.advanceRedeemWeightController.text);
                      double redeemAmount = double.parse(value.isEmpty ? "0" : value);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _advancePaymentController.totalAdvanceAmount(totalAmount);
                      _advancePaymentController.totalAdvanceMetalValue(totalMetalValue);
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
                    controller: _advancePaymentController.advanceRedeemWeightController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(_advancePaymentController.advanceMetalRateController.text.isEmpty ? "0" : _advancePaymentController.advanceMetalRateController.text);
                      double redeemWeight = double.parse(value.isEmpty ? "0" : value);
                      double redeemAmount = double.parse(_advancePaymentController.advanceRedeemAmountController.text.isEmpty ? "0" : _advancePaymentController.advanceRedeemAmountController.text);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _advancePaymentController.totalAdvanceAmount(totalAmount);
                      _advancePaymentController.totalAdvanceMetalValue(totalMetalValue);
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
                    controller: _advancePaymentController.advanceMetalRateController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(value.isEmpty ? "0" : value);
                      double redeemWeight = double.parse(_advancePaymentController.advanceRedeemWeightController.text.isEmpty ? "0" : _advancePaymentController.advanceRedeemWeightController.text);
                      double redeemAmount = double.parse(_advancePaymentController.advanceRedeemAmountController.text.isEmpty ? "0" : _advancePaymentController.advanceRedeemAmountController.text);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _advancePaymentController.totalAdvanceAmount(totalAmount);
                      _advancePaymentController.totalAdvanceMetalValue(totalMetalValue);
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
                  Obx(() => Text("₹ ${_advancePaymentController.totalAdvanceMetalValue.value.toStringAsFixed(2)}"))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Total Redeem Amount"),
                  Obx(() => Text("₹ ${_advancePaymentController.totalAdvanceAmount.value.toStringAsFixed(2)}"))
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        PrimaryButton(isLoading: false, text: 'Apply', onPressed: () {
          _advancePaymentController.applyAdvanceDetails(context, widget.data, widget.onCompleted, widget.advanceItemsList);
        })
      ],
    );
  }
}