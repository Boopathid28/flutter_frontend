import 'package:ausales_application/controller/vendor_payment/vendor_payment_form/vendor_payment_form_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentFormPopup extends StatefulWidget {
  const VendorPaymentFormPopup({super.key});

  @override
  State<VendorPaymentFormPopup> createState() => _VendorPaymentFormPopupState();
}

class _VendorPaymentFormPopupState extends State<VendorPaymentFormPopup> {
  final VendorPaymentFormController _vendorPaymentFormController =
      Get.put(VendorPaymentFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Make Payment'),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: double.infinity,
        color: Colors.white,
        child: Form(
          key: _vendorPaymentFormController.vendorPaymentFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                paymentTypes(),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() => _vendorPaymentFormController
                            .selectedPaymentType.value?.value ==
                        "c2c"
                    ? Responsive.isMobile(context)
                        ? Column(
                            children: [
                              paymentMethods(),
                              SizedBox(
                                height: 10.w,
                              ),
                              Obx(
                                () => _vendorPaymentFormController
                                            .selectedPaymentMethod
                                            .value
                                            ?.value !=
                                        'cash'
                                    ? paymentProviders()
                                    : SizedBox(),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              amount(),
                              SizedBox(
                                height: 10.w,
                              ),
                              remarks(),
                              SizedBox(
                                height: 10.w,
                              ),
                              reffered()
                            ],
                          )
                        : Row(
                            children: [
                              paymentMethods(),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(
                                () => _vendorPaymentFormController
                                            .selectedPaymentMethod
                                            .value
                                            ?.value !=
                                        'cash'
                                    ? paymentProviders()
                                    : SizedBox(),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              amount(),
                              SizedBox(
                                width: 10.w,
                              ),
                              remarks(),
                              SizedBox(
                                width: 10.w,
                              ),
                              reffered()
                            ],
                          )
                    : _vendorPaymentFormController
                                .selectedPaymentType.value?.value ==
                            "m2m"
                        ? Responsive.isMobile(context)
                            ? Column(
                                children: [
                                  metalWeight(),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  metal(),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  touchSelect(),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  pureWeight(),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  remarks(),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  reffered()
                                ],
                              )
                            : Row(
                                children: [
                                  metalWeight(),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  metal(),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  touchSelect(),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  pureWeight(),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  remarks(),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  reffered()
                                ],
                              )
                        : _vendorPaymentFormController
                                    .selectedPaymentType.value?.value ==
                                "c2m"
                            ? Responsive.isMobile(context)
                                ? Column(
                                    children: [
                                      amount(),
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      metalRate(),
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      metal(),
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      touchSelect(),
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      pureWeight(),
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      remarks(),
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      reffered()
                                    ],
                                  )
                                : Row(
                                    children: [
                                      amount(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      metalRate(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      metal(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      touchSelect(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      pureWeight(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      remarks(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      reffered()
                                    ],
                                  )
                            : _vendorPaymentFormController
                                        .selectedPaymentType.value?.value ==
                                    "m2c"
                                ? Responsive.isTablet(context)
                                    ? Column(
                                        children: [
                                          pureWeight(),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          pureRate(),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          paymentMethods(),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Obx(
                                            () => _vendorPaymentFormController
                                                        .selectedPaymentMethod
                                                        .value
                                                        ?.value !=
                                                    'cash'
                                                ? paymentProviders()
                                                : SizedBox(),
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          amount(),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          remarks(),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          reffered()
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          pureWeight(),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          pureRate(),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          paymentMethods(),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Obx(
                                            () => _vendorPaymentFormController
                                                        .selectedPaymentMethod
                                                        .value
                                                        ?.value !=
                                                    'cash'
                                                ? paymentProviders()
                                                : SizedBox(),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          amount(),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          remarks(),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          reffered()
                                        ],
                                      )
                                : SizedBox())
              ],
            ),
          ),
        ),
      ),
      actions: [actions(context)],
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
                    _vendorPaymentFormController.resetForm();
                  })),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _vendorPaymentFormController.isFormSubmit.value,
                  text: "Add",
                  onPressed: () {
                    _vendorPaymentFormController.submitPaymentForm(context);
                  }))),
        ],
      ),
    );
  }

  SizedBox pureRate() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pure Rate"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: "double",
            controller: _vendorPaymentFormController.pureRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Pure Rate",
            onChanged: (value) {
              _vendorPaymentFormController.calculatePayment();
            },
          ),
        ],
      ),
    );
  }

  SizedBox metalRate() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Rate"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: "double",
            controller: _vendorPaymentFormController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              _vendorPaymentFormController.calculatePayment();
            },
          ),
        ],
      ),
    );
  }

  SizedBox amount() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _vendorPaymentFormController.amountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Amount",
            readOnly:
                _vendorPaymentFormController.selectedPaymentType.value?.value ==
                        'm2c'
                    ? true
                    : false,
            onChanged: (value) {
              _vendorPaymentFormController.calculatePayment();
            },
          ),
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'text',
            controller: _vendorPaymentFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox reffered() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Reffered"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'text',
            controller: _vendorPaymentFormController.refferedController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Reffered",
          ),
        ],
      ),
    );
  }

  SizedBox paymentProviders() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Provider"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _vendorPaymentFormController.selectedPaymentProvider.value,
                options:
                    _vendorPaymentFormController.paymentProviderDropDown.value,
                onChanged: (value) {
                  _vendorPaymentFormController.selectedPaymentProvider(value);
                },
                hintText: "Provider",
              ))
        ],
      ),
    );
  }

  SizedBox paymentMethods() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Methods"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _vendorPaymentFormController.selectedPaymentMethod.value,
                options:
                    _vendorPaymentFormController.paymentMethodDropDown.value,
                onChanged: (value) {
                  _vendorPaymentFormController.selectedPaymentMethod(value);
                  _vendorPaymentFormController.getPaymentProviderList(
                      method: value!.value);
                },
                hintText: "Payment Methods",
              ))
        ],
      ),
    );
  }

  SizedBox pureWeight() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pure Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: "double",
            controller: _vendorPaymentFormController.pureWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Pure Weight",
            readOnly:
                _vendorPaymentFormController.selectedPaymentType.value?.value ==
                        'm2c'
                    ? false
                    : true,
            onChanged: (value) {
              _vendorPaymentFormController.calculatePayment();
            },
          ),
        ],
      ),
    );
  }

  SizedBox touch() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Touch"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: "double",
            controller: _vendorPaymentFormController.touchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Touch",
            onChanged: (value) {
              _vendorPaymentFormController.calculatePayment();
            },
          ),
        ],
      ),
    );
  }

  SizedBox touchSelect() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Touch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _vendorPaymentFormController.selectedTouch.value,
                options: _vendorPaymentFormController.touchDropDown.value,
                onChanged: (value) {
                  _vendorPaymentFormController.selectedTouch(value);
                  _vendorPaymentFormController.calculatePayment();
                  _vendorPaymentFormController
                      .remaingTouchPureWeight(value?.value);
                },
                hintText: "Touch",
              ))
        ],
      ),
    );
  }

  SizedBox metalWeight() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: "double",
            controller: _vendorPaymentFormController.metalWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Metal Weight",
            onChanged: (value) {
              _vendorPaymentFormController.calculatePayment();
            },
          ),
        ],
      ),
    );
  }

  SizedBox paymentTypes() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payment Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _vendorPaymentFormController.selectedPaymentType.value,
                options: _vendorPaymentFormController.paymentTypeDropDown.value,
                onChanged: (value) {
                  _vendorPaymentFormController.selectedPaymentType(value);
                  _vendorPaymentFormController.resetForm();
                },
                hintText: "Payment Type",
              ))
        ],
      ),
    );
  }

  SizedBox metal() {
    return SizedBox(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _vendorPaymentFormController.selectedMetal.value,
                options: _vendorPaymentFormController.metalDropDown.value,
                onChanged: (value) {
                  _vendorPaymentFormController.selectedMetal(value);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
