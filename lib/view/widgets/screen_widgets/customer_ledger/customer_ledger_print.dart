import 'dart:typed_data';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/customer_ledger/customer_ledger_models.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class CustomerLedgerPrint extends StatefulWidget {
  List<CustomerLedgerListData> items;
  String? totaoOutPieces;
  String? totalInWeight;
  String? totalInPieces;
  String? totalOutWeight;
  String? totalOpenPieces;
  String? totalClosePieces;
  String? totalOpenWeight;
  String? totalCloseWeight;

  CustomerLedgerPrint({
    super.key,
    required this.items,
    this.totaoOutPieces,
    this.totalInWeight,
    this.totalInPieces,
    this.totalOutWeight,
    this.totalOpenPieces,
    this.totalClosePieces,
    this.totalOpenWeight,
    this.totalCloseWeight,
  });

  @override
  State<CustomerLedgerPrint> createState() =>
      _CustomerLedgerPrintState();
}

class _CustomerLedgerPrintState
    extends State<CustomerLedgerPrint> {
  Future<Uint8List> fetchNetworkImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load network image');
    }
  }

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
                          'Customer Name',
                          'Invoice Number',
                          'Reffrence Number',
                          'Entry Type',
                          'Transaction Type',
                          'Transaction Amount',
                        ],
                        data: widget.items.map((item) {
                          return [
                            " ${item.customerDetailsName}",
                            " ${item.invoiceNumber}",
                            " ${item.reffrenceNumber}",
                            " ${item.entryType}",
                            " ${item.transactionType}",
                            " ${item.transactionAmount}",
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
            'Customer Ledger',
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
                                  "Customer Name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Invoice Number",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Reffrence Number",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Entry Type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Transaction Type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Transaction Amount",
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
                                      "${item.customerDetailsName}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.invoiceNumber}", // Assuming `item.createdAt` is a DateTime
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.reffrenceNumber}", // Assuming `item.createdAt` is a DateTime
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.entryType}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.transactionType}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.transactionAmount}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ]);
                              }).toList()),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Column(
                        //   children: [
                        //     SizedBox(
                        //       width: 700,
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           Column(
                        //             children: [
                        //               Text(
                        //                 "Total Open Pieces",
                        //                 style: TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               Text(
                        //                 "${widget.totalOpenPieces}",
                        //                 style: TextStyle(fontSize: 14),
                        //               )
                        //             ],
                        //           ),
                        //           Column(
                        //             children: [
                        //               Text(
                        //                 "Total Close Pieces",
                        //                 style: TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               Text(
                        //                 "${widget.totalClosePieces}",
                        //                 style: TextStyle(fontSize: 14),
                        //               )
                        //             ],
                        //           ),
                        //           Column(
                        //             children: [
                        //               Text(
                        //                 "Total Open Weight",
                        //                 style: TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               Text(
                        //                 "${widget.totalOpenWeight}",
                        //                 style: TextStyle(fontSize: 14),
                        //               )
                        //             ],
                        //           ),
                        //           Column(
                        //             children: [
                        //               Text(
                        //                 "Total Close Weight",
                        //                 style: TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               Text(
                        //                 "${widget.totalCloseWeight}",
                        //                 style: TextStyle(fontSize: 14),
                        //               )
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // )
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
