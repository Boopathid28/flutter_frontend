import 'package:ausales_application/controller/estimation/estimation_chit_scheme_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/estimation/estimation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationChitSchemePaymentTagParticulars extends StatefulWidget {
  List<ParticularDetails> taggedItems;
  // Function() onComplete;
  List<ParticularDetails> selectedTagChitPaymentParticulars;
  EstimationChitSchemePaymentTagParticulars({super.key, required this.taggedItems, 
  // required this.onComplete, 
  required this.selectedTagChitPaymentParticulars});

  @override
  State<EstimationChitSchemePaymentTagParticulars> createState() =>
      _EstimationChitSchemePaymentTagParticularsState();
}

class _EstimationChitSchemePaymentTagParticularsState
    extends State<EstimationChitSchemePaymentTagParticulars> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.h,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Stack(
        children: [
          ListView(
            children: [
              Obx(() => PaginatedDataTable(
                showEmptyRows: false,
                rowsPerPage: widget.taggedItems.length,
                headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) =>
                        ColorPalete.tableHeaderBgColor),
                columns: [
                  DataColumn(
                      label: Text(
                    '#',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Tag Number',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Rate',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Gross Weight',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Net Weight',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Wastage %',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'F Wastage',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'MC/G',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'FMC',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                  DataColumn(
                      label: Text(
                    'Payable Amount',
                    style: TextPalette.tableHeaderTextStyle,
                  )),
                ],
                source: _DataSource(context, widget.taggedItems, widget.selectedTagChitPaymentParticulars),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ParticularDetails> data;
  List<ParticularDetails> selectedTagChitPaymentParticulars;
  _DataSource(this.context, this.data, this.selectedTagChitPaymentParticulars);

  int _selectedCount = 0;

  final EstimationChitSchemeController _estimationChitSchemeController = Get.put(EstimationChitSchemeController());

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
        DataCell(Obx(() => Checkbox(
              value: _estimationChitSchemeController.selectedTagItemIdsList.contains(row.sNo),
              onChanged: (value) {
                _estimationChitSchemeController.selecteTagItems(context, row);
              },
            ))),
        DataCell(Text(
          row.tag.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.rate.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.grossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.netWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.wastagePercent.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.flatWastage.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.makingChargePerGram.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.flatMakingCharge.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.payableAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        ))
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
