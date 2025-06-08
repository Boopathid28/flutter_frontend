import 'package:ausales_application/controller/subitem_master/subitem_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubitemViewPopup extends StatefulWidget {
  const SubitemViewPopup({super.key});

  @override
  State<SubitemViewPopup> createState() => _SubitemViewPopupState();
}

class _SubitemViewPopupState extends State<SubitemViewPopup> {
  final SubitemFormController _subitemFormController =
      Get.put(SubitemFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sub Item Details',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              iconSize: 25.sp,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Obx(() => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    thickness: 1.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Wrap(
                    spacing: 50.w,
                    runSpacing: 50.h,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Item Detail"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _subitemFormController
                                    .currentSubItem.value?.itemName ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Sub Item Name"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _subitemFormController
                                    .currentSubItem.value?.subItemName ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Sub Item Code"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _subitemFormController
                                    .currentSubItem.value?.subItemCode ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "HSN Code"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _subitemFormController
                                    .currentSubItem.value?.hsnCode ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Stock Type"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _subitemFormController
                                    .currentSubItem.value?.stockTypeName ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Measurement Type"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _subitemFormController
                                    .currentSubItem.value?.measurementTypeName ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Calculation Type"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _subitemFormController
                                    .currentSubItem.value?.calculationTypeName ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 1.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  _subitemFormController.currentSubItem.value?.calculationType ==
                          fixedRateCalcType
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabel(label: "Fixed Rate"),
                            SizedBox(
                              height: 7.w,
                            ),
                            Text(
                              _subitemFormController
                                      .currentSubItem.value?.fixedRate
                                      .toString() ??
                                  "-",
                              style: TextPalette.viewDetailsDataTextStyle,
                            )
                          ],
                        )
                      : _subitemFormController
                                  .currentSubItem.value?.calculationType ==
                              weightCalcType
                          ? Wrap(
                              spacing: 50.w,
                              runSpacing: 50.h,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabel(
                                        label: "Wastage Calculation Type"),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      _subitemFormController.currentSubItem.value
                                              ?.wastageCalculationTypeName ??
                                          "-",
                                      style: TextPalette.viewDetailsDataTextStyle,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabel(label: "Wastage Percentage"),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      _subitemFormController
                                              .currentSubItem.value?.itemName ??
                                          "-",
                                      style: TextPalette.viewDetailsDataTextStyle,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabel(
                                        label: "Flat Wastage Calculation Type"),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      _subitemFormController.currentSubItem.value
                                              ?.flatWastageTypeName ??
                                          "-",
                                      style: TextPalette.viewDetailsDataTextStyle,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabel(label: "Flat Wastage"),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      _subitemFormController
                                              .currentSubItem.value?.flatWastage
                                              .toString() ??
                                          "-",
                                      style: TextPalette.viewDetailsDataTextStyle,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabel(label: "MC Calculation Type"),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      _subitemFormController.currentSubItem.value
                                              ?.makingChargeCalculationTypeName ??
                                          "-",
                                      style: TextPalette.viewDetailsDataTextStyle,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabel(label: "MC/G"),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      _subitemFormController.currentSubItem.value
                                              ?.makingChargePerGram
                                              .toString() ??
                                          "-",
                                      style: TextPalette.viewDetailsDataTextStyle,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabel(label: "Flat MC"),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      _subitemFormController.currentSubItem.value
                                              ?.flatMakingCharge
                                              .toString() ??
                                          "-",
                                      style: TextPalette.viewDetailsDataTextStyle,
                                    )
                                  ],
                                )
                              ],
                            )
                          : _subitemFormController
                                      .currentSubItem.value?.calculationType ==
                                  perGramRateCalcType
                              ? Wrap(
                                  spacing: 50.w,
                                  runSpacing: 50.h,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomLabel(
                                            label: "Per Gram Weight Type"),
                                        SizedBox(
                                          height: 7.w,
                                        ),
                                        Text(
                                          _subitemFormController.currentSubItem
                                                  .value?.perGramWeightTypeName ??
                                              "-",
                                          style: TextPalette
                                              .viewDetailsDataTextStyle,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomLabel(label: "Per Gram Rate"),
                                        SizedBox(
                                          height: 7.w,
                                        ),
                                        Text(
                                          _subitemFormController.currentSubItem
                                                  .value?.perGramRate
                                                  .toString() ??
                                              "-",
                                          style: TextPalette
                                              .viewDetailsDataTextStyle,
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : _subitemFormController.currentSubItem.value
                                          ?.calculationType ==
                                      perPieceRateCalcType
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomLabel(label: "Per Piece Rate"),
                                        SizedBox(
                                          height: 7.w,
                                        ),
                                        Text(
                                          _subitemFormController.currentSubItem
                                                  .value?.perPieceRate
                                                  .toString() ??
                                              "-",
                                          style: TextPalette
                                              .viewDetailsDataTextStyle,
                                        )
                                      ],
                                    )
                                  : SizedBox()
                ],
              ),
        )),
      ),
    );
  }
}
