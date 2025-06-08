import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_form_controller.dart';
import 'package:ausales_application/controller/old_purchase/old_purchase_form/old_purchase_item_form_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_purchase/old_purchase_form/old_purchase_details_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_purchase/old_purchase_form/old_purchase_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldPurchaseFormScreen extends StatefulWidget {
  const OldPurchaseFormScreen({super.key});

  @override
  State<OldPurchaseFormScreen> createState() => _OldPurchaseFormScreenState();
}

class _OldPurchaseFormScreenState extends State<OldPurchaseFormScreen> {
  final OldPurchaseFormController _oldPurchaseFormController =
      Get.put(OldPurchaseFormController());

  final OldPurchaseItemFormController _oldPurchaseItemFormController =
      Get.put(OldPurchaseItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _oldPurchaseFormController.scaffoldKey,
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
                            "Create Old Purchase",
                            style: Responsive.isDesktop(context)
                                ? TextPalette.screenTitle
                                : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: Responsive.isDesktop(context) ? 150.w : 75.w,
                            child: Obx(() => PrimaryButton(
                                btnHeight: 46.h,
                                isLoading: _oldPurchaseFormController
                                    .isFormSubmit.value,
                                text: "Create",
                                onPressed: () {
                                  _oldPurchaseFormController.submitForm(
                                      context, false);
                                      
                                }))),
                        SizedBox(
                          width: 10.w,
                        ),
                        Obx(() => PrimaryButton(
                            btnHeight: 46.h,
                            btnWidth: 200,
                            isLoading:
                                _oldPurchaseFormController.isFormSubmit.value,
                            text: 'Save & Print',
                            onPressed: () {
                              _oldPurchaseFormController.submitForm(
                                  context, true);
                            })),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              OldPurchaseDetailsForm(),
              SizedBox(
                height: 15.h,
              ),
              OldPurchaseItemForm(),
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
                      'Metal',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Metal Weight',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Metal Rate',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 125.w,
                    child: Text(
                      'Dust Weight',
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
                      'Old Metal Amount',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
                // DataColumn(
                //   label: SizedBox(
                //     width: 125.w,
                //     child: Text(
                //       'GST Amount',
                //       style: TextPalette.tableHeaderTextStyle,
                //     ),
                //   ),
                // ),
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
              rows:
                  _oldPurchaseItemFormController.particulars.value.map((item) {
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            _oldPurchaseItemFormController.editItem(item);
                          },
                          child: Icon(Icons.edit)),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            _oldPurchaseItemFormController.deleteItem(item);
                          },
                          child: Icon(Icons.delete)),
                    ],
                  )),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                        item.oldMetalName ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorPalete.primaryColor,
                            fontSize: 13.sp),
                      ))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(
                        item.oldWeight.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 13.sp),
                      ))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.oldRate.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.oldDustWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.oldNetWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.oldRate.toString()))),
                  // DataCell(SizedBox(
                  //     width: 100.w, child: Text(item.gstAmount.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.totalAmount.toString()))),
                ]);
              }).toList(),
            )),
      ),
    );
  }
}
