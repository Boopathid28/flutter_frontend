import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../model/reports/vendor_metal_wise_sales_report_models.dart';

class VendorMetalWiseSalesReportPopup extends StatefulWidget {
  final List<Data> list;
  const VendorMetalWiseSalesReportPopup({super.key, required this.list});

  @override
  State<VendorMetalWiseSalesReportPopup> createState() =>
      _VendorMetalWiseSalesReportPopupState();
}

class _VendorMetalWiseSalesReportPopupState
    extends State<VendorMetalWiseSalesReportPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Details',style: TextPalette.screenTitle,),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: const Icon(Icons.close)),
              ],
            ),
            SizedBox(height: 15.w,),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
                    columns: [
                      // DataColumn(
                      //   label: Expanded(
                      //     child: SizedBox(
                      //       width: 75.w,
                      //       child: Text(
                      //         'No',
                      //         style: TextPalette.tableHeaderTextStyle,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      DataColumn(
                        label: SizedBox(
                          width: 200.w,
                          child: Text(
                            'Metal name',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 200.w,
                          child: Text(
                            'Total pieces',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 200.w,
                          child: Text(
                            'Total gross weight',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 200.w,
                          child: Text(
                            'Total amount',
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                        ),
                      ),
                    ],
                    rows: widget.list.map((item) {
                      return DataRow(cells: [
                        // DataCell(SizedBox(
                        //   child: Text(
                        //     '${1}',
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black,
                        //       fontSize: 13.sp,
                        //     ),
                        //   ),
                        // )),
                        DataCell(SizedBox(
                          child: Text(
                            item.metalName ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorPalete.primaryColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        )),
                        DataCell(SizedBox(
                          child: Text(
                            item.totalPieces.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorPalete.primaryColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        )),
                        DataCell(SizedBox(
                          child: Text(
                            item.totalGrossweight.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorPalete.primaryColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        )),
                        DataCell(SizedBox(
                          child: Text(
                            item.totalAmount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorPalete.primaryColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        )),
                      ]);
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
