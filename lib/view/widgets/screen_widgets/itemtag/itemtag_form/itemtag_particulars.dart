import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_particulars_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_form/stock_assign_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/itemtag_form/stock_assign_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemtagParticulars extends StatefulWidget {
  const ItemtagParticulars({super.key});

  @override
  State<ItemtagParticulars> createState() => _ItemtagParticularsState();
}

class _ItemtagParticularsState extends State<ItemtagParticulars> {
  final ItemtagFormParticularsController _itemtagFormParticularsController =
      Get.put(ItemtagFormParticularsController());

  final ItemtagFormController _itemtagFormController =
      Get.put(ItemtagFormController());

final StockAssignFormListController _stockAssignFormListController =
      Get.put(StockAssignFormListController());
  @override
  void initState() {
    super.initState();
    _itemtagFormParticularsController.getItemTagList(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: particularsTable(context),
      ),
    );
  }

  Obx particularsTable(BuildContext context) {
    return Obx(() => DataTable(
                headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) =>
                        ColorPalete.tableHeaderBgColor),
                columns: [
                  DataColumn(
                    label: SizedBox(width: 100.w, 
                      child: Text(
                        'Action',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Tag Number',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Sub Item',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Gross Wgt',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Reduce Wgt',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Net Wgt',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Pieces',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Stone Pcs',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Stone Wgt',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Diamond Pcs',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(width: 150.w, 
                      child: Text(
                        'Diamond Wgt',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  
                ],
                rows: _itemtagFormParticularsController.itemTagList.value
                    .map((item) {
                  return DataRow(cells: [
                    DataCell(Row(
                      children: [
                        GestureDetector(
                            onTap: () {}, child: Icon(Icons.print)),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                            onTap: () async {
                              _itemtagFormController.deleteTagItemDetails(item.tagNumber!, context);
                            }, child: Icon(Icons.delete)),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                            onTap: () async {
                              _itemtagFormController.onEditableChange(item, context);
                            }, child: Icon(item.tagNumber?.toString() == _itemtagFormController.editableTagNumber.value ? Icons.save : Icons.edit)),
                             GestureDetector(
                      onTap: () async {
                        _stockAssignFormListController.currenttagnumber.add(item.tagNumber!);
                        await Get.dialog(StockAssignForm(), barrierDismissible: false);
                      },
                      child: Icon(Icons.assessment)),
                      ],
                    )),
                    DataCell(Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.tagNumber.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: ColorPalete.primaryColor, fontSize: 13.sp),),
                        SizedBox(
                          height: 5.h,
                        ),
                        item.tagNumber?.toString() == _itemtagFormController.editableTagNumber.value ? SizedBox(
                          width: 150.w,
                          height: 20.h,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            initialValue: item.huid,
                            onChanged: (value) {
                              _itemtagFormController.onHuidChange(value, item.tagNumber!);
                            },
                            style: TextStyle(fontSize: 10.sp),
                            decoration: InputDecoration(
                                hintText: "huid",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.w),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.r)),
                                    borderSide: BorderSide(
                                      color: ColorPalete.inputBorderColor,
                                      width: 1,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.r)),
                                    borderSide: BorderSide(
                                      color: ColorPalete.inputBorderColor,
                                      width: 1,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.r)),
                                    borderSide: BorderSide(
                                      color: ColorPalete.inputBorderColor,
                                      width: 1,
                                    ))),
                          ),
                        ) : Text(item.huid??"", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 13.sp),),
                      ],
                    )),
                    
                    DataCell(SizedBox(width: 100.w, child: Text(item.subItemDetailsName.toString()))),
                    DataCell(Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: item.tagNumber?.toString() == _itemtagFormController.editableTagNumber.value ? TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              initialValue: item.grossWeight.toString(),
                              onChanged: (value) {
                                _itemtagFormController.onGrossWeightChange(value, item.tagNumber!);
                              },
                              style: TextStyle(fontSize: 10.sp),
                              decoration: InputDecoration(
                                  hintText: "Gross Wgt",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 2.w),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      borderSide: BorderSide(
                                        color: ColorPalete.inputBorderColor,
                                        width: 1,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      borderSide: BorderSide(
                                        color: ColorPalete.inputBorderColor,
                                        width: 1,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      borderSide: BorderSide(
                                        color: ColorPalete.inputBorderColor,
                                        width: 1,
                                      ))),
                            ) : Text(item.grossWeight.toString()),
                    )),
                    DataCell(Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: item.tagNumber?.toString() == _itemtagFormController.editableTagNumber.value ? TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              initialValue: item.reduceWeight.toString(),
                              onChanged: (value) {
                                _itemtagFormController.onReduceWeightChange(value, item.tagNumber!);
                              },
                              style: TextStyle(fontSize: 10.sp),
                              decoration: InputDecoration(
                                  hintText: "Reduce Wgt",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 2.w),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      borderSide: BorderSide(
                                        color: ColorPalete.inputBorderColor,
                                        width: 1,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      borderSide: BorderSide(
                                        color: ColorPalete.inputBorderColor,
                                        width: 1,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      borderSide: BorderSide(
                                        color: ColorPalete.inputBorderColor,
                                        width: 1,
                                      ))),
                            ) : Text(item.reduceWeight.toString()),
                    )),
                    DataCell(SizedBox(width: 100.w, child: Text(item.netWeight.toString()))),
                    DataCell(SizedBox(width: 100.w, child: Text(item.pieces.toString()))),
                    DataCell(SizedBox(width: 100.w, child: Text(item.totalStonePieces.toString()))),
                    DataCell(SizedBox(width: 100.w, child: Text(item.totalStoneWeight.toString()))),
                    DataCell(SizedBox(width: 100.w, child: Text(item.totalDiamondPieces.toString()))),
                    DataCell(SizedBox(width: 100.w, child: Text(item.totalDiamondWeight.toString()))),
                    
                  ]);
                }).toList(),
              ));
  }

  OutlineInputBorder _borderInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputBorderColor,
          width: 1,
        ));
  }

  OutlineInputBorder _borderFocusInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputFocusBorderColor,
          width: 1,
        ));
  }
}
