import 'dart:developer';

import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_item_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_dropdown_field.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_primary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_secondary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_stone_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/manual_invoice/manual_invoice_diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/manual_invoice/manual_invoice_stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ManualInvoiceItemForm extends StatefulWidget {
  const ManualInvoiceItemForm({super.key});

  @override
  State<ManualInvoiceItemForm> createState() => _ManualInvoiceItemFormState();
}

class _ManualInvoiceItemFormState extends State<ManualInvoiceItemForm> {
  final ManualInvoiceItemController _manualInvoiceItemController =
      Get.put(ManualInvoiceItemController());

  final ManualInvoiceController _manualInvoiceController =
      Get.put(ManualInvoiceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _manualInvoiceItemController.manualinvoiceItemFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 5.h,
              spacing: 5.w,
              children: [
                item(),
                subitem(),
                rate(),
                pieces(),
                grossWeight(),
                reduceWeight(),
                netWeight(),
                wastagePercent(),
                flatWastage(),
                makingChargePerGram(),
                flatMakingCharge(),
                stoneAmount(),
                diamondAmount(),
                huidAmount(),
                totalAmount(),
                gstAmount(),
                payableAmount()
              ],
            ),
            SizedBox(
              height: 5,
            ),
            actions(context)
          ],
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 100,
              child: Obx(() => BillingPrimaryButton(
                  isLoading: false,
                  text: _manualInvoiceItemController.itemFormMode.value,
                  onPressed: () {
                    if (_manualInvoiceController.selectedGstType.value != null) {
                      _manualInvoiceItemController.addManualParticularItem(context);
                    } else {
                      toastification.show(
                          context:
                              context, // optional if you use ToastificationWrapper
                          type: ToastificationType.info,
                          title: Text('Kindly select the GST Type first!'),
                          autoCloseDuration: notificationDuration,
                          showProgressBar: false,
                          pauseOnHover: false);
                    }
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 100,
              child: BillingSecondaryButton(
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _manualInvoiceItemController.resetManualForm(context: context);
                  }))
        ],
      ),
    );
  }

  SizedBox payableAmount() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Payable Amt'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            filled: true,
            width: 100,
            height: 50,
            validator: 'default',
            controller: _manualInvoiceItemController.payableAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Payable Amt',
            onChanged: (value) {
              _manualInvoiceItemController.reverseManualCalculation(context);
            },
          ),
        ],
      ),
    );
  }

  SizedBox gstAmount() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'GST Amt'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            filled: true,
            width: 100,
            height: 50,
            validator: 'default',
            controller: _manualInvoiceItemController.gstAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'GST Amt',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox totalAmount() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Total Amt'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            filled: true,
            width: 100,
            height: 50,
            validator: 'default',
            controller: _manualInvoiceItemController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Total Amt',
            onChanged: (value) {
              // _manualInvoiceItemController.reverseManualCalculation(context);
            },
          ),
        ],
      ),
    );
  }

  SizedBox huidAmount() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'HUID Amt'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            filled: true,
            width: 100,
            height: 50,
            validator: 'default',
            controller: _manualInvoiceItemController.huidAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'HUID Amt',
            onChanged: (value) {
              _manualInvoiceItemController.calculationManualItemValues();
            },
          ),
        ],
      ),
    );
  }

  SizedBox diamondAmount() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Diamond Amt'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            onTap: () async {
              await Get.dialog(
                  barrierDismissible: false,
                  ManualInvoiceDiamondDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _manualInvoiceItemController.diamondAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Diamond Amt',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox stoneAmount() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Stone Amt'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            onTap: () async {
              await Get.dialog(
                  barrierDismissible: false,
                  ManualInvoiceStoneDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _manualInvoiceItemController.stoneAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Stone Amt',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox flatMakingCharge() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'F.MC'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                isBillingValidator: true,
                  validator: _manualInvoiceItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
                controller:
                    _manualInvoiceItemController.flatMakingChargeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.MC',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualItemValues();
                },
              ),
        ],
      ),
    );
  }

  SizedBox makingChargePerGram() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'MC/G'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                isBillingValidator: true,
                validator: _manualInvoiceItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
                // validator: _manualInvoiceItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller:
                    _manualInvoiceItemController.makingChargePerGramController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'MC/G',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualItemValues();
                },
              ),
        ],
      ),
    );
  }

  SizedBox flatWastage() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'F.Wastage'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                isBillingValidator: true,
               validator: _manualInvoiceItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
                // validator: _manualInvoiceItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller: _manualInvoiceItemController.flatWastageController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.Wastage',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualItemValues();
                },
              ),
        ],
      ),
    );
  }

  SizedBox wastagePercent() {
    return SizedBox(
      height: 70.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Wastage %'),
          SizedBox(
            height: 2.5,
          ),
         BillingTextInput(
                width: 100,
                height: 50,
                filled: true,
                // validator: _manualInvoiceItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller: _manualInvoiceItemController.wastagePercentController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Wastage %',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualItemValues();
                },
                isBillingValidator: true,
                validator: _manualInvoiceItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
              ),
        ],
      ),
    );
  }

  SizedBox netWeight() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Net WGT'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            filled: true,
            width: 100,
            height: 50,
            validator: 'default',
            controller: _manualInvoiceItemController.netWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Net Weight',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox reduceWeight() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Reduce WGT'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                validator: 'default',
                controller: _manualInvoiceItemController.reduceWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Reduce Weight',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualItemValues();
                },
              ),
        ],
      ),
    );
  }

  SizedBox grossWeight() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Gross WGT'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                // validator: 'default',
                isBillingValidator: true,
                validator: 'default',
                controller: _manualInvoiceItemController.grossWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Gross Weight',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualItemValues();
                },
              ),
        ],
      ),
    );
  }


 SizedBox item() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Item"),
          SizedBox(
            height: 2.w,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _manualInvoiceItemController.selectedItem.value,
                options: _manualInvoiceItemController.itemDropDown.value,
                onChanged:(value) {
                        _manualInvoiceItemController.selectedItem(value);
                        _manualInvoiceItemController.getSubItemList(value!.value);
                      },
                hintText: "Item",
              ))
        ],
      ),
    );
  }

   SizedBox subitem() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Sub Item"),
          SizedBox(
            height: 2.w,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _manualInvoiceItemController.selectedSubItem.value,
                options: _manualInvoiceItemController.subItemDropDown.value,
                onChanged:(value) {
                        _manualInvoiceItemController.selectedSubItem(value);
                        _manualInvoiceItemController.getsubitemId(value!.value, context);
                      },
                hintText: "Sub Item",
              ))
        ],
      ),
    );
  }
   

  SizedBox pieces() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Pieces'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
                filled: true,
                width: 75,
                height: 50,
                // validator: 'default',
                isBillingValidator: true,
                validator: 'default',
                controller: _manualInvoiceItemController.piecesController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormat: 'integer',
                hintText: 'Pieces',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualItemValues();
                },
              ),
        ],
      ),
    );
  }

  SizedBox rate() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Rate'),
          SizedBox(
            height: 2.5,
          ),
         BillingTextInput(
                filled: true,
                height: 50,
                // validator: 'default',
                isBillingValidator: true,
                 validator: 'default',
                controller: _manualInvoiceItemController.rateController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Rate',
                onChanged: (value) {
                  _manualInvoiceItemController.calculationManualBilling();
                },
              ),
        ],
      ),
    );
  }

 

}
