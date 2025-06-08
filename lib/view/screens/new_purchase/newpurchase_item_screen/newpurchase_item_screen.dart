import 'dart:developer';

import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_form_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_item_table_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_lot_form/new_purchase_lot_detail_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewpurchaseItemScreen extends StatefulWidget {
  @override
  State<NewpurchaseItemScreen> createState() => _NewpurchaseItemScreenState();
}

class _NewpurchaseItemScreenState extends State<NewpurchaseItemScreen> {
  final NewpurchaseToLotController _newpurchaseToLotController =
      Get.put(NewpurchaseToLotController());

  final NewpurchaseToLotItemTableController
      _newpurchaseToLotItemTableController =
      Get.put(NewpurchaseToLotItemTableController());

  final NewpurchaseToLotFormController _newpurchaseToLotFormController =
      Get.put(NewpurchaseToLotFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _newpurchaseToLotController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _newpurchaseToLotController.scaffoldKey,
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
                                _newpurchaseToLotFormController.goBack();
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "New Purchase Item List",
                            style: Responsive.isDesktop(context)
                                ? TextPalette.screenTitle
                                : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 100.w,
                        child: Obx(() => PrimaryButton(
                            btnHeight: 46.h,
                            isLoading: _newpurchaseToLotFormController
                                .isFormSubmit.value,
                            text:
                                _newpurchaseToLotFormController.fromMode.value,
                            onPressed: () async {
                              _newpurchaseToLotFormController
                                  .submitLotFormDetails(context);
                            }))),
                  ],
                ),
              ),
              NewPurchaseLotDetailForm(),
              SizedBox(
                height: 15.h,
              ),
              purchaseItemlist(size)
            ],
          ),
        ),
      ),
    );
  }

  Container purchaseItemlist(Size size) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() => DataTable(
              headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) =>
                      ColorPalete.tableHeaderBgColor),
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Item Name',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Tag Count',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Pieces',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Gross Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: _newpurchaseToLotItemTableController.lotitemParticularList.value.map((item) {
                return DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.itemDetailsName.toString()))),
                  DataCell(Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 30.h,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            _newpurchaseToLotFormController.onTagcountChange(
                                value, item.id.toString());
                          },
                          style: TextStyle(fontSize: 12.sp),
                          decoration: InputDecoration(
                              hintText: "Tag Count",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 2.w),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  borderSide: BorderSide(
                                    color: ColorPalete.inputBorderColor,
                                    width: 1,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  borderSide: BorderSide(
                                    color: ColorPalete.inputBorderColor,
                                    width: 1,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                  borderSide: BorderSide(
                                    color: ColorPalete.inputBorderColor,
                                    width: 1,
                                  ))),
                        ),
                      )
                    ],
                  )),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.pieces.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.grossWeight.toString()))),
                ]);
              }).toList(),
            )),
      ),
    );
  }
}
