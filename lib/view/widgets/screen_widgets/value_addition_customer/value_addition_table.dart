import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_form_controller.dart';
import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/value_addition_customer/value_addition_customer_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionTable extends StatefulWidget {
  @override
  State<ValueAdditionTable> createState() => _ValueAdditionTableState();
}

class _ValueAdditionTableState extends State<ValueAdditionTable> {
  final ValueAdditionCustomerListController
      _valueAdditionCustomerListController =
      Get.put(ValueAdditionCustomerListController());

       final ValueAdditionCustomerFormController
      _valueAdditionCustomerFormController =
      Get.put(ValueAdditionCustomerFormController());

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Stack(
                    children: [
                      Obx(() => _valueAdditionCustomerListController
                              .isTableLoading.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                              child: LinearProgressIndicator(),
                            )
                          : ListView(
                              children: [
                                Obx(() => PaginatedDataTable(
                                      showEmptyRows: false,
                                      rowsPerPage:
                                          _valueAdditionCustomerListController
                                              .itemsPerPage.value,
                                      headingRowColor: WidgetStateProperty
                                          .resolveWith<Color?>(
                                              (Set<WidgetState> states) =>
                                                  ColorPalete
                                                      .tableHeaderBgColor),
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                          'S.No',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Tag Number',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Pieces',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Gross Weight',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Net Weight',
                                          style:
                                              TextPalette.tableHeaderTextStyle,
                                        )),
                                      ],
                                      source: _DataSource(
                                          context,
                                          _valueAdditionCustomerFormController
                                              .tableDataList.value),
                                    )),
                              ],
                            )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: 60.h,
                          width: size.width - 38,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15.r)),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // itemsPerPageChange(context),
                              SizedBox(
                                width: 5.w,
                              ),
                              // changePage(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: defaultBottombarHeight,
                )
              ],
            ),
          );
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ValueAdditionGetTagDetails> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ValueAdditionCustomerFormController
      _valueAdditionCustomerFormController =
      Get.put(ValueAdditionCustomerFormController());
  final ValueAdditionCustomerListController
      _valueAdditionCustomerListController =
      Get.put(ValueAdditionCustomerListController());

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
          row.id.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.tagNumber.toString(),
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
          row.netWeight.toString(),
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
