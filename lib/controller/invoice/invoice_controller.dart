import 'dart:developer';

import 'package:ausales_application/controller/customer/customer_creation_common_controller.dart';
import 'package:ausales_application/controller/invoice_history/invoice_history_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/invoice/invoice_history_models.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/service/advance/advance_service.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/invoice/invoice_service.dart';
import 'package:ausales_application/service/old_purchase/old_purchase_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/utils/validation_helpler.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/billing_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_advance/invoice_retrieve_data_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class InvoiceController extends HeaderController {
  final CustomerCreationCommonController _customerCreationCommonController =
      Get.put(CustomerCreationCommonController());

  final InvoiceHistoryListController _invoiceHistoryListController =
      Get.put(InvoiceHistoryListController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController metalSearchController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();

  TextEditingController tagNumberController = TextEditingController();

  TextEditingController billingDate = TextEditingController();
  TextEditingController billingDateTimeController = TextEditingController();
  TextEditingController customerMobileController = TextEditingController();

  TextEditingController roundOffController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();
  TextEditingController suspenseController = TextEditingController();
  TextEditingController oldMetalController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController chitController = TextEditingController();
  TextEditingController salesReturnController = TextEditingController();
  TextEditingController suspenseRemarksController = TextEditingController();
  TextEditingController totalPayableController = TextEditingController();

  RxObjectMixin<CustomerVerificationResponse> customerDetails =
      CustomerVerificationResponse().obs;

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> gstTypeDropDown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedGstType = Rx<DropdownModel?>(null);

  RxBool isValidCustomer = false.obs;
  RxBool isVerifyCustomerLoading = false.obs;
  RxBool isOldMetalFetchLoading = false.obs;
  RxBool isOldMetalSubmitLoading = false.obs;
  RxBool isAdvanceFetchLoading = false.obs;
  RxBool isSuspenseFetchLoading = false.obs;
  RxBool isSuspenseSubmitLoading = false.obs;
  RxBool isChitMobileFetchLoading = false.obs;

  RxList<ParticularDetails> particulars = <ParticularDetails>[].obs;
  RxList<InvoiceOldItemDetails> oldParticulars = <InvoiceOldItemDetails>[].obs;
  RxList<InvoiceAdvanceDetails> advanceParticulars =
      <InvoiceAdvanceDetails>[].obs;

  RxList<OldPurchaseParticularsDetails> oldPurchaseParticulars =
      <OldPurchaseParticularsDetails>[].obs;

  RxList<PaymentDenominationDetails> paymentParticulars =
      <PaymentDenominationDetails>[].obs;

  RxList<InvoiceSuspenseItemDetails> suspenseParticulars =
      <InvoiceSuspenseItemDetails>[].obs;

  RxList<InvoiceSuspenseFetchParticularsDetails> fetchSuspenseParticulars =
      <InvoiceSuspenseFetchParticularsDetails>[].obs;

  RxDouble totalAmount = 0.0.obs;
  RxDouble gstAmount = 0.0.obs;
  RxDouble advanceAmount = 0.0.obs;
  RxDouble exchangeAmount = 0.0.obs;
  RxDouble chitAmount = 0.0.obs;
  RxDouble saleReturnAmount = 0.0.obs;
  RxDouble suspenseAmount = 0.0.obs;
  RxDouble payableAmount = 0.0.obs;
  RxDouble paidAmount = 0.0.obs;
  RxDouble balanceAmount = 0.0.obs;

  RxBool isSaveBillingLoading = false.obs;
  RxBool issuedValue = true.obs;

  // Advance
  TextEditingController advanceMetalRateController = TextEditingController();
  TextEditingController advanceRedeemWeightController = TextEditingController();
  TextEditingController advanceRedeemAmountController = TextEditingController();

  RxDouble totalAdvanceAmount = 0.0.obs;
  RxDouble totalAdvanceMetalValue = 0.0.obs;

  //Chit Scheme
  RxList<ChitPaymentDenominationParticulars> chitPaymentParticulars =
      <ChitPaymentDenominationParticulars>[].obs;
  RxList<ChitSchemeListData> selectedChitSchemeList =
      <ChitSchemeListData>[].obs;
  RxList<ParticularDetails> selectedTagChitPaymentParticulars =
      <ParticularDetails>[].obs;

  RxDouble totalBonusAmount = 0.0.obs;
  RxDouble totalPaidAmount = 0.0.obs;
  RxDouble totalPaidWeight = 0.0.obs;
  RxDouble balancePaidAmount = 0.0.obs;
  RxDouble balancePaidWeight = 0.0.obs;
  RxDouble negativeBalancePaidWeight = 0.0.obs;
  RxDouble chitSchemeBenifitAmount = 0.0.obs;

  RxList<String> orderId = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    bool value = await getIsBranchUser();

    if (value == true) {
      getBranchList();
    }

    getGstTypeList();
    getMetalList();

    DateTime today = DateTime.now();
    billingDate.text = DateHelper.convertDateYearMonthDate(today.toString());
    String formattedDate = DateFormat('yyyy-M-dd kk:mm:ss').format(today);
    billingDateTimeController.text = formattedDate.toString();
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<BillMetalDropdownModel> tempList =
        await DropdownService.billmetalDropDown();
    tempList.forEach((item) {
      metalDropDown.add(
          DropdownModel(label: item.metalName!, value: item.id.toString()));
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
        chitController.text = data.mobileNumber!;
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

  Future getOldMetalDetails(context) async {
    if (isBranchuser.value) {
      if (billingDate.text.isNotEmpty &&
          selectedBranch.value != null &&
          selectedGstType.value != null &&
          isValidCustomer.value) {
        if (oldMetalController.text.isNotEmpty) {
          isOldMetalFetchLoading(true);

          bool isValid = true;

          for (var i in oldPurchaseParticulars.value) {
            if (i.oldGoldBillNo == oldMetalController.text) {
              isValid = false;
              break;
            } else {
              isValid = true;
            }
          }

          if (isValid) {
            final OldPurchaseRetrieveResponse? data =
                await OldPurchaseService.retrieveOldPurchaseByNumber(
                    context: context,
                    oldPurdchaseNumber: oldMetalController.text);

            if (data != null) {
              OldPurchaseParticularsDetails oldPurchaseParticularsDetails =
                  OldPurchaseParticularsDetails(
                      id: data.id.toString(),
                      oldGoldBillNo: data.oldGoldBillNumber,
                      totalAmount: data.oldGoldAmount.toString());
              oldPurchaseParticulars.add(oldPurchaseParticularsDetails);

              oldMetalController.clear();
            }

            calculateOldMetals();
            isOldMetalFetchLoading(false);
          } else {
            isOldMetalFetchLoading(false);
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("${oldMetalController.text} is already added!"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Old Metal Search Field is Not Empty"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Billing details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      if (billingDate.text.isNotEmpty &&
          selectedGstType.value != null &&
          isValidCustomer.value) {
        if (oldMetalController.text.isNotEmpty) {
          isOldMetalFetchLoading(true);

          bool isValid = true;

          for (var i in oldPurchaseParticulars.value) {
            if (i.oldGoldBillNo == oldMetalController.text) {
              isValid = false;
              break;
            } else {
              isValid = true;
            }
          }

          if (isValid) {
            final OldPurchaseRetrieveResponse? data =
                await OldPurchaseService.retrieveOldPurchaseByNumber(
                    context: context,
                    oldPurdchaseNumber: oldMetalController.text);

            if (data != null) {
              OldPurchaseParticularsDetails oldPurchaseParticularsDetails =
                  OldPurchaseParticularsDetails(
                      id: data.id.toString(),
                      oldGoldBillNo: data.oldGoldBillNumber,
                      totalAmount: data.oldGoldAmount.toString());
              oldPurchaseParticulars.add(oldPurchaseParticularsDetails);

              oldMetalController.clear();
            }

            calculateOldMetals();
            isOldMetalFetchLoading(false);
          } else {
            isOldMetalFetchLoading(false);
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("${oldMetalController.text} is already added!"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Old Metal Search Field is Not Empty"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Billing details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }

  Future getSuspenseDetails(context) async {
    if (isBranchuser.value) {
      if (billingDate.text.isNotEmpty &&
          selectedBranch.value != null &&
          selectedGstType.value != null &&
          isValidCustomer.value) {
        if (suspenseController.text.isNotEmpty) {
          isSuspenseFetchLoading(true);

          bool isValid = true;

          for (var i in fetchSuspenseParticulars.value) {
            if (i.suspenseId == suspenseController.text) {
              isValid = false;
              break;
            } else {
              isValid = true;
            }
          }

          if (isValid) {
            final InvoiceSuspenseRetrieveDetails? data =
                await InvoiceService.retrieveSuspenseDetail(
                    context: context, suspenseId: suspenseController.text);

            if (data != null) {
              InvoiceSuspenseFetchParticularsDetails
                  invoiceSuspenseFetchParticularsDetails =
                  InvoiceSuspenseFetchParticularsDetails(
                      id: data.id.toString(),
                      suspenseId: data.suspenseId,
                      totalAmount: data.suspenseAmount.toString());
              fetchSuspenseParticulars
                  .add(invoiceSuspenseFetchParticularsDetails);

              oldMetalController.clear();
            }

            calculateSuspense();
            isSuspenseFetchLoading(false);
          } else {
            isSuspenseFetchLoading(false);
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("${suspenseController.text} is already added!"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Suspense Search Field is Not Empty"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Billing details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      if (billingDate.text.isNotEmpty &&
          selectedGstType.value != null &&
          isValidCustomer.value) {
        if (suspenseController.text.isNotEmpty) {
          isSuspenseFetchLoading(true);

          bool isValid = true;

          for (var i in fetchSuspenseParticulars.value) {
            if (i.suspenseId == suspenseController.text) {
              isValid = false;
              break;
            } else {
              isValid = true;
            }
          }

          if (isValid) {
            final InvoiceSuspenseRetrieveDetails? data =
                await InvoiceService.retrieveSuspenseDetail(
                    context: context, suspenseId: suspenseController.text);

            if (data != null) {
              InvoiceSuspenseFetchParticularsDetails
                  invoiceSuspenseFetchParticularsDetails =
                  InvoiceSuspenseFetchParticularsDetails(
                      id: data.id.toString(),
                      suspenseId: data.suspenseId,
                      totalAmount: data.suspenseAmount.toString());
              fetchSuspenseParticulars
                  .add(invoiceSuspenseFetchParticularsDetails);

              oldMetalController.clear();
            }

            calculateSuspense();
            isSuspenseFetchLoading(false);
          } else {
            isSuspenseFetchLoading(false);
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("${suspenseController.text} is already added!"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Suspense Search Field is Not Empty"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Billing details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }

  Future getAdvanceDetails(context) async {
    if (isBranchuser.value) {
      if (billingDate.text.isNotEmpty &&
          selectedBranch.value != null &&
          selectedGstType.value != null &&
          isValidCustomer.value) {
        if (advanceController.text.isNotEmpty) {
          isAdvanceFetchLoading(true);

          bool isValid = true;

          for (var i in advanceParticulars.value) {
            if (i.advanceDetailsNo == advanceController.text) {
              isValid = false;
              break;
            } else {
              isValid = true;
            }
          }

          if (isValid) {
            final AdvanceRetrieveData? data =
                await AdvanceService.retrieveAdvanceByNumber(
                    context: context, advanceNumber: advanceController.text);

            advanceController.clear();

            isAdvanceFetchLoading(false);
            if (data != null) {
              if (data.metalRate != "null") {
                advanceMetalRateController.text = data.metalRate!;
              }
              await Get.dialog(
                  barrierDismissible: false,
                  InvoiceRetrieveDataForm(data: data));
            }
          } else {
            isAdvanceFetchLoading(false);
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("${advanceController.text} is already added!"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Advance Search Field is Not Empty"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Billing details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      if (billingDate.text.isNotEmpty &&
          selectedGstType.value != null &&
          isValidCustomer.value) {
        if (advanceController.text.isNotEmpty) {
          isAdvanceFetchLoading(true);

          bool isValid = true;

          for (var i in advanceParticulars.value) {
            if (i.advanceDetailsNo == advanceController.text) {
              isValid = false;
              break;
            } else {
              isValid = true;
            }
          }

          if (isValid) {
            final AdvanceRetrieveData? data =
                await AdvanceService.retrieveAdvanceByNumber(
                    context: context, advanceNumber: advanceController.text);

            advanceController.clear();

            isAdvanceFetchLoading(false);
            if (data != null) {
              if (data.metalRate != "null") {
                advanceMetalRateController.text = data.metalRate!;
              }
              await Get.dialog(
                  barrierDismissible: false,
                  InvoiceRetrieveDataForm(data: data));
            }
          } else {
            isAdvanceFetchLoading(false);
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("${advanceController.text} is already added!"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Advance Search Field is Not Empty"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Billing details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }

  void applyAdvanceDetails(
      BuildContext context, AdvanceRetrieveData advanceData) {
    if ((advanceRedeemAmountController.text.isNotEmpty &&
            advanceMetalRateController.text.isNotEmpty) ||
        advanceRedeemAmountController.text.isNotEmpty) {
      InvoiceAdvanceDetails invoiceAdvanceDetails = InvoiceAdvanceDetails(
          advanceDetails: advanceData.id,
          advanceDetailsNo: advanceData.advanceId,
          redeemWeight: double.parse(advanceRedeemWeightController.text.isEmpty
              ? "0"
              : advanceRedeemWeightController.text),
          redeemAmount: double.parse(advanceRedeemAmountController.text.isEmpty
              ? "0"
              : advanceRedeemAmountController.text),
          redeemMetalRate: double.parse(advanceMetalRateController.text.isEmpty
              ? "0"
              : advanceMetalRateController.text),
          redeemMetalValue: totalAdvanceMetalValue.value,
          totalAmount: totalAdvanceAmount.value);

      advanceParticulars.add(invoiceAdvanceDetails);
      calculateAdvanceValues();
      advanceRedeemWeightController.clear();
      advanceMetalRateController.clear();
      advanceRedeemAmountController.clear();
      totalAdvanceMetalValue(0.0);
      totalAdvanceAmount(0.0);
      Get.back();
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("Advance Amount or Advance Weight Field is Required"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  void calculateAdvanceValues() {
    double totalValue = 0.0;
    for (var i in advanceParticulars) {
      totalValue += i.totalAmount!;
    }
    advanceAmount(totalValue);
    calculateBilling();
  }

  void calculateOldMetals() {
    double totalValue = 0.0;
    for (var i in oldPurchaseParticulars.value) {
      totalValue += double.parse(i.totalAmount ?? "0.0");
    }
    exchangeAmount(totalValue);
    calculateBilling();
  }

  void calculateBilling() {
    double discount = double.parse(
        discountController.text.isEmpty ? "0" : discountController.text);
    double paid = double.parse(
        paidAmountController.text.isEmpty ? "0" : paidAmountController.text);
    double orderAmount =
        double.parse(orderController.text.isEmpty ? "0" : orderController.text);
    double exchange = exchangeAmount.value;
    double advance = advanceAmount.value;
    double suspense = suspenseAmount.value;
    double chitScheme = chitAmount.value;
    double roundOff = double.tryParse(roundOffController.text.isEmpty
                ? "0"
                : roundOffController.text) ==
            null
        ? 0.0
        : double.parse(
            roundOffController.text.isEmpty ? "0" : roundOffController.text);

    var calcPayable =
        ((totalAmount.value + gstAmount.value) - (discount + (roundOff * -1)))
            .toStringAsFixed(2);
    payableAmount(double.parse(calcPayable));

    totalPayableController.text = calcPayable;

    balanceAmount(double.parse(calcPayable ?? "0") -
            (exchange + advance + paid + suspense + chitScheme + orderAmount))
        .toStringAsFixed(3);
  }

  Future createBilling(BuildContext context, bool print) async {
    if (particulars.length > 0) {
      if (!isSaveBillingLoading.value) {
        isSaveBillingLoading(true);
        int? menuId = await HomeSharedPrefs.getCurrentMenu();

        List<int> oldPurchaseIds = [];

        for (var i in oldPurchaseParticulars.value) {
          oldPurchaseIds.add(int.parse(i.id!));
        }

        List<int> suspenseIds = [];

        for (var i in fetchSuspenseParticulars.value) {
          suspenseIds.add(int.parse(i.id!));
        }

        ChitPaymentDetails chitValues = ChitPaymentDetails(
          totalAmount: chitAmount.value,
          benefitAmount: chitSchemeBenifitAmount.value,
          schemeWeight: totalPaidWeight.value,
          balanceWeight: (negativeBalancePaidWeight.value * -1),
          denominationDetails: chitPaymentParticulars.value,
        );
        if (paymentParticulars.isNotEmpty ||
            suspenseIds.isNotEmpty ||
            advanceParticulars.isNotEmpty ||
            oldPurchaseIds.isNotEmpty ||
            chitPaymentParticulars.isNotEmpty ||
            orderController.text.isNotEmpty) {
          InvoicePayload payload = InvoicePayload(
              isIssued: issuedValue.value,
              menuId: menuId,
              billDate: billingDateTimeController.text,
              customerDetails: customerDetails.value.id,
              metal: selectedMetal.value?.value,
              branch: isBranchuser.value ? selectedBranch.value?.value : null,
              totalAmount: totalAmount.value,
              gstAmount: gstAmount.value,
              advanceAmount: advanceAmount.value,
              discountAmount: double.parse(discountController.text.isEmpty
                  ? "0"
                  : discountController.text),
              roundoffAmount: double.parse(roundOffController.text.isEmpty
                  ? "0"
                  : roundOffController.text),
              exchangeAmount: exchangeAmount.value,
              orderDetails: orderId.value,
              chitAmount: chitAmount.value,
              saleReturnAmount: saleReturnAmount.value,
              gstType: selectedGstType.value?.value,
              payableAmount: payableAmount.value,
              orderAmount: double.parse(
                  orderController.text.isEmpty ? "0.0" : orderController.text),
              particularDetails: particulars.value,
              exchangeDetails: oldPurchaseIds,
              advanceDetails: advanceParticulars.value,
              isPayment: paymentParticulars.isNotEmpty ||
                      suspenseIds.isNotEmpty ||
                      advanceParticulars.isNotEmpty ||
                      oldPurchaseIds.isNotEmpty ||
                      chitPaymentParticulars.isNotEmpty ||
                      orderController.text.isNotEmpty
                  ? true
                  : false,
              paymentDenominationDetails: paymentParticulars.value,
              chitDetails: [chitValues],
              suspenseDetails: suspenseIds);

              log("payload   ${payload.toJson()}");

          final String? data = await InvoiceService.createInvoice(
              context: context, payload: payload);

          if (data != null) {
            if (print) {
              final CompanyDetailsData? companyData =
                  await CompanyService.retrieveCompany(context: context);

              if (companyData != null) {
                final RetrieveBillingDetails? billDetails =
                    await _invoiceHistoryListController.getBillDetails(
                        context, data.toString());

                if (billDetails != null) {
                  List<RetrieveParticularDetails> itemsList =
                      <RetrieveParticularDetails>[
                    ...billDetails.particularDetails!
                  ];
                  String? Paymentmode = "";
                  int totalPieces = 0;
                  double totalNetWeight = 0.0;
                  double totalGrossWeight = 0.0;
                  for (var i in billDetails.particularDetails!) {
                    totalPieces += i.pieces ?? 0;
                    totalGrossWeight += i.grossWeight ?? 0.0;
                    totalNetWeight += i.netWeight ?? 0.0;
                  }
                  itemsList.add(RetrieveParticularDetails(
                      pieces: totalPieces,
                      grossWeight: totalGrossWeight,
                      netWeight: totalNetWeight,
                      gstAmount: billDetails.gstAmount,
                      payableAmount: billDetails.payableAmount,
                      totalAmount: billDetails.totalAmount));
                  for (var i in billDetails.paymentDetails!) {
                    for (var j in i.denominationDetails!) {
                      Paymentmode = j.paymentMethod;
                    }
                  }
                  await Get.dialog(
                      barrierDismissible: false,
                      BillingPrintout(
                            companyDetailsData: companyData,
                            billingDetails: billDetails,
                            items: itemsList,
                            paymentMode: Paymentmode,
                          ));
                }
              }
              resetBillingValues();
            } else {
              resetBillingValues();
            }
          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("add atleast one payment"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
        isSaveBillingLoading(false);
      }
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("add atleast one item"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  void calculatePayments() {
    var totalPaidAmount = 0.0;
    for (var i in paymentParticulars) {
      totalPaidAmount += i.paidAmount!;
    }
    paidAmountController.text = totalPaidAmount.toStringAsFixed(2);
    paidAmount(totalPaidAmount);

    calculateBilling();
  }

  void calculateSuspense() {
    double totalValue = 0.0;
    for (var i in fetchSuspenseParticulars.value) {
      totalValue += double.parse(i.totalAmount!);
    }
    suspenseAmount(totalValue);
    calculateBilling();
  }

  Future createSuspense(BuildContext context) async {
    if (isBranchuser.value) {
      if (selectedBranch.value != null && isValidCustomer.value) {
        if (!isSuspenseSubmitLoading.value) {
          isSuspenseSubmitLoading(true);
          if (suspenseParticulars.isNotEmpty) {
            CreateSuspensePayload payload = CreateSuspensePayload(
                branch: selectedBranch.value?.value,
                customerDetails: customerDetails.value.id.toString(),
                itemDetails: suspenseParticulars.value,
                remarks: suspenseRemarksController.text,
                menuId: await HomeSharedPrefs.getCurrentMenu());

            final InvoiceCreateSuspenseResponse? data =
                await InvoiceService.createSuspense(
                    payload: payload, context: context);
            if (data != null) {
              await Get.dialog(
                  barrierDismissible: false,
                  AlertDialog(
                        content: Text(
                          data.suspenseId.toString(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                        actions: [
                          PrimaryButton(
                              isLoading: false,
                              text: 'Copy',
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: data.suspenseId.toString()));

                                Get.back();
                              }),
                          SecondaryButton(
                              isLoading: false,
                              text: 'Close',
                              onPressed: () {
                                Get.back();
                              })
                        ],
                      ));

              Get.back();
            }
          } else {
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("Add at least one item"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
          isSuspenseSubmitLoading(false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Filling Billing details"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      if (isValidCustomer.value) {
        if (!isSuspenseSubmitLoading.value) {
          isSuspenseSubmitLoading(true);
          if (suspenseParticulars.isNotEmpty) {
            CreateSuspensePayload payload = CreateSuspensePayload(
                branch: null,
                customerDetails: customerDetails.value.id.toString(),
                itemDetails: suspenseParticulars.value,
                menuId: await HomeSharedPrefs.getCurrentMenu());

            final InvoiceCreateSuspenseResponse? data =
                await InvoiceService.createSuspense(
                    payload: payload, context: context);
            if (data != null) {
              await Get.dialog(
                  barrierDismissible: false,
                  AlertDialog(
                        content: Text(
                          data.suspenseId.toString(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                        actions: [
                          PrimaryButton(
                              isLoading: false,
                              text: 'Copy',
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: data.suspenseId.toString()));

                                Get.back();
                              }),
                          SecondaryButton(
                              isLoading: false,
                              text: 'Close',
                              onPressed: () {
                                Get.back();
                              })
                        ],
                      ));

              Get.back();
            }
          } else {
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("Add at least one item"),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
          isSuspenseSubmitLoading(false);
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Need a valid customer details"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }

  void onTotalPayableAmountChanged() {
    double userTotalPaybale = double.parse(totalPayableController.text.isEmpty
        ? "0"
        : totalPayableController.text);

    double gstValue = 0.0;
    double totalValue = 0.0;
    double balValue = 0.0;

    for (var i = 0; i < particulars.value.length; i++) {
      ParticularDetails item = particulars.value[i];
      var itemJson = item.toJson();

      double itemPayableAmountCalc = (userTotalPaybale - payableAmount.value) *
          ((item.actualPayableAmount ?? 0.0) / payableAmount.value);

      double itemPayableAmount =
          (item.actualPayableAmount ?? 0.0) + (itemPayableAmountCalc);
      itemJson['payable_amount'] =
          double.parse(itemPayableAmount.toStringAsFixed(2));

      double itemTotalAmount = 0.0;
      double gstAmount = 0.0;
      if (selectedGstType.value != null) {
        itemTotalAmount =
            (itemPayableAmount * 100) / (100 + (item.gstPercent ?? 0.0));
        itemJson['total_amount'] =
            double.parse(itemTotalAmount.toStringAsFixed(2));

        gstAmount = itemPayableAmount - itemTotalAmount;
        itemJson['gst_amount'] = double.parse(gstAmount.toStringAsFixed(2));
      } else {
        itemTotalAmount = itemPayableAmount;
        itemJson['total_amount'] =
            double.parse(itemTotalAmount.toStringAsFixed(2));

        gstAmount = itemPayableAmount - itemTotalAmount;
        itemJson['gst_amount'] = double.parse(gstAmount.toStringAsFixed(2));
      }

      totalValue += itemTotalAmount;
      gstValue += gstAmount;

      if (item.calculationType == fixedRateCalcType) {
        double rate = itemTotalAmount -
            ((item.stoneAmount ?? 0.0) +
                (item.diamondAmount ?? 0.0) +
                (item.huidAmount ?? 0.0));
        itemJson['rate'] = double.parse(rate.toStringAsFixed(2));
      } else if (item.calculationType == perGramRateCalcType) {
        double totalRate = itemTotalAmount -
            ((item.stoneAmount ?? 0.0) +
                (item.diamondAmount ?? 0.0) +
                (item.huidAmount ?? 0.0));
        double rate = 0.0;
        if (item.perGramWeightType == grossWeightType) {
          rate = totalRate / (item.grossWeight ?? 0.0);
        } else {
          rate = totalRate / (item.netWeight ?? 0.0);
        }
        itemJson['rate'] = double.parse(rate.toStringAsFixed(2));
      } else if (item.calculationType == perPieceRateCalcType) {
        double totalRate = itemTotalAmount -
            ((item.stoneAmount ?? 0.0) +
                (item.diamondAmount ?? 0.0) +
                (item.huidAmount ?? 0.0));
        double rate = totalRate / (item.pieces ?? 0);
        itemJson['rate'] = double.parse(rate.toStringAsFixed(2));
      } else if (item.calculationType == weightCalcType) {
        double wastageWeight = item.wastageWeightType == grossWeightType
            ? (item.grossWeight ?? 0.0)
            : (item.netWeight ?? 0.0);
        String flatWasType = item.flatWastageType!;
        double mcWeight = item.makingChargeType == grossWeightType
            ? (item.grossWeight ?? 0.0)
            : (item.netWeight ?? 0.0);

        double flatWastageValue = item.flatWastage ?? 0.0;
        double mcPerGramValue = item.makingChargePerGram ?? 0.0;
        double flatMcValue = item.flatMakingCharge ?? 0.0;

        double makingCharge = (mcPerGramValue * mcWeight) + flatMcValue;

        double wihtoutGstAmount = itemTotalAmount;
        double wihtoutOtherAmount = wihtoutGstAmount -
            ((item.stoneAmount ?? 0.0) +
                (item.diamondAmount ?? 0.0) +
                (item.huidAmount ?? 0.0) +
                makingCharge);

        if (flatWasType == 'gram') {
          double withoutFMC =
              wihtoutOtherAmount - (flatWastageValue * (item.rate ?? 0.0));
          double actualRate = (item.netWeight ?? 0.0) * (item.rate ?? 0.0);

          double wastageWeightValue = withoutFMC - actualRate;

          double wastage =
              (wastageWeightValue * 100) / (wastageWeight * (item.rate ?? 0.0));
          itemJson['wastage_percent'] =
              double.parse(wastage.toStringAsFixed(2));
        } else {
          double withoutFMC = wihtoutOtherAmount - flatWastageValue;
          double actualRate = (item.netWeight ?? 0.0) * (item.rate ?? 0.0);

          double wastageWeightValue = withoutFMC - actualRate;

          double wastage =
              (wastageWeightValue * 100) / (wastageWeight * (item.rate ?? 0.0));
          itemJson['wastage_percent'] =
              double.parse(wastage.toStringAsFixed(2));
        }
      }

      particulars[i] = ParticularDetails.fromJson(itemJson);
    }

    totalAmount(double.parse(totalValue.toStringAsFixed(2)));
    gstAmount(double.parse(gstValue.toStringAsFixed(2)));

    double paid = double.parse(
        paidAmountController.text.isEmpty ? "0" : paidAmountController.text);
    double exchange = exchangeAmount.value;
    double advance = advanceAmount.value;
    double suspense = suspenseAmount.value;
    double chitScheme = chitAmount.value;
    double orderAmount =
        double.parse(orderController.text.isEmpty ? "0" : orderController.text);

    balanceAmount(userTotalPaybale -
        (exchange + advance + paid + suspense + chitScheme + orderAmount));
  }

  resetBillingValues() {
    DateTime today = DateTime.now();
    billingDate.text = DateHelper.convertDateYearMonthDate(today.toString());
    String formattedDate = DateFormat('yyyy-M-dd kk:mm:ss').format(today);
    billingDateTimeController.text = formattedDate.toString();

    selectedGstType.value = null;
    selectedMetal.value = null;
    selectedBranch.value = null;
    isValidCustomer(false);
    isVerifyCustomerLoading(false);
    customerDetails(CustomerVerificationResponse());
    customerMobileController.clear();

    particulars([]);
    chitController.clear();
    oldMetalController.clear();
    advanceController.clear();

    orderId([]);
    totalAmount(0.0);
    gstAmount(0.0);
    discountController.clear();
    roundOffController.clear();
    advanceAmount(0.0);
    exchangeAmount(0.0);
    saleReturnAmount(0.0);
    chitAmount(0.0);
    suspenseAmount(0.0);
    payableAmount(0.0);
    balanceAmount(0.0);
    orderController.clear();
    totalPayableController.clear();

    oldParticulars([]);
    oldPurchaseParticulars([]);
    calculateOldMetals();
    advanceParticulars([]);

    chitPaymentParticulars([]);
    selectedChitSchemeList([]);
    selectedTagChitPaymentParticulars([]);
    totalBonusAmount(0.0);
    totalPaidAmount(0.0);
    totalPaidWeight(0.0);
    balancePaidAmount(0.0);
    balancePaidWeight(0.0);
    negativeBalancePaidWeight(0.0);
    chitSchemeBenifitAmount(0.0);

    advanceMetalRateController.clear();
    advanceRedeemAmountController.clear();
    advanceRedeemWeightController.clear();
    totalAdvanceAmount(0.0);
    totalAdvanceMetalValue(0.0);
    calculateAdvanceValues();

    paymentParticulars([]);
    paidAmountController.clear();
    paidAmount(0.0);

    suspenseController.clear();
    fetchSuspenseParticulars([]);
    suspenseParticulars([]);
    calculateSuspense();

    issuedValue(true);
  }
}
