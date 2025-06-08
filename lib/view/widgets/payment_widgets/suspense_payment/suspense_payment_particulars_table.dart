import 'package:ausales_application/controller/payment_controllers/suspense_payment_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/suspense_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspensePaymentParticularsTable extends StatefulWidget {
  List<SuspensePaymentItemModel> particularList;
  SuspensePaymentParticularsTable({super.key, required this.particularList});

  @override
  State<SuspensePaymentParticularsTable> createState() =>
      _SuspensePaymentParticularsTableState();
}

class _SuspensePaymentParticularsTableState
    extends State<SuspensePaymentParticularsTable> {
  final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

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
                  label: Text(
                'Metal',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Item',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Sub Item',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Weight',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Amount',
                style: TextPalette.tableHeaderTextStyle,
              )),
              DataColumn(
                  label: Text(
                'Total Amount',
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
                  item.metalName!,
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Text(
                  item.itemDetailsName!,
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Text(
                  item.subItemDetailsName!,
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Text(
                  item.metalWeight!.toStringAsFixed(3),
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Text(
                  item.metalAmount!.toStringAsFixed(2),
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Text(
                  item.totalAmount!.toStringAsFixed(2),
                  style: TextPalette.tableDataTextStyle,
                )),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _suspensePaymentController.editItemInList(item);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(width: 5.w,),
                    IconButton(
                      onPressed: () {
                        _suspensePaymentController.deleteItemInList(widget.particularList, item.id!);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                )),
              ]);
            }).toList())),
      ),
    );
  }
}
