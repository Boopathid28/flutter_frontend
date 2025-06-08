import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/suspense/suspense_service.dart';
import 'package:ausales_application/view/screens/suspense/suspense_view_details_screen.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/payment/payment_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class SuspensePaymentController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final SuspenseListController _suspenseListController =
      Get.put(SuspenseListController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Rx<SuspenseDetailsData?> currentPayment = Rx<SuspenseDetailsData?>(null);

  final suspensepaymentformkey = GlobalKey<FormState>();

  TextEditingController branchSearchController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool add = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;

  RxList<DenominationDetails> denominationDetailsParticulars =
      <DenominationDetails>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future CreatePayment(BuildContext context) async {
    if (suspensepaymentformkey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        if (denominationDetailsParticulars.isNotEmpty) {
          CreateSuspensePaymentPayload payload = CreateSuspensePaymentPayload(
              id: currentPayment.value!.id,
              branch: selectedBranch.value?.value,
              denominationDetails: denominationDetailsParticulars,
              menuId: await HomeSharedPrefs.getCurrentMenu());

          final CreateSuspensePaymentResponse? data =
              await SuspenseService.createPayment(
                  payload: payload, context: context);
          if (data != null) {
            _suspenseListController.getsuspenseList(context);
            Get.back();
            resetForm();
            denominationDetailsParticulars([]);
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Add at least one payment method"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
        isFormSubmit(false);
      }
    }
  }



  Future getSuspenseDetails(
      BuildContext context, SuspenseListData item) async {

    final SuspenseDetailsData? data =
        await SuspenseService.retrieveSuspenseDetail(
            context: context, SuspenseId: item.id.toString());

    if (data != null) {

      currentPayment(data);

      await Get.dialog(
          barrierDismissible: false,
          PaymentDetailPopup());

    } else {
      resetForm();
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    suspensepaymentformkey.currentState!.reset();
    selectedBranch.value = null;
    fromMode("create");
  }
}
