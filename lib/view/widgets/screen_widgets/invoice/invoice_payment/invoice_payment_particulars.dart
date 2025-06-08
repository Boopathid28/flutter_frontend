import 'package:ausales_application/controller/invoice/invocie_payment_form_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoicePaymentParticulars extends StatefulWidget {
  const InvoicePaymentParticulars({super.key});

  @override
  State<InvoicePaymentParticulars> createState() => _InvoicePaymentParticularsState();
}

class _InvoicePaymentParticularsState extends State<InvoicePaymentParticulars> {

  final InvoiceController _invoiceController = Get.put(InvoiceController());

  final InvociePaymentFormController _invociePaymentFormController = Get.put(InvociePaymentFormController());

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
                      'Payment Method',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Payment Provider',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: _invoiceController.paymentParticulars.value.map((item) {
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      GestureDetector(onTap: () {
                        _invociePaymentFormController.deleteParticulars(item.sNo!);
                      }, child: Icon(Icons.delete)),
                    ],
                  )),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.paymentMethodName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.paymentProviderName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.paidAmount.toString()))),
                ]);
              }).toList(),
            )),
      ),
    );
  }
}