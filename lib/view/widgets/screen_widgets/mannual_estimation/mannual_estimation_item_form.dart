import 'dart:developer';

import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_item_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_dropdown_field.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_primary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_secondary_button.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class MannualEstimationItemForm extends StatefulWidget {
  const MannualEstimationItemForm({super.key});

  @override
  State<MannualEstimationItemForm> createState() => _MannualEstimationItemFormState();
}

class _MannualEstimationItemFormState extends State<MannualEstimationItemForm> {
  final MannualEstimationItemController _mannualEstimationItemController =
      Get.put(MannualEstimationItemController());

  final MannualEstimationController _mannualEstimationController =
      Get.put(MannualEstimationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _mannualEstimationItemController.estimationItemFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 5.h,
              spacing: 5.w,
              children: [
                // tagNumber(),
                item(),
                purity(),
                rate(),
                pieces(),
                grossWeight(),
                reduceWeight(),
                netWeight(),
                calculationtype(),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? wastagecalculationtype() : SizedBox()),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? flatwastagetype() : SizedBox()),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? makingchargecalculationtype() : SizedBox()),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? pergramweighttype() : SizedBox()),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? wastagePercent() : SizedBox()),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? flatWastage() : SizedBox()),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? makingChargePerGram() : SizedBox()),
                Obx(() => _mannualEstimationItemController.selectedcalculationType.value?.value == weightCalcType ? flatMakingCharge() : SizedBox()),
                stoneAmount(),
                diamondAmount(),
                huidAmount(),
                totalAmount(),
                gstpercentageAmount(),
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
                  text: _mannualEstimationItemController.itemFormMode.value,
                  onPressed: () {
                    if (_mannualEstimationController.selectedGstType.value != null) {
                      _mannualEstimationItemController.addParticularItem(context);
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
                    _mannualEstimationItemController.resetForm(context: context);
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
            controller: _mannualEstimationItemController.payableAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Payable Amt',
            onChanged: (value) {
              _mannualEstimationItemController.reverseCalculation(context);
            },
          ),
        ],
      ),
    );
  }



    SizedBox gstpercentageAmount() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'GST Per'),
          SizedBox(
            height: 2.5,
          ),
          BillingTextInput(
            filled: true,
            width: 100,
            height: 50,
            validator: 'default',
            controller: _mannualEstimationItemController.gstPercentController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'GST Per',
              onChanged: (value) {
              _mannualEstimationItemController.calculationItemValues();
            },
          ),
        ],
      ),
    );
  }


SizedBox purity() {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Purity"),
          SizedBox(
            height: 2.5,
          ),
          Obx(() => BillingDropdownSearchField(
                controller: _mannualEstimationItemController.searchPurityController,
                selectedValue: _mannualEstimationItemController.selectedPurity.value,
                options: _mannualEstimationItemController.purityDropDown.value,
                onChanged: (value) {
                  _mannualEstimationItemController.selectedPurity(value);

                  for (var i in _mannualEstimationItemController.purityList.value) {
                    if (i.id.toString() == value!.value) {
                      _mannualEstimationItemController.rateController.text = (i.metalRate??0.0).toString();
                      break;
                    }
                  }
                  _mannualEstimationItemController.calculationItemValues();
                },
                hintText: "Purity",
              ))
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
            controller: _mannualEstimationItemController.gstAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'GST Amt',
              onChanged: (value) {
              _mannualEstimationItemController.calculationItemValues();
            },
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
            controller: _mannualEstimationItemController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'Total Amt',
            readOnly: true,
            // onChanged: (value) {
            //   _mannualEstimationItemController.reverseCalculation(context);
            // },
              onChanged: (value) {
              _mannualEstimationItemController.calculationItemValues();
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
            controller: _mannualEstimationItemController.huidAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormat: 'double',
            hintText: 'HUID Amt',
            onChanged: (value) {
              _mannualEstimationItemController.calculationItemValues();
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
                  MannualEstimationDiamondDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _mannualEstimationItemController.diamondAmountController,
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
                  MannualEstimationStoneDetailsPopup());
            },
            filled: true,
            width: 100,
            height: 50,
            validator: 'no_validation',
            controller: _mannualEstimationItemController.stoneAmountController,
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
          BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
              
                validator: _mannualEstimationItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
                controller:
                    _mannualEstimationItemController.flatMakingChargeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.MC',
               
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
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
             
                validator: _mannualEstimationItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
                controller:
                    _mannualEstimationItemController.makingChargePerGramController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'MC/G',
                
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
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
              
                validator: _mannualEstimationItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
                controller: _mannualEstimationItemController.flatWastageController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'F.Wastage',
              
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
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
                validator: _mannualEstimationItemController.calculationType.value ==
                        weightCalcType
                    ? 'default'
                    : 'no_validation',
                controller: _mannualEstimationItemController.wastagePercentController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Wastage %',
               
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
                },
               
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
            controller: _mannualEstimationItemController.netWeightController,
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
          BillingTextInput(
                filled: true,
                width: 100,
                height: 50,
                validator: 'default',
                controller: _mannualEstimationItemController.reduceWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Reduce Weight',
                
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
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
                validator: 'default',
              
                controller: _mannualEstimationItemController.grossWeightController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Gross Weight',
                
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
                },
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
           BillingTextInput(
                filled: true,
                width: 75,
                height: 50,
                validator: 'default',
                controller: _mannualEstimationItemController.piecesController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormat: 'integer',
                hintText: 'Pieces',
               
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
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
                validator: 'default',
                
                controller: _mannualEstimationItemController.rateController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Rate',
               
                onChanged: (value) {
                  _mannualEstimationItemController.calculationItemValues();
                },
              ),
        ],
      ),
    );
  }

//  SizedBox tagNumber() {
//     return SizedBox(
//       width: 180,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 70,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 BillingLabel(label: 'Tag Number'),
//                 SizedBox(
//                   height: 2.5,
//                 ),
//                 Row(
//                   children: [
//                     BillingTextInput(
//                       filled: true,
//                       height: 50,
//                       validator: 'default',
//                       controller: _mannualEstimationItemController.tagNumberController,
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.text,
//                       inputFormat: 'text',
//                       hintText: 'Tag Number',
//                       onChanged: (value) {
//                         _mannualEstimationItemController.resetForm(
//                             context: context, tagNumberReset: false);
//                       },
//                     ),
//                     Obx(() =>
//                         _mannualEstimationItemController.retrieveTagNumberLoading.value
//                             ? SizedBox(
//                                 width: 10.w,
//                                 height: 10.w,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 4.sp,
//                                 ),
//                               )
//                             : IconButton(
//                                 onPressed: () {
//                                   _mannualEstimationItemController.getTagDetails(
//                                       context,
//                                       _mannualEstimationItemController
//                                           .tagNumberController.text);
//                                 },
//                                 icon: Icon(Icons.search)))
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Obx(() => _mannualEstimationItemController.retrieveTagNumberLoading.value
//               ? SizedBox(
//                   width: 20, height: 20, child: CircularProgressIndicator())
//               : SizedBox())
//         ],
//       ),
//     );
//   }




 SizedBox item() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: 'Item'),
          SizedBox(
            height: 2.5,
          ),
           BillingTextInput(
                filled: true,
                width: 75,
                height: 50,
                validator: 'default',
                controller: _mannualEstimationItemController.itemController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormat: 'text',
                hintText: 'Item',
               
                // onChanged: (value) {
                //   _mannualEstimationItemController.calculationItemValues();
                // },
              ),
        ],
      ),
    );
  }







  // SizedBox item() {
  //   return SizedBox(
  //     width: 200,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         BillingLabel(label: "Item"),
  //         SizedBox(
  //           height: 2.5,
  //         ),
  //         Obx(() => BillingDropdownField(
  //               filled: true,
  //               selectedValue: _mannualEstimationItemController.selectedItem.value,
  //               options: _mannualEstimationItemController.itemFilterList.value,
  //               onChanged: (value) {
  //                 _mannualEstimationItemController.selectedItem(value);
  //                 _mannualEstimationItemController.getSubItemList(value!.value);
  //               },
  //               hintText: "Item",
  //             ))
  //       ],
  //     ),
  //   );
  // }
  SizedBox calculationtype() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Calculation Type"),
          SizedBox(
            height: 2.5,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _mannualEstimationItemController.selectedcalculationType.value,
                options: _mannualEstimationItemController.calculationTypeFilterList.value,
                onChanged: (value) {
                  _mannualEstimationItemController.selectedcalculationType(value);
                },
                hintText: "Calculation Type",
              ))
        ],
      ),
    );
  }



  SizedBox wastagecalculationtype() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Wastage Calculation Type"),
          SizedBox(
            height: 2.5,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _mannualEstimationItemController.selectedwasatgecalculationType.value,
                options: _mannualEstimationItemController.wastagecalculationTypeFilterList.value,
                onChanged: (value) {
                  _mannualEstimationItemController.selectedwasatgecalculationType(value);
                },
                hintText: "Wastage Calculation",
              ))
        ],
      ),
    );
  }



SizedBox flatwastagetype() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Flat Wastage Type"),
          SizedBox(
            height: 2.5,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _mannualEstimationItemController.selectedflatwasatgeType.value,
                options: _mannualEstimationItemController.flatwastageTypeFilterList.value,
                onChanged: (value) {
                  _mannualEstimationItemController.selectedflatwasatgeType(value);
                },
                hintText: "Flat Wastage Type",
              ))
        ],
      ),
    );
  }





SizedBox makingchargecalculationtype() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Makingcharge Calculation Type"),
          SizedBox(
            height: 2.5,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _mannualEstimationItemController.selectedmakingchargecalculationType.value,
                options: _mannualEstimationItemController.makingchargecalculationTypeFilterList.value,
                onChanged: (value) {
                  _mannualEstimationItemController.selectedmakingchargecalculationType(value);
                },
                hintText: "Makingcharge ",
              ))
        ],
      ),
    );
  }



SizedBox pergramweighttype() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Pergram Weight Type"),
          SizedBox(
            height: 2.5,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _mannualEstimationItemController.selectedpergramweightType.value,
                options: _mannualEstimationItemController.pergramweightTypeFilterList.value,
                onChanged: (value) {
                  _mannualEstimationItemController.selectedpergramweightType(value);
                },
                hintText: "Pergram Weight Type",
              ))
        ],
      ),
    );
  }











}
