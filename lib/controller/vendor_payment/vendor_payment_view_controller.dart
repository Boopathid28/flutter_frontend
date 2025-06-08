import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_view_models.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPaymentViewController {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxObjectMixin<VendorPaymentListDataDetailsResponse> vendorDetails = VendorPaymentListDataDetailsResponse().obs;

  Future getVendorPayDetails(BuildContext context, String paymentId) async {

    int? menuId = await HomeSharedPrefs.getCurrentMenu();

    final VendorPaymentListDataDetailsResponse? data = await VendorPaymentService.retrieveVendorPayment(menuId: menuId.toString(), id: paymentId, context: context);

    if (data != null) {
      vendorDetails(data);
    } else {
      vendorDetails(VendorPaymentListDataDetailsResponse());
    }
  }
}