import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/estimation/estimation_print_out_models.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/svg.dart';

class EstimationPrintout extends StatefulWidget {
  CompanyDetailsData companyDetailsData;
  PrintEstimationDetails estimationDetails;
  List<PrintParticularDetails> items;
  List<PrintExchangeDetails> exchangeItems;
  List<PrintAdvanceDetails> advanceItems;

  EstimationPrintout(
      {super.key,
      required this.companyDetailsData,
      required this.estimationDetails,
      required this.items,
      required this.exchangeItems,
      required this.advanceItems});

  @override
  State<EstimationPrintout> createState() => _EstimationPrintoutState();
}

class _EstimationPrintoutState extends State<EstimationPrintout> {
  final barcode = Barcode.code128();

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: pw.EdgeInsets.symmetric(vertical: 15),
        build: (pw.Context context) {
          return pw.Container(
            width: 200,
            margin: pw.EdgeInsets.only(left: 10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'Rough Estimation',
                    style: pw.TextStyle(fontSize: 13),
                  ),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Gold Rate: ${widget.estimationDetails.displayRate!.gold ?? ""}",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                        pw.Text(
                          "Silver Rate: ${widget.estimationDetails.displayRate!.silver ?? ""}",
                          style: pw.TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                    pw.Text(
                      "Date: ${DateHelper.convertDate(widget.estimationDetails.createdAt ?? "")}",
                      style: pw.TextStyle(fontSize: 9),
                    ),
                  ],
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Item",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "WT",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "V.A",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "MC/RT",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Stn",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Amt",
                      style: pw.TextStyle(fontSize: 8),
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.ListView.separated(
                  itemCount: widget.items.length,
                  separatorBuilder: (context, index) => pw.Divider(
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    PrintParticularDetails item = widget.items[index];
                    return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "${item.sNo}: ${item.itemDetailsName!}",
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Row(
                            mainAxisSize: pw.MainAxisSize.max,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                item.pieces!.toString(),
                                style: pw.TextStyle(fontSize: 8),
                              ),
                              pw.SizedBox(
                                width: 1,
                              ),
                              pw.Text(
                                item.netWeight!.toStringAsFixed(3),
                                style: pw.TextStyle(fontSize: 8),
                              ),
                              pw.SizedBox(
                                width: 1,
                              ),
                              pw.Text(
                                item.wastageGram!.toStringAsFixed(2),
                                style: pw.TextStyle(fontSize: 8),
                              ),
                              pw.SizedBox(
                                width: 1,
                              ),
                              pw.Text(
                                item.makingChargePerGram!.toStringAsFixed(2),
                                style: pw.TextStyle(fontSize: 8),
                              ),
                              pw.SizedBox(
                                width: 1,
                              ),
                              pw.Text(
                                item.stoneAmount!.toStringAsFixed(2),
                                style: pw.TextStyle(fontSize: 8),
                              ),
                              pw.SizedBox(
                                width: 1,
                              ),
                              pw.Text(
                                item.totalAmount!.toStringAsFixed(2),
                                style: pw.TextStyle(fontSize: 8),
                              )
                            ],
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.ListView.separated(
                            itemCount: item.stoneDetails!.length,
                            separatorBuilder: (context, index) => pw.SizedBox(
                              height: 3,
                            ),
                            itemBuilder: (context, index) {
                              PrintStoneDetails stoneItem =
                                  item.stoneDetails![index];
                              return pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        '${stoneItem.stoneName}   ${stoneItem.rate} x ${stoneItem.stoneWeight} = ${(stoneItem.rate ?? 0.0) * (stoneItem.stoneWeight ?? 0.0)}',
                                        style: pw.TextStyle(fontSize: 9)),
                                    pw.Text(
                                        'cert amt   ${stoneItem.certificateAmount} x ${stoneItem.stoneWeight} = ${(stoneItem.certificateAmount ?? 0.0) * (stoneItem.stoneWeight ?? 0.0)}',
                                        style: pw.TextStyle(fontSize: 9))
                                  ],
                                ),
                              );
                            },
                          ),
                          item.stoneAmount! > 0
                              ? pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 100,
                                      child: pw.Text(
                                        'Stone Amount',
                                        style: pw.TextStyle(fontSize: 9),
                                      ),
                                    ),
                                    pw.Text(
                                      ': ${item.stoneAmount}',
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.ListView.separated(
                            itemCount: item.diamondDetails!.length,
                            separatorBuilder: (context, index) => pw.SizedBox(
                              height: 3,
                            ),
                            itemBuilder: (context, index) {
                              PrintDiamondDetails diamondItem =
                                  item.diamondDetails![index];
                              return pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        '${diamondItem.diamondName}   ${diamondItem.rate} x ${diamondItem.diamondWeight} = ${(diamondItem.rate ?? 0.0) * (diamondItem.diamondWeight ?? 0.0)}',
                                        style: pw.TextStyle(fontSize: 9)),
                                    pw.Text(
                                        'cert amt   ${diamondItem.certificateAmount} x ${diamondItem.diamondWeight} = ${(diamondItem.certificateAmount ?? 0.0) * (diamondItem.diamondWeight ?? 0.0)}',
                                        style: pw.TextStyle(fontSize: 9))
                                  ],
                                ),
                              );
                            },
                          ),
                          item.diamondAmount! > 0
                              ? pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 100,
                                      child: pw.Text(
                                        'Diamond Amount',
                                        style: pw.TextStyle(fontSize: 9),
                                      ),
                                    ),
                                    pw.Text(
                                      ': ${item.diamondAmount}',
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                        ]);
                  },
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "${widget.estimationDetails.totalPieces}",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "${widget.estimationDetails.totalWeight}",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "${widget.estimationDetails.totalAmount}",
                      style: pw.TextStyle(fontSize: 8),
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 1,
                ),
                widget.estimationDetails.chitAmount! > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 100,
                            child: pw.Text(
                              "Chit. Wt",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Text(
                            "${widget.estimationDetails.totalSchemeWeight ?? 0.0}",
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.bold),
                          )
                        ],
                      )
                    : pw.SizedBox(),
                widget.estimationDetails.chitAmount! > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 100,
                            child: pw.Text(
                              "Exc. Wt",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Text(
                            "${widget.estimationDetails.totalBalanceWeight ?? 0.0}",
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.bold),
                          )
                        ],
                      )
                    : pw.SizedBox(),
                widget.estimationDetails.chitAmount! > 0
                    ? pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 100,
                            child: pw.Text(
                              "Benifit",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Text(
                            "${widget.estimationDetails.totalBenefitAmount ?? 0.0}",
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.bold),
                          )
                        ],
                      )
                    : pw.SizedBox(),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 50),
                  child: pw.Row(
                    children: [
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          "CGST 1.5%",
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Text(
                        "${(widget.estimationDetails.gstAmount ?? 0.0) / 2}",
                        style: pw.TextStyle(
                            fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )
                    ],
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 50),
                  child: pw.Row(
                    children: [
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          "SGST 1.5%",
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Text(
                        "${(widget.estimationDetails.gstAmount ?? 0.0) / 2}",
                        style: pw.TextStyle(
                            fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )
                    ],
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 50),
                  child: pw.Row(
                    children: [
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          "Nett",
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Text(
                        "${widget.estimationDetails.payableAmount ?? ""}",
                        style: pw.TextStyle(
                            fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )
                    ],
                  ),
                ),
                
                pw.SizedBox(
                height: 5,
              ),
              widget.exchangeItems.length > 0 ? pw.Text(
                      "Valuation",
                      style: pw.TextStyle(fontSize: 8),
                    ) : pw.SizedBox(),
              widget.exchangeItems.length > 0 ? pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Item",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Wt",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Dust",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Wst",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Rate",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Amt",
                      style: pw.TextStyle(fontSize: 8),
                    )
                  ],
                ) : pw.SizedBox(),
              widget.exchangeItems.length > 0 ? pw.Divider(
                  thickness: 1,
                ) : pw.SizedBox(),
              widget.exchangeItems.length > 0 ? pw.ListView.separated(
                  itemCount: widget.exchangeItems.length,
                  separatorBuilder: (context, index) => pw.SizedBox(
                    height: 3,
                  ),
                  itemBuilder: (context, index) {
                    PrintExchangeDetails item = widget.exchangeItems[index];
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "${item.metalName??""}",
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Row(
                          mainAxisSize: pw.MainAxisSize.max,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.SizedBox(
                              width: 25,
                              child: pw.Text(
                                "",
                                style: pw.TextStyle(fontSize: 8),
                              ),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              item.oldGrossWeight != null ? item.oldGrossWeight!.toStringAsFixed(3) : "",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              item.oldDustWeight != null ? item.oldDustWeight!.toStringAsFixed(3) : "",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              "0.000",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              item.oldRate != null ? item.oldRate!.toStringAsFixed(3) : "",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              item.totalAmount != null ? item.totalAmount!.toStringAsFixed(3) : "",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ) : pw.SizedBox(),
              widget.exchangeItems.length > 0 ? pw.Divider(
                  thickness: 1,
                ) : pw.SizedBox(),
              widget.exchangeItems.length > 0 ? pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.SizedBox(
                      width: 100,
                      child: pw.Text(
                        "Nett",
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Text(
                      "${((widget.estimationDetails.payableAmount ?? 0.0) - (widget.estimationDetails.exchangeAmount ?? 0.0)).toStringAsFixed(2)}",
                      style:
                          pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    )
                  ],
                ) : pw.SizedBox(),
              widget.exchangeItems.length > 0 ? pw.SizedBox(
                  height: 5,
                ) : pw.SizedBox(),
              widget.advanceItems.length > 0 ? pw.Text(
                      "Advance",
                      style: pw.TextStyle(fontSize: 8),
                    ) : pw.SizedBox(),
              widget.advanceItems.length > 0 ? pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Adv Id",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Amount",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "Wt",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(
                      width: 1,
                    ),
                    pw.Text(
                      "total Amt",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                  ],
                ) : pw.SizedBox(),
              widget.advanceItems.length > 0 ? pw.Divider(
                  thickness: 1,
                ) : pw.SizedBox(),
              widget.advanceItems.length > 0 ? pw.ListView.separated(
                  itemCount: widget.advanceItems.length,
                  separatorBuilder: (context, index) => pw.SizedBox(
                    height: 3,
                  ),
                  itemBuilder: (context, index) {
                    PrintAdvanceDetails item = widget.advanceItems[index];
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisSize: pw.MainAxisSize.max,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "${item.advanceId??""}",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              item.redeemAmount != null ? item.redeemAmount!.toStringAsFixed(2) : "",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              item.redeemWeight != null ? item.redeemWeight!.toStringAsFixed(3) : "",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(
                              width: 1,
                            ),
                            pw.Text(
                              item.totalAmount != null ? item.totalAmount!.toStringAsFixed(2) : "",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ) : pw.SizedBox(),
              widget.advanceItems.length > 0 ? pw.Divider(
                  thickness: 1,
                ) : pw.SizedBox(),
              widget.advanceItems.length > 0 ? pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.SizedBox(
                      width: 100,
                      child: pw.Text(
                        "Nett",
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Text(
                      "${(widget.estimationDetails.balanceAmount ?? 0.0).toStringAsFixed(2)}",
                      style:
                          pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                    )
                  ],
                ) : pw.SizedBox(),
                pw.SizedBox(
                  height: 30,
                ),
                pw.Text(
                  "${DateHelper.convertTime(widget.estimationDetails.estimationDate ?? '')}//${widget.estimationDetails.metalCode}//${widget.estimationDetails.estimationId}",
                  style:
                      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                ),
                pw.Divider(
                  thickness: 1,
                ),
                pw.Text(
                  "SUBJECT TO BILLING ON APPROVAL..",
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
                pw.Container(
                    width: 100,
                    height: 25,
                    child: pw.SvgImage(
                        svg: barcode.toSvg(
                      widget.estimationDetails.estimationId!,
                      width: 100,
                      height: 25,
                      drawText:
                          false, // Set to true if you want text below the barcode
                    ))),
                pw.SizedBox(
                  height: 100,
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
            'Estimation',
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
              Center(
                child: Text(
                  'Rough Estimation',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gold Rate: ${widget.estimationDetails.displayRate!.gold ?? ""}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Silver Rate: ${widget.estimationDetails.displayRate!.silver ?? ""}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    "Date: ${DateHelper.convertDate(widget.estimationDetails.createdAt ?? "")}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Item",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "WT",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "V.A",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "MC/RT",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "Stn",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "Amt",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  PrintParticularDetails item = widget.items[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.sNo}: ${item.itemDetailsName!}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.pieces!.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.netWeight!.toStringAsFixed(3),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.wastageGram!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.makingChargePerGram!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.stoneAmount!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.totalAmount!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: item.stoneDetails!.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          PrintStoneDetails stoneItem =
                              item.stoneDetails![index];
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${stoneItem.stoneName}   ${stoneItem.rate} x ${stoneItem.stoneWeight} = ${(stoneItem.rate ?? 0.0) * (stoneItem.stoneWeight ?? 0.0)}',
                                    style: TextStyle(fontSize: 9)),
                                Text(
                                    'cert amt   ${stoneItem.certificateAmount} x ${stoneItem.stoneWeight} = ${(stoneItem.certificateAmount ?? 0.0) * (stoneItem.stoneWeight ?? 0.0)}',
                                    style: TextStyle(fontSize: 9))
                              ],
                            ),
                          );
                        },
                      ),
                      item.stoneAmount! > 0
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Stone Amount',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Text(
                                  ': ${item.stoneAmount}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: item.diamondDetails!.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          PrintDiamondDetails diamondItem =
                              item.diamondDetails![index];
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${diamondItem.diamondName}   ${diamondItem.rate} x ${diamondItem.diamondWeight} = ${(diamondItem.rate ?? 0.0) * (diamondItem.diamondWeight ?? 0.0)}',
                                    style: TextStyle(fontSize: 9)),
                                Text(
                                    'cert amt   ${diamondItem.certificateAmount} x ${diamondItem.diamondWeight} = ${(diamondItem.certificateAmount ?? 0.0) * (diamondItem.diamondWeight ?? 0.0)}',
                                    style: TextStyle(fontSize: 9))
                              ],
                            ),
                          );
                        },
                      ),
                      item.diamondAmount! > 0
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Diamond Amount',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Text(
                                  ': ${item.diamondAmount}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.estimationDetails.totalPieces}",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "${widget.estimationDetails.totalWeight}",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text(
                    "${widget.estimationDetails.totalAmount}",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              widget.estimationDetails.chitAmount! > 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Chit. Wt",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          "${widget.estimationDetails.totalSchemeWeight ?? 0.0}",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : SizedBox(),
              widget.estimationDetails.chitAmount! > 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Exc. Wt",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          "${widget.estimationDetails.totalBalanceWeight ?? 0.0}",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : SizedBox(),
              widget.estimationDetails.chitAmount! > 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Benifit",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          "${widget.estimationDetails.totalBenefitAmount ?? 0.0}",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "CGST 1.5%",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "${(widget.estimationDetails.gstAmount ?? 0.0) / 2}",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "SGST 1.5%",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "${(widget.estimationDetails.gstAmount ?? 0.0) / 2}",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Nett",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "${widget.estimationDetails.payableAmount ?? ""}",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              widget.exchangeItems.length > 0 ? Text(
                      "Valuation",
                      style: TextStyle(fontSize: 12),
                    ) : SizedBox(),
              widget.exchangeItems.length > 0 ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Item",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Wt",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Dust",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Wst",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Rate",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Amt",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ) : SizedBox(),
              widget.exchangeItems.length > 0 ? Divider(
                  thickness: 1,
                ) : SizedBox(),
              widget.exchangeItems.length > 0 ? ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.exchangeItems.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 3,
                  ),
                  itemBuilder: (context, index) {
                    PrintExchangeDetails item = widget.exchangeItems[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.metalName??""}",
                          style: TextStyle(fontSize: 12),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 25,
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              item.oldGrossWeight != null ? item.oldGrossWeight!.toStringAsFixed(3) : "",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              item.oldDustWeight != null ? item.oldDustWeight!.toStringAsFixed(3) : "",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              "0.000",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              item.oldRate != null ? item.oldRate!.toStringAsFixed(3) : "",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              item.totalAmount != null ? item.totalAmount!.toStringAsFixed(3) : "",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ) : SizedBox(),
              widget.exchangeItems.length > 0 ? Divider(
                  thickness: 1,
                ) : SizedBox(),
              widget.exchangeItems.length > 0 ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Nett",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "${((widget.estimationDetails.payableAmount ?? 0.0) - (widget.estimationDetails.exchangeAmount ?? 0.0)).toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  ],
                ) : SizedBox(),
              widget.exchangeItems.length > 0 ? SizedBox(
                  height: 5,
                ) : SizedBox(),
              widget.advanceItems.length > 0 ? Text(
                      "Advance",
                      style: TextStyle(fontSize: 12),
                    ) : SizedBox(),
              widget.advanceItems.length > 0 ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Adv Id",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Amount",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Wt",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "total Amt",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ) : SizedBox(),
              widget.advanceItems.length > 0 ? Divider(
                  thickness: 1,
                ) : SizedBox(),
              widget.advanceItems.length > 0 ? ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.advanceItems.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 3,
                  ),
                  itemBuilder: (context, index) {
                    PrintAdvanceDetails item = widget.advanceItems[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${item.advanceId??""}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              item.redeemAmount != null ? item.redeemAmount!.toStringAsFixed(2) : "",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              item.redeemWeight != null ? item.redeemWeight!.toStringAsFixed(3) : "",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              item.totalAmount != null ? item.totalAmount!.toStringAsFixed(2) : "",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ) : SizedBox(),
              widget.advanceItems.length > 0 ? Divider(
                  thickness: 1,
                ) : SizedBox(),
              widget.advanceItems.length > 0 ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Nett",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "${(widget.estimationDetails.balanceAmount ?? 0.0).toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  ],
                ) : SizedBox(),
              SizedBox(
                height: 30,
              ),
              Text(
                "${DateHelper.convertTime(widget.estimationDetails.estimationDate ?? '')}//${widget.estimationDetails.metalCode}//${widget.estimationDetails.estimationId}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Divider(
                thickness: 1,
              ),
              Text(
                "SUBJECT TO BILLING ON APPROVAL..",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Container(
                  width: 100,
                  height: 25,
                  child: SvgPicture.string(barcode.toSvg(
                    widget.estimationDetails.estimationId!,
                    width: 100,
                    height: 25,
                    drawText:
                        false, // Set to true if you want text below the barcode
                  ))),
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
