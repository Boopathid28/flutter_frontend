import 'dart:developer';

import 'package:ausales_application/controller/customer/customer_creation_common_controller.dart';
import 'package:ausales_application/controller/estimation_history/estimation_history_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/estimation/estimation_history_models.dart';
import 'package:ausales_application/model/estimation/estimation_model.dart';
import 'package:ausales_application/model/estimation/estimation_print_out_models.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/service/advance/advance_service.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/estimation/estimation_service.dart';
import 'package:ausales_application/service/old_purchase/old_purchase_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/utils/validation_helpler.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_advance/estimation_retrieve_data_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_printout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class EstimationController extends HeaderController {
  final CustomerCreationCommonController _customerCreationCommonController =
      Get.put(CustomerCreationCommonController());

  final EstimationHistoryListController _estimationHistoryListController =
      Get.put(EstimationHistoryListController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController SearchmetalController = TextEditingController();

  TextEditingController estimationDate = TextEditingController();
  TextEditingController estimationDateTimeController = TextEditingController();
  TextEditingController customerMobileController = TextEditingController();
  TextEditingController totalPayableController = TextEditingController();

  TextEditingController roundOffController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController oldMetalController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController chitMobileController = TextEditingController();
  TextEditingController salesReturnController = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();

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
  RxBool isAdvanceFetchLoading = false.obs;
  RxBool isChitMobileFetchLoading = false.obs;

  RxList<ParticularDetails> particulars = <ParticularDetails>[].obs;
  RxList<ExchangeDetails> oldParticulars = <ExchangeDetails>[].obs;
  RxList<EstimationAdvanceDetails> advanceParticulars =
      <EstimationAdvanceDetails>[].obs;

  RxList<OldPurchaseParticularsDetails> oldPurchaseParticulars =
      <OldPurchaseParticularsDetails>[].obs;

  RxDouble totalAmount = 0.0.obs;
  RxDouble gstAmount = 0.0.obs;
  RxDouble advanceAmount = 0.0.obs;
  RxDouble exchangeAmount = 0.0.obs;
  RxDouble chitAmount = 0.0.obs;
  RxDouble saleReturnAmount = 0.0.obs;
  RxDouble payableAmount = 0.0.obs;
  RxDouble balanceAmount = 0.0.obs;

  RxBool isSaveEstimationLoading = false.obs;

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
    estimationDate.text = DateHelper.convertDateYearMonthDate(today.toString());
    String formattedDate = DateFormat('yyyy-M-dd kk:mm:ss').format(today);
    estimationDateTimeController.text = formattedDate.toString();
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
              mobileNumber: int.parse(_customerCreationCommonController
                  .mobilenumbercontroller.text),
              customerGroup: int.parse(_customerCreationCommonController
                  .selectedCustomergroup.value!.value),
              address:
                  _customerCreationCommonController.addresscontroller.text);

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
        chitMobileController.text = data.mobileNumber.toString();
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
      if (estimationDate.text.isNotEmpty &&
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
            title: Text("Estimation details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      if (estimationDate.text.isNotEmpty &&
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
            title: Text("Estimation details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    }
  }

  Future getAdvanceDetails(context) async {
    if (isBranchuser.value) {
      if (estimationDate.text.isNotEmpty &&
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
              advanceMetalRateController.text = data.metalRate!;
              await Get.dialog(
                  barrierDismissible: false,
                  EstimationRetrieveDataForm(data: data));
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
            title: Text("Estimation details must be required"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      if (estimationDate.text.isNotEmpty &&
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
              advanceMetalRateController.text = data.metalRate!;
              await Get.dialog(
                  barrierDismissible: false,
                  EstimationRetrieveDataForm(data: data));
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
            title: Text("Estimation details must be required"),
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
      EstimationAdvanceDetails estimationAdvanceDetails =
          EstimationAdvanceDetails(
              advanceDetails: advanceData.id,
              advanceDetailsNo: advanceData.advanceId,
              redeemWeight: double.parse(
                  advanceRedeemWeightController.text.isEmpty
                      ? "0"
                      : advanceRedeemWeightController.text),
              redeemAmount: double.parse(
                  advanceRedeemAmountController.text.isEmpty
                      ? "0"
                      : advanceRedeemAmountController.text),
              redeemMetalRate: double.parse(
                  advanceMetalRateController.text.isEmpty
                      ? "0"
                      : advanceMetalRateController.text),
              redeemMetalValue: totalAdvanceMetalValue.value,
              totalAmount: totalAdvanceAmount.value);

      advanceParticulars.add(estimationAdvanceDetails);
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
    for (var i in oldParticulars.value) {
      totalValue += i.totalAmount!;
    }
    for (var i in oldPurchaseParticulars.value) {
      totalValue += double.parse(i.totalAmount ?? "0.0");
    }
    exchangeAmount(totalValue);
    calculateBilling();
  }

  void calculateBilling() {
    double discount = double.parse(
        discountController.text.isEmpty ? "0" : discountController.text);
    double exchange = exchangeAmount.value;
    double advance = advanceAmount.value;
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
            
    totalPayableController.text = calcPayable;
    payableAmount(double.parse(calcPayable));

    String bal =
        (double.parse(calcPayable ?? "0") - (exchange + advance + chitScheme))
            .toStringAsFixed(2);

    balanceAmount(double.parse(bal));
  }

  Future createEstimation(BuildContext context, bool print) async {
    if (particulars.length > 0) {
      if (!isSaveEstimationLoading.value) {
        isSaveEstimationLoading(true);
        int? menuId = await HomeSharedPrefs.getCurrentMenu();

        List<int> oldPurchaseIds = [];

        for (var i in oldPurchaseParticulars.value) {
          oldPurchaseIds.add(int.parse(i.id!));
        }

        ChitPaymentDetails chitValues = ChitPaymentDetails(
          totalAmount: chitAmount.value,
          benefitAmount: chitSchemeBenifitAmount.value,
          schemeWeight: totalPaidWeight.value,
          balanceWeight: (negativeBalancePaidWeight.value * -1),
          denominationDetails: chitPaymentParticulars.value,
        );

        EstimationPayload payload = EstimationPayload(
            menuId: menuId,
            estimationDate: estimationDateTimeController.text,
            customerDetails: customerDetails.value.id,
            metalname: selectedMetal.value?.value,
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
            chitAmount: chitAmount.value,
            saleReturnAmount: saleReturnAmount.value,
            gstType: selectedGstType.value?.value,
            payableAmount: payableAmount.value,
            particularDetails: particulars.value,
            oldPurchaseDetails: oldPurchaseIds,
            exchangeDetails: oldParticulars.value,
            advanceDetails: advanceParticulars.value,
            chitDetails: [chitValues]);


        final String? data = await EstimationService.createEstimtaion(
            context: context, payload: payload);

        if (data != null) {
          if (print) {
            final CompanyDetailsData? companyData =
                await CompanyService.retrieveCompany(context: context);
 
            if (companyData != null) {
              final PrintEstimationDetails? estimationDetails =
                            await EstimationService.printRetrieveEstimationDetail(context: context, estimationId: data.toString());
            
              if (estimationDetails != null) {
                List<PrintParticularDetails> itemsList =
                    <PrintParticularDetails>[
                  ...estimationDetails.particularDetails!
                ];
 
                List<PrintExchangeDetails> exchangeDetailsList =
                    <PrintExchangeDetails>[
                  ...estimationDetails.exchangeDetails!
                ];
 
                double totalGrossWeight = 0.0;
                          for (var i in estimationDetails.exchangeDetails!) {
                            totalGrossWeight += i.oldGrossWeight??0.0;
                          }
 
                if (estimationDetails.exchangeDetails!.isNotEmpty) {
 
                            exchangeDetailsList.add(PrintExchangeDetails(
                              oldGrossWeight: totalGrossWeight,
                              totalAmount: estimationDetails.exchangeAmount
                            ));
                          }
 
                List<PrintAdvanceDetails> advanceDetailsList =
                    <PrintAdvanceDetails>[
                  ...estimationDetails.advanceDetails!
                ];
                
                await Get.dialog(
                    barrierDismissible: false,
                    EstimationPrintout(
                        companyDetailsData: companyData,
                        estimationDetails: estimationDetails,
                        exchangeItems: exchangeDetailsList,
                        advanceItems: advanceDetailsList,
                        items: itemsList));
                _estimationHistoryListController.isPrintLoadingIndex("");
              
              }
            }
            resetEstimationDetails();
            log("resetEstimationDetails   ${resetEstimationDetails}");
          } else {
            resetEstimationDetails();
          }
        }
        isSaveEstimationLoading(false);
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

resetEstimationDetails() {
    DateTime today = DateTime.now();
    estimationDate.text = DateHelper.convertDateYearMonthDate(today.toString());
    String formattedDate = DateFormat('yyyy-M-dd kk:mm:ss').format(today);
    estimationDateTimeController.text = formattedDate.toString();
 
    selectedGstType.value = null;
    selectedMetal.value = null;
    selectedBranch.value = null;
    isValidCustomer(false);
    isVerifyCustomerLoading(false);
    customerDetails(CustomerVerificationResponse());
    customerMobileController.clear();
 
    particulars([]);
    chitMobileController.clear();
    oldMetalController.clear();
    advanceController.clear();
 
    totalAmount(0.0);
    gstAmount(0.0);
    discountController.clear();
    roundOffController.clear();
    advanceAmount(0.0);
    exchangeAmount(0.0);
    saleReturnAmount(0.0);
    chitAmount(0.0);
    payableAmount(0.0);
    balanceAmount(0.0);
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
    double chitScheme = chitAmount.value;

    balanceAmount(
        userTotalPaybale - (exchange + advance + paid + chitScheme));
  }
}
