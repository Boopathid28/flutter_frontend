import 'dart:typed_data';

import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_view_models.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class VendorPaymentPrintout extends StatefulWidget {
  VendorPaymentListDataDetailsResponse vendorPaymentDetails;

  VendorPaymentPrintout({super.key, required this.vendorPaymentDetails});

  @override
  State<VendorPaymentPrintout> createState() => _VendorPaymentPrintoutState();
}

class _VendorPaymentPrintoutState extends State<VendorPaymentPrintout> {
  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: pw.EdgeInsets.symmetric(vertical: 15),
        build: (pw.Context context) {
          return pw.Container(
            margin: pw.EdgeInsets.only(left: 10),
            width: 200,
            color: PdfColors.white,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                    'Ledger: ${widget.vendorPaymentDetails.vendorDetailsName}',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.max,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Date",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "Description",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "WT-DR",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "WT-CR",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                    pw.Text(
                      "Amt-DR",
                      style: pw.TextStyle(fontSize: 9),
                    ),
                    pw.Text(
                      "Amt-CR",
                      style: pw.TextStyle(fontSize: 9),
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Text(
                    'Opening Amount: ${widget.vendorPaymentDetails.openAmount}',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.Text(
                    'Opening Weight: ${widget.vendorPaymentDetails.openWeight}',
                    style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(
                  height: 5,
                ),
                pw.ListView.separated(
                  itemCount: widget.vendorPaymentDetails.weightDetails!.length,
                  separatorBuilder: (context, index) => pw.SizedBox(
                    height: 3,
                  ),
                  itemBuilder: (context, index) {
                    WeightDetails item =
                        widget.vendorPaymentDetails.weightDetails![index];
                    return pw.Column(
                      children: [
                        pw.Wrap(
                          children: [
                            pw.Row(
                              mainAxisSize: pw.MainAxisSize.max,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  width: 50,
                                  child: pw.Text(
                                    "${DateHelper.convertDate(widget.vendorPaymentDetails.paymentDate ?? "")}",
                                    style: pw.TextStyle(fontSize: 9),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  padding:
                                      pw.EdgeInsets.symmetric(horizontal: 2),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        "${item.remarks}/${item.metalWeight}/${item.touch}%",
                                        style: pw.TextStyle(fontSize: 9),
                                      ),
                                      pw.Text(
                                        "${item.refferedBy}",
                                        style: pw.TextStyle(fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 40,
                                  child: pw.Text(
                                    "${item.pureWeight}",
                                    style: pw.TextStyle(fontSize: 9),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 40,
                                  child: pw.Text(
                                    "",
                                    style: pw.TextStyle(fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              width: 40,
                              child: pw.Text(
                                "",
                                style: pw.TextStyle(fontSize: 9),
                              ),
                            ),
                            pw.SizedBox(
                              width: 40,
                              child: pw.Text(
                                "",
                                style: pw.TextStyle(fontSize: 9),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
                pw.SizedBox(
                  height: 3,
                ),
                pw.ListView.separated(
                  itemCount: widget.vendorPaymentDetails.paymentDetails!.length,
                  separatorBuilder: (context, index) => pw.SizedBox(
                    height: 3,
                  ),
                  itemBuilder: (context, index) {
                    PaymentDetails item =
                        widget.vendorPaymentDetails.paymentDetails![index];
                    return pw.Column(
                      children: [
                        pw.Wrap(
                          children: [
                            pw.Row(
                              mainAxisSize: pw.MainAxisSize.max,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  width: 50,
                                  child: pw.Text(
                                    "${DateHelper.convertDate(widget.vendorPaymentDetails.paymentDate ?? "")}",
                                    style: pw.TextStyle(fontSize: 9),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  padding:
                                      pw.EdgeInsets.symmetric(horizontal: 2),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        "${item.remarks}/${item.metalRate}",
                                        style: pw.TextStyle(fontSize: 9),
                                      ),
                                      pw.Text(
                                        "${item.refferedBy}",
                                        style: pw.TextStyle(fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 40,
                                  child: pw.Text(
                                    "${item.pureWeight}",
                                    style: pw.TextStyle(fontSize: 9),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 40,
                                  child: pw.Text(
                                    "",
                                    style: pw.TextStyle(fontSize: 9),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              width: 40,
                              child: pw.Text(
                                "${item.amount}",
                                style: pw.TextStyle(fontSize: 9),
                              ),
                            ),
                            pw.SizedBox(
                              width: 40,
                              child: pw.Text(
                                "",
                                style: pw.TextStyle(fontSize: 9),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.max,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Total",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "${widget.vendorPaymentDetails.paymentWeight}",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                    pw.Text(
                      "${widget.vendorPaymentDetails.paymentAmount}",
                      style: pw.TextStyle(fontSize: 9),
                    ),
                    pw.Text(
                      "",
                      style: pw.TextStyle(fontSize: 9),
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 3,
                ),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.max,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Balance",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "${(widget.vendorPaymentDetails.openWeight ?? 0.0) - (widget.vendorPaymentDetails.paymentWeight ?? 0.0)}",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                    pw.Text(
                      "${(widget.vendorPaymentDetails.openAmount ?? 0.0) - (widget.vendorPaymentDetails.paymentAmount ?? 0.0)}",
                      style: pw.TextStyle(fontSize: 9),
                    ),
                    pw.Text(
                      "",
                      style: pw.TextStyle(fontSize: 9),
                    )
                  ],
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
            'Vendor Payment',
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
        width: 200,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ledger: ${widget.vendorPaymentDetails.vendorDetailsName}',
                  style: const TextStyle(fontSize: 10)),
              Divider(
                thickness: 1,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "Description",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "WT-DR",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "WT-CR",
                        style: TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                  Text(
                    "Amt-DR",
                    style: TextStyle(fontSize: 9),
                  ),
                  Text(
                    "Amt-CR",
                    style: TextStyle(fontSize: 9),
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Text('Opening Amount: ${widget.vendorPaymentDetails.openAmount}',
                  style: const TextStyle(fontSize: 10)),
              Text('Opening Weight: ${widget.vendorPaymentDetails.openWeight}',
                  style: const TextStyle(fontSize: 10)),
              SizedBox(
                height: 5,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.vendorPaymentDetails.weightDetails!.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 3,
                ),
                itemBuilder: (context, index) {
                  WeightDetails item =
                      widget.vendorPaymentDetails.weightDetails![index];
                  return Column(
                    children: [
                      Wrap(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  "${DateHelper.convertDate(widget.vendorPaymentDetails.paymentDate ?? "")}",
                                  style: TextStyle(fontSize: 9),
                                ),
                              ),
                              Container(
                                width: 100,
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item.remarks}/${item.metalWeight}/${item.touch}%",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    Text(
                                      "${item.refferedBy}",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  "${item.pureWeight}",
                                  style: TextStyle(fontSize: 9),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  "",
                                  style: TextStyle(fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(
                              "",
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(
                              "",
                              style: TextStyle(fontSize: 9),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 3,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.vendorPaymentDetails.paymentDetails!.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 3,
                ),
                itemBuilder: (context, index) {
                  PaymentDetails item =
                      widget.vendorPaymentDetails.paymentDetails![index];
                  return Column(
                    children: [
                      Wrap(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  "${DateHelper.convertDate(widget.vendorPaymentDetails.paymentDate ?? "")}",
                                  style: TextStyle(fontSize: 9),
                                ),
                              ),
                              Container(
                                width: 100,
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item.remarks}/${item.metalRate}",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    Text(
                                      "${item.refferedBy}",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  "${item.pureWeight}",
                                  style: TextStyle(fontSize: 9),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  "",
                                  style: TextStyle(fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(
                              "${item.amount}",
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Text(
                              "",
                              style: TextStyle(fontSize: 9),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              Divider(
                thickness: 1,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "${widget.vendorPaymentDetails.paymentWeight}",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.vendorPaymentDetails.paymentAmount}",
                    style: TextStyle(fontSize: 9),
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 9),
                  )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Balance",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "${(widget.vendorPaymentDetails.openWeight ?? 0.0) - (widget.vendorPaymentDetails.paymentWeight ?? 0.0)}",
                        style: TextStyle(fontSize: 9),
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                  Text(
                    "${(widget.vendorPaymentDetails.openAmount ?? 0.0) - (widget.vendorPaymentDetails.paymentAmount ?? 0.0)}",
                    style: TextStyle(fontSize: 9),
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 9),
                  )
                ],
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
