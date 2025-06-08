import 'package:ausales_application/controller/company_ledger/company_ledger_form_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyLedgerForm extends StatefulWidget {
  const CompanyLedgerForm({super.key});

  @override
  State<CompanyLedgerForm> createState() => _CompanyLedgerFormState();
}

class _CompanyLedgerFormState extends State<CompanyLedgerForm> {
  final CompanyLedgerFormController _companyLedgerFormController =
      Get.put(CompanyLedgerFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Company Ledger"
          ),
          IconButton(onPressed: () {
            Get.back();
            _companyLedgerFormController.resetForm();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Form(
        key: _companyLedgerFormController.companyledgerFormKey,
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _companyLedgerFormController.isBranchuser.value ? branch() : SizedBox()),
            expenseclassification(),
            expensetype(),
            expense(),
            subexpense(),
            paymentMethods(),
            Obx(() => _companyLedgerFormController.selectedPaymentMethod.value?.value != 'cash' ? paymentProviders() : SizedBox(),),
            amount(),
            remark()
          ],
        )
      ),
      actions: [
        actions(context)
      ],
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _companyLedgerFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _companyLedgerFormController.CreateCompanyLedger(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _companyLedgerFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _companyLedgerFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _companyLedgerFormController.branchSearchController,
                selectedValue: _companyLedgerFormController.selectedBranch.value,
                options: _companyLedgerFormController.branchDropDown.value,
                onChanged: (value) {
                  _companyLedgerFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox remark() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remark"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyLedgerFormController.remarkController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remark",
          ),
        ],
      ),
    );
  }


SizedBox amount() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyLedgerFormController.amountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Amount",
          ),
        ],
      ),
    );
  }

   SizedBox expenseclassification() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Expense Classification"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _companyLedgerFormController.selectedClassification.value,
                options: _companyLedgerFormController.classificationDropDown.value,
                onChanged: (value) {
                  _companyLedgerFormController.selectedClassification(value);
                },
                hintText: "Expense Classification",
              ))
        ],
      ),
    );
  }

  SizedBox expensetype() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Expense Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _companyLedgerFormController.searchExpensetypeController,
                selectedValue: _companyLedgerFormController.selectedExpensetype.value,
                options: _companyLedgerFormController.expensetypeDropDown.value,
                onChanged: (value) {
                  _companyLedgerFormController.selectedExpensetype(value);
                },
                hintText: "Expense Type",
              ))
        ],
      ),
    );
  }

  SizedBox expense() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Expense"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _companyLedgerFormController.searchExpenseController,
                selectedValue: _companyLedgerFormController.selectedExpense.value,
                options: _companyLedgerFormController.expenseDropDown.value,
                onChanged: (value) {
                  _companyLedgerFormController.selectedExpense(value);
                },
                hintText: "Expense",
              ))
        ],
      ),
    );
  }

   SizedBox subexpense() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Expense"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _companyLedgerFormController.searchSubExpenseController,
                selectedValue: _companyLedgerFormController.selectedSubExpense.value,
                options: _companyLedgerFormController.subexpenseDropDown.value,
                onChanged: (value) {
                  _companyLedgerFormController.selectedSubExpense(value);
                },
                hintText: "Sub Expense",
              ))
        ],
      ),
    );
  }


   SizedBox paymentProviders() {
    return SizedBox(
      width: 145.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Provider"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _companyLedgerFormController.selectedPaymentProvider.value,
                options:
                    _companyLedgerFormController.paymentproviderDropDown.value,
                onChanged: (value) {
                  _companyLedgerFormController.selectedPaymentProvider(value);
                },
                hintText: "Payment Provider",
              ))
        ],
      ),
    );
  }

  SizedBox paymentMethods() {
    return SizedBox(
      width: 145.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Methods"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _companyLedgerFormController.selectedPaymentMethod.value,
                options:
                    _companyLedgerFormController.paymentmethodDropDown.value,
                onChanged: (value) {
                  _companyLedgerFormController.selectedPaymentMethod(value);
                  _companyLedgerFormController.getPaymentProviderList(
                      method: value!.value);
                },
                hintText: "Payment Methods",
              ))
        ],
      ),
    );
  }
}
