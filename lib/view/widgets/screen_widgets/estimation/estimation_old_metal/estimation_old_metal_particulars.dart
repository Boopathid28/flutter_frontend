import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/estimation/estimation_old_item_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationOldMetalParticulars extends StatefulWidget {
  const EstimationOldMetalParticulars({super.key});

  @override
  State<EstimationOldMetalParticulars> createState() => _EstimationOldMetalParticularsState();
}

class _EstimationOldMetalParticularsState extends State<EstimationOldMetalParticulars> {

  final EstimationController _estimationController = Get.put(EstimationController());

  final EstimationOldItemFormController _estimationOldItemFormController = Get.put(EstimationOldItemFormController());

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
        child: Obx(() => DataTable(
              headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 100.w,
                    child: Text(
                      'Action',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Metal',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Metal Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Metal Rate',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Dust Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Net Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                // DataColumn(
                //   label: SizedBox(
                //     width: 125.w,
                //     child: Text(
                //       'GST Amount',
                //       style: TextPalette.tableHeaderTextStyle,
                //     ),
                //   ),
                // ),
                DataColumn(
                  label: SizedBox(
                    width: 150.w,
                    child: Text(
                      'Total Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: _estimationController.oldParticulars.value.map((item) {
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      GestureDetector(onTap: () {
                        _estimationOldItemFormController.editItem(item);
                      }, child: Icon(Icons.edit)),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(onTap: () {
                        _estimationOldItemFormController.deleteItem(item);
                      }, child: Icon(Icons.delete)),
                    ],
                  )),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                        item.oldMetalName ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorPalete.primaryColor,
                            fontSize: 13.sp),
                      ))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                        item.oldGrossWeight.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 13.sp),
                      ))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.oldRate.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.oldDustWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.oldNetWeight.toString()))),
                  // DataCell(SizedBox(
                  //     width: 100.w, child: Text(item.gstAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.totalAmount.toString()))),
                ]);
              }).toList(),
            )),
      ),
    );
  }
}