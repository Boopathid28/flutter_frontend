import 'package:ausales_application/controller/company_ledger/company_ledger_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/company_ledger/company_ledger_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/company_ledger/company_ledger_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyLedgerFormController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final CompanyLedgerListController _companyLedgerListController =
      Get.put(CompanyLedgerListController());

  final companyledgerFormKey = GlobalKey<FormState>();


  TextEditingController branchSearchController = TextEditingController();
  TextEditingController searchExpensetypeController = TextEditingController();
  TextEditingController searchExpenseController = TextEditingController();
  TextEditingController searchSubExpenseController = TextEditingController();

  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedExpensetype = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedClassification = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedExpense = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubExpense = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentMethod = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPaymentProvider = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> classificationDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> expensetypeDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> expenseDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subexpenseDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentmethodDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> paymentproviderDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool isForm = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;

  @override
  void onInit() async{
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getclassificationList();
    getexpensetype();
    getExpenseDropdown();
    getSubExpenseDropdown();
    getPaymentMethodList();
  }

  Future getclassificationList() async {
    classificationDropDown([]);
    final List<ExpenseclassificationDropDownModel> tempList =
        await DropdownService.expenseclassificationDropDown(
          );
    tempList.forEach((item) {
      classificationDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }


  Future getexpensetype() async {
    expensetypeDropDown([]);
    final List<ExpensetypeDropDownModel> tempList =
        await DropdownService.expensetypeDropDownModel(
          );
    tempList.forEach((item) {
      expensetypeDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }


   Future getPaymentMethodList() async {
    paymentmethodDropDown([]);
    final List<PaymentMethodDropDown> tempList =
        await DropdownService.paymentMethodDropDown();
    tempList.forEach((item) {
      paymentmethodDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getPaymentProviderList({required String method}) async {
    paymentproviderDropDown([]);
    selectedPaymentProvider.value = null;
    final List<PaymentProviderDropDown> tempList =
        await DropdownService.paymentProviderDropDown(paymentMethod: method);
    tempList.forEach((item) {
      paymentproviderDropDown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }



    Future getExpenseDropdown() async {
    expenseDropDown([]);
    final List<ExpenseDropDown> tempList =
        await DropdownService.expenseDropDown();
    tempList.forEach((item) {
      expenseDropDown.add(
          DropdownModel(label: item.expensesName!, value: item.id.toString()));
    });
  }

     Future getSubExpenseDropdown() async {
    subexpenseDropDown([]);
    final List<SubExpenseDropDownModel> tempList =
        await DropdownService.subExpenseDropDown();
    tempList.forEach((item) {
      subexpenseDropDown.add(
          DropdownModel(label: item.subExpensesName!, value: item.id.toString()));
    });
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


  Future CreateCompanyLedger(BuildContext context) async {
    if (companyledgerFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        final CreateCompanyLedgerPayload payload = CreateCompanyLedgerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              classification: selectedClassification.value!.value,
              expensesType: selectedExpensetype.value!.value,
              expenses: selectedExpense.value!.value,
              subExpenses: selectedSubExpense.value!.value,
              paymentMethod: selectedPaymentMethod.value!.value,    
              paymentProvider: selectedPaymentProvider.value?.value != null ? selectedPaymentProvider.value?.value : null, 
              remarks: remarkController.text,   
              amount: amountController.text,
              branch: isBranchuser.value ? selectedBranch.value!.value : null);

          await CompanyLedgerService.createCompanyLedger(
              context: context, payload: payload);
          _companyLedgerListController.getcompanyledgerList(context);
        resetForm();
        Get.back();
      }
    }
  }


  resetForm() {
    isFormSubmit.value = false;
    companyledgerFormKey.currentState!.reset();
    selectedClassification.value = null;
    selectedExpense.value = null;
    selectedExpensetype.value = null;
    selectedPaymentMethod.value = null;
    selectedPaymentProvider.value = null;
    selectedSubExpense.value = null;
    remarkController.clear();
    amountController.clear();
    selectedBranch.value = null;
    fromMode("create");
  }
}
