import 'package:ausales_application/controller/sub_expense_account/sub_expense_account_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubExpenseAccountForm extends StatefulWidget {
  const SubExpenseAccountForm({super.key});

  @override
  State<SubExpenseAccountForm> createState() => _SubExpenseAccountFormState();
}

class _SubExpenseAccountFormState extends State<SubExpenseAccountForm> {
  final SubExpenseAccountFormController _subExpenseAccountFormController =
      Get.put(SubExpenseAccountFormController());

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Form(
          key: _subExpenseAccountFormController.subexpenseFormKey,
          child: SizedBox(
             width: double.infinity,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [expense(context), subexpensename(), actions(context)],
            ),
          )),
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
                  isLoading:
                      _subExpenseAccountFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _subExpenseAccountFormController
                        .submitSubExpenseForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading:
                      _subExpenseAccountFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _subExpenseAccountFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox expense(BuildContext context) {
    return SizedBox(
       width: 300.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabel(label: "Expense Name"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _subExpenseAccountFormController
                      .searchsubexpenseController,
                  filled: true,
                  selectedValue:
                      _subExpenseAccountFormController.selectedExpense.value,
                  options:
                      _subExpenseAccountFormController.expensedropdown.value,
                  onChanged: (value) {
                    _subExpenseAccountFormController.selectedExpense(value);
                  },
                  hintText: "Expense Name",
                ),
              ],
            )));
  }

  SizedBox subexpensename() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Expense Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller:
                _subExpenseAccountFormController.subexpenseNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Sub Expense Name",
          ),
        ],
      ),
    );
  }
}
