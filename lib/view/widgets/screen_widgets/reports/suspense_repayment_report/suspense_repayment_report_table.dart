import 'package:ausales_application/controller/reports/suspense_repayment_report_list_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/suspense_repayment_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SuspenseRepaymentReportTable extends StatefulWidget {
  List<Denomination> denominationList;
  SuspenseRepaymentReportTable({super.key, required this.denominationList});

  @override
  State<SuspenseRepaymentReportTable> createState() => _SuspenseRepaymentReportTableState();
}

class _SuspenseRepaymentReportTableState extends State<SuspenseRepaymentReportTable> {
final SuspenseRepaymentReportListController _suspenseRepaymentListController = Get.put(SuspenseRepaymentReportListController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Denomination Details",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: Responsive.isDesktop(context) ? size.width : null,
                    child: DataTable(
                          headingRowColor:
                              WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) =>
                                      ColorPalete.tableHeaderBgColor),
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: 200.w,
                                child: Text(
                                  'Payment Method',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 200.w,
                                child: Text(
                                  'Payment Provider',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 200.w,
                                child: Text(
                                  'Paid Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 200.w,
                                child: Text(
                                  'Remark',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            )
                          ],
                          rows: widget
                              .denominationList
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.paymentMethod.toString())),
                              DataCell(Text(item.paymentProvider.toString())),
                              DataCell(Text(item.paidAmount.toString())),
                              DataCell(Text(item.remark.toString())),
                            ]);
                          }).toList(),
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}