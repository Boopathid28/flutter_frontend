import 'package:ausales_application/controller/advance/advance_denomiation_form.dart';
import 'package:ausales_application/controller/advance/advance_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AdvanceDenomiation extends StatefulWidget {
  const AdvanceDenomiation({super.key});

  @override
  State<AdvanceDenomiation> createState() => _AdvanceDenomiationState();
}

class _AdvanceDenomiationState extends State<AdvanceDenomiation> {
  final AdvanceDenomiationForm _advanceDenomiationForm =
      Get.put(AdvanceDenomiationForm());

      final AdvanceFormController _advanceFormController =
      Get.put(AdvanceFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Denominations"),
          IconButton(
              onPressed: () {
                _advanceDenomiationForm.resetForm();
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        height: 500,
        color: Colors.white,
        padding: EdgeInsets.all(15.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _advanceDenomiationForm.advancePaymentFormKey,
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: [
                    paymentMethods(),
                    Obx(
                      () => _advanceDenomiationForm
                                  .selectedPaymentMethod.value?.value !=
                              'cash'
                          ? paymentProviders()
                          : SizedBox(),
                    ),
                    amount(),
                    remarks(),
                    actions(context)
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton( btnWidth: 200,isLoading: false, text: "Done",onPressed: () {
                 _advanceDenomiationForm.calculateAdvance();
                  Get.back();
                },)
              ],),
              SizedBox(height: 20,),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                      width: Responsive.isDesktop(context) ? size.width : null,
                    child: Obx(() => DataTable(
                          headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) =>
                                  ColorPalete.tableHeaderBgColor),
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Action',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 125.w,
                                child: Text(
                                  'Payment Method',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 125.w,
                                child: Text(
                                  'Payment Provider',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 125.w,
                                child: Text(
                                  'Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                          ],
                          rows:
                              _advanceFormController.paymentParticulars.value.map((item) {
                            return DataRow(cells: [
                              DataCell(Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _advanceDenomiationForm
                                            .deleteParticulars(item.sNo!);
                                      },
                                      child: Icon(Icons.delete)),
                                ],
                              )),
                              DataCell(SizedBox(
                                  width: 100.w,
                                  child: Text(item.paymentMethodName.toString()))),
                              DataCell(SizedBox(
                                  width: 100.w,
                                  child: Text(item.paymentProviderName.toString()))),
                              DataCell(SizedBox(
                                  width: 100.w,
                                  child: Text(item.paidAmount.toString()))),
                            ]);
                          }).toList(),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              
            ],
          ),
        ),
      ),
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
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _advanceDenomiationForm.resetForm();
                  })),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _advanceDenomiationForm.isFormSubmit.value,
                  text: "Add",
                  onPressed: () {
                    _advanceDenomiationForm.submitPaymentForm(context);
                  }))),
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
            inputFormat: 'double',
            controller: _advanceDenomiationForm.amountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Amount",
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'text',
            controller: _advanceDenomiationForm.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox paymentProviders() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Provider"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _advanceDenomiationForm.selectedPaymentProvider.value,
                options: _advanceDenomiationForm.paymentProviderDropDown.value,
                onChanged: (value) {
                  _advanceDenomiationForm.selectedPaymentProvider(value);
                },
                hintText: "Provider",
              ))
        ],
      ),
    );
  }

  SizedBox paymentMethods() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Methods"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _advanceDenomiationForm.selectedPaymentMethod.value,
                options: _advanceDenomiationForm.paymentMethodDropDown.value,
                onChanged: (value) {
                  _advanceDenomiationForm.selectedPaymentMethod(value);
                  _advanceDenomiationForm.getPaymentProviderList(
                      method: value!.value);
                },
                hintText: "Payment Methods",
              ))
        ],
      ),
    );
  }
}
