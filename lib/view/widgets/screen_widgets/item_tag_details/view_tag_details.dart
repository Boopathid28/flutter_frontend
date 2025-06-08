import 'package:ausales_application/controller/item_tag_details/item_tag_details_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewTagDetails extends StatefulWidget {
  @override
  State<ViewTagDetails> createState() => _ViewTagDetailsState();
}

class _ViewTagDetailsState extends State<ViewTagDetails> {
  final TagDetailsFormController _tagDetailsFormController =
      Get.put(TagDetailsFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "View Tax",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Wrap(
                  spacing: 100.w,
                  runSpacing: 20.h,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tag Number", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                      .tableData.value.tagNumber
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Measurement Value",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                      .tableData.value.measurementValue
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Huid", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController.tableData.value.huid
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pieces", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController.tableData.value.pieces
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Gross Weight", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.grossWeight
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Reduce Weight",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.reduceWeight
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Net Weight", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.netWeight
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Available Pieces",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.availablePieces
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Available Gross Weight",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.availableGrossWeight
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Stone Pieces",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.totalStonePieces
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Stone Weight",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.totalStoneWeight
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Stone Amount",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.totalStoneAmount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Diamond Pieces",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.totalDiamondPieces
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Diamond Weight",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.totalDiamondWeight
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Diamond Amount",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.totalDiamondAmount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Calculation Type",
                            style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _tagDetailsFormController
                                  .tableData.value.calculationtype
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            fixedRateCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Min Fixed Rate",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.minFixedRate
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            fixedRateCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Fixed Rate",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.fixedRate
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Wastage Calculation Type",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController.tableData.value
                                        .wastageCalculationTypeName
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Min Wastage Percent",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.minWastagePercent
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Wastage Percent",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.wastagePercent
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Flat Wastage Type",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.flatWastageTypeName
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Min Flat Wastage",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.minFlatWastage
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Flat Wastage",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.flatWastage
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Making Charge Calculation Type",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController.tableData.value
                                        .makingChargeCalculationTypeName
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Min making charge per gram",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.minMakingChargePerGram
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Making charge per gram",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.makingChargePerGram
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Min flat making charge",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.minFlatMakingCharge
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            weightCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Flat making charge",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.flatMakingCharge
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            perGramRateCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Per gram weight type",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.perGramWeightType
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            perGramRateCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Min per gram rate",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.minPerGramRate
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            perGramRateCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Per gram rate",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.perGramRate
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            perPieceRateCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Min Per Piece rate",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.minPerPieceRate
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                    Obx(() => _tagDetailsFormController
                                .tableData.value.calculationtype ==
                            perPieceRateCalcType
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Per Piece rate",
                                  style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => Text(
                                    _tagDetailsFormController
                                        .tableData.value.perPieceRate
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.blue),
                                  ))
                            ],
                          )
                        : SizedBox()),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  IconButton closeicon() {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.close));
  }
}
