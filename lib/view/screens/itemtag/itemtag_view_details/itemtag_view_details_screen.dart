import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_particulars_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_view_details/itemtag_view_details_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/item_tag_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ItemtagViewDetailsScreen extends StatefulWidget {
  const ItemtagViewDetailsScreen({super.key});

  @override
  State<ItemtagViewDetailsScreen> createState() =>
      _ItemtagViewDetailsScreenState();
}

class _ItemtagViewDetailsScreenState extends State<ItemtagViewDetailsScreen> {
  final ItemtagViewDetailsController _itemtagViewDetailsController =
      Get.put(ItemtagViewDetailsController());

  @override
  void initState() {
    super.initState();
    _itemtagViewDetailsController.getItemTagList(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _itemtagViewDetailsController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _itemtagViewDetailsController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "View Item Tag",
                            style: TextPalette.screenTitle,
                          ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      btnWidth: 150.w,
                      isLoading: false,
                      text: 'Print All',
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => ItemTagPrint(
                                itemTagList: _itemtagViewDetailsController
                                    .itemTagList.value));
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              Wrap(
                spacing: 50.w,
                runSpacing: 15.h,
                children: [
                  Column(
                    children: [
                      Text(
                        "Total Tag Count",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => Text(
                            _itemtagViewDetailsController.totalTagCount.value,
                            style: TextPalette.tableDataTextStyle,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Total Pieces",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => Text(
                            "${_itemtagViewDetailsController.totalPieces.value} Pcs",
                            style: TextPalette.tableDataTextStyle,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Total Gross Weight",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => Text(
                            "${_itemtagViewDetailsController.totalGrossWeight.value} g",
                            style: TextPalette.tableDataTextStyle,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Remaining Tag Count",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => Text(
                            _itemtagViewDetailsController
                                .remainingTagCount.value,
                            style: TextPalette.tableDataTextStyle,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Remaining Pieces",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => Text(
                            "${_itemtagViewDetailsController.remainingPieces.value} Pcs",
                            style: TextPalette.tableDataTextStyle,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Remaining Gross Weight",
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => Text(
                            "${_itemtagViewDetailsController.remainingGrossWeight.value} g",
                            style: TextPalette.tableDataTextStyle,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: size.width * 0.98,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => DataTable(
                        headingRowColor:
                            WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) =>
                                    ColorPalete.tableHeaderBgColor),
                        columns: [
                          DataColumn(
                            label: SizedBox(
                              width: 100.w,
                              child: Text(
                                'Action',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Tag Number',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'HUID',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Sub Item',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Gross Wgt',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Reduce Wgt',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Net Wgt',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Pieces',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Stone Pcs',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Stone Wgt',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Diamond Pcs',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150.w,
                              child: Text(
                                'Diamond Wgt',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                        ],
                        rows: _itemtagViewDetailsController.itemTagList.value
                            .map((item) {
                          return DataRow(cells: [
                            DataCell(Row(
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => ItemTagPrint(
                                              itemTagList: [item]));
                                    },
                                    child: Icon(Icons.print)),
                              ],
                            )),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(
                                  item.tagNumber.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorPalete.primaryColor,
                                      fontSize: 13.sp),
                                ))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(
                                  item.huid ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 13.sp),
                                ))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child:
                                    Text(item.subItemDetailsName.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(item.grossWeight.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(item.reduceWeight.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(item.netWeight.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(item.pieces.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(item.totalStonePieces.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child: Text(item.totalStoneWeight.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child:
                                    Text(item.totalDiamondPieces.toString()))),
                            DataCell(SizedBox(
                                width: 100.w,
                                child:
                                    Text(item.totalDiamondWeight.toString()))),
                          ]);
                        }).toList(),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
