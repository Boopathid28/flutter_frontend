import 'package:ausales_application/controller/itemtag/create_itemtag_branch_form_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_controller.dart';
import 'package:ausales_application/controller/itemtag/itemtag_form/itemtag_form_particulars_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/item_tag_print.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/itemtag_form/itemtag_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/itemtag_form/itemtag_particulars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemtagFormScreen extends StatefulWidget {
  const ItemtagFormScreen({super.key});

  @override
  State<ItemtagFormScreen> createState() => _ItemtagFormScreenState();
}

class _ItemtagFormScreenState extends State<ItemtagFormScreen> {
  final ItemtagFormController _itemtagFormController =
      Get.put(ItemtagFormController());

  final ItemtagFormParticularsController _itemtagFormParticularsController =
      Get.put(ItemtagFormParticularsController());

        final CreateItemtagBranchFormController _createItemtagBranchFormController =
      Get.put(CreateItemtagBranchFormController());

  @override
  Widget build(BuildContext context) {
    return ShorcutKeyboardHandler(
      scaffoldKey: _itemtagFormController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _itemtagFormController.scaffoldKey,
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
                child: Responsive.isMobile(context) ? Column(
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
                            height: 10.w,
                          ),
                          Text(
                                "Create Item Tag",
                                style: TextPalette.screenTitle,
                              ),
                        ],
                      ),
                    ),
                    SizedBox(
                        child: Column(
                          children: [
                            PrimaryButton(
                                btnHeight: 46.h,
                                isLoading: false,
                                text: "Print All",
                                onPressed: () async {
                                  await Get.dialog(
                                          barrierDismissible: false,
                                          ItemTagPrint(
                                              itemTagList: _itemtagFormParticularsController.itemTagList.value));
                                }),
                            
                    SizedBox(height: 10.h,),
                            Obx(() => PrimaryButton(
                                btnHeight: 46.h,
                                isLoading: _itemtagFormController.isFormDone.value,
                                text: "Done",
                                onPressed: () async {
                                  _itemtagFormController
                                      .completeItemtagging(context);
                                })),
                          ],
                        )),
                  ],
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                _itemtagFormController.lotItemId("");
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                                "Create Item Tag",
                                style: TextPalette.screenTitle,
                              ),
                        ],
                      ),
                    ),
                    SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryButton(
                                btnHeight: 46.h,
                                btnWidth: 100.w,
                                isLoading: false,
                                text: "Print All",
                                onPressed: () async {
                                  await Get.dialog(
                                          barrierDismissible: false,
                                          ItemTagPrint(
                                              itemTagList: _itemtagFormParticularsController.itemTagList.value));
                                }),
                            
                    SizedBox(width: 10.w,),
                            Obx(() => PrimaryButton(
                                btnHeight: 46.h,
                                btnWidth: 100.w,
                                isLoading: _itemtagFormController.isFormDone.value,
                                text: "Done",
                                onPressed: () async {
                                  _itemtagFormController
                                      .completeItemtagging(context);
                                })),
                          ],
                        )),
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
                            _itemtagFormParticularsController.totalTagCount.value,
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
                            "${_itemtagFormParticularsController.totalPieces.value} Pcs",
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
                            "${_itemtagFormParticularsController.totalGrossWeight.value} g",
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
                            _itemtagFormParticularsController.remainingTagCount.value,
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
                            "${_itemtagFormParticularsController.remainingPieces.value} Pcs",
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
                            "${_itemtagFormParticularsController.remainingGrossWeight.value} g",
                            style: TextPalette.tableDataTextStyle,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              ItemtagItemForm(),
              SizedBox(
                height: 10.w,
              ),
              ItemtagParticulars()
            ],
          ),
        ),
      ),
    );
  }
}
