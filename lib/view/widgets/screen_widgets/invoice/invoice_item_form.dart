import 'dart:developer';

import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_item_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_primary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_secondary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class InvoiceItemForm extends StatefulWidget {
  const InvoiceItemForm({super.key});

  @override
  State<InvoiceItemForm> createState() => _InvoiceItemFormState();
}

class _InvoiceItemFormState extends State<InvoiceItemForm> {
  final InvoiceItemController _invoiceItemController =
      Get.put(InvoiceItemController());

  final InvoiceController _invoiceController =
      Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _invoiceItemController.invoiceItemFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 5.h,
              spacing: 5.w,
              children: [
                tagNumber(),
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
                  text: _invoiceItemController.itemFormMode.value,
                  onPressed: () {
                    if (_invoiceController.selectedGstType.value != null) {
                      _invoiceItemController.addParticularItem(context);
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
                    _invoiceItemController.resetForm(context: context);
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
            controller: _invoiceItemController.payableAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Payable Amt',
            onChanged: (value) {
              _invoiceItemController.reverseCalculation(context);
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
            controller: _invoiceItemController.gstAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'GST Amt',
            readOnly: true,
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
            controller: _invoiceItemController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Total Amt',
            readOnly: true,
            onChanged: (value) {
              // _invoiceItemController.reverseCalculation(context);
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
            controller: _invoiceItemController.huidAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'HUID Amt',
            onChanged: (value) {
              _invoiceItemController.calculationItemValues();
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
                  InvoiceDiamondDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _invoiceItemController.diamondAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Diamond Amt',
            readOnly: true,
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
                  InvoiceStoneDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _invoiceItemController.stoneAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Stone Amt',
            readOnly: true,
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
          Obx(() => BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                isBillingValidator: true,
                billingValidator: (value) {
                  if (_invoiceItemController.calculationType.value ==
                      weightCalcType) {
                    double fmc = double.parse(value ?? "0");

                    if (fmc >=
                        _invoiceItemController.minFlatMakingCharge.value) {
                      return null;
                    } else {
                      return "FMC < ${_invoiceItemController.minFlatMakingCharge.value}";
                    }
                  } else {
                    return null;
                  }
                },
                // validator: _invoiceItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller:
                    _invoiceItemController.flatMakingChargeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.MC',
                readOnly: _invoiceItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
              )),
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
          Obx(() => BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                isBillingValidator: true,
                billingValidator: (value) {
                  if (_invoiceItemController.calculationType.value ==
                      weightCalcType) {
                    double perGram = double.parse(value ?? "0");

                    if (perGram >=
                        _invoiceItemController
                            .minMakingChargePerGram.value) {
                      return null;
                    } else {
                      return "MC/G < ${_invoiceItemController.minMakingChargePerGram.value}";
                    }
                  } else {
                    return null;
                  }
                },
                // validator: _invoiceItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller:
                    _invoiceItemController.makingChargePerGramController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'MC/G',
                readOnly: _invoiceItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
              )),
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
          Obx(() => BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                isBillingValidator: true,
                billingValidator: (value) {
                  if (_invoiceItemController.calculationType.value ==
                      weightCalcType) {
                    double flatWas = double.parse(value ?? "0");

                    if (flatWas >=
                        _invoiceItemController.minFlatWastage.value) {
                      return null;
                    } else {
                      return "F.WAS < ${_invoiceItemController.minFlatWastage.value}";
                    }
                  } else {
                    return null;
                  }
                },
                // validator: _invoiceItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller: _invoiceItemController.flatWastageController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.Wastage',
                readOnly: _invoiceItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
              )),
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
          Obx(() => BillingTextInput(
                width: 100,
                height: 50,
                filled: true,
                // validator: _invoiceItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller: _invoiceItemController.wastagePercentController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Wastage %',
                readOnly: _invoiceItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
                isBillingValidator: true,
                billingValidator: (value) {
                  if (_invoiceItemController.calculationType.value ==
                      weightCalcType) {
                    double wastagePercentage = double.parse(value ?? "0");

                    if (wastagePercentage >=
                        _invoiceItemController.minWastagePercent.value) {
                      return null;
                    } else {
                      return "Was % < ${_invoiceItemController.minWastagePercent.value}";
                    }
                  } else {
                    return null;
                  }
                },
              )),
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
            controller: _invoiceItemController.netWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Net Weight',
            readOnly: true,
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
          Obx(() => BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                validator: 'default',
                controller: _invoiceItemController.reduceWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Reduce Weight',
                readOnly:
                    _invoiceItemController.stockType.value == weightStockType
                        ? false
                        : true,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
              )),
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
          Obx(() => BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                // validator: 'default',
                isBillingValidator: true,
                billingValidator: (value) {
                  if (value!.isNotEmpty) {
                    double actualValue = double.parse(value ?? "0");

                    if (actualValue <=
                        _invoiceItemController.remainingGrossWeight.value) {
                      return null;
                    } else {
                      return "Weight > ${_invoiceItemController.remainingGrossWeight.value}";
                    }
                  } else {
                    return "required";
                  }
                },
                controller: _invoiceItemController.grossWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Gross Weight',
                readOnly:
                    _invoiceItemController.stockType.value == weightStockType
                        ? false
                        : true,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
              )),
        ],
      ),
    );
  }

   SizedBox subitem() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Subitem'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
                      filled: true,
                      height: 50,
                      validator: 'default',
                      controller: _invoiceItemController.subItemController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      inputFormat: 'text',
                      hintText: 'Subitem',
                    ),
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
          Obx(() => BillingTextInput(
                filled: true,
                width: 75,
                height: 50,
                // validator: 'default',
                isBillingValidator: true,
                billingValidator: (value) {
                  if (value!.isNotEmpty) {
                    int actualValue = int.parse(value ?? "0");

                    if (actualValue <=
                        _invoiceItemController.remainingPieces.value) {
                      return null;
                    } else {
                      return "Pieces > ${_invoiceItemController.remainingPieces.value}";
                    }
                  } else {
                    return "required";
                  }
                },
                controller: _invoiceItemController.piecesController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormat: 'integer',
                hintText: 'Pieces',
                readOnly:
                    _invoiceItemController.stockType.value == pieceStockType
                        ? false
                        : true,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
              )),
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
          Obx(() => BillingTextInput(
                filled: true,
                height: 50,
                // validator: 'default',
                isBillingValidator: true,
                billingValidator: (value) {
                  if (value!.isNotEmpty) {
                    double actualValue = double.parse(value ?? "0");

                    if (actualValue >=
                        _invoiceItemController.minMetalRate.value) {
                      return null;
                    } else {
                      return "Rate < ${_invoiceItemController.minMetalRate.value}";
                    }
                  } else {
                    return "required";
                  }
                },
                controller: _invoiceItemController.rateController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Rate',
                readOnly: _invoiceItemController.calculationType.value ==
                        weightCalcType
                    ? true
                    : false,
                onChanged: (value) {
                  _invoiceItemController.calculationItemValues();
                },
              )),
        ],
      ),
    );
  }

 SizedBox tagNumber() {
    return SizedBox(
      width: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BillingLabel(label: 'Tag Number'),
                SizedBox(
                  height: 2.5,
                ),
                Row(
                  children: [
                    BillingTextInput(
                      filled: true,
                      height: 50,
                      validator: 'default',
                      controller: _invoiceItemController.tagNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      inputFormat: 'text',
                      hintText: 'Tag Number',
                      onChanged: (value) {
                        _invoiceItemController.resetForm(
                            context: context, tagNumberReset: false);
                      },
                    ),
                    Obx(() =>
                        _invoiceItemController.retrieveTagNumberLoading.value
                            ? SizedBox(
                                width: 10.w,
                                height: 10.w,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 4.sp,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  _invoiceItemController.getTagDetails(
                                      context,
                                      _invoiceItemController
                                          .tagNumberController.text);
                                },
                                icon: Icon(Icons.search)))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Obx(() => _invoiceItemController.retrieveTagNumberLoading.value
              ? SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator())
              : SizedBox())
        ],
      ),
    );
  }

}
