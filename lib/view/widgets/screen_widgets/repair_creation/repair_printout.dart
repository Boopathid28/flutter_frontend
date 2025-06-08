import 'dart:typed_data';

import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class RepairPrintOut extends StatefulWidget {
  CompanyDetailsData companyDetailsData;
  RepairGetbyData repairgetbydata;
  List<ItemDetails> items;

  RepairPrintOut(
      {super.key,
      required this.companyDetailsData,
      required this.repairgetbydata,
      required this.items});

  @override
  State<RepairPrintOut> createState() => _RepairPrintOutState();
}

class _RepairPrintOutState extends State<RepairPrintOut> {
  // Future<Uint8List> fetchNetworkImage(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     return response.bodyBytes;
  //   } else {
  //     throw Exception('Failed to load network image');
  //   }
  // }

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    // final Uint8List imageBytes = await fetchNetworkImage(
    //     "$baseMediaUrl/${widget.companyDetailsData.companyLogo}");

    // final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(14),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            width: 550,
            color: PdfColors.white,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 120.h),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Center(
                      child: pw.Text(
                        "Repair Receipt",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  mainAxisSize: pw.MainAxisSize.min,
                                  children: [
                                    pw.Text(
                                      'Name : ',
                                      style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                        "${widget.repairgetbydata.customerName}",
                                        style: pw.TextStyle(
                                            fontSize: 9,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.SizedBox(
                                      width: 10,
                                    ),
                                    pw.Text(
                                      'Ph No : ',
                                      style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                        "${widget.repairgetbydata.customerPhone}",
                                        style: pw.TextStyle(
                                            fontSize: 9,
                                            fontWeight: pw.FontWeight.bold))
                                  ],
                                ),
                                pw.Text(
                                  'Address : ${widget.repairgetbydata.customerAddress}',
                                  style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                              ]),
                          pw.Row(
                            children: [
                              pw.Text(
                                'Repair Id : ${widget.repairgetbydata.repairId}',
                                style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 6),
                              pw.Text(
                                'Date : ${widget.repairgetbydata.createdAt!.split('T')[0]}',
                                style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                pw.SizedBox(
                  height: 4.h,
                ),
                pw.SizedBox(
                    child: pw.TableHelper.fromTextArray(
                  border: pw.TableBorder(
                    top: pw.BorderSide(color: PdfColors.black),
                    bottom: pw.BorderSide(color: PdfColors.black),
                    horizontalInside: pw.BorderSide(color: PdfColors.black),
                  ),
                  cellAlignment: pw.Alignment.center,
                  headers: [
                    pw.Text("SI.No", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Item", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Metal", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Repair Type", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Pc", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Wt", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Due Date", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Remark", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Amount", style: pw.TextStyle(fontSize: 9)),
                  ],
                  data: widget.items!.map((item) {
                    return [
                      pw.Text("${item.Sno ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.itemDetailsName ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.metalName ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.repairType ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.pieces.toString()}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.metalName.toString()}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.dueDate.toString()}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.remarks.toString()}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.customerCharges.toString()}",
                          style: pw.TextStyle(fontSize: 9)),
                    ];
                  }).toList(),
                )),
                pw.SizedBox(height: 2),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.SizedBox(
                        width: 140,
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Nett',
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              "${widget.repairgetbydata.totalCustomerCharges}",
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.SizedBox(
                        width: 140,
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Advance',
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              "${widget.repairgetbydata.totalAdvanceAmount}",
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.SizedBox(
                        width: 140,
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Balance',
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              "${widget.repairgetbydata.balanceAmount}",
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            'Repair Receipt',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      "Repair Receipt",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text("${widget.repairgetbydata.customerName}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Ph No : ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text("${widget.repairgetbydata.customerPhone}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(
                            "Address :  ${widget.repairgetbydata.customerAddress}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Repair Id : ${widget.repairgetbydata.repairId}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'Date : ${widget.repairgetbydata.createdAt!.split('T')[0]}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
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
                                  "S No",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Item Description",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Metal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Repair type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Pc",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Wt.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Due Date",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Remark",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Amount",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                              rows: widget.items.map((item) {
                                return DataRow(cells: [
                                  DataCell(
                                    Text(
                                      item.Sno == null
                                          ? ""
                                          : item.Sno.toString(),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.itemDetailsName ?? ''}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.metalName ?? ''}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.repairType ?? ''}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      (item.pieces.toString()),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      (item.grossWeight != null
                                          ? "${item.grossWeight} g"
                                          : ""),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      DateHelper.convertDate(
                                          item.dueDate.toString()),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.remarks ?? ""}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.customerCharges ?? ""}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )
                                ]);
                              }).toList()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              gstAndAmount(
                                label: 'Nett',
                                value: (widget
                                        .repairgetbydata.totalCustomerCharges)
                                    .toString(),
                              ),
                              gstAndAmount(
                                label: 'Advance',
                                value:
                                    (widget.repairgetbydata.totalAdvanceAmount)
                                        .toString(),
                              ),
                              gstAndAmount(
                                label: 'Balance',
                                value: (widget.repairgetbydata.balanceAmount)
                                    .toString(),
                              ),
                            ],
                          ),
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

  Widget gstAndAmount({required String label, required String value}) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 25,
        width: 190,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 32,
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
