import 'package:ausales_application/controller/estimation/estimation_chit_scheme_controller.dart';
import 'package:ausales_application/controller/estimation/estimation_controller.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class EstimationScreen extends StatefulWidget {
  const EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  final EstimationController _estimationController =
      Get.put(EstimationController());

  final EstimationChitSchemeController _estimationChitSchemeController =
      Get.put(EstimationChitSchemeController());

  @override
  Widget build(BuildContext context) {
    return ShorcutKeyboardHandler(
      scaffoldKey: _estimationController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _estimationController.scaffoldKey,
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
                      child: Text("Estimation",
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
                          Obx(() => _estimationController.isBranchuser.value
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
                    visible: _estimationController.isBranchuser.value
                        ? (_estimationController.selectedGstType.value !=
                                    null &&
                                _estimationController.selectedBranch.value !=
                                    null &&
                                _estimationController
                                    .estimationDate.text.isNotEmpty &&
                                _estimationController.isValidCustomer.value)
                            ? true
                            : false
                        : (_estimationController.selectedGstType.value !=
                                    null &&
                                _estimationController
                                    .estimationDate.text.isNotEmpty &&
                                _estimationController.isValidCustomer.value)
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
                              child: EstimationItemForm()),
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
                        EstimationItemTable(),
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
                controller: _estimationController.totalPayableController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _estimationController.onTotalPayableAmountChanged();
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
                    child: Text("${_estimationController.balanceAmount.value}",
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
              isLoading: _estimationController.isSaveEstimationLoading.value,
              text: 'Save',
              onPressed: () {
                _estimationController.createEstimation(context, false);
              })),
          SizedBox(
            height: 5.h,
          ),
          Obx(() => PrimaryButton(
              btnWidth: double.infinity,
              btnHeight: 35,
              isLoading: _estimationController.isSaveEstimationLoading.value,
              text: 'Save & Print',
              onPressed: () {
                _estimationController.createEstimation(context, true);
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
                    child: Text("${_estimationController.advanceAmount.value}",
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
                    child: Text("${_estimationController.exchangeAmount.value}",
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
                        "${_estimationController.saleReturnAmount.value}",
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
                    child: Text("${_estimationController.chitAmount.value}",
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
                    child: Text("${_estimationController.totalAmount.value}",
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
                    child: Text("${_estimationController.gstAmount.value}",
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
                controller: _estimationController.discountController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _estimationController.calculateBilling();
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
                controller: _estimationController.roundOffController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  _estimationController.calculateBilling();
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
                        _estimationChitSchemeController.chitSchemeReset();
                        _estimationChitSchemeController
                            .selectedTagItemIdsList([]);
                        _estimationChitSchemeController
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
                controller: _estimationController.chitMobileController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: 'no_validation',
                onChanged: (value) {},
              ),
              Obx(() => GestureDetector(
                    onTap: _estimationChitSchemeController
                            .isCitSchemeFetchLoading.value
                        ? null
                        : () async {
                            if (_estimationController
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
                              _estimationChitSchemeController
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
                                ShowOldPurchaseParticuars());
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          )),
                      IconButton(
                          onPressed: () async {
                            if (_estimationController.selectedGstType.value !=
                                null) {
                              await Get.bottomSheet(
                                  isDismissible: false,
                                  Container(
                                    height: 700,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                EstimationOldPurchaseItemForm(),
                                                EstimationOldMetalParticulars()
                                              ],
                                            ),
                                        ),
                                  ));
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
                    controller: _estimationController.oldMetalController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap:
                            _estimationController.isOldMetalFetchLoading.value
                                ? null
                                : () async {
                                    _estimationController
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
                                ShowAdvanceParticuars());
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorPalete.primaryBtnColor,
                          )),
                      // IconButton(
                      //     onPressed: () async {
                      //       if (_estimationController.isBranchuser.value) {
                      //         if (_estimationController.isValidCustomer.value &&
                      //             _estimationController.selectedBranch.value !=
                      //                 null) {
                      //           await showDialog(
                      //               context: context,
                      //               barrierDismissible: false,
                      //               builder: (_) => EstimationAdvanceForm());
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
                      //         if (_estimationController.isValidCustomer.value) {
                      //           await showDialog(
                      //               context: context,
                      //               barrierDismissible: false,
                      //               builder: (_) => EstimationAdvanceForm());
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
                    controller: _estimationController.advanceController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: 'no_validation',
                    onChanged: (value) {},
                  ),
                  Obx(() => GestureDetector(
                        onTap: _estimationController.isAdvanceFetchLoading.value
                            ? null
                            : () async {
                                _estimationController
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
            controller: _estimationController.estimationDate,
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
                _estimationController.estimationDate.text =
                    pickedDate.toString().substring(0, 10);

                DateTime now = DateTime.now();
                String formattedDate =
                    DateFormat('yyyy-M-dd kk:mm:ss').format(now);
                _estimationController.estimationDateTimeController.text =
                    formattedDate.toString();
              } else {
                _estimationController.estimationDate.clear();
                _estimationController.estimationDateTimeController.clear();
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
                  controller: _estimationController.customerMobileController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: "phone",
                  hintText: "Customer Mobile",
                  onChanged: (value) {
                    _estimationController.findCustomer(value, context);
                  },
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Obx(() => _estimationController.isVerifyCustomerLoading.value
                  ? CircularProgressIndicator()
                  : _estimationController.isValidCustomer.value
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
                                      onSubmit: _estimationController
                                          .submitCustomerCreationForm,
                                    ));
                          },
                          icon: Icon(Icons.add_circle_outline_outlined,
                              size: 25.sp, color: ColorPalete.primaryColor))),
              Obx(() => Text(
                    _estimationController
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
                selectedValue: _estimationController.selectedMetal.value,
                options: _estimationController.metalDropDown.value,
                onChanged: (value) {
                  _estimationController.selectedMetal(value);
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
                selectedValue: _estimationController.selectedGstType.value,
                options: _estimationController.gstTypeDropDown.value,
                onChanged: _estimationController.particulars.isNotEmpty
                    ? null
                    : (DropdownModel? value) {
                        _estimationController.selectedGstType(value);
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
                controller: _estimationController.branchSearchController,
                selectedValue: _estimationController.selectedBranch.value,
                options: _estimationController.branchDropDown.value,
                onChanged: (value) {
                  _estimationController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
