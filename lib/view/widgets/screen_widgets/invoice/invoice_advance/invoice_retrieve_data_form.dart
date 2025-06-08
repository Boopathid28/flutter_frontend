import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceRetrieveDataForm extends StatefulWidget {
  AdvanceRetrieveData data;
  InvoiceRetrieveDataForm({super.key, required this.data});

  @override
  State<InvoiceRetrieveDataForm> createState() =>
      _InvoiceRetrieveDataFormState();
}

class _InvoiceRetrieveDataFormState
    extends State<InvoiceRetrieveDataForm> {

      final InvoiceController _invoiceController = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                    controller: _invoiceController.advanceRedeemAmountController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(_invoiceController.advanceMetalRateController.text.isEmpty ? "0" : _invoiceController.advanceMetalRateController.text);
                      double redeemWeight = double.parse(_invoiceController.advanceRedeemWeightController.text.isEmpty ? "0" : _invoiceController.advanceRedeemWeightController.text);
                      double redeemAmount = double.parse(value.isEmpty ? "0" : value);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _invoiceController.totalAdvanceAmount(totalAmount);
                      _invoiceController.totalAdvanceMetalValue(totalMetalValue);
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
                  CustomLabel(label: "Redeem Weight in Gram"),
                  BillingTextInput(
                    width: 100,
                    controller: _invoiceController.advanceRedeemWeightController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(_invoiceController.advanceMetalRateController.text.isEmpty ? "0" : _invoiceController.advanceMetalRateController.text);
                      double redeemWeight = double.parse(value.isEmpty ? "0" : value);
                      double redeemAmount = double.parse(_invoiceController.advanceRedeemAmountController.text.isEmpty ? "0" : _invoiceController.advanceRedeemAmountController.text);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _invoiceController.totalAdvanceAmount(totalAmount);
                      _invoiceController.totalAdvanceMetalValue(totalMetalValue);
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
                    controller: _invoiceController.advanceMetalRateController, 
                    textInputAction: TextInputAction.next, 
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormat: 'double',
                    filled: true,
                    onChanged: (value) {
                      double metalRate = double.parse(value.isEmpty ? "0" : value);
                      double redeemWeight = double.parse(_invoiceController.advanceRedeemWeightController.text.isEmpty ? "0" : _invoiceController.advanceRedeemWeightController.text);
                      double redeemAmount = double.parse(_invoiceController.advanceRedeemAmountController.text.isEmpty ? "0" : _invoiceController.advanceRedeemAmountController.text);

                      double totalMetalValue = metalRate * redeemWeight;

                      double totalAmount = redeemAmount + totalMetalValue;

                      _invoiceController.totalAdvanceAmount(totalAmount);
                      _invoiceController.totalAdvanceMetalValue(totalMetalValue);
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
                  Obx(() => Text("₹ ${_invoiceController.totalAdvanceMetalValue.value.toStringAsFixed(2)}"))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Total Redeem Amount"),
                  Obx(() => Text("₹ ${_invoiceController.totalAdvanceAmount.value.toStringAsFixed(2)}"))
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        PrimaryButton(isLoading: false, text: 'Apply', onPressed: () {
          _invoiceController.applyAdvanceDetails(context, widget.data);
        })
      ],
    );
  }
}
