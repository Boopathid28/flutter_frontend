import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_suspense_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceSuspenseParticulars extends StatefulWidget {
  const InvoiceSuspenseParticulars({super.key});

  @override
  State<InvoiceSuspenseParticulars> createState() => _InvoiceSuspenseParticularsState();
}

class _InvoiceSuspenseParticularsState extends State<InvoiceSuspenseParticulars> {

  final InvoiceController _invoiceController = Get.put(InvoiceController());

  final InvoiceSuspenseFormController _invoiceSuspenseFormController = Get.put(InvoiceSuspenseFormController());

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
        child: SizedBox(
          width: Responsive.isDesktop(context) ? size.width : null,
          child: Obx(() => DataTable(
                headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) =>
                        ColorPalete.tableHeaderBgColor),
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Metal Name',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Item Name',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Metal Amount',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 100.w,
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
                        'Total Amount',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Action',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                ],
                rows: _invoiceController.suspenseParticulars.value
                    .map((item) {
                  return DataRow(cells: [
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.metalName.toString()))),
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.itemDetailsName.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.metalAmount.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.metalWeight.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.totalAmount.toString()))),
                    DataCell(Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _invoiceSuspenseFormController.editItem(
                                  context, item);
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                            onTap: () async {
                              _invoiceSuspenseFormController.deleteItem(
                                  context, item.sNo!);
                            },
                            child: Icon(Icons.delete)),
                      ],
                    )),
                  ]);
                }).toList(),
              )),
        ),
      ),
    );
  }
}