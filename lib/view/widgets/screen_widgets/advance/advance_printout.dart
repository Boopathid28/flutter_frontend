import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AdvancePrintout extends StatefulWidget {
  AdvanceDetailsData advanceDetails;
  AdvancePrintout({super.key, required this.advanceDetails});

  @override
  State<AdvancePrintout> createState() => _AdvancePrintoutState();
}

class _AdvancePrintoutState extends State<AdvancePrintout> {

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(horizontal: 3, vertical: 15),
        build: (context) {
          return pw.Container(
        width: 300,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'BAL-RCVD',
              style: pw.TextStyle(fontSize: 13),
            ),
            pw.SizedBox(
              height: 5,
            ),
            pw.Text(
              '${DateHelper.convertDate(widget.advanceDetails.createdAt!)}',
              style: pw.TextStyle(fontSize: 13),
            ),
            pw.Divider(
              thickness: 1,
            ),
            pw.Text(
              'RCVD with Thanks From',
              style: pw.TextStyle(fontSize: 9),
            ),
            pw.Text(
              '${widget.advanceDetails.customerDetailsName}      [${widget.advanceDetails.advanceId}]',
              style: pw.TextStyle(fontSize: 9),
            ),
            pw.Text(
              'PAYMENT RECEIVED BY ${widget.advanceDetails.customerDetailsName}',
              style: pw.TextStyle(fontSize: 9),
            ),
            pw.Text(
              'For ${widget.advanceDetails.advancePurpose!.capitalizeFirst} (${widget.advanceDetails.advanceId})',
              style: pw.TextStyle(fontSize: 9),
            ),
            pw.SizedBox(
              height: 15,
            ),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(
                  'RCVD Amt',
                  style: pw.TextStyle(fontSize: 9),
                ),
                pw.SizedBox(
                  width: 30,
                ),
                pw.Text(
                  '${widget.advanceDetails.totalAdvanceAmount}',
                  style: pw.TextStyle(fontSize: 9),
                ),
              ],
            ),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(
                  'RCVD Wgt',
                  style: pw.TextStyle(fontSize: 9),
                ),
                pw.SizedBox(
                  width: 30,
                ),
                pw.Text(
                  '${widget.advanceDetails.totalAdvanceWeight} g',
                  style: pw.TextStyle(fontSize: 9),
                ),
              ],
            ),
            pw.SizedBox(
              height: 15,
            ),
            pw.Divider(
              thickness: 1,
            ),
            pw.Text(
              '${DateHelper.convertDate(widget.advanceDetails.createdAt!)}',
              style: pw.TextStyle(fontSize: 13),
            ),
          ],
        ),
      );
        },)
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
            'Advance',
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BAL-RCVD',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${DateHelper.convertDate(widget.advanceDetails.createdAt!)}',
              style: TextStyle(fontSize: 15),
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              'RCVD with Thanks From',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              '${widget.advanceDetails.customerDetailsName}      [${widget.advanceDetails.advanceId}]',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'PAYMENT RECEIVED BY ${widget.advanceDetails.customerAddress}',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'For ${widget.advanceDetails.advancePurpose!.capitalizeFirst} (${widget.advanceDetails.customerMobile})',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RCVD Amt',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  '${widget.advanceDetails.totalAdvanceAmount}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RCVD Wgt',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  '${widget.advanceDetails.totalAdvanceWeight} g',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              '${DateHelper.convertDate(widget.advanceDetails.createdAt!)}',
              style: TextStyle(fontSize: 15),
            ),
          ],
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
