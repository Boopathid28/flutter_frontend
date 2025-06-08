import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/model/invoice/invoice_view_payment_details_models.dart';
import 'package:ausales_application/service/invoice/invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceViewPaymentDetailsController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<RetrievePaymentDetailListData> tableData = <RetrievePaymentDetailListData>[].obs;

  RxDouble totalPaid = 0.0.obs;
  RxString paymentDate = "".obs;
  RxString customerName = "".obs;
  RxString customerMobile = "".obs;

  RxBool isLoading = true.obs;
  RxBool isNotFound = false.obs;

  Future getBillingPaymentDetails(BuildContext context) async {
    isLoading(true);
    var args = Get.arguments;
    final Map<String, dynamic>? data = await InvoiceService.retrieveBillingPaymentDetail(context: context, billId: args.toString()
    );

    if (data != null) {
      tableData(data['list']);
      totalPaid(data['data']['total_paid_amount']);
      paymentDate(data['data']['last_payment_date']);
      customerName(data['data']['customer_name']);
      customerMobile(data['data']['customer_mobile']);
    } else {
      isNotFound(true);
    }
    isLoading(false);
  }
}