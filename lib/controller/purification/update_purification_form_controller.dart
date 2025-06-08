import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/purification/purification_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/purification/purification_models.dart';
import 'package:ausales_application/service/purification/purification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePurificationFormController extends HeaderController {
  final PurificationListController _purificationListController =
      Get.put(PurificationListController());
  final updatepurificationFormKey = GlobalKey<FormState>();

  Rx<PurificationListData?> currentPurification =
      Rx<PurificationListData?>(null);

  TextEditingController receivedweightController = TextEditingController();
  TextEditingController receivedtouchController = TextEditingController();
  TextEditingController purificationChargesController = TextEditingController();
  TextEditingController gstpercentController = TextEditingController();
  TextEditingController gstamountController = TextEditingController();
  TextEditingController vendorchargesController = TextEditingController();

  RxBool isFormSubmit = false.obs;

  @override

  Future UpdatePurification(BuildContext context) async {
    if (updatepurificationFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        UpdatePurificationPayload payload = UpdatePurificationPayload(
            id: currentPurification.value?.id,
            receivedWeight: double.parse(receivedweightController.text),
            purificationCharges: double.parse(purificationChargesController.text),
            recievedTouch: double.parse(receivedtouchController.text),
            gstPercent: double.parse(gstpercentController.text),
            gstAmount: double.parse(gstamountController.text),
            vendorCharges: double.parse(vendorchargesController.text),
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final Map<String, dynamic>? updatePurification =
            await PurificationService.updatePurification(
                payload: payload, context: context);
        _purificationListController.getPurificationList(context);
        resetForm();
        Get.back();
      }
    }
  }

  void calculateGstAmount(
      {required String purificationcharge, required String gstPercent}) {
    final double purificationCharge =
        double.parse(purificationcharge.isEmpty ? "0.0" : purificationcharge);
    final double gstpercent =
        double.parse(gstPercent.isEmpty ? "0.0" : gstPercent);

    final gstamount = (gstpercent / 100) * purificationCharge;

    final vendorCharge = gstamount + purificationCharge;

    gstamountController.text = gstamount.toString();

    vendorchargesController.text = vendorCharge.toString();
  }

  resetForm() {
    receivedweightController.clear();
    gstamountController.clear();
    gstpercentController.clear();
    vendorchargesController.clear();
    receivedtouchController.clear();
    purificationChargesController.clear();
  }
}
