import 'dart:math';

import 'package:ausales_application/controller/order/order_vendor_assign_controller/order_vendor_assign_controller.dart';
import 'package:ausales_application/controller/order/order_vendor_assign_controller/order_vendor_form_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/vendor_assign/delete_vendor_assign_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/vendor_assign/vendor_assign_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderAssignListScreen extends StatefulWidget {
  @override
  State<OrderAssignListScreen> createState() => _OrderAssignListScreenState();
}

class _OrderAssignListScreenState extends State<OrderAssignListScreen> {
  final OrderVendorAssignController _orderVendorAssignController =
      Get.put(OrderVendorAssignController());

  final OrderVendorFormController _orderVendorFormController =
      Get.put(OrderVendorFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _orderVendorAssignController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _orderVendorAssignController.scaffoldKey,
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
                            "Assign Item List",
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
                            isLoading: _orderVendorFormController.isForm.value,
                            text: "Done",
                            onPressed: () {
                              _orderVendorFormController.AssignVendor(context);
                            }))),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              oldParticulars(size)
            ],
          ),
        ),
      ),
    );
  }

  Container oldParticulars(Size size) {
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
              rows: _orderVendorAssignController.tableData.value.map((item) {
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      Obx(
                        () => _orderVendorFormController.id.contains(item.id)
                            ? GestureDetector(
                                onTap: () async {
                                  await Get.dialog(
                                      barrierDismissible: false,
                                          DeleteVendorAssignPopup(itemIndex: item.id.toString()));
                                },
                                child: Text(
                                  "UnAssign",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ))
                            : GestureDetector(
                                onTap: () async {
                                  _orderVendorFormController
                                      .currentItemdetails(item);
                                  await Get.dialog(
                                      barrierDismissible: false,
                                          VendorAssignPopup());
                                },
                                child: Text(
                                  "Assign",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                )),
                      ),
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
