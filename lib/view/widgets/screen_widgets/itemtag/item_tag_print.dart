import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/itemtag/itemtag_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

class ItemTagPrint extends StatefulWidget {
  List<TagItemDetailsResponse> itemTagList;
  ItemTagPrint({super.key, required this.itemTagList});

  @override
  State<ItemTagPrint> createState() => _ItemTagPrintState();
}

class _ItemTagPrintState extends State<ItemTagPrint> {
  final barcode = Barcode.code128(); // Choose the barcode type
  Future<List<String>> _generateBarcodeSvgs(
      List<TagItemDetailsResponse> dataList) async {
    final barcode = Barcode.code128(); // Choose the barcode type

    // Generate SVG data for each barcode
    return dataList.map((data) {
      return barcode.toSvg(
        data.tagNumber!,
        width: 200,
        height: 35,
        drawText: false, // Set to true if you want text below the barcode
      );
    }).toList();
  }

  // Future<Uint8List> _convertSvgToPng(String svg, double width, double height) async {
  //   final picture = await ui.instantiateImageCodec(
  //     Uint8List.fromList(svg.codeUnits),
  //     targetWidth: width.toInt(),
  //     targetHeight: height.toInt(),
  //   );
  //   final frameInfo = await picture.getNextFrame();
  //   final byteData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  //   return byteData!.buffer.asUint8List();
  // }

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();
 
    final images = await _generateBarcodeSvgs(widget.itemTagList);
    for (var i = 0; i < widget.itemTagList.length; i++) {
      TagItemDetailsResponse item = widget.itemTagList[i];
      pdf.addPage(pw.Page(
        
          margin: pw.EdgeInsets.only(left: 40 , top: 3), 
          pageFormat: PdfPageFormat(226, 75),
          build: (pw.Context context) {
          return pw.Container(
                  width: 200,
                  child: pw.Row(
                  children: [
                    pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 60,
                          height: 55,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Text(
                                        "WT :",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 5),
                                      ),
                                      pw.Text(
                                        '${item.netWeight}',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 5),
                                      ),
                                    ],
                                  ),
                                  pw.Row(
                                    children: [
                                      pw.Text(
                                        'VA :',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 5),
                                      ),
                                      pw.Text(
                                        '${item.wastagePercent}% - ',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 5),
                                      ),
                                      pw.Text(
                                        '${item.wastagePercent} ',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 5),
                                      ),
                                      pw.Text(
                                        'M:${item.makingChargePerGram}',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                               pw.SvgImage(svg: images[i] , width: 30.0 , height: 10.0),
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      width: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 45,
                          height: 55,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    '${item.tagNumber}',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 5),
                                  ),
                                  pw.Text(
                                    '${item.subItemDetailsName}',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 5),
                                  ),
                                ],
                              ),
                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                               pw.SvgImage(svg: images[i] , width: 30.0 , height: 10.0),
                              ])
                            ],
                          ),
                        ),
                        pw.SizedBox(
                          width: 1,
                        ),
                        pw.SizedBox(
                          width: 45,
                          height: 55,
                          child: pw.Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'SRJ',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, fontSize: 5),
                              ),
                              pw.Text(
                                '${item.designerName}',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, fontSize: 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                );
        }));
    }
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
            'Tag Print',
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
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.builder(
            itemCount: widget.itemTagList.length,
            itemBuilder: (context, index) {
              TagItemDetailsResponse item = widget.itemTagList[index];
              return Container(
                width: 226,
                child: Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                          height: 55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "WT :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 6),
                                      ),
                                      Text(
                                        '${item.netWeight}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'VA :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 6),
                                      ),
                                      Text(
                                        '${item.wastagePercent}% - ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 6),
                                      ),
                                      Text(
                                        '${item.wastagePercent} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 6),
                                      ),
                                      Text(
                                        'M:${item.makingChargePerGram}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 6),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.string(barcode.toSvg(
                                      item.tagNumber.toString(),
                                      width: 30,
                                      height: 10,
                                      drawText: false)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item.tagNumber}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8),
                                  ),
                                  Text(
                                    '${item.subItemDetailsName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 6),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.string(barcode.toSvg(
                                      item.tagNumber.toString(),
                                      width: 30,
                                      height: 10,
                                      drawText: false)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: 50,
                          height: 55,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SRJ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 8),
                              ),
                              Text(
                                '${item.designerName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
      actions: [
        PrimaryButton(
            btnWidth: double.infinity,
            btnHeight: 35,
            isLoading: false,
            text: 'Print',
            onPressed: () {
              printPdf();
            })
      ],
    );
  }
}
