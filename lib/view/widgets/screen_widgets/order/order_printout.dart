import 'dart:typed_data';

import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/order/order_view_details_models.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class OrderPrintout extends StatefulWidget {
  CompanyDetailsData companyDetailsData;
  RetrieveOrderDetails orderDetails;
  List<ItemDetails> items;

  OrderPrintout(
      {super.key,
      required this.companyDetailsData,
      required this.orderDetails,
      required this.items});

  @override
  State<OrderPrintout> createState() => _OrderPrintoutState();
}

class _OrderPrintoutState extends State<OrderPrintout> {
  // Future<Uint8List> fetchNetworkImage(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     return response.bodyBytes;
  //   } else {
  //     throw Exception('Failed to load network image');
  //   }
  // }

  List<String> conclusionList = [
    "** Goods Delivered At Our Premises **",
    "** The Product With Us **"
  ];
  String conclusion = "** Goods Delivered At Our Premises **";

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
                        "${widget.orderDetails.metalName} Order",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Row(
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
                                        "${widget.orderDetails.customerName}",
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
                                        "${widget.orderDetails.customerPhone}",
                                        style: pw.TextStyle(
                                            fontSize: 9,
                                            fontWeight: pw.FontWeight.bold))
                                  ],
                                ),
                                pw.SizedBox(
                                  child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        'Address : ',
                                        style: pw.TextStyle(
                                            fontSize: 8,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.SizedBox(
                                        width: 300,
                                        child: pw.Text(
                                          "${widget.orderDetails.customerAddress}",
                                          style: pw.TextStyle(
                                              fontSize: 8,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                children: [
                                  pw.Text(
                                    'Gold Rate : ${widget.orderDetails.displayRate!.gold}',
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    'Silver Rate : ${widget.orderDetails.displayRate!.silver}',
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    'Date : ${widget.orderDetails.createdAt!.split('T')[0]}',
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                'Due Date : ${widget.orderDetails.dueDate!.split('T')[0]}',
                                style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          )
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
                    pw.Text("Pc", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Wt", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Wst", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("M.C", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Stn", style: pw.TextStyle(fontSize: 9)),
                    pw.Text("Amount", style: pw.TextStyle(fontSize: 9)),
                  ],
                  data: widget.items!.map((item) {
                    return [
                      pw.Text("${item.id ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.itemDetailsName ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.pieces ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.netWeight.toString()}",
                          style: pw.TextStyle(fontSize: 9)),
                          pw.Text("${item.wastagePercent ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                          pw.Text("${item.makingCharge ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                          pw.Text( "${item.totalStoneAmount ?? ""}",
                          style: pw.TextStyle(fontSize: 9)),
                      pw.Text("${item.totalAmount ?? ""}",
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
                              'CGST %',
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              '${(widget.orderDetails.gstAmount! / 2)}',
                              style: pw.TextStyle(
                                fontSize: 9,
                              ),
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
                              'SGST %',
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              '${(widget.orderDetails.gstAmount! / 2)}',
                              style: pw.TextStyle(
                                fontSize: 9,
                              ),
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
                              'Nett',
                              style: pw.TextStyle(
                                  fontSize: 9, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              '${widget.orderDetails.payableAmount}',
                              style: pw.TextStyle(
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  height: 2.h,
                ),
                widget.orderDetails.exchangeDetails!.isEmpty
                    ? pw.SizedBox()
                    : pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'OLD GOLD PURCHASE-Bill',
                          style: pw.TextStyle(
                              fontSize: 9, fontWeight: pw.FontWeight.bold),
                        )),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    widget.orderDetails.exchangeDetails!.isEmpty
                        ? pw.SizedBox()
                        : pw.Container(
                            width: 250,
                            height: 150,
                            child: pw.ListView.separated(
                              itemCount:
                                  widget.orderDetails.exchangeDetails!.length,
                              separatorBuilder: (context, index) => pw.SizedBox(
                                height: 5,
                              ),
                              itemBuilder: (context, index) {
                                var detail =
                                    widget.orderDetails.exchangeDetails![index];
                                return pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      detail.oldBillNumber!,
                                      style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(
                                      child: pw.TableHelper.fromTextArray(
                                          cellStyle: pw.TextStyle(fontSize: 7),
                                          border: pw.TableBorder(
                                            top: pw.BorderSide(
                                                color: PdfColors.black),
                                            bottom: pw.BorderSide(
                                                color: PdfColors.black),
                                            horizontalInside: pw.BorderSide(
                                                color: PdfColors.black),
                                          ),
                                          cellAlignment: pw.Alignment.center,
                                          headers: [
                                            pw.Text("Item",
                                                style:
                                                    pw.TextStyle(fontSize: 9)),
                                            pw.Text("Wt",
                                                style:
                                                    pw.TextStyle(fontSize: 9)),
                                            pw.Text("Dust",
                                                style:
                                                    pw.TextStyle(fontSize: 9)),
                                            pw.Text("Wst",
                                                style:
                                                    pw.TextStyle(fontSize: 9)),
                                            pw.Text("Rate",
                                                style:
                                                    pw.TextStyle(fontSize: 9)),
                                            pw.Text("+/-",
                                                style:
                                                    pw.TextStyle(fontSize: 9)),
                                            pw.Text("Amount",
                                                style:
                                                    pw.TextStyle(fontSize: 9)),
                                          ],
                                          data: detail.particularList!
                                              .map((item) {
                                            return [
                                              pw.Text(
                                                  "${item.itemName.toString()}",
                                                  style: pw.TextStyle(
                                                      fontSize: 9)),
                                              pw.Text(
                                                  "${item.oldGrossWeight.toString()}",
                                                  style: pw.TextStyle(
                                                      fontSize: 9)),
                                              pw.Text(
                                                  "${item.oldDustWeight.toString()}",
                                                  style: pw.TextStyle(
                                                      fontSize: 9)),
                                              0,
                                              pw.Text(
                                                  "${item.oldRate.toString()}",
                                                  style: pw.TextStyle(
                                                      fontSize: 9)),
                                              0,
                                              pw.Text(
                                                  "${item.totalAmount.toString()}",
                                                  style: pw.TextStyle(
                                                      fontSize: 9)),
                                            ];
                                          }).toList()),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                    pw.Column(
                      children: [
                        pw.SizedBox(
                          width: 350,
                          child: pw.Column(
                            children: [
                              pw.Padding(
                                padding:
                                    widget.orderDetails.exchangeDetails!.isEmpty
                                        ? pw.EdgeInsets.only(right: 10)
                                        : pw.EdgeInsets.only(right: 60),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [
                                    widget.orderDetails.totalExchangeAmount
                                                    .toString()
                                                    .split(".")[0] ==
                                                "0" ||
                                            widget.orderDetails
                                                    .totalExchangeAmount ==
                                                null
                                        ? pw.SizedBox()
                                        : pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.SizedBox(
                                              height: 25,
                                              width: 145,
                                              child: pw.Row(
                                                mainAxisSize:
                                                    pw.MainAxisSize.min,
                                                mainAxisAlignment: pw
                                                    .MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  pw.Text(
                                                    "Exchange",
                                                    style: pw.TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
                                                  pw.SizedBox(
                                                    width: 32,
                                                  ),
                                                  pw.Text(
                                                    (widget.orderDetails
                                                                .totalExchangeAmount
                                                                ?.toStringAsFixed(
                                                                    2) ??
                                                            "0.0")
                                                        .toString(),
                                                    style: pw.TextStyle(
                                                        fontSize: 9),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    widget.orderDetails.totalAdvanceAmount
                                                    .toString()
                                                    .split(".")[0] ==
                                                "0" ||
                                            widget.orderDetails
                                                    .totalAdvanceAmount ==
                                                null
                                        ? pw.SizedBox()
                                        : pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.SizedBox(
                                              height: 25,
                                              width: 145,
                                              child: pw.Row(
                                                mainAxisSize:
                                                    pw.MainAxisSize.min,
                                                mainAxisAlignment: pw
                                                    .MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  pw.Text(
                                                    "Advance",
                                                    style: pw.TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
                                                  pw.SizedBox(
                                                    width: 32,
                                                  ),
                                                  pw.Text(
                                                    (widget.orderDetails
                                                                .totalAdvanceAmount
                                                                ?.toStringAsFixed(
                                                                    2) ??
                                                            "0.0")
                                                        .toString(),
                                                    style: pw.TextStyle(
                                                        fontSize: 9),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    widget.orderDetails.totalChitAmount
                                                    .toString()
                                                    .split(".")[0] ==
                                                "0" ||
                                            widget.orderDetails
                                                    .totalChitAmount ==
                                                null
                                        ? pw.SizedBox()
                                        : pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.SizedBox(
                                              height: 25,
                                              width: 145,
                                              child: pw.Row(
                                                mainAxisSize:
                                                    pw.MainAxisSize.min,
                                                mainAxisAlignment: pw
                                                    .MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  pw.Text(
                                                    "Chit",
                                                    style: pw.TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
                                                  pw.SizedBox(
                                                    width: 32,
                                                  ),
                                                  pw.Text(
                                                    (widget.orderDetails
                                                                .totalChitAmount
                                                                ?.toStringAsFixed(
                                                                    2) ??
                                                            "0.0")
                                                        .toString(),
                                                    style: pw.TextStyle(
                                                        fontSize: 9),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    widget.orderDetails.balanceAmount
                                                    .toString()
                                                    .split(".")[0] ==
                                                "0" ||
                                            widget.orderDetails.balanceAmount ==
                                                null
                                        ? pw.SizedBox()
                                        : pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.SizedBox(
                                              height: 25,
                                              width: 145,
                                              child: pw.Row(
                                                mainAxisSize:
                                                    pw.MainAxisSize.min,
                                                mainAxisAlignment: pw
                                                    .MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  pw.Text(
                                                    "Balance",
                                                    style: pw.TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
                                                  pw.SizedBox(
                                                    width: 32,
                                                  ),
                                                  pw.Text(
                                                    (widget.orderDetails
                                                                .balanceAmount
                                                                ?.toStringAsFixed(
                                                                    2) ??
                                                            "0.0")
                                                        .toString(),
                                                    style: pw.TextStyle(
                                                        fontSize: 9),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    // pw.SizedBox(
                    //   width: 300,
                    //   child: pw.Column(
                    //     children: [
                    //       widget.orderDetails.totalAmount
                    //                       .toString()
                    //                       .split(".")[0] ==
                    //                   "0" ||
                    //               widget.orderDetails.totalAdvanceAmount ==
                    //                   null
                    //           ? pw.SizedBox()
                    //           : pw.Padding(
                    //               padding:
                    //                   pw.EdgeInsets.symmetric(horizontal: 10),
                    //               child: pw.Row(
                    //                 mainAxisAlignment: pw.MainAxisAlignment.end,
                    //                 children: [
                    //                   pw.SizedBox(
                    //                     width: 140,
                    //                     child: pw.Row(
                    //                       mainAxisAlignment:
                    //                           pw.MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         pw.Text(
                    //                           'Advance',
                    //                           style: pw.TextStyle(
                    //                               fontSize: 9,
                    //                               fontWeight:
                    //                                   pw.FontWeight.bold),
                    //                         ),
                    //                         pw.Text(
                    //                           '${widget.orderDetails.totalAdvanceAmount ?? "0.0"}',
                    //                           style: pw.TextStyle(
                    //                             fontSize: 9,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //       widget.orderDetails.TotalChitAmount
                    //                       .toString()
                    //                       .split(".")[0] ==
                    //                   "0" ||
                    //               widget.orderDetails.TotalChitAmount == null
                    //           ? pw.SizedBox()
                    //           : pw.Padding(
                    //               padding:
                    //                   pw.EdgeInsets.symmetric(horizontal: 10),
                    //               child: pw.Row(
                    //                 mainAxisAlignment: pw.MainAxisAlignment.end,
                    //                 children: [
                    //                   pw.SizedBox(
                    //                     width: 140,
                    //                     child: pw.Row(
                    //                       mainAxisAlignment:
                    //                           pw.MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         pw.Text(
                    //                           'Chit',
                    //                           style: pw.TextStyle(
                    //                               fontSize: 9,
                    //                               fontWeight:
                    //                                   pw.FontWeight.bold),
                    //                         ),
                    //                         pw.Text(
                    //                           '${widget.orderDetails.TotalChitAmount ?? "0.0"}',
                    //                           style: pw.TextStyle(
                    //                             fontSize: 9,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),

                    //       pw.Padding(
                    //         padding: pw.EdgeInsets.symmetric(horizontal: 10),
                    //         child: pw.Row(
                    //           mainAxisAlignment: pw.MainAxisAlignment.end,
                    //           children: [
                    //             pw.SizedBox(
                    //               width: 140,
                    //               child: pw.Row(
                    //                 mainAxisAlignment:
                    //                     pw.MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   pw.Text(
                    //                     'Old Gold Purch',
                    //                     style: pw.TextStyle(
                    //                         fontSize: 9,
                    //                         fontWeight: pw.FontWeight.bold),
                    //                   ),
                    //                   pw.Text(
                    //                     '${widget.orderDetails.totalExchangeAmount ?? "0.0"}',
                    //                     style: pw.TextStyle(
                    //                       fontSize: 9,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       // pw.Padding(
                    //       //   padding: pw.EdgeInsets.symmetric(horizontal: 10),
                    //       //   child: pw.Row(
                    //       //     mainAxisAlignment: pw.MainAxisAlignment.end,
                    //       //     children: [
                    //       //       pw.SizedBox(
                    //       //         width: 140,
                    //       //         child: pw.Row(
                    //       //           mainAxisAlignment:
                    //       //               pw.MainAxisAlignment.spaceBetween,
                    //       //           children: [
                    //       //             pw.Text(
                    //       //               'Nett',
                    //       //               style: pw.TextStyle(
                    //       //                   fontSize: 9,
                    //       //                   fontWeight: pw.FontWeight.bold),
                    //       //             ),
                    //       //             pw.Text(
                    //       //               '${((widget.orderDetails.payableAmount ?? 0.0) - (widget.orderDetails.totalExchangeAmount ?? 0.0) - (widget.orderDetails.totalAdvanceAmount ?? 0.0) - (widget.orderDetails.TotalChitAmount ?? 0.0) - (widget.orderDetails.roundoffAmount ?? 0.0)).toStringAsFixed(2)}',
                    //       //               style: pw.TextStyle(
                    //       //                 fontSize: 9,
                    //       //               ),
                    //       //             ),
                    //       //           ],
                    //       //         ),
                    //       //       ),
                    //       //     ],
                    //       //   ),
                    //       // ),
                    //       pw.Padding(
                    //         padding: pw.EdgeInsets.symmetric(horizontal: 10),
                    //         child: pw.Row(
                    //           mainAxisAlignment: pw.MainAxisAlignment.end,
                    //           children: [
                    //             pw.SizedBox(
                    //               width: 140,
                    //               child: pw.Row(
                    //                 mainAxisAlignment:
                    //                     pw.MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   pw.Text(
                    //                     'Balance',
                    //                     style: pw.TextStyle(
                    //                         fontSize: 9,
                    //                         fontWeight: pw.FontWeight.bold),
                    //                   ),
                    //                   pw.Text(
                    //                     '${widget.orderDetails.balanceAmount?.toStringAsFixed(2)}',
                    //                     style: pw.TextStyle(
                    //                       fontSize: 9,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       pw.SizedBox(height: 8),
                    //       pw.Padding(
                    //         padding: pw.EdgeInsets.only(right: 10),
                    //         child: pw.Row(
                    //           mainAxisAlignment: pw.MainAxisAlignment.end,
                    //           children: [
                    //             pw.Wrap(spacing: 2, runSpacing: 2, children: [
                    //               widget.orderDetails.TotalBankAmount
                    //                               .toString()
                    //                               .split(".")[0] ==
                    //                           "0" ||
                    //                       widget.orderDetails
                    //                               .TotalBankAmount ==
                    //                           null
                    //                   ? pw.SizedBox()
                    //                   : pw.Row(
                    //                       children: [
                    //                         pw.Text("Bank",
                    //                             style: pw.TextStyle(
                    //                                 fontSize: 9,
                    //                                 fontWeight:
                    //                                     pw.FontWeight.bold)),
                    //                         pw.SizedBox(width: 4),
                    //                         pw.Text(
                    //                             "${widget.orderDetails.TotalBankAmount ?? "0.0"}",
                    //                             style:
                    //                                 pw.TextStyle(fontSize: 9)),
                    //                       ],
                    //                     ),
                    //               widget.orderDetails.TotalCardAmount
                    //                               .toString()
                    //                               .split(".")[0] ==
                    //                           "0" ||
                    //                       widget.orderDetails
                    //                               .TotalCardAmount ==
                    //                           null
                    //                   ? pw.SizedBox()
                    //                   : pw.Row(
                    //                       children: [
                    //                         pw.Text("Card",
                    //                             style: pw.TextStyle(
                    //                                 fontSize: 9,
                    //                                 fontWeight:
                    //                                     pw.FontWeight.bold)),
                    //                         pw.SizedBox(width: 4),
                    //                         pw.Text(
                    //                             "${widget.orderDetails.TotalCardAmount ?? "0.0"}",
                    //                             style:
                    //                                 pw.TextStyle(fontSize: 9)),
                    //                       ],
                    //                     ),
                    //               widget.orderDetails.TotalCashAmount
                    //                               .toString()
                    //                               .split(".")[0] ==
                    //                           "0" ||
                    //                       widget.orderDetails
                    //                               .TotalCashAmount ==
                    //                           null
                    //                   ? pw.SizedBox()
                    //                   : pw.Row(
                    //                       children: [
                    //                         pw.Text("Cash",
                    //                             style: pw.TextStyle(
                    //                                 fontSize: 9,
                    //                                 fontWeight:
                    //                                     pw.FontWeight.bold)),
                    //                         pw.SizedBox(width: 4),
                    //                         pw.Text(
                    //                             "${widget.orderDetails.TotalCashAmount ?? "0.0"}",
                    //                             style:
                    //                                 pw.TextStyle(fontSize: 9)),
                    //                       ],
                    //                     ),
                    //               widget.orderDetails.TotalUpiAmount
                    //                               .toString()
                    //                               .split(".")[0] ==
                    //                           "0" ||
                    //                       widget.orderDetails
                    //                               .TotalUpiAmount ==
                    //                           null
                    //                   ? pw.SizedBox()
                    //                   : pw.Row(
                    //                       children: [
                    //                         pw.Text("Upi",
                    //                             style: pw.TextStyle(
                    //                                 fontSize: 9,
                    //                                 fontWeight:
                    //                                     pw.FontWeight.bold)),
                    //                         pw.SizedBox(width: 4),
                    //                         pw.Text(
                    //                             "${widget.orderDetails.TotalUpiAmount ?? "0.0"}",
                    //                             style:
                    //                                 pw.TextStyle(fontSize: 9)),
                    //                       ],
                    //                     ),
                    //               widget.orderDetails.totalAdvanceAmount
                    //                               .toString()
                    //                               .split(".")[0] ==
                    //                           "0" ||
                    //                       widget.orderDetails
                    //                               .totalAdvanceAmount ==
                    //                           null
                    //                   ? pw.SizedBox()
                    //                   : pw.Row(
                    //                       children: [
                    //                         pw.Text(
                    //                           "Advance",
                    //                           style: pw.TextStyle(
                    //                               fontSize: 9,
                    //                               fontWeight:
                    //                                   pw.FontWeight.bold),
                    //                         ),
                    //                         pw.SizedBox(width: 4),
                    //                         pw.Text(
                    //                           "${widget.orderDetails.totalAdvanceAmount ?? "0.0"}",
                    //                           style: pw.TextStyle(fontSize: 9),
                    //                         ),
                    //                       ],
                    //                     ),
                    //               widget.orderDetails.TotalChitAmount
                    //                               .toString()
                    //                               .split(".")[0] ==
                    //                           "0" ||
                    //                       widget.orderDetails
                    //                               .TotalChitAmount ==
                    //                           null
                    //                   ? pw.SizedBox()
                    //                   : pw.Row(
                    //                       children: [
                    //                         pw.Text(
                    //                           "Chit",
                    //                           style: pw.TextStyle(
                    //                               fontSize: 9,
                    //                               fontWeight:
                    //                                   pw.FontWeight.bold),
                    //                         ),
                    //                         pw.SizedBox(width: 4),
                    //                         pw.Text(
                    //                           "${widget.orderDetails.TotalChitAmount ?? "0.0"}",
                    //                           style: pw.TextStyle(fontSize: 9),
                    //                         ),
                    //                       ],
                    //                     ),
                    //             ])
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
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
            'Order',
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
                      "${widget.orderDetails.metalName} Order",
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
                              Text("${widget.orderDetails.customerName}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text("${widget.orderDetails.orderId}",
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
                              Text("${widget.orderDetails.customerPhone}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(
                              "Address: ${widget.orderDetails.customerAddress}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Gold Rate : ${widget.orderDetails.displayRate!.gold}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Silver Rate : ${widget.orderDetails.displayRate!.silver}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Date : ${widget.orderDetails.createdAt!.split('T')[0]}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            'Due Date : ${widget.orderDetails.dueDate!.split('T')[0]}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
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
                                  "Wst.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "M.C.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Stn",
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
                                      item.id == null ? "" : item.id.toString(),
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
                                      (item.pieces.toString()),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      (item.netWeight != null
                                          ? "${item.netWeight} g"
                                          : ""),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.wastagePercent ?? ""}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.makingCharge ?? ""}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${item.totalStoneAmount ?? ""}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "₹ ${item.totalAmount.toString()}",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ]);
                              }).toList()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              gstAndAmount(
                                label: 'CGST 1.5%',
                                value: (widget.orderDetails.gstAmount! / 2)
                                    .toString(),
                              ),
                              gstAndAmount(
                                label: 'SGST 1.5%',
                                value: (widget.orderDetails.gstAmount! / 2)
                                    .toString(),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 75.w,
                                  child: Divider(
                                    thickness: 0.5,
                                    height: 1,
                                    color:
                                        ColorPalete.filledInputPlaceholderColor,
                                  ),
                                ),
                              ),
                              gstAndAmount(
                                label: 'Nett',
                                value: (widget.orderDetails.payableAmount)
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
              SizedBox(
                height: 16.h,
              ),
              widget.orderDetails.exchangeDetails == null ||
                      widget.orderDetails.exchangeDetails!.isEmpty
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'OLD GOLD PURCHASE-Bill',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.orderDetails.exchangeDetails == null ||
                          widget.orderDetails.exchangeDetails!.isEmpty
                      ? SizedBox()
                      : Container(
                          width: 400,
                          height: 200,
                          child: ListView.separated(
                            itemCount: widget.orderDetails.exchangeDetails !=
                                    null
                                ? widget.orderDetails.exchangeDetails!.length
                                : 0,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                            itemBuilder: (context, index) {
                              var detail =
                                  widget.orderDetails.exchangeDetails![index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.oldBillNumber!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: DataTable(
                                        columnSpacing: 0,
                                        border: TableBorder(
                                            top: BorderSide(
                                              color: Colors.black,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ),
                                            horizontalInside: BorderSide(
                                                color: Colors.black)),
                                        headingRowHeight: 40,
                                        dataRowHeight: 40,
                                        columns: const [
                                          DataColumn(
                                              label: Text(
                                            "Item",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Wt",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Dust\nWgt",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Wst",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Rate",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "+/-",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Total\nAmount",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ],
                                        rows: detail.particularList == null
                                            ? []
                                            : detail.particularList!
                                                .map((item) {
                                                return DataRow(cells: [
                                                  DataCell(
                                                    Text(
                                                      item.itemName ?? "",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      item.oldGrossWeight!
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      "${item.oldDustWeight.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      "0",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      "${item.oldRate.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      "₹ ${item.totalAmount.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  )
                                                ]);
                                              }).toList()),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                  Column(
                    children: [
                      SizedBox(
                        width: 350,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  widget.orderDetails.totalExchangeAmount
                                                  .toString()
                                                  .split(".")[0] ==
                                              "0" ||
                                          widget.orderDetails
                                                  .totalExchangeAmount ==
                                              null
                                      ? SizedBox()
                                      : gstAndAmount(
                                          label: 'Exchange',
                                          value: (widget.orderDetails
                                                      .totalExchangeAmount
                                                      ?.toStringAsFixed(2) ??
                                                  "0.0")
                                              .toString(),
                                        ),
                                  widget.orderDetails.totalAdvanceAmount
                                                  .toString()
                                                  .split(".")[0] ==
                                              "0" ||
                                          widget.orderDetails
                                                  .totalAdvanceAmount ==
                                              null
                                      ? SizedBox()
                                      : gstAndAmount(
                                          label: 'Advance',
                                          value: (widget.orderDetails
                                                      .totalAdvanceAmount
                                                      ?.toStringAsFixed(2) ??
                                                  "0.0")
                                              .toString(),
                                        ),
                                  widget.orderDetails.totalChitAmount
                                                  .toString()
                                                  .split(".")[0] ==
                                              "0" ||
                                          widget.orderDetails.totalChitAmount ==
                                              null
                                      ? SizedBox()
                                      : gstAndAmount(
                                          label: 'Chit',
                                          value: (widget.orderDetails
                                                      .totalChitAmount
                                                      ?.toStringAsFixed(2) ??
                                                  "0.0")
                                              .toString(),
                                        ),
                                  widget.orderDetails.balanceAmount
                                                  .toString()
                                                  .split(".")[0] ==
                                              "0" ||
                                          widget.orderDetails.balanceAmount ==
                                              null
                                      ? SizedBox()
                                      : gstAndAmount(
                                          label: 'Balance',
                                          value: (widget.orderDetails
                                                      .balanceAmount
                                                      ?.toStringAsFixed(2) ??
                                                  "0.0")
                                              .toString(),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2,
              ),
              // ListView.separated(
              //   shrinkWrap: true,
              //   itemCount: conclusionList.length,
              //   separatorBuilder: (context, index) => SizedBox(height: 5,),
              //   itemBuilder: (context, index) {
              //     return Center(
              //       child: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             conclusion = conclusionList[index];
              //           });
              //         },
              //         child: Text(conclusionList[index], style: TextStyle(fontSize: 14, color: conclusion == conclusionList[index] ? Colors.green : Colors.grey),)),
              //     );
              //   },
              // )
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
