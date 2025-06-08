import 'dart:math';

import 'package:ausales_application/controller/order/order_receive_item_controller/order_receive_item_form_controller.dart';
import 'package:ausales_application/controller/order/order_receive_item_convert/order_receive_item_convert_form_controller.dart';
import 'package:ausales_application/controller/order/order_receive_item_convert/order_receive_item_convert_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderConvertReceiveItemScreen extends StatefulWidget {
  @override
  State<OrderConvertReceiveItemScreen> createState() => _OrderConvertReceiveItemScreenState();
}

class _OrderConvertReceiveItemScreenState extends State<OrderConvertReceiveItemScreen> {
  final OrderConvertReceiveItemController _orderConvertReceiveItemController =
      Get.put(OrderConvertReceiveItemController());

        final OrderReceiveItemConvertFormController _order1receiveItemConvertFormController =
      Get.put(OrderReceiveItemConvertFormController());

  final OrderReceiveItemFormController _orderReceiveItemFormController =
      Get.put(OrderReceiveItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _orderConvertReceiveItemController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _orderConvertReceiveItemController.scaffoldKey,
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
                            "Convert Receive Item List",
                            style: Responsive.isDesktop(context)
                                ? TextPalette.screenTitle
                                : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: Responsive.isDesktop(context) ? 150.w : 75.w,
                        child: Obx(() => PrimaryButton(
                            btnHeight: 46.h,
                            isLoading:
                                _orderReceiveItemFormController.isForm.value,
                            text: "Done",
                            onPressed: () {
                              _orderReceiveItemFormController.ReceiveItem(context);
                            }))),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              receiveItemlist(size)
            ],
          ),
        ),
      ),
    );
  }

  Container receiveItemlist(Size size) {
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
                  (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
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
                    width: 125.w,
                    child: Text(
                      'Order Id',
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
                      'Customer Name',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Metal Name',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
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
                    width: 150.w,
                    child: Text(
                      'Sub Item Name',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: _orderConvertReceiveItemController.tableData.value.map((item) {
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                     GestureDetector(
                      onTap: () {
                        _order1receiveItemConvertFormController.editItem(item,context);
                      },
                      child: Text(
                        "Convert to Purchase",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                     )
                    ],
                  )),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.orderId.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.grossWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.pieces.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.customerName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.metalName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.itemDetailsName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.subItemDetailsName.toString()))),
                ]);
              }).toList(),
            )),
      ),
    );
  }
}
