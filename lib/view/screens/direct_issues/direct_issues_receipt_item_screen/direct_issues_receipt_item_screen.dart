import 'dart:math';

import 'package:ausales_application/controller/approval_issues/approval_issues_receipt/approval_issues_receipt_controller.dart';
import 'package:ausales_application/controller/order/order_receive_item_convert/order_receive_item_convert_form_controller.dart';
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

class ApprovalIssuesReceiptItemScreen extends StatefulWidget {
  @override
  State<ApprovalIssuesReceiptItemScreen> createState() =>
      _ApprovalIssuesReceiptItemScreenState();
}

class _ApprovalIssuesReceiptItemScreenState
    extends State<ApprovalIssuesReceiptItemScreen> {
  final ApprovalIssuesReceiptController _approvalIssuesReceiptController =
      Get.put(ApprovalIssuesReceiptController());

  final OrderReceiveItemConvertFormController
      _order1receiveItemConvertFormController =
      Get.put(OrderReceiveItemConvertFormController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _approvalIssuesReceiptController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _approvalIssuesReceiptController.scaffoldKey,
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
                            "Receipt Item List",
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
                                _approvalIssuesReceiptController.isForm.value,
                            text: "Done",
                            onPressed: () {
                              _approvalIssuesReceiptController.createReceipt(
                                  context);
                            }))),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
               Container(
                color: Colors.white,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Center(
                  child: Wrap(
                    spacing: 20.w,
                    runSpacing: 15.h,
                    children: [
                    Obx(() => Text("Issues Id: ${_approvalIssuesReceiptController.issuesId.value}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Issues By: ${_approvalIssuesReceiptController.issuedBy.value}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Designer Name: ${_approvalIssuesReceiptController.designerName.value}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Created By: ${_approvalIssuesReceiptController.createdBy}", style: TextPalette.tableHeaderTextStyle,)),
                  ],),
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
                // DataColumn(
                //   label: SizedBox(
                //     width: 100.w,
                //     child: Text(
                //       'Action',
                //       style: TextPalette.tableHeaderTextStyle,
                //     ),
                //   ),
                // ),
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
                      'Sub Item Name',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Tag Number',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Total Diamond',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Total Stone',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                 DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Is Received',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Received',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: _approvalIssuesReceiptController
                  .approvalParticularList.value
                  .map((item) {
                return DataRow(cells: [
                  // DataCell(Row(
                  //   children: [
                  //    GestureDetector(
                  //     onTap: () {
                  //       _order1receiveItemConvertFormController.editItem(item,context);
                  //     },
                  //     child: Text(
                  //       "Convert to Purchase",
                  //       style: TextStyle(
                  //         fontSize: 16.sp,
                  //         color: Colors.green,
                  //         fontWeight: FontWeight.w800
                  //       ),
                  //     ),
                  //    )
                  //   ],
                  // )),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.itemDetailsName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.subItemDetailsName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.tagNumber.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.totalDiamondPieces.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.totalStonePieces.toString()))),
                       DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.isReceived! ? "True" : "False" , style : TextStyle(color: item.isReceived! ? Colors.green  : Colors.red)))),
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
                            _approvalIssuesReceiptController.onReceiveChange(
                                value, item.id.toString());
                          },
                          style: TextStyle(fontSize: 12.sp),
                          decoration: InputDecoration(
                              hintText: "Received By",
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
                  ))
                ]);
              }).toList(),
            )),
      ),
    );
  }
}
