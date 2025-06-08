import 'package:ausales_application/controller/order/order_old_metal_payment_controller.dart';
import 'package:ausales_application/controller/payment_controllers/old_metal_payment_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/old_gold_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderOldMetalPaymentParticularsTable extends StatefulWidget {
  List<OldItemPaymentDetails> particularList;
  OrderOldMetalPaymentParticularsTable({super.key, required this.particularList});

  @override
  State<OrderOldMetalPaymentParticularsTable> createState() =>
      _OrderOldMetalPaymentParticularsTableState();
}

class _OrderOldMetalPaymentParticularsTableState
    extends State<OrderOldMetalPaymentParticularsTable> {
  final OrderOldMetalPaymentController _orderOldMetalPaymentController =
      Get.put(OrderOldMetalPaymentController());

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      'Item',
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
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Old Metal Amount',
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
            rows: widget.particularList.map((item) {
              return DataRow(cells: [
                DataCell(Row(
                    children: [
                      GestureDetector(onTap: () {
                        _orderOldMetalPaymentController.editItem(item);
                      }, child: Icon(Icons.edit)),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(onTap: () {
                        _orderOldMetalPaymentController.deleteItem(widget.particularList, item.id!);
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
                        item.item ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorPalete.primaryColor,
                            fontSize: 13.sp),
                      ))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                        item.oldWeight.toString(),
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
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.oldRate.toString()))),
                  // DataCell(SizedBox(
                  //     width: 100.w, child: Text(item.gstAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.totalAmount.toString()))),
              ]);
            }).toList())),
      ),
    );
  }
}
