import 'package:ausales_application/controller/expense_account/expense_account_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseAccountForm extends StatefulWidget {
  const ExpenseAccountForm({super.key});

  @override
  State<ExpenseAccountForm> createState() => _ExpenseAccountFormState();
}

class _ExpenseAccountFormState extends State<ExpenseAccountForm> {
  final ExpenseAccountFormController _expenseAccountFormController = Get.put(ExpenseAccountFormController());

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
        key: _expenseAccountFormController.expenseFormKey,
        child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            expensename(),
            SizedBox(
              width: 10.w,
            ),
            actions(context)
          ],
        ): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            expensename(),
            SizedBox(
              height: 10.w,
            ),
            actions(context)
          ],
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 73.h ,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _expenseAccountFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _expenseAccountFormController.submitExpenseForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _expenseAccountFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _expenseAccountFormController.resetForm();
                  }))
        ],
      ),
    );
  }


  SizedBox expensename() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Expense Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
             controller: _expenseAccountFormController.expenseNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Expense Name",
          ),
        ],
      ),
    );
  }
}