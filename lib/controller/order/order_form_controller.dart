import 'dart:developer';

import 'package:ausales_application/controller/customer/customer_creation_common_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/order/order_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/model/payment/old_gold_payment_model.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/order/order_service.dart';
import 'package:ausales_application/utils/validation_helpler.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class OrderFormController extends HeaderController {
  final CustomerCreationCommonController _customerCreationCommonController =
      Get.put(CustomerCreationCommonController());

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final OrderListController _orderListController =
      Get.put(OrderListController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final orderformkey = GlobalKey<FormState>();

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController metalSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();

  Rx<CounterDetailsData?> currentOrder = Rx<CounterDetailsData?>(null);

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedGstType = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> gstTypeDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool add = false.obs;

  RxBool fixedValue = false.obs;

  RxString fromMode = "create".obs;

  RxList<OrderItemDetails> orderitemdetailsParticularList =
      <OrderItemDetails>[].obs;

  RxBool isValidCustomer = false.obs;
  RxBool isVerifyCustomerLoading = false.obs;

  RxObjectMixin<CustomerVerificationResponse> customerDetails =
      CustomerVerificationResponse().obs;

  // Retrieve Order Advance
  RxObjectMixin<AdvanceRetrieveData> advanceDetails = AdvanceRetrieveData().obs;
  RxBool isAdvanceAdded = false.obs;

  // payments
  RxList<AdvanceDetails> advanceParticulars = <AdvanceDetails>[].obs;

  RxList<OldItemPaymentDetails> oldPurchaseParticulars =
      <OldItemPaymentDetails>[].obs;

  RxList<OrderOldPurchasePaymentParticularsDetails>
      oldPurchaseFetchParticulars =
      <OrderOldPurchasePaymentParticularsDetails>[].obs;

  RxList<ChitPaymentDenominationParticulars> chitPaymentParticulars =
      <ChitPaymentDenominationParticulars>[].obs;
  RxList<ChitSchemeListData> selectedChitSchemeList =
      <ChitSchemeListData>[].obs;
  RxList<OrderItemDetails> selectedTagChitPaymentParticulars =
      <OrderItemDetails>[].obs;

  RxDouble orderItemsAmount = 0.0.obs;
  RxDouble orderItemsGstAmount = 0.0.obs;
  RxDouble orderItemsPayableAmount = 0.0.obs;
  RxDouble advanceAmount = 0.0.obs;
  RxDouble chitSchemeRedeemAmount = 0.0.obs;
  RxDouble oldPurchaseAmount = 0.0.obs;
  RxDouble balanceAmount = 0.0.obs;

  RxDouble totalBonusAmount = 0.0.obs;
  RxDouble totalPaidAmount = 0.0.obs;
  RxDouble totalPaidWeight = 0.0.obs;
  RxDouble balancePaidAmount = 0.0.obs;
  RxDouble balancePaidWeight = 0.0.obs;
  RxDouble negativeBalancePaidWeight = 0.0.obs;
  RxDouble chitSchemeBenifitAmount = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getCustomerList();
    getGstTypeList();
    getMetalList();
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

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    tempList.forEach((item) {
      metalDropDown.add(DropdownModel(
          label: item.metalName.toString(),
          value: item.id.toString()));
    });
  }

  Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    tempList.forEach((item) {
      customerDropDown.add(DropdownModel(
          label: "${item.customerName!} (${item.mobileNumber})",
          value: item.id.toString()));
    });
  }

  Future getGstTypeList() async {
    gstTypeDropDown([]);
    final List<GstTypeDropdownModel> tempList =
        await DropdownService.gstTypeDropDown();
    tempList.forEach((item) {
      gstTypeDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future CreateOrder(BuildContext context) async {
    if (orderformkey.currentState!.validate() && isValidCustomer.value) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (orderitemdetailsParticularList.isNotEmpty) {
          List<int> oldPurchaseitemsList = [];
          for (var i in oldPurchaseFetchParticulars.value) {
            oldPurchaseitemsList.add(int.parse(i.id!));
          }

          List<DenominationDetail> dataList = [];
          for (var i in chitPaymentParticulars.value) {
            dataList.add(DenominationDetail.fromJson(i.toJson()));
          }

          ChitDetails chitDetails = ChitDetails(
            denominationDetails: dataList,
            totalAmount: chitSchemeRedeemAmount.value,
            benefitAmount: chitSchemeBenifitAmount.value,
            schemeWeight: totalPaidWeight.value,
            balanceWeight: (negativeBalancePaidWeight.value * -1),
          );

          CreateOrderPayload payload = CreateOrderPayload(
              branch: selectedBranch.value?.value,
              isFixed: fixedValue.value,
              dueDate: dueDateController.text,
              balanceAmount: balanceAmount.value,
              metal: selectedMetal.value?.value,
              customerDetails: customerDetails.value.id.toString(),
              orderItemDetails: orderitemdetailsParticularList.value,
              gstType: selectedGstType.value?.value,
              gstAmount: orderItemsGstAmount.value,
              totalAmount: orderItemsAmount.value,
              payableAmount: orderItemsPayableAmount.value,
              exchangeDetails: oldPurchaseitemsList,
              advanceDetails: advanceParticulars.value,
              chitDetails: [chitDetails],
              isPayment: advanceAmount.value > 0 ||
                      oldPurchaseAmount.value > 0 ||
                      orderItemsPayableAmount.value > 0
                  ? true
                  : false,
              menuId: await HomeSharedPrefs.getCurrentMenu());

              log("payload  ${payload.toJson()}");

          final CreateOrderResponse? data = await OrderService.createOrder(
              payload: payload, context: context);
          if (data != null) {
            _orderListController.getorderList(context);
            navOrderList();
            resetForm();
          }
          isFormSubmit.value = false;
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Add at least one item"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);

          isFormSubmit.value = false;
        }
      }
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("Enter the customer details"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  Future submitCustomerCreationForm(BuildContext context) async {
    if (_customerCreationCommonController.customerCommonFormKey.currentState!
        .validate()) {
      if (!_customerCreationCommonController.isFormSubmit.value) {
        _customerCreationCommonController.isFormSubmit(true);
        // if (_customerCreationCommonController.fromMode.value == "create") {
        final CreateCustomerPayload payload = CreateCustomerPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            customerName:
                _customerCreationCommonController.customerNamecontroller.text,
            mobileNumber: int.parse(
                _customerCreationCommonController.mobilenumbercontroller.text),
            customerGroup: int.parse(_customerCreationCommonController
                .selectedCustomergroup.value!.value),
            address: _customerCreationCommonController.addresscontroller.text);

        await CustomerService.createCustomer(
            context: context, payload: payload);

        findCustomer(
            _customerCreationCommonController.mobilenumbercontroller.text,
            context);
        // }
        _customerCreationCommonController.resetForm();
        Get.back();
      }
    }
  }

  Future findCustomer(String value, BuildContext context) async {
    var validMobile = await ValidationHelper.phone(value);

    isValidCustomer(false);

    if (validMobile.isEmpty) {
      isVerifyCustomerLoading(true);
      int? menuId = await HomeSharedPrefs.getCurrentMenu();
      CustomerVerificationResponse? data =
          await CustomerService.customerVerification(
              mobile: value, menuId: menuId.toString(), context: context);

      if (data != null) {
        customerDetails(data);
        isValidCustomer(true);
      } else {
        customerDetails(null);
        _customerCreationCommonController.mobilenumbercontroller.text = value;
        await Get.dialog(
            barrierDismissible: false,
            CustomerCreationCommonPopup(
                  onSubmit: submitCustomerCreationForm,
                ));
      }
      isVerifyCustomerLoading(false);
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    orderformkey.currentState!.reset();
    currentOrder.value = null;
    selectedBranch.value = null;
    selectedCustomer.value = null;
    selectedMetal.value = null;
    fromMode("create");
  }

  void calculateOrderItemParticularsPayment() {
    double orderItemsValue = 0.0;
    double orderItemsGstValue = 0.0;
    double orderItemsPayableValue = 0.0;
    for (var i in orderitemdetailsParticularList) {
      orderItemsValue += i.totalAmount ?? 0.0;
      orderItemsGstValue += i.gstAmount ?? 0.0;
      orderItemsPayableValue += i.payableAmount ?? 0.0;
    }
    orderItemsAmount(orderItemsValue);
    orderItemsGstAmount(orderItemsGstValue);
    orderItemsPayableAmount(orderItemsPayableValue);
    calculateBalanceAmount();
  }

  void calculateAdvancePayment() {
    double value = 0.0;
    for (var i in advanceParticulars) {
      value += i.totalAmount ?? 0.0;
    }
    advanceAmount(value);
    calculateBalanceAmount();
  }

  void calculateOldPurchasePayment() {
    double value = 0.0;
    for (var i in oldPurchaseFetchParticulars) {
      value += double.parse(i.totalAmount ?? "0.0");
    }
    oldPurchaseAmount(value);
    calculateBalanceAmount();
  }

  void chitSchemeReset() {
    selectedTagChitPaymentParticulars([]);
    selectedChitSchemeList([]);
    chitPaymentParticulars([]);
    chitSchemeRedeemAmount(0.0);
    calculateBalanceAmount();
  }

  void calculateChitPayableValues() {
    double totalWastagePercentAmount = 0.0;
    double totalFlatWastageAmount = 0.0;
    double totalMakingChargePerGram = 0.0;
    double totalFlatMakingCharge = 0.0;
    double totalMetalValue = 0.0;

    for (var i in selectedTagChitPaymentParticulars.value) {
      if (double.parse(i.grossWeight ?? "0.0") == i.wastageWeightReduced) {
        totalMetalValue +=
            ((i.metalRate ?? 0.0) * (double.parse(i.netWeight ?? "0.0")));
      } else {
        totalMetalValue +=
            ((i.metalRate ?? 0.0) * ((i.wastageWeightReduced ?? 0.0)));
      }

      if (i.wastageWeightReduced == double.parse(i.grossWeight ?? "0.0")) {
        totalFlatWastageAmount += double.parse(i.flatWastage ?? "0.0");
      } else {
        double perGramFlatWastageValue = double.parse(i.flatWastage ?? "0.0") /
            double.parse(i.grossWeight ?? "0.0");
        totalFlatWastageAmount +=
            (perGramFlatWastageValue * (i.wastageWeightReduced ?? 0.0));
      }

      totalMakingChargePerGram += (double.parse(i.makingCharge ?? "0.0") *
          (i.wastageWeightReduced ?? 0.0));

      if (i.wastageWeightReduced == double.parse(i.grossWeight ?? "0.0")) {
        totalFlatMakingCharge += double.parse(i.flatMakingCharge ?? "0.0");
      } else {
        double flatMakingChargePerGramValue =
            double.parse(i.flatMakingCharge ?? "0.0") /
                double.parse(i.grossWeight ?? "0.0");
        totalFlatMakingCharge +=
            (flatMakingChargePerGramValue * (i.wastageWeightReduced ?? 0.0));
      }

      double wastageAmount = ((i.wastageWeightReduced ?? 0.0) *
              (double.parse(i.wastagePercent ?? "0.0") / 100)) *
          (i.metalRate ?? 0.0);

      totalWastagePercentAmount += wastageAmount;
    }

    double totalSchemeValue = 0.0;
    for (var i in chitPaymentParticulars.value) {
      if (amountSchemes.contains(i.schemeType)) {
        totalSchemeValue += (i.schemeAmount! + i.bonusAmount!);
      }
    }

    String chitRedeemValue =
        (double.parse(totalWastagePercentAmount.toStringAsFixed(2)) +
                double.parse(totalFlatWastageAmount.toStringAsFixed(2)) +
                double.parse(totalMakingChargePerGram.toStringAsFixed(2)) +
                double.parse(totalFlatMakingCharge.toStringAsFixed(2)) +
                double.parse(totalMetalValue.toStringAsFixed(2)) +
                double.parse(totalSchemeValue.toStringAsFixed(2)))
            .toStringAsFixed(2);
    chitSchemeRedeemAmount(double.parse(chitRedeemValue));
    String chitBenifitValue =
        (double.parse(totalWastagePercentAmount.toStringAsFixed(2)) +
                double.parse(totalFlatWastageAmount.toStringAsFixed(2)) +
                double.parse(totalMakingChargePerGram.toStringAsFixed(2)) +
                double.parse(totalFlatMakingCharge.toStringAsFixed(2)))
            .toStringAsFixed(2);
    chitSchemeBenifitAmount(double.parse(chitBenifitValue));
    calculateBalanceAmount();
  }

  void calculateBalanceAmount() {
    double balanceValue = orderItemsPayableAmount.value -
        (chitSchemeRedeemAmount.value +
            advanceAmount.value +
            oldPurchaseAmount.value);
    balanceAmount(double.parse(balanceValue.toStringAsFixed(2)));
  }
}
