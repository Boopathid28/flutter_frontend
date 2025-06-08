import 'dart:developer';

import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/vendor_payment/vendor_payment_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class VendorPaymentFormController extends HeaderController {

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final VendorPaymentListController _vendorPaymentListController = Get.put(VendorPaymentListController());

  final vendorPaymentFormKey = GlobalKey<FormState>();

  RxObjectMixin<VendorPaymentRetrieveData> vendorPaymentDetails =
      VendorPaymentRetrieveData().obs;

  TextEditingController branchSearchController = TextEditingController();

  TextEditingController metalWeightController = TextEditingController();
  TextEditingController touchController = TextEditingController();
  TextEditingController pureWeightController = TextEditingController();
  TextEditingController metalRateController = TextEditingController();
  TextEditingController pureRateController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  TextEditingController remarksController = TextEditingController();
  TextEditingController refferedController = TextEditingController();

  Rx<DropdownModel?> selectedPaymentType = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedTouch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentMethod = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentProvider = Rx<DropdownModel?>(null);

  RxList<DropdownModel> paymentTypeDropDown = <DropdownModel>[
    DropdownModel(value: 'm2m', label: "Metal To Metal"),
    // DropdownModel(value: 'c2m', label: "Cash To Metal"),
    DropdownModel(value: 'c2c', label: "Cash To Cash"),
    DropdownModel(value: 'm2c', label: "Metal To Cash"),
  ].obs;
  RxList<DropdownModel> paymentMethodDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> touchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentProviderDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  RxList<WeightDetails> metalPariculars = <WeightDetails>[].obs;
  RxList<PaymentDetails> cashPariculars = <PaymentDetails>[].obs;

  RxList<Map> metalCalcuationList = <Map>[].obs;
  RxList<Map> cashCalcuationList = <Map>[].obs;

  RxList<PaymentDetails> subCashPariculars = <PaymentDetails>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool viewLedgerDetails = false.obs;

  RxString formMode = "create".obs;

  RxDouble totalPaidWeight = 0.0.obs;
  RxDouble totalPaidAmount = 0.0.obs;

  RxString remaingTouchPureWeight = "".obs;

  RxList<OldMetalTouchDropDownModel> touchList = <OldMetalTouchDropDownModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getPaymentMethodList();
    bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }
    getMetalList();
    getTouchList();
  }
  
  
  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown
          .add(DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    tempList.forEach((item) {
      metalDropDown
          .add(DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
  }

  Future getTouchList() async {
    touchDropDown([]);
    final List<OldMetalTouchDropDownModel> tempList =
        await DropdownService.oldMetalTouchDropDown();
    touchList(tempList);
    tempList.forEach((item) {
      touchDropDown
          .add(DropdownModel(label: "${item.touch.toString()}(${item.remainingWeight.toString()}g)", value: item.touch.toString()));
    });
  }

  Future getPaymentMethodList() async {
    paymentMethodDropDown([]);
    final List<PaymentMethodDropDown> tempList =
        await DropdownService.paymentMethodDropDown();
    tempList.forEach((item) {
      paymentMethodDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getPaymentProviderList({required String method}) async {
    paymentProviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentProviderDropDown> tempList =
        await DropdownService.paymentProviderDropDown(paymentMethod: method);
    tempList.forEach((item) {
      paymentProviderDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getVendorPaymentDetails(BuildContext context, String vendorId) async {
    int? menuId = await HomeSharedPrefs.getCurrentMenu();
    final VendorPaymentRetrieveData? data =
        await VendorPaymentService.retrieveVendorPaymentDetails(
            menuId: menuId.toString(), vendorId: vendorId, context: context);

    if (data != null) {
      vendorPaymentDetails(data);
    }
  }

  void calculatePayment() {
    if (selectedPaymentType.value?.value == "m2m") {
      double metalWeight = double.parse(metalWeightController.text.isEmpty
          ? "0"
          : metalWeightController.text);
      double touch = double.parse(selectedTouch.value == null ? "0" : selectedTouch.value!.value);

      pureWeightController.text =
          (metalWeight * (touch / 100)).toStringAsFixed(3);
    } else if (selectedPaymentType.value?.value == "c2m") {
      double amount = double.parse(
          amountController.text.isEmpty ? "0" : amountController.text);
      double metalRate = double.parse(
          metalRateController.text.isEmpty ? "0" : metalRateController.text);
      double metalWeight = amount / metalRate;

      double touch = double.parse(selectedTouch.value == null ? "0" : selectedTouch.value!.value);

      metalWeightController.text = metalWeight.toStringAsFixed(3);
      pureWeightController.text =
          (metalWeight * (touch / 100)).toStringAsFixed(3);
    } else if (selectedPaymentType.value?.value == "m2c") {
      double pureWeight = double.parse(
          pureWeightController.text.isEmpty ? "0" : pureWeightController.text);
      double pureRate = double.parse(
          pureRateController.text.isEmpty ? "0" : pureRateController.text);

      amountController.text = (pureWeight * pureRate).toStringAsFixed(2);
    }
  }

  void deleteMetalParticulars(String id) {

    metalCalcuationList.removeWhere((item) {
      return item['id'] == id;
    });
    cashCalcuationList.removeWhere((item) {
      return item['id'] == id;
    });
    metalPariculars.removeWhere((item) => item.id == id);
    calculateTotalWeightAmount();
  }

  void deleteCashParticulars(String id) {
    metalCalcuationList.removeWhere((item) {
      return item['id'] == id;
    });
    cashCalcuationList.removeWhere((item) {
      return item['id'] == id;
    });
    cashPariculars.removeWhere((item) => item.id == id);

    calculateTotalWeightAmount();
  }

  void calculateTotalWeightAmount() {
    double totalAmount = 0.0;
    for (var i in cashCalcuationList) {
      totalAmount += i['cash'];
    }

    double totalWeight = 0.0;
    for (var i in metalCalcuationList) {
      totalWeight += i['metal'];
    }

    totalPaidAmount(totalAmount);
    totalPaidWeight(totalWeight);
  }

  void submitPaymentForm(BuildContext context) {
    if (vendorPaymentFormKey.currentState!.validate()) {
      if (formMode.value == "create") {
        if (selectedPaymentType.value?.value == "m2m" ||
            selectedPaymentType.value?.value == "c2m") {
          var uuid = Uuid();
          var id = uuid.v4();

          WeightDetails details = WeightDetails(
            id: id,
            paymentType: selectedPaymentType.value?.value,
            metalWeight: double.parse(metalWeightController.text.isEmpty
                ? "0"
                : metalWeightController.text),
            touch: double.parse(selectedTouch.value!.value),
            metalDetails: selectedMetal.value?.value,
            refferedBy: refferedController.text,
            remarks: remarksController.text,
            pureWeight: double.parse(pureWeightController.text.isEmpty
                ? "0"
                : pureWeightController.text),
          );

          metalPariculars.insert(0, details);


          if (selectedPaymentType.value?.value == "m2m") {
            metalCalcuationList.add({
              "metal": double.parse(pureWeightController.text.isEmpty
                ? "0"
                : pureWeightController.text),
                "id": id
            });
          } else if (selectedPaymentType.value?.value == "c2m") {
            cashCalcuationList.add({
              "cash": double.parse(amountController.text.isEmpty
                ? "0"
                : amountController.text),
                "id": id
            });
          }
        } else {
          var uuid = Uuid();
          var id = uuid.v4();

          PaymentDetails details = PaymentDetails(
              id: id,
              paymentType: selectedPaymentType.value?.value,
              metalRate: double.parse(
                  pureRateController.text.isEmpty ? "0" : pureRateController.text),
              pureWeight: double.parse(
                  pureWeightController.text.isEmpty ? "0" : pureWeightController.text),
              amount: double.parse(
                  amountController.text.isEmpty ? "0" : amountController.text),
              paymentMethodName: selectedPaymentMethod.value?.label,
              paymentMethod: selectedPaymentMethod.value?.value,
              paymentProviders: selectedPaymentProvider.value?.value,
              remarks: remarksController.text,
              refferedBy: refferedController.text,
              paymentProvidersName: selectedPaymentProvider.value?.label);

          cashPariculars.insert(0, details);

          if (selectedPaymentType.value?.value == "c2c") {
            cashCalcuationList.add({
              "cash": double.parse(amountController.text.isEmpty
                ? "0"
                : amountController.text),
                "id": id
            });
          } else if (selectedPaymentType.value?.value == "m2c") {
            metalCalcuationList.add({
              "metal": double.parse(pureWeightController.text.isEmpty
                ? "0"
                : pureWeightController.text),
                "id": id
            });
          }
        }
      }
      calculateTotalWeightAmount();
      resetForm();
      Get.back();
    }
  }

  resetForm() {
    metalWeightController.clear();
    pureWeightController.clear();
    touchController.clear();
    amountController.clear();
    metalRateController.clear();
    pureRateController.clear();
    remarksController.clear();

    selectedPaymentMethod.value = null;
    selectedPaymentProvider.value = null;

    formMode('create');
  }

  Future addPayment(BuildContext context) async {
    if (cashPariculars.isNotEmpty || metalPariculars.isNotEmpty) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        int? menuId = await HomeSharedPrefs.getCurrentMenu();
        var args = Get.arguments;
        VendorMakePaymentPayload payload = VendorMakePaymentPayload(
            menuId: menuId,
            vendorDetails: args,
            openAmount: vendorPaymentDetails.value.balanceAmount,
            openWeight: vendorPaymentDetails.value.balanceWeight,
            paymentAmount: totalPaidAmount.value,
            paymentWeight: totalPaidWeight.value,
            branch: isBranchuser.value ? selectedBranch.value?.value : null,
            remark: remarksController.text,
            paymentDetails: cashPariculars,
            weightDetails: metalPariculars);

        final String? data = await VendorPaymentService.createVendorPayment(
            context: context, payload: payload);

        if (data != null) {
          _vendorPaymentListController.getVendorPaymentList(context);
          Get.back();
          remarksController.clear();
          cashPariculars([]);
          metalPariculars([]);
          totalPaidAmount(0.0);
          totalPaidWeight(0.0);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Atleast one denomination is required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
      isFormSubmit(false);
    }
  }
}