import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/model/manual_invoice/manual_invoice_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ManualInvociePaymentFormController extends HeaderController {

  final ManualInvoiceController _manualInvoiceController = Get.put(ManualInvoiceController());

  @override
  RxBool get isBranchuser => super.isBranchuser;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final manualinvoicePaymentFormKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  Rx<DropdownModel?> selectedPaymentMethod = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentProvider = Rx<DropdownModel?>(null);

  RxList<DropdownModel> paymentMethodDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentProviderDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString formMode = "create".obs;

  @override
  void onInit() async {
    super.onInit();
    getPaymentMethodList();
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

  void deleteManaulParticulars(String id) {
    _manualInvoiceController.paymentParticulars.removeWhere((item) => item.sNo == id);
    _manualInvoiceController.calculateManualPayments();
  }

  void submitManualPaymentForm(BuildContext context) {
    if (manualinvoicePaymentFormKey.currentState!.validate()) {
      if (formMode.value == "create") {
        var uuid = Uuid();
        ManualPaymentDenominationDetails data = ManualPaymentDenominationDetails(
          sNo: uuid.v4(),
          paymentMethod: selectedPaymentMethod.value?.value,
          paymentMethodName: selectedPaymentMethod.value?.label,
          paymentProvider: selectedPaymentProvider.value?.value,
          paymentProviderName: selectedPaymentProvider.value?.value,
          paidAmount: double.parse(amountController.text.isEmpty ? "0" : amountController.text),
          remark: remarksController.text
        );
        _manualInvoiceController.paymentParticulars.add(data);
        _manualInvoiceController.calculateManualPayments();
      }
      resetManualForm();
    }
  }

  resetManualForm() {
    amountController.clear();
    remarksController.clear();

    selectedPaymentMethod.value = null;
    selectedPaymentProvider.value = null;

    formMode('create');
  }

}