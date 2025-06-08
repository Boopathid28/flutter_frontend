import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceAllPaymentPrintout extends StatefulWidget {
  double totalPaid;
  String paymentDate;
  String customerName;
  String customerMobile;
  InvoiceAllPaymentPrintout(
      {super.key,
      required this.totalPaid,
      required this.paymentDate,
      required this.customerName,
      required this.customerMobile});

  @override
  State<InvoiceAllPaymentPrintout> createState() =>
      _InvoiceAllPaymentPrintoutState();
}

class _InvoiceAllPaymentPrintoutState extends State<InvoiceAllPaymentPrintout> {
  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: pw.EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        build: (pw.Context context) {
          return pw.Container(
            width: 300,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'BAL-PAID',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Text(
                  '${DateHelper.convertDate(widget.paymentDate)} / ${widget.totalPaid}',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.Divider(
                  thickness: 1,
                  color: PdfColors.black,
                ),
                pw.Text(
                  'RCVD with Thanks from ${widget.customerName} [${widget.customerMobile}]',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 75,
                      child: pw.Text(
                        'Paid',
                        style: pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.SizedBox(
                      width: 75,
                      child: pw.Text(
                        ': ${widget.totalPaid}',
                        style: pw.TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Divider(
                  thickness: 1,
                  color: PdfColors.black,
                ),
                pw.Text(
                    "${DateHelper.convertTime(widget.paymentDate)}/${widget.totalPaid}",
                    style: pw.TextStyle(fontSize: 12))
              ],
            ),
          );
        }));

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
            "Payment Print",
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
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BAL-PAID',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${DateHelper.convertDate(widget.paymentDate)} / ${widget.totalPaid}',
                style: TextStyle(fontSize: 12),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Text(
                'RCVD with Thanks from ${widget.customerName} [${widget.customerMobile}]',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75,
                    child: Text(
                      'Paid',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    child: Text(
                      ': ${widget.totalPaid}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Text(
                  "${DateHelper.convertTime(widget.paymentDate)}/${widget.totalPaid}",
                  style: TextStyle(fontSize: 12))
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
