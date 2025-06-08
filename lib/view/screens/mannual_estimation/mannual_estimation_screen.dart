import 'package:ausales_application/controller/estimation/estimation_chit_scheme_controller.dart';
import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_chit_scheme_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_dropdown_field.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_advance/show_advance_particuars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_item_table.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_old_metal/estimation_old_metal_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_old_metal/estimation_old_purchase_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_old_metal/show_old_purchase_particuars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_advance/mannual_show_advance_particuars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_item_table.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_old_metal/mannual_estimation_old_metal_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_old_metal/mannual_estimation_old_purchase_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_old_metal/mannual_show_old_purchase_particuars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class MannualEstimationScreen extends StatefulWidget {
  const MannualEstimationScreen({super.key});

  @override
  State<MannualEstimationScreen> createState() =>
      _MannualEstimationScreenState();
}

class _MannualEstimationScreenState extends State<MannualEstimationScreen> {
  final MannualEstimationController _mannualEstimationController =
      Get.put(MannualEstimationController());

  final MannualEstimationChitSchemeController
      _mannualEstimationChitSchemeController =
      Get.put(MannualEstimationChitSchemeController());

  @override
  Widget build(BuildContext context) {
    return ShorcutKeyboardHandler(
      scaffoldKey: _mannualEstimationController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _mannualEstimationController.scaffoldKey,
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
                      child: Text("Manual Estimation",
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
                          estimationDate(),
                          Obx(() =>
                              _mannualEstimationController.isBranchuser.value
                                  ? branch()
                                  : SizedBox()),
                          gstType(),
                          metal(),
                          customerMobile()
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
                    visible: _mannualEstimationController.isBranchuser.value
                        ? (_mannualEstimationController
                                        .selectedGstType.value !=
                                    null &&
                                _mannualEstimationController
                                        .selectedBranch.value !=
                                    null &&
                                _mannualEstimationController
                                    .estimationDate.text.isNotEmpty &&
                                _mannualEstimationController
                                    .isValidCustomer.value)
                            ? true
                            : false
                        : (_mannualEstimationController.selectedGstType.value !=
                                    null &&
                                _mannualEstimationController
                                    .estimationDate.text.isNotEmpty &&
                                _mannualEstimationController
                                    .isValidCustomer.value)
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
                              child: MannualEstimationItemForm()),
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
                        MannualEstimationItemTable(),
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
                              paymentSectionOne(context),
                              paymentSectionTwo(context),
                              paymentSectionThree(context),
                            ],
                          ),
              ),
              SizedBox(
                height: defaultBottombarHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container paymentSectionThree(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: 250.w,
      child: Column(
        children: [
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
                controller: _mannualEstimationController.totalPayableController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _mannualEstimationController.onTotalPayableAmountChanged();
                },
              )
            ],
          ),
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
                    child: Text(
                        "${_mannualEstimationController.balanceAmount.value}",
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
              isLoading:
                  _mannualEstimationController.isSaveEstimationLoading.value,
              text: 'Print',
              onPressed: () {
                _mannualEstimationController.getPrint(
                  context,
                );
              })),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => PrimaryButton(
              btnWidth: double.infinity,
              btnHeight: 35,
              isLoading:
                  _mannualEstimationController.isSaveEstimationLoading.value,
              text: 'Save & Print',
              onPressed: () {
                _mannualEstimationController.createEstimation(context, true);
              })),
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
                    child: Text(
                        "${_mannualEstimationController.advanceAmount.value}",
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
                    child: Text(
                        "${_mannualEstimationController.exchangeAmount.value}",
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
                    child: Text(
                        "${_mannualEstimationController.saleReturnAmount.value}",
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
                    child: Text(
                        "${_mannualEstimationController.chitAmount.value}",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp)),
                  )
                ],
              )),
        ],
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
                    child: Text(
                        "${_mannualEstimationController.totalAmount.value}",
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
                    child: Text(
                        "${_mannualEstimationController.gstAmount.value}",
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
                controller: _mannualEstimationController.discountController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _mannualEstimationController.calculateBilling();
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
                controller: _mannualEstimationController.roundOffController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _mannualEstimationController.calculateBilling();
                },
              )
            ],
          ),
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
                        _mannualEstimationChitSchemeController
                            .chitSchemeReset();
                        _mannualEstimationChitSchemeController
                            .selectedTagItemIdsList([]);
                        _mannualEstimationChitSchemeController
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
                controller: _mannualEstimationController.chitMobileController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: 'no_validation',
                onChanged: (value) {},
              ),
              Obx(() => GestureDetector(
                    onTap: _mannualEstimationChitSchemeController
                            .isCitSchemeFetchLoading.value
                        ? null
                        : () async {
                            if (_mannualEstimationController
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
                              _mannualEstimationChitSchemeController
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
                                    MannualShowOldPurchaseParticuars());
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          )),
                      IconButton(
                          onPressed: () async {
                            if (_mannualEstimationController
                                    .selectedGstType.value !=
                                null) {
                              await Get.bottomSheet(
                                  isDismissible: false,
                                  Container(
                                      height: 700,
                                      color: Colors.white,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            MannualEstimationOldPurchaseItemForm(),
                                            MannualEstimationOldMetalParticulars()
                                          ],
                                        ),
                                      )));
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
                    controller: _mannualEstimationController.oldMetalController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap: _mannualEstimationController
                                .isOldMetalFetchLoading.value
                            ? null
                            : () async {
                                _mannualEstimationController
                                    .getOldMetalDetails(context);
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
                                MannualShowAdvanceParticuars());
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          )),
                      // IconButton(
                      //     onPressed: () async {
                      //       if (_mannualEstimationController.isBranchuser.value) {
                      //         if (_mannualEstimationController.isValidCustomer.value &&
                      //             _mannualEstimationController.selectedBranch.value !=
                      //                 null) {
                      //           await showDialog(
                      //               context: context,
                      //               barrierDismissible: false,
                      //               builder: (_) => MannualEstimationAdvanceForm());
                      //         } else {
                      //           toastification.show(
                      //               context:
                      //                   context, // optional if you use ToastificationWrapper
                      //               type: ToastificationType.info,
                      //               title: Text("Select GST Type & Branch"),
                      //               autoCloseDuration: notificationDuration,
                      //               showProgressBar: false,
                      //               pauseOnHover: false);
                      //         }
                      //       } else {
                      //         if (_mannualEstimationController.isValidCustomer.value) {
                      //           await showDialog(
                      //               context: context,
                      //               barrierDismissible: false,
                      //               builder: (_) => MannualEstimationAdvanceForm());
                      //         } else {
                      //           toastification.show(
                      //               context:
                      //                   context, // optional if you use ToastificationWrapper
                      //               type: ToastificationType.info,
                      //               title: Text("Select GST Type"),
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
                    controller: _mannualEstimationController.advanceController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap: _mannualEstimationController
                                .isAdvanceFetchLoading.value
                            ? null
                            : () async {
                                _mannualEstimationController
                                    .getAdvanceDetails(context);
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

  SizedBox estimationDate() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Estimation Date"),
          SizedBox(
            height: 7.w,
          ),
          BillingTextInput(
            height: 50,
            width: 200,
            filled: true,
            controller: _mannualEstimationController.estimationDate,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Estimation Date",
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
                _mannualEstimationController.estimationDate.text =
                    pickedDate.toString().substring(0, 10);

                DateTime now = DateTime.now();
                String formattedDate =
                    DateFormat('yyyy-M-dd kk:mm:ss').format(now);
                _mannualEstimationController.estimationDateTimeController.text =
                    formattedDate.toString();
              } else {
                _mannualEstimationController.estimationDate.clear();
                _mannualEstimationController.estimationDateTimeController
                    .clear();
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
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Customer Mobile"),
          SizedBox(height: 7.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                height: 75,
                child: BillingTextInput(
                  filled: true,
                  maxLength: 10,
                  inputFormat: 'integer',
                  controller:
                      _mannualEstimationController.customerMobileController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: "phone",
                  hintText: "Customer Mobile",
                  onChanged: (value) {
                    _mannualEstimationController.findCustomer(value, context);
                  },
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Obx(() =>
                  _mannualEstimationController.isVerifyCustomerLoading.value
                      ? CircularProgressIndicator()
                      : _mannualEstimationController.isValidCustomer.value
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
                                          onSubmit: _mannualEstimationController
                                              .submitCustomerCreationForm,
                                        ));
                              },
                              icon: Icon(Icons.add_circle_outline_outlined,
                                  size: 25.sp,
                                  color: ColorPalete.primaryColor))),
              Obx(() => Text(
                    _mannualEstimationController
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

  SizedBox metal() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue: _mannualEstimationController.selectedMetal.value,
                options: _mannualEstimationController.metalDropDown.value,
                onChanged: (value) {
                  _mannualEstimationController.selectedMetal(value);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }

  SizedBox gstType() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingLabel(label: "GST Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => BillingDropdownField(
                filled: true,
                selectedValue:
                    _mannualEstimationController.selectedGstType.value,
                options: _mannualEstimationController.gstTypeDropDown.value,
                onChanged: _mannualEstimationController.particulars.isNotEmpty
                    ? null
                    : (DropdownModel? value) {
                        _mannualEstimationController.selectedGstType(value);
                      },
                hintText: "GST Type",
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
                controller: _mannualEstimationController.branchSearchController,
                selectedValue:
                    _mannualEstimationController.selectedBranch.value,
                options: _mannualEstimationController.branchDropDown.value,
                onChanged: (value) {
                  _mannualEstimationController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
