import 'dart:developer';

import 'package:ausales_application/controller/invoice/invoice_chit_scheme_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_item_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_item_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_dropdown_field.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_advance/show_advance_particuars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_old_metal/invoice_old_metal_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_old_metal/invoice_old_purchase_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_old_metal/show_old_purchase_particuars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_payment/invoice_payment_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_payment/invoice_payment_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_suspense/invoice_suspense_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_suspense/invoice_suspense_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_suspense/show_suspense_particuars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/manual_invoice/manual_invoice_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/manual_invoice/manual_invoice_item_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class ManualInvoiceScreen extends StatefulWidget {
  const ManualInvoiceScreen({super.key});

  @override
  State<ManualInvoiceScreen> createState() => _ManualInvoiceScreenState();
}

class _ManualInvoiceScreenState extends State<ManualInvoiceScreen> {
  final ManualInvoiceController _manualInvoiceController = Get.put(ManualInvoiceController());
  final InvoiceChitSchemeController _invoiceChitSchemeController =
      Get.put(InvoiceChitSchemeController());


      final ManualInvoiceItemController _manualInvoiceItemController =
      Get.put(ManualInvoiceItemController());

  @override
  Widget build(BuildContext context) {
    return ShorcutKeyboardHandler(
      scaffoldKey: _manualInvoiceController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _manualInvoiceController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: ColorPalete.primaryColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(7.r))),
                      child: Text("Manual Billing",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(7.r))),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          billingDate(),
                          Obx(() => _manualInvoiceController.isBranchuser.value
                              ? branch()
                              : SizedBox()),
                          gstType(),
                          metal(),
                          customerMobile(),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() => Checkbox(
                                      fillColor:
                                          WidgetStateProperty.resolveWith<Color?>(
                                              (Set<WidgetState> states) =>
                                                  ColorPalete.primaryBtnColor),
                                      value: _manualInvoiceController.issuedValue.value
                                          ? true
                                          : false,
                                      onChanged: (bool? value) {
                                        _manualInvoiceController.issuedValue(value);
                                      },
                                    )),
                                    Text("ISSUED",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(() => Visibility(
                    visible: _manualInvoiceController.isBranchuser.value
                        ? (_manualInvoiceController.selectedGstType.value != null &&
                                _manualInvoiceController.selectedBranch.value !=
                                    null &&
                                _manualInvoiceController
                                    .billingDate.text.isNotEmpty &&
                                _manualInvoiceController.isValidCustomer.value)
                            ? true
                            : false
                        : (_manualInvoiceController.selectedGstType.value != null &&
                                _manualInvoiceController
                                    .billingDate.text.isNotEmpty &&
                                _manualInvoiceController.isValidCustomer.value)
                            ? true
                            : false,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                color: ColorPalete.primaryColor,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(7.r))),
                            child: Text("Item Form",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(7.r))),
                              child: ManualInvoiceItemForm()),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(7.r))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Items",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        ManualInvoiceItemTable(),
                      ],
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Responsive.isDesktop(context)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              chitSchemeSection(context),
                              advanceSection(context),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              oldMetalSection(context),
                              suspensionSection(context),
                              paymentSection(context),
                            ],
                          ),
                          paymentSectionOne(context),
                          paymentSectionTwo(context),
                          paymentSectionThree(context),
                        ],
                      )
                    : Responsive.isTablet(context)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  chitSchemeSection(context),
                                  advanceSection(context),
                                  oldMetalSection(context),
                                  suspensionSection(context),
                                  // paymentSection(context),
                                ],
                              ),
                              Column(
                                children: [
                                  paymentSectionOne(context),
                                  paymentSectionTwo(context),
                                ],
                              ),
                              paymentSectionThree(context),
                            ],
                          )
                        : Column(
                            children: [
                              chitSchemeSection(context),
                              advanceSection(context),
                              oldMetalSection(context),
                              suspensionSection(context),
                              paymentSection(context),
                              paymentSectionOne(context),
                              paymentSectionTwo(context),
                              paymentSectionThree(context),
                            ],
                          ),
              ),
              // Container(
              //   width: double.infinity,
              //   color: ColorPalete.appBgColor,
              //   margin: EdgeInsets.symmetric(horizontal: 15.w),
              //   child: Responsive.isDesktop(context)
              //       ? Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             chitSchemeSection(context),
              //             Column(
              //               children: [
              //                 advanceSection(context),
              //                 suspensionSection(context),
              //               ],
              //             ),
              //             Column(
              //               children: [
              //                 oldMetalSection(context),
              //                 paymentSection(context)
              //               ],
              //             ),
              //             paymentDetails(context),
              //           ],
              //         )
              //       : Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             chitSchemeSection(context),
              //             advanceSection(context),
              //             suspensionSection(context),
              //             oldMetalSection(context),
              //             paymentSection(context),
              //             paymentDetails(context),
              //           ],
              //         ),
              // ),
              SizedBox(
                height: defaultBottombarHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container paymentSectionOne(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: 250.w,
      child: Column(
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.totalAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gst Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.gstAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Payable Amount:",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp)),
              BillingTextInput(
                width: 100.w,
                height: 30.h,
                filled: true,
                inputFormat: 'double',
                filledColor: Colors.white,
                controller: _manualInvoiceController.totalPayableController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _manualInvoiceController.onManualTotalPayableAmountChanged();
                },
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order Amount:",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp)),
              BillingTextInput(
                width: 100.w,
                height: 30.h,
                filled: true,
                inputFormat: 'double',
                filledColor: Colors.white,
                controller: _manualInvoiceController.orderController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                readOnly: true,
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Discount Amount:",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp)),
              BillingTextInput(
                width: 100.w,
                height: 30.h,
                filled: true,
                inputFormat: 'double',
                filledColor: Colors.white,
                controller: _manualInvoiceController.discountController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _manualInvoiceController.calculateManualBilling();
                },
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Round Off Amount:",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp)),
              BillingTextInput(
                width: 100.w,
                height: 30.h,
                inputFormat: 'negative',
                filled: true,
                filledColor: Colors.white,
                controller: _manualInvoiceController.roundOffController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _manualInvoiceController.calculateManualBilling();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Container paymentSectionTwo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: 250.w,
      child: Column(
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Advance Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.advanceAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Exchange Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.exchangeAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sales Rtn Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.saleReturnAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Suspense Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.suspenseAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chit Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.chitAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Container paymentSectionThree(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: 250.w,
      child: Column(
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Paid Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.paidAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Balance Amount:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorPalete.billingTableDataAlternateBgColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    padding: EdgeInsets.all(5.w),
                    child: Text("${_manualInvoiceController.balanceAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => PrimaryButton(
              btnWidth: double.infinity,
              btnHeight: 35,
              isLoading: _manualInvoiceController.isSaveBillingLoading.value,
              text: 'Save',
              onPressed: () {
                _manualInvoiceController.createManualBilling(context, false);
              })),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => PrimaryButton(
              btnWidth: double.infinity,
              btnHeight: 35,
              isLoading: _manualInvoiceController.isSaveBillingLoading.value,
              text: 'Save & Print',
              onPressed: () {
                _manualInvoiceController.createManualBilling(context, true);
              })),
        ],
      ),
    );
  }

  Container chitSchemeSection(BuildContext context) {
    return Container(
      width: 243.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Chit Scheme",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        _invoiceChitSchemeController.chitSchemeReset();
                        _invoiceChitSchemeController.selectedTagItemIdsList([]);
                        _invoiceChitSchemeController
                            .selectedChitSchemeIdsList([]);
                      },
                      icon: Icon(Icons.cleaning_services_outlined,
                          size: 15.sp, color: ColorPalete.primaryBtnColor))
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BillingTextInput(
                width: 180.w,
                height: 30,
                filled: true,
                filledColor: Colors.white,
                controller: _manualInvoiceController.chitController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: 'no_validation',
                onChanged: (value) {},
              ),
              Obx(() => GestureDetector(
                    onTap: _invoiceChitSchemeController
                            .isCitSchemeFetchLoading.value
                        ? null
                        : () async {
                            if (_manualInvoiceController
                                .selectedTagChitPaymentParticulars.isNotEmpty) {
                              toastification.show(
                                  context:
                                      context, // optional if you use ToastificationWrapper
                                  type: ToastificationType.info,
                                  title: Text(
                                      "Clear schemes and add new scheme payemnts"),
                                  autoCloseDuration: notificationDuration,
                                  showProgressBar: false,
                                  pauseOnHover: false);
                            } else {
                              _invoiceChitSchemeController
                                  .getChitSchemeDetails(context);
                            }
                          },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: ColorPalete.primaryBtnColor),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  // Container chitSchemeSection(BuildContext context) {
  //   return Container(
  //     width: 250.w,
  //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             CustomLabel(label: "Scheme"),
  //             SizedBox(
  //               height: 7.w,
  //             ),
  //             BillingTextInput(
  //               width: 250.w,
  //               height: 45,
  //               filled: true,
  //               filledColor: Colors.white,
  //               controller: _manualInvoiceController.chitController,
  //               textInputAction: TextInputAction.done,
  //               keyboardType: TextInputType.text,
  //               validator: 'no_validation',
  //               onChanged: (value) {},
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         Obx(() => PrimaryButton(
  //             btnWidth: 250.w,
  //             isLoading: _invoiceChitSchemeController.isCitSchemeFetchLoading.value,
  //             text: 'Fetch Details',
  //             onPressed: _invoiceChitSchemeController.isCitSchemeFetchLoading.value ? null : () async {
  //               if (_manualInvoiceController.selectedTagChitPaymentParticulars.isNotEmpty) {
  //                 toastification.show(
  //                   context: context, // optional if you use ToastificationWrapper
  //                   type: ToastificationType.info,
  //                   title: Text("Clear schemes and add new scheme payemnts"),
  //                   autoCloseDuration: notificationDuration,
  //                   showProgressBar: false,
  //                   pauseOnHover: false);
  //               } else {
  //                 _invoiceChitSchemeController.getChitSchemeDetails(context);
  //               }
  //             })),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         SecondaryButton(isLoading: false, text: "Clear", onPressed: () {
  //           _invoiceChitSchemeController.chitSchemeReset();
  //           _invoiceChitSchemeController.selectedTagItemIdsList([]);
  //           _invoiceChitSchemeController.selectedChitSchemeIdsList([]);
  //         })
  //       ],
  //     ),
  //   );
  // }

  Container suspensionSection(BuildContext context) {
    return Container(
      width: 243.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Suspense",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await Get.dialog(
                                barrierDismissible: false,
                                ShowSuspenseParticuars());
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          )),
                      IconButton(
                          onPressed: () async {
                            if (_manualInvoiceController.selectedGstType.value !=
                                null) {
                              await Get.bottomSheet(
                                isDismissible: false,
                                Container(
                                  height: 700,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width: 300,
                                                        child: Text(
                                                          'Suspense',
                                                          style: TextPalette
                                                              .screenTitle,
                                                        )),
                                                    SizedBox(
                                                      width: 300,
                                                      child: Row(
                                                        children: [
                                                          Obx(() =>
                                                              PrimaryButton(
                                                                  btnWidth: 145,
                                                                  isLoading:
                                                                      _manualInvoiceController
                                                                          .isSuspenseSubmitLoading
                                                                          .value,
                                                                  text: 'Done',
                                                                  onPressed:
                                                                      () {
                                                                    _manualInvoiceController
                                                                        .createManualSuspense(
                                                                            context);
                                                                  })),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          SecondaryButton(
                                                              btnWidth: 145,
                                                              isLoading: false,
                                                              text: 'Close',
                                                              onPressed: () {
                                                                Get.back();
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                InvoiceSuspenseForm(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                InvoiceSuspenseParticulars(),
                                              ],
                                            ),
                                          ),
                                        ),
                                )
                              );
                            } else {
                              toastification.show(
                                  context:
                                      context, // optional if you use ToastificationWrapper
                                  type: ToastificationType.info,
                                  title: Text("Select GST Type"),
                                  autoCloseDuration: notificationDuration,
                                  showProgressBar: false,
                                  pauseOnHover: false);
                            }
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          ))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BillingTextInput(
                    width: 180.w,
                    height: 30,
                    filled: true,
                    filledColor: Colors.white,
                    controller: _manualInvoiceController.suspenseController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap: _manualInvoiceController.isSuspenseFetchLoading.value
                            ? null
                            : () async {
                                _manualInvoiceController.getManualSuspenseDetails(context);
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: ColorPalete.primaryBtnColor),
                          child: Center(
                            child: Icon(
                              Icons.search,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Container suspensionSection(BuildContext context) {
  //   return Container(
  //     width: 300,
  //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             CustomLabel(label: "Suspense"),
  //             SizedBox(
  //               height: 7.w,
  //             ),
  //             BillingTextInput(
  //               width: 300,
  //               height: 45,
  //               filled: true,
  //               filledColor: Colors.white,
  //               controller: _manualInvoiceController.suspenseController,
  //               textInputAction: TextInputAction.done,
  //               keyboardType: TextInputType.text,
  //               validator: 'no_validation',
  //               onChanged: (value) {},
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Obx(() => PrimaryButton(
  //                 btnWidth: 125,
  //                 isLoading: _manualInvoiceController.isSuspenseFetchLoading.value,
  //                 text: 'Fetch Details',
  //                 onPressed: () {
  //                   _manualInvoiceController.getManualSuspenseDetails(context);
  //                 })),
  //             SizedBox(
  //               width: 10.w,
  //             ),
  //             SecondaryButton(
  //                 btnWidth: 125,
  //                 isLoading: false,
  //                 text: '+ Add',
  //                 onPressed: () async {
  //                   if (_manualInvoiceController.selectedGstType.value != null) {
  //                     await showModalBottomSheet(
  //                         context: context,
  //                         isDismissible: false,
  //                         isScrollControlled: true,
  //                         // shape: ,
  //                         builder: (_) => DraggableScrollableSheet(
  //                               expand: false,
  //                               initialChildSize: 0.7,
  //                               maxChildSize: 0.7,
  //                               minChildSize: 0.32,
  //                               builder: (context, scrollController) =>
  //                                   SingleChildScrollView(
  //                                 controller: scrollController,
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(15.0),
  //                                   child: Column(
  //                                     children: [
  //                                       Row(
  //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                         children: [
  //                                           SizedBox(width: 300, child: Text('Suspense', style: TextPalette.screenTitle,)),
  //                                           SizedBox(
  //                                             width: 300,
  //                                             child: Row(
  //                                               children: [
  //                                                 Obx(() => PrimaryButton(btnWidth: 145, isLoading: _manualInvoiceController.isSuspenseSubmitLoading.value, text: 'Done', onPressed: () {
  //                                                   _manualInvoiceController.createManualSuspense(context);
  //                                                 })),
  //                                                 SizedBox(width: 10,),
  //                                                 SecondaryButton(btnWidth: 145, isLoading: false, text: 'Close', onPressed: () {
  //                                               Get.back();
  //                                             })
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(height: 10,),
  //                                       InvoiceSuspenseForm(),
  //                                       SizedBox(height: 10,),
  //                                       InvoiceSuspenseParticulars(),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ));
  //                   } else {
  //                     toastification.show(
  //                         context:
  //                             context, // optional if you use ToastificationWrapper
  //                         type: ToastificationType.info,
  //                         title: Text("Select GST Type"),
  //                         autoCloseDuration: notificationDuration,
  //                         showProgressBar: false,
  //                         pauseOnHover: false);
  //                   }
  //                 }),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         PrimaryButton(
  //             btnWidth: 300,
  //             isLoading: false,
  //             text: 'View Suspense Details',
  //             onPressed: () async {
  //               await showDialog(
  //                   context: context,
  //                   barrierDismissible: false,
  //                   builder: (_) => ShowSuspenseParticuars());
  //             }),
  //       ],
  //     ),
  //   );
  // }

  Container paymentSection(BuildContext context) {
    return Container(
      width: 243.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payment",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp)),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BillingTextInput(
                    width: 180.w,
                    height: 30,
                    filled: true,
                    filledColor: Colors.white,
                    controller: _manualInvoiceController.paidAmountController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    readOnly: true,
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap: _manualInvoiceController.isOldMetalFetchLoading.value
                            ? null
                            : () async {
                                await Get.bottomSheet(
                                isDismissible: false,
                                Container(
                                  height: 700,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(15.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Text(
                                                          "Add Payment",
                                                          style: Responsive
                                                                  .isDesktop(
                                                                      context)
                                                              ? TextPalette
                                                                  .screenTitle
                                                              : TextPalette
                                                                  .tableHeaderTextStyle,
                                                        ),
                                                      ),
                                                      PrimaryButton(
                                                          btnWidth: 200,
                                                          isLoading: false,
                                                          text: 'Done',
                                                          onPressed: () {
                                                            _manualInvoiceController
                                                                .calculateManualPayments();
                                                            Get.back();
                                                          })
                                                    ],
                                                  ),
                                                ),
                                                InvoicePaymentPopup(),
                                                Center(
                                                    child:
                                                        InvoicePaymentParticulars())
                                              ],
                                            ),
                                          ),
                                )
                              );
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: ColorPalete.primaryBtnColor),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Container paymentSection(BuildContext context) {
  //   return Container(
  //     width: 300,
  //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             CustomLabel(label: "Payment"),
  //             SizedBox(
  //               height: 7.w,
  //             ),
  //             BillingTextInput(
  //               width: 300,
  //               height: 45,
  //               filled: true,
  //               filledColor: Colors.white,
  //               controller: _manualInvoiceController.paidAmountController,
  //               textInputAction: TextInputAction.done,
  //               keyboardType: TextInputType.text,
  //               validator: 'no_validation',
  //               readOnly: true,
  //               onChanged: (value) {},
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         PrimaryButton(
  //             btnWidth: 300,
  //             isLoading: false,
  //             text: 'Add Payment Details',
  //             onPressed: () async {
  //               await showModalBottomSheet(
  //                   context: context,
  //                   isDismissible: false,
  //                   isScrollControlled: true,
  //                   // shape: ,
  //                   builder: (_) => DraggableScrollableSheet(
  //                         expand: false,
  //                         initialChildSize: 0.7,
  //                         maxChildSize: 0.7,
  //                         minChildSize: 0.32,
  //                         builder: (context, scrollController) =>
  //                             SingleChildScrollView(
  //                           controller: scrollController,
  //                           child: Column(
  //                             children: [
  //                               Padding(
  //                                 padding: EdgeInsets.all(15.w),
  //                                 child: Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     SizedBox(
  //                                       width: 300,
  //                                       child: Text(
  //                                         "Add Payment",
  //                                         style: Responsive.isDesktop(context)
  //                                             ? TextPalette.screenTitle
  //                                             : TextPalette
  //                                                 .tableHeaderTextStyle,
  //                                       ),
  //                                     ),
  //                                     PrimaryButton(
  //                                       btnWidth: 200,
  //                                         isLoading: false,
  //                                         text: 'Done',
  //                                         onPressed: () {
  //                                           _manualInvoiceController
  //                                               .calculateManualPayments();
  //                                           Get.back();
  //                                         })
  //                                   ],
  //                                 ),
  //                               ),
  //                               InvoicePaymentPopup(),
  //                               Center(child: InvoicePaymentParticulars())
  //                             ],
  //                           ),
  //                         ),
  //                       ));
  //             }),
  //       ],
  //     ),
  //   );
  // }

  Container oldMetalSection(BuildContext context) {
    return Container(
      width: 243.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Exchange",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await Get.dialog(
                                barrierDismissible: false,
                                ShowOldPurchaseParticuars());
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          )),
                      IconButton(
                          onPressed: () async {
                            if (_manualInvoiceController.isBranchuser.value) {
                              if (_manualInvoiceController.selectedBranch.value !=
                                      null &&
                                  _manualInvoiceController.selectedGstType.value !=
                                      null &&
                                  _manualInvoiceController.isValidCustomer.value) {
                                await Get.bottomSheet(
                                isDismissible: false,
                                Container(
                                  height: 700,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                InvoiceOldPurchaseItemForm(),
                                                InvoiceOldMetalParticulars()
                                              ],
                                            ),
                                          ),
                                )
                              );
                              } else {
                                toastification.show(
                                    context:
                                        context, // optional if you use ToastificationWrapper
                                    type: ToastificationType.info,
                                    title: Text("Fill Billing Details"),
                                    autoCloseDuration: notificationDuration,
                                    showProgressBar: false,
                                    pauseOnHover: false);
                              }
                            } else {
                              if (_manualInvoiceController.selectedGstType.value !=
                                      null &&
                                  _manualInvoiceController.isValidCustomer.value) {
                                await Get.bottomSheet(
                                isDismissible: false,
                                Container(
                                  height: 700,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                InvoiceOldPurchaseItemForm(),
                                                InvoiceOldMetalParticulars()
                                              ],
                                            ),
                                          ),
                                )
                              );
                              } else {
                                toastification.show(
                                    context:
                                        context, // optional if you use ToastificationWrapper
                                    type: ToastificationType.info,
                                    title: Text("Fill Billing Details"),
                                    autoCloseDuration: notificationDuration,
                                    showProgressBar: false,
                                    pauseOnHover: false);
                              }
                            }
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          ))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BillingTextInput(
                    width: 180.w,
                    height: 30,
                    filled: true,
                    filledColor: Colors.white,
                    controller: _manualInvoiceController.oldMetalController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap: _manualInvoiceController.isOldMetalFetchLoading.value
                            ? null
                            : () async {
                                _manualInvoiceController.getManualOldMetalDetails(context);
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: ColorPalete.primaryBtnColor),
                          child: Center(
                            child: Icon(
                              Icons.search,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Container oldMetalSection(BuildContext context) {
  //   return Container(
  //     width: 300,
  //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             CustomLabel(label: "Old Metal"),
  //             SizedBox(
  //               height: 7.w,
  //             ),
  //             BillingTextInput(
  //               width: 300,
  //               height: 45,
  //               filled: true,
  //               filledColor: Colors.white,
  //               controller: _manualInvoiceController.oldMetalController,
  //               textInputAction: TextInputAction.done,
  //               keyboardType: TextInputType.text,
  //               validator: 'no_validation',
  //               onChanged: (value) {},
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Obx(() => PrimaryButton(
  //                 btnWidth: 125,
  //                 isLoading: _manualInvoiceController.isOldMetalFetchLoading.value,
  //                 text: 'Fetch Details',
  //                 onPressed: () {
  //                   _manualInvoiceController.getManualOldMetalDetails(context);
  //                 })),
  //             SizedBox(
  //               width: 10.w,
  //             ),
  //             SecondaryButton(
  //                 btnWidth: 125,
  //                 isLoading: false,
  //                 text: '+ Add',
  //                 onPressed: () async {
  //                   if(_manualInvoiceController.isBranchuser.value) {
  //                     if (_manualInvoiceController.selectedBranch.value != null && _manualInvoiceController.selectedGstType.value != null && _manualInvoiceController.isValidCustomer.value) {
  //                       await showModalBottomSheet(
  //                           context: context,
  //                           isDismissible: false,
  //                           isScrollControlled: true,
  //                           // shape: ,
  //                           builder: (_) => DraggableScrollableSheet(
  //                                 expand: false,
  //                                 initialChildSize: 0.7,
  //                                 maxChildSize: 0.7,
  //                                 minChildSize: 0.32,
  //                                 builder: (context, scrollController) =>
  //                                     SingleChildScrollView(
  //                                   controller: scrollController,
  //                                   child: Column(
  //                                     children: [
  //                                       InvoiceOldPurchaseItemForm(),
  //                                       InvoiceOldMetalParticulars()
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ));
  //                     } else {
  //                       toastification.show(
  //                           context:
  //                               context, // optional if you use ToastificationWrapper
  //                           type: ToastificationType.info,
  //                           title: Text("Fill Billing Details"),
  //                           autoCloseDuration: notificationDuration,
  //                           showProgressBar: false,
  //                           pauseOnHover: false);
  //                     }
  //                   } else {
  //                     if (_manualInvoiceController.selectedGstType.value != null && _manualInvoiceController.isValidCustomer.value) {
  //                       await showModalBottomSheet(
  //                           context: context,
  //                           isDismissible: false,
  //                           isScrollControlled: true,
  //                           // shape: ,
  //                           builder: (_) => DraggableScrollableSheet(
  //                                 expand: false,
  //                                 initialChildSize: 0.7,
  //                                 maxChildSize: 0.7,
  //                                 minChildSize: 0.32,
  //                                 builder: (context, scrollController) =>
  //                                     SingleChildScrollView(
  //                                   controller: scrollController,
  //                                   child: Column(
  //                                     children: [
  //                                       InvoiceOldPurchaseItemForm(),
  //                                       InvoiceOldMetalParticulars()
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ));
  //                     } else {
  //                       toastification.show(
  //                           context:
  //                               context, // optional if you use ToastificationWrapper
  //                           type: ToastificationType.info,
  //                           title: Text("Fill Billing Details"),
  //                           autoCloseDuration: notificationDuration,
  //                           showProgressBar: false,
  //                           pauseOnHover: false);
  //                     }
  //                   }
  //                 }),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         PrimaryButton(
  //             btnWidth: 300,
  //             isLoading: false,
  //             text: 'View Old Metal Details',
  //             onPressed: () async {
  //               await showDialog(
  //                   context: context,
  //                   barrierDismissible: false,
  //                   builder: (_) => ShowOldPurchaseParticuars());
  //             }),
  //       ],
  //     ),
  //   );
  // }

  Container advanceSection(BuildContext context) {
    return Container(
      width: 243.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Advance",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await Get.dialog(
                                barrierDismissible: false,
                                ShowAdvanceParticuars());
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          )),
                      // IconButton(
                      //     onPressed: () async {
                      //       if (_manualInvoiceController.isBranchuser.value) {
                      //         if (_manualInvoiceController.isValidCustomer.value &&
                      //             _manualInvoiceController.selectedBranch.value != null) {
                      //           await showDialog(
                      //               context: context,
                      //               barrierDismissible: false,
                      //               builder: (_) => InvoiceAdvanceForm());
                      //         } else {
                      //           toastification.show(
                      //               context:
                      //                   context, // optional if you use ToastificationWrapper
                      //               type: ToastificationType.info,
                      //               title: Text("Fill Billing Details"),
                      //               autoCloseDuration: notificationDuration,
                      //               showProgressBar: false,
                      //               pauseOnHover: false);
                      //         }
                      //       } else {
                      //         if (_manualInvoiceController.isValidCustomer.value) {
                      //           await showDialog(
                      //               context: context,
                      //               barrierDismissible: false,
                      //               builder: (_) => InvoiceAdvanceForm());
                      //         } else {
                      //           toastification.show(
                      //               context:
                      //                   context, // optional if you use ToastificationWrapper
                      //               type: ToastificationType.info,
                      //               title: Text("Fill Billing Details"),
                      //               autoCloseDuration: notificationDuration,
                      //               showProgressBar: false,
                      //               pauseOnHover: false);
                      //         }
                      //       }
                      //     },
                      //     icon: Icon(
                      //       Icons.add_circle_outline,
                      //       size: 18.sp,
                      //       color: ColorPalete.primaryBtnColor,
                      //     ))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BillingTextInput(
                    width: 180.w,
                    height: 30,
                    filled: true,
                    filledColor: Colors.white,
                    controller: _manualInvoiceController.advanceController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap: _manualInvoiceController.isAdvanceFetchLoading.value
                            ? null
                            : () async {
                                _manualInvoiceController.getManualAdvanceDetails(context);
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: ColorPalete.primaryBtnColor),
                          child: Center(
                            child: Icon(
                              Icons.search,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Container advanceSection(BuildContext context) {
  //   return Container(
  //     width: 300,
  //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             CustomLabel(label: "Advance"),
  //             SizedBox(
  //               height: 7.w,
  //             ),
  //             BillingTextInput(
  //               width: 300,
  //               height: 45,
  //               filled: true,
  //               filledColor: Colors.white,
  //               controller: _manualInvoiceController.advanceController,
  //               textInputAction: TextInputAction.done,
  //               keyboardType: TextInputType.text,
  //               validator: 'no_validation',
  //               onChanged: (value) {},
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Obx(() => PrimaryButton(
  //                 btnWidth: 125,
  //                 isLoading: _manualInvoiceController.isAdvanceFetchLoading.value,
  //                 text: 'Fetch Details',
  //                 onPressed: () {
  //                   _manualInvoiceController.getAdvanceDetails(context);
  //                 })),
  //             SizedBox(
  //               width: 10.w,
  //             ),
  //             SecondaryButton(
  //                 btnWidth: 125,
  //                 isLoading: false,
  //                 text: '+ Add',
  //                 onPressed: () async {
  //                   if (_manualInvoiceController.isValidCustomer.value &&
  //                       _manualInvoiceController.selectedBranch.value != null) {
  //                     await showDialog(
  //                         context: context,
  //                         barrierDismissible: false,
  //                         builder: (_) => InvoiceAdvanceForm());
  //                   } else {
  //                     toastification.show(
  //                         context:
  //                             context, // optional if you use ToastificationWrapper
  //                         type: ToastificationType.info,
  //                         title: Text("Fill Billing Details"),
  //                         autoCloseDuration: notificationDuration,
  //                         showProgressBar: false,
  //                         pauseOnHover: false);
  //                   }
  //                 }),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 7.w,
  //         ),
  //         PrimaryButton(
  //             btnWidth: 300,
  //             isLoading: false,
  //             text: 'View Advance Details',
  //             onPressed: () async {
  //               await showDialog(
  //                   context: context,
  //                   barrierDismissible: false,
  //                   builder: (_) => ShowAdvanceParticuars());
  //             }),
  //       ],
  //     ),
  //   );
  // }

  Container paymentDetails(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? 500 : 400,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text("${_manualInvoiceController.totalAmount.value}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("GST Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text(
                      "${_manualInvoiceController.gstAmount.value.toStringAsFixed(2)}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Discount Amount:",
                  style: Responsive.isDesktop(context)
                      ? TextPalette.screenTitle
                      : TextPalette.tableHeaderTextStyle),
              BillingTextInput(
                filled: true,
                inputFormat: 'double',
                filledColor: Colors.white,
                controller: _manualInvoiceController.discountController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _manualInvoiceController.calculateManualBilling();
                },
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Round Off Amount:",
                  style: Responsive.isDesktop(context)
                      ? TextPalette.screenTitle
                      : TextPalette.tableHeaderTextStyle),
              BillingTextInput(
                inputFormat: 'negative',
                filled: true,
                filledColor: Colors.white,
                controller: _manualInvoiceController.roundOffController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _manualInvoiceController.calculateManualBilling();
                },
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payable Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text("${_manualInvoiceController.payableAmount.value}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Advance Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text("${_manualInvoiceController.advanceAmount.value}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Exchange Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text("${_manualInvoiceController.exchangeAmount.value}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chit Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text("${_manualInvoiceController.chitAmount.value}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sale Return Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text("${_manualInvoiceController.saleReturnAmount.value}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Suspense Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text("${_manualInvoiceController.suspenseAmount.value}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Paid Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text(
                      "${_manualInvoiceController.paidAmount.value.toStringAsFixed(2) ?? "0.0"}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Balance Amount:",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle),
                  Text(
                      "${_manualInvoiceController.balanceAmount.value.toStringAsFixed(2) ?? "0.00"}",
                      style: Responsive.isDesktop(context)
                          ? TextPalette.screenTitle
                          : TextPalette.tableHeaderTextStyle)
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => PrimaryButton(
                  btnWidth: 200,
                  isLoading: _manualInvoiceController.isSaveBillingLoading.value,
                  text: 'Save',
                  onPressed: () {
                    _manualInvoiceController.createManualBilling(context, false);
                  })),
              Obx(() => PrimaryButton(
                  btnWidth: 200,
                  isLoading: _manualInvoiceController.isSaveBillingLoading.value,
                  text: 'Save & Print',
                  onPressed: () {
                    _manualInvoiceController.createManualBilling(context, true);
                  })),
            ],
          )
        ],
      ),
    );
  }

  Container addedFunctions(BuildContext context) {
    return Container(
      // width: Responsive.isDesktop(context) ? 550 : 550,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(label: "Sales Return"),
                  SizedBox(
                    height: 7.w,
                  ),
                  BillingTextInput(
                    width: 250,
                    height: 45,
                    filled: true,
                    readOnly: true,
                    filledColor: Colors.white,
                    controller: _manualInvoiceController.salesReturnController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              PrimaryButton(
                  btnWidth: 125,
                  isLoading: false,
                  text: 'Fetch Details',
                  onPressed: () {}),
              SizedBox(
                width: 10.w,
              ),
              SecondaryButton(
                  btnWidth: 75,
                  isLoading: false,
                  text: '+ Add',
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox billingDate() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Bill Date"),
          SizedBox(
            height: 7.w,
          ),
          BillingTextInput(
            height: 50,
            width: 150,
            filled: true,
            controller: _manualInvoiceController.billingDate,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Bill Date",
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _manualInvoiceController.billingDate.text =
                    pickedDate.toString().substring(0, 10);

                DateTime now = DateTime.now();
                String formattedDate =
                    DateFormat('yyyy-M-dd kk:mm:ss').format(now);
                _manualInvoiceController.billingDateTimeController.text =
                    formattedDate.toString();
              } else {
                _manualInvoiceController.billingDate.clear();
                _manualInvoiceController.billingDateTimeController.clear();
              }
            },
            onChanged: (value) {},
          )
        ],
      ),
    );
  }

  SizedBox customerMobile() {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Customer Mobile"),
          SizedBox(height: 7.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                height: 75,
                child: BillingTextInput(
                  filled: true,
                  maxLength: 10,
                  inputFormat: 'integer',
                  controller: _manualInvoiceController.customerMobileController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: "phone",
                  hintText: "Customer Mobile",
                  onChanged: (value) {
                    log("hi check");
                    _manualInvoiceController.findCustomer(value, context);
                  },
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Obx(() => _manualInvoiceController.isVerifyCustomerLoading.value
                  ? CircularProgressIndicator()
                  : _manualInvoiceController.isValidCustomer.value
                      ? Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: ColorPalete.primaryBtnColor,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 25.sp,
                            color: Colors.white,
                          ),
                        )
                      : IconButton(
                          onPressed: () async {
                            await Get.dialog(
                                barrierDismissible: false,
                                CustomerCreationCommonPopup(
                                      onSubmit: _manualInvoiceController
                                          .submitCustomerCreationForm,
                                    ));
                          },
                          icon: Icon(Icons.add_circle_outline_outlined,
                              size: 25.sp, color: ColorPalete.primaryColor))),
              Obx(() => Text(
                    _manualInvoiceController
                            .customerDetails.value.customerName?.capitalize ??
                        "",
                    style: TextStyle(
                        color: ColorPalete.primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  SizedBox gstType() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "GST Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _manualInvoiceController.selectedGstType.value,
                options: _manualInvoiceController.gstTypeDropDown.value,
                onChanged: _manualInvoiceController.particulars.isNotEmpty
                    ? null
                    : (DropdownModel? value) {
                        _manualInvoiceController.selectedGstType(value);
                      },
                hintText: "GST Type",
              ))
        ],
      ),
    );
  }

  SizedBox metal() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _manualInvoiceController.selectedMetal.value,
                options: _manualInvoiceController.metalDropDown.value,
                onChanged:_manualInvoiceController.particulars.isNotEmpty
                    ? null
                    : (DropdownModel? value) {
                        _manualInvoiceController.selectedMetal(value);
                      },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 150,
      // height: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => BillingDropdownSearchField(
                filled: true,
                controller: _manualInvoiceController.branchSearchController,
                selectedValue: _manualInvoiceController.selectedBranch.value,
                options: _manualInvoiceController.branchDropDown.value,
                onChanged: (value) {
                  _manualInvoiceController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

}
