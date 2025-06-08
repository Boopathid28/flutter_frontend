import 'dart:typed_data';
 
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
 
class OldPurchasePrintout extends StatefulWidget {
  CompanyDetailsData companyDetailsData;
  OldPurchaseRetrieveResponse oldPurchaseDetails;
 
  OldPurchasePrintout(
      {super.key,
      required this.companyDetailsData,
      required this.oldPurchaseDetails});
 
  @override
  State<OldPurchasePrintout> createState() => _OldPurchasePrintoutState();
}
 
class _OldPurchasePrintoutState extends State<OldPurchasePrintout> {
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
 
    final Uint8List imageBytes = await fetchNetworkImage(
        "$baseMediaUrl/${widget.companyDetailsData.companyLogo}");
 
    final image = pw.MemoryImage(imageBytes);
 
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
        width: 750,
        color: PdfColors.white,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text(
                      'Name : ',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.SizedBox(
                        width: 300,
                        child: pw.Text(
                            "${widget.oldPurchaseDetails.customerDetailsName}\n${widget.oldPurchaseDetails.customerDetailsAddress}\n${widget.oldPurchaseDetails.customerDetailsMobile}",
                            style: pw.TextStyle(fontSize: 14)))
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'No       : ${widget.oldPurchaseDetails.oldGoldBillNumber}',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      'Date    : ${DateHelper.convertDate(widget.oldPurchaseDetails.createdAt ?? "")}',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      'Rate     : ${widget.oldPurchaseDetails.oldGoldAmount}',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      'GST     : ${widget.oldPurchaseDetails.totalGstAmount}',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            pw.SizedBox(
              height: 16.h,
            ),
             pw.SizedBox(
                child: pw.TableHelper.fromTextArray(
                  border: pw.TableBorder(
                    top: pw.BorderSide(color: PdfColors.black),
                    bottom: pw.BorderSide(color: PdfColors.black),
                    horizontalInside: pw.BorderSide(color: PdfColors.black),
                  ),
                  cellAlignment: pw.Alignment.center,
                  headers: ["Item", "Wt", "Dust", "Wst", "Rate", "+/-", "Amount"],
                  data: widget.oldPurchaseDetails.oldItemDetailsList!.map((item) {
                    return [
                      item.itemName??"",
                      item.oldGrossWeight??"",
                      item.oldDustWeight??"",
                      0,
                      item.oldRate??"",
                      0,
                      item.totalAmount??""
                    ];
                  }).toList()
                ),
              ),
            pw.SizedBox(
              height: 5,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  width: 200,
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('CGST 1.5 %', style: pw.TextStyle(fontSize: 12)),
                          pw.Text(
                              '${(widget.oldPurchaseDetails.totalGstAmount ?? 0.0) / 2}',
                              style: pw.TextStyle(fontSize: 12)),
                        ],
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('SGST 1.5 %', style: pw.TextStyle(fontSize: 12)),
                          pw.Text(
                              '${(widget.oldPurchaseDetails.totalGstAmount ?? 0.0) / 2}',
                              style: pw.TextStyle(fontSize: 12)),
                        ],
                      ),
                      pw.Divider(
                        thickness: 1,
                        color: PdfColors.black,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Nett', style: pw.TextStyle(fontSize: 12)),
                          pw.Text(
                              '${widget.oldPurchaseDetails.oldGoldAmount ?? "0.0"}',
                              style: pw.TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
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
            'Old Purchase',
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
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Name : ',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                          width: 300,
                          child: Text(
                              "${widget.oldPurchaseDetails.customerDetailsName}\n${widget.oldPurchaseDetails.customerDetailsAddress}\n${widget.oldPurchaseDetails.customerDetailsMobile}",
                              style: TextStyle(fontSize: 14)))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No       : ${widget.oldPurchaseDetails.oldGoldBillNumber}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Date    : ${DateHelper.convertDate(widget.oldPurchaseDetails.createdAt ?? "")}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Rate     : ${widget.oldPurchaseDetails.oldGoldAmount}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'GST     : ${widget.oldPurchaseDetails.totalGstAmount}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                    border: TableBorder(
                        top: BorderSide(
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                        horizontalInside: BorderSide(color: Colors.black)),
                    headingRowHeight: 40,
                    dataRowHeight: 40,
                    columns: const [
                      DataColumn(
                          label: Text(
                        "Item",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Gross Wgt",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Dust Wgt",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Wst",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Rate",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "+/-",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Total Amount",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                    ],
                    rows: widget.oldPurchaseDetails.oldItemDetailsList == null
                        ? []
                        : widget.oldPurchaseDetails.oldItemDetailsList!
                            .map((item) {
                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  item.itemName ?? "",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.oldGrossWeight!.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${item.oldDustWeight.toString()} g",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "0",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${item.oldRate.toString()} g",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "₹ 0",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "₹ ${item.totalAmount.toString()}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ]);
                          }).toList()),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('CGST 1.5 %', style: TextStyle(fontSize: 12)),
                            Text(
                                '${(widget.oldPurchaseDetails.totalGstAmount ?? 0.0) / 2}',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SGST 1.5 %', style: TextStyle(fontSize: 12)),
                            Text(
                                '${(widget.oldPurchaseDetails.totalGstAmount ?? 0.0) / 2}',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nett', style: TextStyle(fontSize: 12)),
                            Text(
                                '${widget.oldPurchaseDetails.oldGoldAmount ?? "0.0"}',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
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