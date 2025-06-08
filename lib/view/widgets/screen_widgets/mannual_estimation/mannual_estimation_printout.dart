import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/estimation/estimation_history_models.dart';
import 'package:ausales_application/model/mannual_estimation/mannual_estimation_history_model.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/svg.dart';

class MannualEstimationPrintout extends StatefulWidget {
  CompanyDetailsData companyDetailsData;
  ManualRetrieveEstimationDetails estimationDetails;
  List<ManualRetrieveParticularDetails> items;

  MannualEstimationPrintout(
      {super.key,
      required this.companyDetailsData,
      required this.estimationDetails,
      required this.items});

  @override
  State<MannualEstimationPrintout> createState() => _MannualEstimationPrintoutState();
}

class _MannualEstimationPrintoutState extends State<MannualEstimationPrintout> {
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
                    'Rough Manual Estimation',
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
                    ManualRetrieveParticularDetails item = widget.items[index];
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
                              ManualEstimationStoneDetails stoneItem =
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
                              ManualEstimationDiamondDetails diamondItem =
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
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.items[0].stoneAmount);
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
                        "Gold Rate: ${widget.estimationDetails.displayRate?.gold ?? ""}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Silver Rate: ${widget.estimationDetails.displayRate?.silver ?? ""}",
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
                  ManualRetrieveParticularDetails item = widget.items[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.sNo}: ${item.itemDetailsName?? ""}",
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
                            item.wastageGram == null ?  "" : item.wastageGram!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.makingChargePerGram == null ?  "" : item.makingChargePerGram!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.stoneAmount == null ?  "" : item.stoneAmount!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            item.totalAmount == null ?  "" : item.totalAmount!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: item.stoneDetails == null ? 0 : item.stoneDetails!.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          ManualEstimationStoneDetails stoneItem =
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
                          ManualEstimationDiamondDetails diamondItem =
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
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
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
              ),
              SizedBox(
                height: 5,
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
                    widget.estimationDetails.estimationId ?? "",
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
