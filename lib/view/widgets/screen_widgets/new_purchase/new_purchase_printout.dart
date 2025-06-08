import 'dart:typed_data';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/new_purchase/new_purchase_model.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class NewPurchasePrintout extends StatefulWidget {
  CompanyDetailsData companyDetailsData;
  NewPurchaseRetrieveResponse newPurchaseDetails;

  NewPurchasePrintout(
      {super.key,
      required this.companyDetailsData,
      required this.newPurchaseDetails});

  @override
  State<NewPurchasePrintout> createState() => _NewPurchasePrintoutState();
}

class _NewPurchasePrintoutState extends State<NewPurchasePrintout> {
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
                pw.Text('Ledger: ${widget.newPurchaseDetails.vendorName}',
                    style: pw.TextStyle(fontSize: 10)),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Date",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: pw.Text(
                        "Description",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: pw.Text(
                        "Wt-Dr",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Wt-Cr",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Amt-Dr",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Amt-Cr",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                      child: pw.Text(
                        "Opening Weight",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        widget.newPurchaseDetails.openWeight!
                            .toStringAsFixed(3),
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                      child: pw.Text(
                        "Opening Amount",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        widget.newPurchaseDetails.openAmount!
                            .toStringAsFixed(3),
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.ListView.separated(
                  itemCount: widget.newPurchaseDetails.itemDetails!.length,
                  separatorBuilder: (context, index) => pw.Divider(
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    ItemDetails item =
                        widget.newPurchaseDetails.itemDetails![index];
                    return pw.Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            DateHelper.convertDate(widget
                                .newPurchaseDetails.createdAt!
                                .toString()),
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.SizedBox(
                          width: 40,
                          child: pw.Text(
                            '${item.itemDetailsName}/${item.grossWeight}/${item.touch}',
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.SizedBox(
                          width: 40,
                          child: pw.Text(
                            "0.00",
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            item.totalWeight!.toStringAsFixed(2),
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            "0.00",
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            item.totalAmount!.toStringAsFixed(2),
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        )
                      ],
                    );
                  },
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Total",
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
                    pw.SizedBox(
                      width: 40,
                      child: pw.Text(
                        "0.00",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        widget.newPurchaseDetails.payablePureWeight!
                            .toStringAsFixed(3),
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "0.00",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        widget.newPurchaseDetails.payableAmount!
                            .toStringAsFixed(2),
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Balance",
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
                    pw.SizedBox(
                      width: 40,
                      child: pw.Text(
                        "0.00",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        ((widget.newPurchaseDetails.payablePureWeight ?? 0.0) +
                                (widget.newPurchaseDetails.openWeight ?? 0.0))
                            .toStringAsFixed(3),
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "0.00",
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        ((widget.newPurchaseDetails.payableAmount ?? 0.0) +
                                (widget.newPurchaseDetails.openAmount ?? 0.0))
                            .toStringAsFixed(3),
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    )
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.Center(
                  child: pw.Text(
                      "Conversion ${widget.newPurchaseDetails.convertedWeight?.toStringAsFixed(3)} X ${widget.newPurchaseDetails.convertionRate?.toStringAsFixed(2)}: Rs. ${widget.newPurchaseDetails.convertedAmount?.toStringAsFixed(2)}",
                      style: pw.TextStyle(fontSize: 10)),
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
            'New Purchase',
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
              Text('Ledger: ${widget.newPurchaseDetails.vendorName}',
                  style: const TextStyle(fontSize: 10)),
              Divider(
                thickness: 1,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Date",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "Wt-Dr",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Wt-Cr",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Amt-Dr",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Amt-Cr",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      "Opening Weight",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      widget.newPurchaseDetails.openWeight!.toStringAsFixed(3),
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      "Opening Amount",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      widget.newPurchaseDetails.openAmount!.toStringAsFixed(3),
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.newPurchaseDetails.itemDetails!.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  ItemDetails item =
                      widget.newPurchaseDetails.itemDetails![index];
                  return Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          DateHelper.convertDate(
                              widget.newPurchaseDetails.createdAt!.toString()),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          '${item.itemDetailsName}/${item.grossWeight}/${item.touch}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          "0.00",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          item.totalWeight!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          "0.00",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          item.totalAmount!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  );
                },
              ),
              Divider(
                thickness: 1,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Total",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "0.00",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      widget.newPurchaseDetails.payablePureWeight!
                          .toStringAsFixed(3),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "0.00",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      widget.newPurchaseDetails.payableAmount!
                          .toStringAsFixed(2),
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      "Balance",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "0.00",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      ((widget.newPurchaseDetails.payablePureWeight ?? 0.0) +
                              (widget.newPurchaseDetails.openWeight ?? 0.0))
                          .toStringAsFixed(3),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "0.00",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      ((widget.newPurchaseDetails.payableAmount ?? 0.0) +
                              (widget.newPurchaseDetails.openAmount ?? 0.0))
                          .toStringAsFixed(3),
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: Text(
                    "Conversion ${widget.newPurchaseDetails.convertedWeight?.toStringAsFixed(3)} X ${widget.newPurchaseDetails.convertionRate?.toStringAsFixed(2)}: ₹ ${widget.newPurchaseDetails.convertedAmount?.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 10)),
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
