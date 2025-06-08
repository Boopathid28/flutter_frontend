import 'package:ausales_application/controller/vendor_payment/vendor_payment_view_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_view/vendor_payment_view_cash_particulars.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_view/vendor_payment_view_metal_particulars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentViewScreen extends StatefulWidget {
  const VendorPaymentViewScreen({super.key});

  @override
  State<VendorPaymentViewScreen> createState() =>
      _VendorPaymentViewScreenState();
}

class _VendorPaymentViewScreenState extends State<VendorPaymentViewScreen> {
  final VendorPaymentViewController _vendorPaymentViewController =
      Get.put(VendorPaymentViewController());

  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    _vendorPaymentViewController.getVendorPayDetails(context, args.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _vendorPaymentViewController.scaffoldKey,
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
                            "View Vendor Payment Details",
                            style: Responsive.isDesktop(context)
                                ? TextPalette.screenTitle
                                : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
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
                              "${_vendorPaymentViewController.vendorDetails.value.vendorDetailsName ?? ""}",
                              style: TextPalette.viewDetailsDataTextStyle,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ledgerDetails(context, size)),

              SizedBox(
                height: 15.h,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VendorPaymentViewCashParticulars(),
                  VendorPaymentViewMetalParticulars(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox ledgerDetails(BuildContext context, Size size) {
    return SizedBox(
      width: size.width,
      child: Obx(() => Wrap(
            runSpacing: 20.h,
            spacing: 20.w,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Payment Id: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _vendorPaymentViewController.vendorDetails.value.paymentId.toString(),
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Payment Date: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${DateHelper.convertDate(_vendorPaymentViewController.vendorDetails.value.paymentDate.toString())}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Payment Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorPaymentViewController.vendorDetails.value.paymentWeight?.toStringAsFixed(3)} g",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Payment Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorPaymentViewController.vendorDetails.value.paymentAmount?.toStringAsFixed(2)}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Remarks: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorPaymentViewController.vendorDetails.value.remark.toString()}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
