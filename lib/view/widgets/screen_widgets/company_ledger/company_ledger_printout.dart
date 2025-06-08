import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_print_models.dart';
import 'package:ausales_application/service/company_ledger/company_ledger_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CompanyLedgerPrintout extends StatefulWidget {
  String companyId;
  CompanyLedgerPrintout({super.key, required this.companyId});

  @override
  State<CompanyLedgerPrintout> createState() => _CompanyLedgerPrintoutState();
}

class _CompanyLedgerPrintoutState extends State<CompanyLedgerPrintout> {
  PrintCompanyLedgerDetails details = PrintCompanyLedgerDetails();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCompanyLedgerDetails();
  }

  Future getCompanyLedgerDetails() async {
    setState(() {
      isLoading = true;
    });
    int? menuId = await HomeSharedPrefs.getCurrentMenu();
    PrintCompanyLedgerDetails? data =
        await CompanyLedgerService.printCompanyLedger(
            menuId: menuId!.toString(),
            companyId: widget.companyId,
            context: context);

    if (data != null) {
      setState(() {
        details = data;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a5,
        margin: pw.EdgeInsets.all(15),
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            width: 500,
            child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Center(
                child: pw.Text(
                  "CASH RECEIPT",
                  style: pw.TextStyle(
                      fontSize: 15, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Vr. NO : ${details.expenseId}",
                    style: pw.TextStyle(fontSize: 15),
                  ),
                  pw.Text(
                    "Date : ${DateHelper.convertDate(details.createdAt ?? "")}",
                    style: pw.TextStyle(fontSize: 15),
                  ),
                ],
              ),
              pw.Divider(
                thickness: 1,
                color: PdfColors.black,
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Text(
                "${details.classificationName} ${details.expensesTypeName} for ${details.subExpenseName} by ${details.paymentMethodName} ${details.paymentProviderName == null ? "" : "(${details.paymentProviderName})"}",
                style: pw.TextStyle(fontSize: 15),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Text(
                "the sum of ${NumberToWordsEnglish.convert((details.amount ?? 0.0).round())} only",
                style: pw.TextStyle(fontSize: 15),
              ),
              pw.SizedBox(
                height: 35,
              ),
              pw.Text(
                'Amount : ${details.amount ?? "0.0"}',
                style: pw.TextStyle(fontSize: 15),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Divider(
                thickness: 1,
                color: PdfColors.black,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Sign.',
                    style: pw.TextStyle(fontSize: 15),
                  ),
                  pw.Text(
                    '${DateHelper.convertTime(details.createdAt ?? "")} / ${details.paymentMethodName} / SRJ',
                    style: pw.TextStyle(fontSize: 15),
                  ),
                ],
              ),
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
            'Company Ledger Print',
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
        width: 500,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "CASH RECEIPT",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vr. NO : ${details.expenseId}",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "Date : ${DateHelper.convertDate(details.createdAt ?? "")}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${details.classificationName} ${details.expensesTypeName} for ${details.subExpenseName} by ${details.paymentMethodName} ${details.paymentProviderName == null ? "" : "(${details.paymentProviderName})"}",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "the sum of ${NumberToWordsEnglish.convert((details.amount ?? 0.0).round())} only",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Amount : ${details.amount ?? "0.0"}',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign.',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '${DateHelper.convertTime(details.createdAt ?? "")} / ${details.paymentMethodName} / SRJ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
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
          },
        )
      ],
    );
  }
}
