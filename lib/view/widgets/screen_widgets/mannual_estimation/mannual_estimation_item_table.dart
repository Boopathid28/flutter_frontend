import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/estimation/estimation_item_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_item_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MannualEstimationItemTable extends StatefulWidget {
  const MannualEstimationItemTable({super.key});

  @override
  State<MannualEstimationItemTable> createState() => _MannualEstimationItemTableState();
}

class _MannualEstimationItemTableState extends State<MannualEstimationItemTable> {
  final MannualEstimationController _mannualEstimationController =
      Get.put(MannualEstimationController());

  final MannualEstimationItemController _mannualEstimationItemController =
      Get.put(MannualEstimationItemController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      // padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        // color: Colors.white,
      ),
      width: size.width,
      height: 200,
      child: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() => DataTable(
              border: TableBorder.all(
                color: Colors.grey
              ),
              headingRowHeight: 30,
              columnSpacing: 0,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) => ColorPalete.appBgColor) ,
              headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text(
                      'Action',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 100,
                    child: Text(
                      'Item',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // DataColumn(
                //   label: Container(
                //     width: 100,
                //     child: Text(
                //       'Sub Item',
                //       style: TextPalette.billingTableHeaderTextStyle,
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
              
                DataColumn(
                  label: Container(
                    width: 100,
                    child: Text(
                      'Rate',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 75,
                    child: Text(
                      'Pcs',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'Gross Wgt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'Net Wgt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 100,
                    child: Text(
                      'Was %',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 100,
                    child: Text(
                      'F.Was',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 100,
                    child: Text(
                      'MC/G',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 100.w,
                    child: Text(
                      'F.MC',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'Stone Amt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'Diamond Amt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'HUID Amt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'Total Amt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'GST Amt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 125,
                    child: Text(
                      'Payable Amt',
                      style: TextPalette.billingTableHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
              rows: _mannualEstimationController.particulars.value.map((item) {
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      GestureDetector(onTap: () {
                        _mannualEstimationItemController.editParticularItem(context, item);
                      }, child: Icon(Icons.visibility, size: 20,)),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(onTap: () {
                        _mannualEstimationItemController.editParticularItem(context, item);
                      }, child: Icon(Icons.edit, size: 20,)),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(onTap: () {
                        _mannualEstimationItemController.deleteParticularItem(context, item);
                      }, child: Icon(Icons.delete, size: 20)),
                    ],
                  )),
                 DataCell(SizedBox(
                    width: 100,
                    child: Text(
                      item.itemName.toString(),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  //  DataCell(SizedBox(
                  //   width: 100,
                  //   child: Text(
                  //     item.subitemName.toString(),
                  //     style: TextPalette.billingTableDataTextStyle,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // )),
                  DataCell(SizedBox(
                    width: 100,
                    child: Text(
                      item.rate!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 75,
                    child: Text(
                      item.pieces.toString(),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.grossWeight!.toStringAsFixed(3),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.netWeight!.toStringAsFixed(3),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: Text(
                      item.wastagePercent!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: Text(
                      item.flatWastage!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: Text(
                      item.makingChargePerGram!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: Text(
                      item.flatMakingCharge!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.stoneAmount!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.diamondAmount!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.huidAmount!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.totalAmount!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.gstAmount!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(SizedBox(
                    width: 125,
                    child: Text(
                      item.payableAmount!.toStringAsFixed(2),
                      style: TextPalette.billingTableDataTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )),
        
                ]);
              }).toList(),
            )),
          ),
        ),
      ),
    );
  }
}
