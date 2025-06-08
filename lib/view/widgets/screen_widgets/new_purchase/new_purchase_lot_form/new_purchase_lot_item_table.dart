import 'dart:ffi';

import 'package:ausales_application/controller/lot/lot_item_form_controller.dart';
import 'package:ausales_application/controller/lot/lot_item_table_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LotItemTable extends StatefulWidget {
  const LotItemTable({super.key});

  @override
  State<LotItemTable> createState() => _LotItemTableState();
}

class _LotItemTableState extends State<LotItemTable> {
  final LotItemTableController _lotItemTableController =
      Get.put(LotItemTableController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.h,
      width: 800.w,
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: ListView(
            children: [
              Obx(() => PaginatedDataTable(
                showEmptyRows: false,
                rowsPerPage: 10,
                headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) =>
                        ColorPalete.tableHeaderBgColor),
                columns: [
                  DataColumn(
                      label: Text(
                    'S.No',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Item Name',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Tag Count',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Pieces',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Gross Weight',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Remarks',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Action',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                ],
                source: _DataSource(
                    context, _lotItemTableController.tableData.value),
              )),
            ],
          ),
    );
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<LotFormItemDataModel> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final LotItemFormController _lotItemFormController =
      Get.put(LotItemFormController());
  final LotItemTableController _lotItemTableController =
      Get.put(LotItemTableController());

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow.byIndex(
      color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) =>
              index % 2 == 0 ? Colors.white : ColorPalete.tableHeaderBgColor),
      index: index,
      cells: [
        DataCell(Text(
          (index+1).toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.itemDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.tagCount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.pieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.grossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.remark.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            GestureDetector(
                onTap: () {
                  _lotItemFormController.editItem(index, row);
                  _lotItemFormController.fromMode("update");
                },
                child: Icon(Icons.edit)),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
                onTap: () async {
                  _lotItemFormController.deleteItem(index, row);
                },
                child: Obx(() => _lotItemTableController.isDeleteLoading.value ? CircularProgressIndicator() :  Icon(Icons.delete))),
          ],
        )),
      ],
    );
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
