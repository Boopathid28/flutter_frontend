import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/melting_receipt/melting_receipt_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/melting_receipt/melting_receipt_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/melting_receipt/melting_receipt_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateMeltingReceiptFormController extends HeaderController {
  final MeltingReceiptListController _meltingReceiptListController =
      Get.put(MeltingReceiptListController());
  final updatemeltingreceiptFormKey = GlobalKey<FormState>();

  Rx<MeltingReceiptListData?> currentMelting =
      Rx<MeltingReceiptListData?>(null);

  TextEditingController receivedweightController = TextEditingController();
  TextEditingController meltingChargesController = TextEditingController();
  TextEditingController gstpercentController = TextEditingController();
  TextEditingController gstamountController = TextEditingController();
  TextEditingController vendorchargesController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  @override

  Future UpdateCreateMeltingReceipt(BuildContext context) async {
    if (updatemeltingreceiptFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        UpdateMeltingReceiptPaylaod payload = UpdateMeltingReceiptPaylaod(
            id: currentMelting.value?.id,
            receivedWeight: double.parse(receivedweightController.text),
            meltingCarges: double.parse(meltingChargesController.text),
            gstPercent: double.parse(gstpercentController.text),
            gstAmount: double.parse(gstamountController.text),
            vendorCharges: double.parse(vendorchargesController.text),
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final Map<String, dynamic>? updateMeltingReceiptList =
            await MeltingReceiptService.updateMeltingReceiptList(
                payload: payload, context: context);
        _meltingReceiptListController.getmeltingReceiptList(context);
        resetForm();
        Get.back();
      }
    }
  }

  void calculateGstAmount(
      {required String meltingcharge, required String gstPercent}) {
    final double meltingCharge =
        double.parse(meltingcharge.isEmpty ? "0.0" : meltingcharge);
    final double gstpercent =
        double.parse(gstPercent.isEmpty ? "0.0" : gstPercent);

    final gstamount = (gstpercent / 100) * meltingCharge;

    final vendorCharge = gstamount + meltingCharge;

    gstamountController.text = gstamount.toString();

    vendorchargesController.text = vendorCharge.toString();
  }

  resetForm() {
    selectedBranch.value = null;
    receivedweightController.clear();
    gstamountController.clear();
    gstpercentController.clear();
    vendorchargesController.clear();
    meltingChargesController.clear();
  }
}
