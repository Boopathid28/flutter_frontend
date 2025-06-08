import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/invoice/invoice_view_payment_details_models.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePaymentPrintout extends StatefulWidget {
  RetrievePaymentDetailListData printData;
  InvoicePaymentPrintout({super.key, required this.printData});

  @override
  State<InvoicePaymentPrintout> createState() => _InvoicePaymentPrintoutState();
}

class _InvoicePaymentPrintoutState extends State<InvoicePaymentPrintout> {
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
                  'BAL-RCVD',
                  style: pw.TextStyle(fontSize: 9),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Text(
                  '${DateHelper.convertDate(widget.printData.paymentDate ?? "")} / ${widget.printData.oldBalance ?? 0.00}',
                  style: pw.TextStyle(fontSize: 9),
                ),
                pw.Divider(
                  thickness: 1,
                  color: PdfColors.black,
                ),
                pw.Text(
                  'RCVD with Thanks from ${widget.printData.customerName} [${widget.printData.customerMobile}]',
                  style: pw.TextStyle(fontSize: 9),
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.ListView.separated(
                  itemCount: widget.printData.denominationDetails!.length,
                  separatorBuilder: (context, index) => pw.SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) {
                    return pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 75,
                          child: pw.Text(
                            '${widget.printData.denominationDetails![index].paymentMethod}',
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.SizedBox(
                          width: 75,
                          child: pw.Text(
                            ': ${widget.printData.denominationDetails![index].paidAmount}',
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                (widget.printData.chitAmount ?? 0.0) > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              'Chit',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              ': ${widget.printData.chitAmount}',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                        ],
                      )
                    : pw.SizedBox(),
                (widget.printData.exchangeAmount ?? 0.0) > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              'Exchange',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              ': ${widget.printData.exchangeAmount}',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                        ],
                      )
                    : pw.SizedBox(),
                (widget.printData.suspenseAmount ?? 0.0) > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              'Suspense',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              ': ${widget.printData.suspenseAmount}',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                        ],
                      )
                    : pw.SizedBox(),
                (widget.printData.advanceAmount ?? 0.0) > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              'Advance',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              ': ${widget.printData.advanceAmount}',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                        ],
                      )
                    : pw.SizedBox(),
                pw.SizedBox(
                  height: 10,
                ),
                (widget.printData.paidAmount ?? 0.0) > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              'Paid',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                          pw.SizedBox(
                            width: 75,
                            child: pw.Text(
                              ': ${widget.printData.paidAmount}',
                              style: pw.TextStyle(fontSize: 9),
                            ),
                          ),
                        ],
                      )
                    : pw.SizedBox(),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 75,
                      child: pw.Text(
                        'Bal',
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 75,
                      child: pw.Text(
                        ': ${((widget.printData.oldBalance ?? 0.0) - (widget.printData.paidAmount ?? 0.0)).toStringAsFixed(2)}',
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  ],
                ),
                pw.Divider(
                  thickness: 1,
                  color: PdfColors.black,
                ),
                pw.Text(
                    "${widget.printData.paymentId}/${DateHelper.convertDate(widget.printData.paymentDate ?? "")}/${((widget.printData.oldBalance ?? 0.0) - (widget.printData.paidAmount ?? 0.0)).toStringAsFixed(2)}",
                    style: pw.TextStyle(fontSize: 9))
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
                'BAL-RCVD',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${DateHelper.convertDate(widget.printData.paymentDate ?? "")} / ${widget.printData.oldBalance ?? 0.00}',
                style: TextStyle(fontSize: 12),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Text(
                'RCVD with Thanks from ${widget.printData.customerName} [${widget.printData.customerMobile}]',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 25,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.printData.denominationDetails!.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          '${widget.printData.denominationDetails![index].paymentMethod}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        child: Text(
                          ': ${widget.printData.denominationDetails![index].paidAmount}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  );
                },
              ),
              (widget.printData.chitAmount ?? 0.0) > 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(
                            'Chit',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          child: Text(
                            ': ${widget.printData.chitAmount}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              (widget.printData.exchangeAmount ?? 0.0) > 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(
                            'Exchange',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          child: Text(
                            ': ${widget.printData.exchangeAmount}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              (widget.printData.suspenseAmount ?? 0.0) > 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(
                            'Suspense',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          child: Text(
                            ': ${widget.printData.suspenseAmount}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              (widget.printData.advanceAmount ?? 0.0) > 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(
                            'Advance',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          child: Text(
                            ': ${widget.printData.advanceAmount}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              (widget.printData.paidAmount ?? 0.0) > 0
                  ? Row(
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
                            ': ${widget.printData.paidAmount}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75,
                    child: Text(
                      'Bal',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    child: Text(
                      ': ${((widget.printData.oldBalance ?? 0.0) - (widget.printData.paidAmount ?? 0.0)).toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Text(
                  "${widget.printData.paymentId}/${DateHelper.convertDate(widget.printData.paymentDate ?? "")}/${((widget.printData.oldBalance ?? 0.0) - (widget.printData.paidAmount ?? 0.0)).toStringAsFixed(2)}",
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
