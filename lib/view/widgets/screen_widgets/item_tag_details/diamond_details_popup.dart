import 'package:ausales_application/controller/item_tag_details/item_tag_details_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagDiamondDetailsPopup extends StatefulWidget {
  @override
  State<TagDiamondDetailsPopup> createState() => _TagDiamondDetailsPopupState();
}

class _TagDiamondDetailsPopupState extends State<TagDiamondDetailsPopup> {
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
            "Diamond Details",
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
                    width: Responsive.isDesktop(context) ? size.width : null,
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
                                  'Diamond Name',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150.w,
                                child: Text(
                                  'Diamond Pieces',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150.w,
                                child: Text(
                                  'Diamond Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150.w,
                                child: Text(
                                  'Diamond Weight',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                          ],
                          rows: _tagDetailsFormController
                              .tableData.value.diamondDetails!.map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.diamondName.toString())),
                              DataCell(Text(item.diamondPieces.toString())),
                              DataCell(Text(item.diamondAmount.toString())),
                              DataCell(Text(item.diamondWeight.toString())),
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
    )  : AlertDialog.adaptive(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Diamond Details",
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
                  child: Text(" No Diamond Details"),
                ),
              ),
            ),
          );
  }
}
