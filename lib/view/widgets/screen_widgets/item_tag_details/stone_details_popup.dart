import 'dart:developer';

import 'package:ausales_application/controller/item_tag_details/item_tag_details_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagStoneDetailsPopup extends StatefulWidget {
  @override
  State<TagStoneDetailsPopup> createState() => _TagStoneDetailsPopupState();
}

class _TagStoneDetailsPopupState extends State<TagStoneDetailsPopup> {
  final TagDetailsFormController _tagDetailsFormController =
      Get.put(TagDetailsFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return _tagDetailsFormController.tableData.value.stoneDetails?.length != null
        ? AlertDialog.adaptive(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stone Details",
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
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width:
                              Responsive.isDesktop(context) ? size.width : null,
                          child: Obx(() => DataTable(
                                headingRowColor:
                                    WidgetStateProperty.resolveWith<Color?>(
                                        (Set<WidgetState> states) =>
                                            ColorPalete.tableHeaderBgColor),
                                columns: [
                                  DataColumn(
                                    label: SizedBox(
                                      width: 150.w,
                                      child: Text(
                                        'Stone Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                     width: 150.w,
                                      child: Text(
                                        'Stone Pieces',
                                        style: TextPalette.tableHeaderTextStyle,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                     width: 150.w,
                                      child: Text(
                                        'Stone Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                     width: 150.w,
                                      child: Text(
                                        'Stone Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: _tagDetailsFormController
                                    .tableData.value.stoneDetails!
                                    .map((item) {
                                  return DataRow(cells: [
                                    DataCell(Text(item.stoneName.toString())),
                                    DataCell(Text(item.stonePieces.toString())),
                                    DataCell(Text(item.stoneAmount.toString())),
                                    DataCell(Text(item.stoneWeight.toString())),
                                  ]);
                                }).toList(),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : AlertDialog.adaptive(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stone Details",
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
              width: size.width,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Text(" No Stone Details"),
                ),
              ),
            ),
          );
  }
}
