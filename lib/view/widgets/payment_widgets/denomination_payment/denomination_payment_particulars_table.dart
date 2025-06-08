import 'package:ausales_application/controller/payment_controllers/denomination_payment_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';
import 'package:ausales_application/view/widgets/payment_widgets/denomination_payment/denomination_payment_item_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DenominationPaymentParticularsTable extends StatefulWidget {
  List<PaymentDenominationItemModel> particularList;
  DenominationPaymentParticularsTable(
      {super.key, required this.particularList});

  @override
  State<DenominationPaymentParticularsTable> createState() =>
      _DenominationPaymentParticularsTableState();
}

class _DenominationPaymentParticularsTableState
    extends State<DenominationPaymentParticularsTable> {

  final DenominationPaymentController _denominationPaymentController = Get.put(DenominationPaymentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DataTable(
            headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
            columns: [
              DataColumn(
                  label: Text(
                'Method',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Provider',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Amount',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'remarks',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Action',
                style: TextPalette.tableHeaderTextStyle,
              )),
            ],
            rows: widget.particularList.map((item) {
              return DataRow(cells: [
                DataCell(Text(
                  item.paymentMethodName!,
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Text(
                  item.paymentProviderName??"-",
                  style: TextPalette.tableDataTextStyle,
                )),
                 DataCell(Text(
                  item.remarks??"-",
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Text(
                  item.paidAmount!.toStringAsFixed(2),
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(IconButton(
                  onPressed: () {
                    _denominationPaymentController.deleteItemInList(widget.particularList, item.id!);
                  },
                  icon: Icon(Icons.delete),
                )),
              ]);
            }).toList()));
  }
}
