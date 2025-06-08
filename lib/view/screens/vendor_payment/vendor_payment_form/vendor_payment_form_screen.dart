import 'package:ausales_application/controller/vendor_payment/vendor_payment_form/vendor_payment_form_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/screens/vendor_payment/vendor_payment_form/vendor_payment_particular_details.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_text_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_form/vendor_add_payment_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_form/vendor_payment_with_cash_particular.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_form/vendor_payment_form_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_form/vendor_payment_with_metals_particular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentFormScreen extends StatefulWidget {
  const VendorPaymentFormScreen({super.key});

  @override
  State<VendorPaymentFormScreen> createState() =>
      _VendorPaymentFormScreenState();
}

class _VendorPaymentFormScreenState extends State<VendorPaymentFormScreen> {
  final VendorPaymentFormController _vendorPaymentFormController =
      Get.put(VendorPaymentFormController());

  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    _vendorPaymentFormController.getVendorPaymentDetails(context, args);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _vendorPaymentFormController.scaffoldKey,
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
                            "Vendor Payment",
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
                            child: PrimaryButton(
                                btnHeight: 46.h,
                                isLoading: false,
                                text: "Make Payment",
                                onPressed: () async {
                                  await Get.dialog(
                                      barrierDismissible: false,
                                      VendorPaymentFormPopup());
                                })),
                        SizedBox(
                          width: 15.w,
                        ),
                        SizedBox(
                            width: Responsive.isDesktop(context) ? 150.w : 75.w,
                            child: Obx(() => PrimaryButton(
                                btnHeight: 46.h,
                                isLoading: _vendorPaymentFormController
                                    .isFormSubmit.value,
                                text: "Pay",
                                onPressed: () async {

                                  if (_vendorPaymentFormController.totalPaidAmount.value > _vendorPaymentFormController.vendorPaymentDetails.value.balanceAmount! || _vendorPaymentFormController.totalPaidWeight.value > _vendorPaymentFormController.vendorPaymentDetails.value.balanceWeight! ) {
                                    await Get.dialog(
                                      VendorAddPaymentPopup()
                                    );
                                  } else {

                                    _vendorPaymentFormController.addPayment(context);
                                  }
                                }))),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                margin: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Obx(() => Wrap(
                      runSpacing: 20.h,
                      spacing: 20.w,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Vendor Name: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_vendorPaymentFormController.vendorPaymentDetails.value.vendorName ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Vendor Phone: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_vendorPaymentFormController.vendorPaymentDetails.value.vendorPhone ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Vendor Address: ",
                              style: TextPalette.tableHeaderTextStyle,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${_vendorPaymentFormController.vendorPaymentDetails.value.vendorAddress ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Responsive.isDesktop(context)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ledgerDetails(context, size),
                          Obx(() => PrimaryTextButton(
                              text: _vendorPaymentFormController
                                      .viewLedgerDetails.value
                                  ? "Hide Ledger"
                                  : "View Ledger",
                              onPressed: () {
                                _vendorPaymentFormController.viewLedgerDetails(
                                    !_vendorPaymentFormController
                                        .viewLedgerDetails.value);
                              }))
                        ],
                      )
                    : Column(
                        children: [
                          ledgerDetails(context, size),
                          SizedBox(
                            height: 15.h,
                          ),
                          Obx(() => PrimaryTextButton(
                              text: _vendorPaymentFormController
                                      .viewLedgerDetails.value
                                  ? "Hide Ledger"
                                  : "View Ledger",
                              onPressed: () {
                                _vendorPaymentFormController.viewLedgerDetails(
                                    !_vendorPaymentFormController
                                        .viewLedgerDetails.value);
                              }))
                        ],
                      ),
              ),
              Obx(() => Visibility(
                    visible:
                        _vendorPaymentFormController.viewLedgerDetails.value,
                    child: SizedBox(
                      height: 500.h,
                      child: SingleChildScrollView(
                        child: VendorPaymentParticularDetails(
                          dataList: _vendorPaymentFormController
                                  .vendorPaymentDetails.value.ledgerList ??
                              [],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Wrap(
                    runSpacing: 20.h,
                    spacing: 20.w,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Total Weight: ",
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Obx(() => Text(
                            "${_vendorPaymentFormController.totalPaidWeight.value.toStringAsFixed(3)} g",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Total Amount: ",
                            style: TextPalette.tableHeaderTextStyle,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Obx(() => Text(
                            "₹ ${_vendorPaymentFormController.totalPaidAmount.value.toStringAsFixed(2)}",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )),
                        ],
                      ),
                      Obx(() => _vendorPaymentFormController.isBranchuser.value ? branch() : SizedBox(),),
                      remarks()
                ],),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VendorPaymentWithCashParticular(),
                  VendorPaymentWithMetalsParticular()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox ledgerDetails(BuildContext context, Size size) {
    return SizedBox(
      width:
          Responsive.isDesktop(context) ? size.width * 0.8 : size.width * 0.5,
      child: Obx(() => Wrap(
            runSpacing: 20.h,
            spacing: 20.w,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Overall Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorPaymentFormController.vendorPaymentDetails.value.totalWeight?.toStringAsFixed(3)} g",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Overall Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorPaymentFormController.vendorPaymentDetails.value.totalAmount?.toStringAsFixed(2)}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Discount Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorPaymentFormController.vendorPaymentDetails.value.discWeight?.toStringAsFixed(3)} g",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Discount Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorPaymentFormController.vendorPaymentDetails.value.discAmount?.toStringAsFixed(2)}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Paid Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorPaymentFormController.vendorPaymentDetails.value.paidWeight?.toStringAsFixed(3)} g",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Paid Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorPaymentFormController.vendorPaymentDetails.value.paidAmount?.toStringAsFixed(2)}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Balance Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorPaymentFormController.vendorPaymentDetails.value.balanceWeight?.toStringAsFixed(3)} g ${ _vendorPaymentFormController.vendorPaymentDetails.value.balanceWeight.toString().contains('-') ? "(over payment)" : ""}",
                    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: _vendorPaymentFormController.vendorPaymentDetails.value.balanceWeight.toString().contains('-') ? Colors.red :  Colors.blue
  ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Balance Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorPaymentFormController.vendorPaymentDetails.value.balanceAmount?.toStringAsFixed(2)} ${ _vendorPaymentFormController.vendorPaymentDetails.value.balanceAmount.toString().contains('-') ? "(over payment)" : "" }",
                    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: _vendorPaymentFormController.vendorPaymentDetails.value.balanceAmount.toString().contains('-') ? Colors.red :  Colors.blue
  ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _vendorPaymentFormController.branchSearchController,
                selectedValue: _vendorPaymentFormController.selectedBranch.value,
                options: _vendorPaymentFormController.branchDropDown.value,
                onChanged: (value) {
                  _vendorPaymentFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 350.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            
            controller: _vendorPaymentFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
            onChanged: (value) {
              _vendorPaymentFormController.calculatePayment();
            },
          ),
        ],
      ),
    );
  }

}
