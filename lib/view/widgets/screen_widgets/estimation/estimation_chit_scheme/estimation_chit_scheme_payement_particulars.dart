import 'package:ausales_application/controller/estimation/estimation_chit_scheme_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_chit_scheme_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationChitSchemePayementParticulars extends StatefulWidget {
  List<ChitPaymentDenominationParticulars> chitItemsList;
  List<ChitSchemeListData> selectedChitSchemeList;

  EstimationChitSchemePayementParticulars({super.key, required this.chitItemsList, required this.selectedChitSchemeList});

  @override
  State<EstimationChitSchemePayementParticulars> createState() => _EstimationChitSchemePayementParticularsState();
}

class _EstimationChitSchemePayementParticularsState extends State<EstimationChitSchemePayementParticulars> {

  final EstimationChitSchemeController _estimationChitSchemeController = Get.put(EstimationChitSchemeController());
  
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
          Obx(() => _estimationChitSchemeController.isCitSchemeFetchLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: LinearProgressIndicator(),
                )
              : ListView(
                  children: [
                    Obx(() => PaginatedDataTable(
                          showEmptyRows: false,
                          rowsPerPage: 10,
                          headingRowColor:
                              WidgetStateProperty.resolveWith<Color?>(
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
                              'Scheme No',
                              style: TextPalette.tableHeaderTextStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Scheme Name',
                              style: TextPalette.tableHeaderTextStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Scheme Name',
                              style: TextPalette.tableHeaderTextStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Status',
                              style: TextPalette.tableHeaderTextStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Benifit Bonus',
                              style: TextPalette.tableHeaderTextStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Paid Amount',
                              style: TextPalette.tableHeaderTextStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Metal Weight',
                              style: TextPalette.tableHeaderTextStyle,
                            )),
                          ],
                          source: _DataSource(
                              context, _estimationChitSchemeController.chitSchemeAllList.value, widget.chitItemsList, widget.selectedChitSchemeList),
                        )),
                  ],
                )),
        ],
      ),
    );
  }

}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ChitSchemeListData> data;
  List<ChitPaymentDenominationParticulars> chitItemsList;
  List<ChitSchemeListData> selectedChitSchemeList;
  _DataSource(this.context, this.data, this.chitItemsList, this.selectedChitSchemeList);

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
        DataCell(
          Obx(() => Checkbox(
            value: _estimationChitSchemeController.selectedChitSchemeIdsList.value.contains(row.id) ? true : false,
            onChanged: (value) {
              _estimationChitSchemeController.onSelectedValueChanged(row);
            },
          ))
        ),
        DataCell(Text(
          row.schemeAccNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.schemeName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.schemeType.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.statusName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.benefitBonus.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalPaidAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalMetalweight.toString(),
          style: TextPalette.tableDataTextStyle,
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
