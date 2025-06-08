import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/daily_report_models.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DailyReportPrint extends StatefulWidget {
  List<DailyReportListData> items;

  DailyReportPrint({
    super.key,
    required this.items,
  });

  @override
  State<DailyReportPrint> createState() =>
      _DailyReportPrintState();
}

class _DailyReportPrintState
    extends State<DailyReportPrint> {

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                  child: pw.Column(
                children: [
                  pw.SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: pw.TableHelper.fromTextArray(
                        headers: [
                          'Ref ID',
                          'Pieces',
                          'Wt',
                          'Sale',
                          'GP-WT',
                        ],
                        data: widget.items.map((item) {
                          return [
                            " ${item.refernceId}",
                            " ${item.pieces}",
                            " ${item.netWeight}",
                            " ${item.amount}",
                            " ${item.totalOldGoldWeight}",
                          ];
                        }).toList()),
                  ),
                  
                ],
              )),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  void printPdf() async {
    final pdf = await createPdf();
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Daily Report',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 750,
        height: MediaQuery.of(context).size.height * 0.9,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 750,
                          child: DataTable(
                              border: TableBorder(
                                  top: BorderSide(
                                    color: Colors.black,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.black,
                                  ),
                                  horizontalInside:
                                      BorderSide(color: Colors.black)),
                              headingRowHeight: 40,
                              columnSpacing: 0,
                              dataRowMaxHeight: 25,
                              dataRowMinHeight: 10,
                              horizontalMargin: 10,
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  "Ref Id",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Pieces",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Wt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Sale",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "GP-WT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                              rows: widget.items.map((item) {
                                return DataRow(cells: [
                                  DataCell(
                                    Text(
                                      "${item.refernceId}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.pieces}", // Assuming `item.createdAt` is a DateTime
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.netWeight}", // Assuming `item.createdAt` is a DateTime
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.amount}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.totalOldGoldWeight}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ]);
                              }).toList()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        PrimaryButton(
            isLoading: false,
            text: "Print",
            onPressed: () {
              printPdf();
            })
      ],
    );
  }
}
