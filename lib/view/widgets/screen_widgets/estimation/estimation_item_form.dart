import 'dart:developer';

import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/estimation/estimation_item_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_primary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_secondary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class EstimationItemForm extends StatefulWidget {
  const EstimationItemForm({super.key});

  @override
  State<EstimationItemForm> createState() => _EstimationItemFormState();
}

class _EstimationItemFormState extends State<EstimationItemForm> {
  final EstimationItemController _estimationItemController =
      Get.put(EstimationItemController());

  final EstimationController _estimationController =
      Get.put(EstimationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _estimationItemController.estimationItemFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 5.h,
              spacing: 5.w,
              children: [
                tagNumber(),
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
                  text: _estimationItemController.itemFormMode.value,
                  onPressed: () {
                    if (_estimationController.selectedGstType.value != null) {
                      _estimationItemController.addParticularItem(context);
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
                    _estimationItemController.resetForm(context: context);
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
            controller: _estimationItemController.payableAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Payable Amt',
            onChanged: (value) {
              _estimationItemController.reverseCalculation(context);
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
            controller: _estimationItemController.gstAmountController,
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
            controller: _estimationItemController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Total Amt',
            readOnly: true,
            onChanged: (value) {
              // _estimationItemController.reverseCalculation(context);
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
            controller: _estimationItemController.huidAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'HUID Amt',
            onChanged: (value) {
              _estimationItemController.calculationItemValues();
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
                  EstimationDiamondDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _estimationItemController.diamondAmountController,
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
                  EstimationStoneDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _estimationItemController.stoneAmountController,
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
                  if (_estimationItemController.calculationType.value ==
                      weightCalcType) {
                    double fmc = double.parse(value ?? "0");

                    if (fmc >=
                        _estimationItemController.minFlatMakingCharge.value) {
                      return null;
                    } else {
                      return "FMC < ${_estimationItemController.minFlatMakingCharge.value}";
                    }
                  } else {
                    return null;
                  }
                },
                // validator: _estimationItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller:
                    _estimationItemController.flatMakingChargeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.MC',
                readOnly: _estimationItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
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
                  if (_estimationItemController.calculationType.value ==
                      weightCalcType) {
                    double perGram = double.parse(value ?? "0");

                    if (perGram >=
                        _estimationItemController
                            .minMakingChargePerGram.value) {
                      return null;
                    } else {
                      return "MC/G < ${_estimationItemController.minMakingChargePerGram.value}";
                    }
                  } else {
                    return null;
                  }
                },
                // validator: _estimationItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller:
                    _estimationItemController.makingChargePerGramController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'MC/G',
                readOnly: _estimationItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
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
                  if (_estimationItemController.calculationType.value ==
                      weightCalcType) {
                    double flatWas = double.parse(value ?? "0");

                    if (flatWas >=
                        _estimationItemController.minFlatWastage.value) {
                      return null;
                    } else {
                      return "F.WAS < ${_estimationItemController.minFlatWastage.value}";
                    }
                  } else {
                    return null;
                  }
                },
                // validator: _estimationItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller: _estimationItemController.flatWastageController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.Wastage',
                readOnly: _estimationItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
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
                // validator: _estimationItemController.calculationType.value ==
                //         weightCalcType
                //     ? 'default'
                //     : 'no_validation',
                controller: _estimationItemController.wastagePercentController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Wastage %',
                readOnly: _estimationItemController.calculationType.value ==
                        weightCalcType
                    ? false
                    : true,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
                },
                isBillingValidator: true,
                billingValidator: (value) {
                  if (_estimationItemController.calculationType.value ==
                      weightCalcType) {
                    double wastagePercentage = double.parse(value ?? "0");

                    if (wastagePercentage >=
                        _estimationItemController.minWastagePercent.value) {
                      return null;
                    } else {
                      return "Was % < ${_estimationItemController.minWastagePercent.value}";
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
            controller: _estimationItemController.netWeightController,
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
                controller: _estimationItemController.reduceWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Reduce Weight',
                readOnly:
                    _estimationItemController.stockType.value == weightStockType
                        ? false
                        : true,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
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
                        _estimationItemController.remainingGrossWeight.value) {
                      return null;
                    } else {
                      return "Weight > ${_estimationItemController.remainingGrossWeight.value}";
                    }
                  } else {
                    return "required";
                  }
                },
                controller: _estimationItemController.grossWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Gross Weight',
                readOnly:
                    _estimationItemController.stockType.value == weightStockType
                        ? false
                        : true,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
                },
              )),
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
                        _estimationItemController.remainingPieces.value) {
                      return null;
                    } else {
                      return "Pieces > ${_estimationItemController.remainingPieces.value}";
                    }
                  } else {
                    return "required";
                  }
                },
                controller: _estimationItemController.piecesController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormat: 'integer',
                hintText: 'Pieces',
                readOnly:
                    _estimationItemController.stockType.value == pieceStockType
                        ? false
                        : true,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
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
                        _estimationItemController.minMetalRate.value) {
                      return null;
                    } else {
                      return "Rate < ${_estimationItemController.minMetalRate.value}";
                    }
                  } else {
                    return "required";
                  }
                },
                controller: _estimationItemController.rateController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Rate',
                readOnly: _estimationItemController.calculationType.value ==
                        weightCalcType
                    ? true
                    : false,
                onChanged: (value) {
                  _estimationItemController.calculationItemValues();
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
                      controller: _estimationItemController.tagNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      inputFormat: 'text',
                      hintText: 'Tag Number',
                      onChanged: (value) {
                        _estimationItemController.resetForm(
                            context: context, tagNumberReset: false);
                      },
                    ),
                    Obx(() =>
                        _estimationItemController.retrieveTagNumberLoading.value
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
                                  _estimationItemController.getTagDetails(
                                      context,
                                      _estimationItemController
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
          Obx(() => _estimationItemController.retrieveTagNumberLoading.value
              ? SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator())
              : SizedBox())
        ],
      ),
    );
  }
}
