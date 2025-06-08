import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_form_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_item_form_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_form/convert_weight_to_amount_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_form/new_purchase_details_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_form/new_purchase_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPurchaseFormScreen extends StatefulWidget {
  const NewPurchaseFormScreen({super.key});

  @override
  State<NewPurchaseFormScreen> createState() => _NewPurchaseFormScreenState();
}

class _NewPurchaseFormScreenState extends State<NewPurchaseFormScreen> {
  final NewPurchaseFormController _newPurchaseFormController =
      Get.put(NewPurchaseFormController());

  final NewPurchaseItemFormController _newPurchaseItemFormController = Get.put(NewPurchaseItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _newPurchaseFormController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
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
                            "Create New Purchase",
                            style: Responsive.isDesktop(context) ? TextPalette.screenTitle : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: Responsive.isDesktop(context) ? 150.w : 75.w,
                        child: Obx(() => PrimaryButton(
                            btnHeight: 46.h,
                            isLoading:
                                _newPurchaseFormController.isFormSubmit.value,
                            text: "Create",
                            onPressed: () {
                              _newPurchaseFormController.submitForm(context);
                            }))),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              NewPurchaseDetailsForm(),
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
                    Obx(() => Text("Total Items: ${_newPurchaseItemFormController.totalItems.value}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Total Pieces: ${_newPurchaseItemFormController.totalPieces.value} pcs", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Total Gross Weight: ${_newPurchaseItemFormController.totalGrossWeight.value} g", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Total Net Weight: ${_newPurchaseItemFormController.totalNetWeight.value} g", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("GST Amount: ₹ ${_newPurchaseItemFormController.gstAmount.value}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Grand Total: ₹ ${_newPurchaseItemFormController.payableGrandTotalAmount.value}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("TDS Amount: ₹ ${_newPurchaseItemFormController.tdsAmount.value.toStringAsFixed(2)}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Payable Amount: ₹ ${_newPurchaseItemFormController.payableWithRoundAmount.value.toStringAsFixed(2)}", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Text("Payable Pure Weight: ${_newPurchaseItemFormController.payablPureWeight.value.toStringAsFixed(3)} g", style: TextPalette.tableHeaderTextStyle,)),
                    Obx(() => Visibility(
                      visible: _newPurchaseItemFormController.payablPureWeight.value > 0 ? true : false,
                      child: PrimaryButton(btnWidth: 300.w, isLoading: false, text: 'Convert Weight to Amount', onPressed: () async {
                        await Get.dialog(barrierDismissible: false,ConvertWeightToAmountPopup());
                      }),
                    ))
                  ],),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Visibility(
                      visible: _newPurchaseItemFormController.isConvertedWeight.value,
                      child: Text("Note: If you make any changes in the item table the weight conversion will be reset!", style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.sp
                      ),),
                    )),
                    PrimaryButton(
                      btnWidth: 150.w,
                        btnHeight: 46.h,
                        isLoading: false,
                        text: "Create Item",
                        onPressed: () async {
                          if (_newPurchaseFormController.newPurchaseDetailsFormKey.currentState!.validate()) {
                              await Get.dialog(
                                barrierDismissible: false,
                                NewPurchaseItemForm()
                              );
                          }
                        }),
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
                    width: 75.w,
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
                      'Sub Item',
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
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Net Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Stone Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                 DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Diamond Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Total Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'GST Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 150.w,
                    child: Text(
                      'Total Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: _newPurchaseItemFormController.particulars.value.map((item) {
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      GestureDetector(onTap: () {
                        _newPurchaseItemFormController.editItem(item, context);
                      }, child: Icon(Icons.edit)),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(onTap: () {
                        _newPurchaseItemFormController.deleteItem(item);
                      }, child: Icon(Icons.delete)),
                    ],
                  )),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                        item.subItemDetailsName??"",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorPalete.primaryColor,
                            fontSize: 13.sp),
                      ))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                        item.pieces.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 13.sp),
                      ))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.grossWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.netWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.stoneAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.diamondAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.totalWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.gstAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.totalAmount.toString()))),
                ]);
              }).toList(),
            )),
      ),
    );
  }
}
