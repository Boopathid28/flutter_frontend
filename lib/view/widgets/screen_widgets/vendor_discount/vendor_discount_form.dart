import 'package:ausales_application/controller/vendor_discount/vendor_discount_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorDiscountForm extends StatefulWidget {
  const VendorDiscountForm({super.key});

  @override
  State<VendorDiscountForm> createState() => _VendorDiscountFormState();
}

class _VendorDiscountFormState extends State<VendorDiscountForm> {
  final VendorDiscountFormController _vendorDiscountFormController = Get.put(VendorDiscountFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Form(
        key: _vendorDiscountFormController.vendorDiscountFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vendor(),
            SizedBox(
              height: 15.h,
            ),
            Obx(() => _vendorDiscountFormController.selectedVendor.value != null ? ledgerDetails(context, size) : SizedBox()),
            SizedBox(
              height: 15.h,
            ),
            Wrap(
              spacing: 20.w,
              runSpacing: 15.h,
              children: [
                Obx(() => _vendorDiscountFormController.isBranchuser.value ? branch() : SizedBox()),
                discountWeight(),
                discountAmount(),
                remarks(),
                actions(context)
              ],
            ),
          ],
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
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _vendorDiscountFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _vendorDiscountFormController.submitVendorDiscountForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _vendorDiscountFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _vendorDiscountFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox vendor() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _vendorDiscountFormController.vendorSearchController,
                selectedValue: _vendorDiscountFormController.selectedVendor.value,
                options: _vendorDiscountFormController.vendorDropDown.value,
                onChanged: (value) {
                  _vendorDiscountFormController.selectedVendor(value);
                  _vendorDiscountFormController.getVendorPaymentDetails(context, value!.value);
                },
                hintText: "Vendor",
              ))
        ],
      ),
    );
  }

  SizedBox remarks() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _vendorDiscountFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox discountAmount() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Discount Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _vendorDiscountFormController.discountAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Discount Amount",
          ),
        ],
      ),
    );
  }

  SizedBox discountWeight() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Discount Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _vendorDiscountFormController.discountWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Discount Weight",
          ),
        ],
      ),
    );
  }

  SizedBox ledgerDetails(BuildContext context, Size size) {
    return SizedBox(
      width:
          Responsive.isDesktop(context) ? size.width : size.width * 0.5,
      child: Obx(() => Wrap(
            runSpacing: 20.h,
            spacing: 20.w,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Overall Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorDiscountFormController.vendorPaymentDetails.value.totalWeight?.toStringAsFixed(3)} g",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Overall Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorDiscountFormController.vendorPaymentDetails.value.totalAmount?.toStringAsFixed(2)}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Discount Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorDiscountFormController.vendorPaymentDetails.value.discWeight?.toStringAsFixed(3)} g",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Discount Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorDiscountFormController.vendorPaymentDetails.value.discAmount?.toStringAsFixed(2)}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Paid Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorDiscountFormController.vendorPaymentDetails.value.paidWeight?.toStringAsFixed(3)} g",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Paid Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorDiscountFormController.vendorPaymentDetails.value.paidAmount?.toStringAsFixed(2)}",
                    style: TextPalette.viewDetailsDataTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Balance Weight: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${_vendorDiscountFormController.vendorPaymentDetails.value.balanceWeight?.toStringAsFixed(3)} g ${_vendorDiscountFormController.vendorPaymentDetails.value.balanceWeight.toString().contains('-') ? "(over payment)" : ""}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: _vendorDiscountFormController
                                .vendorPaymentDetails.value.balanceWeight
                                .toString()
                                .contains('-')
                            ? Colors.red
                            : Colors.blue),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Balance Amount: ",
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "₹ ${_vendorDiscountFormController.vendorPaymentDetails.value.balanceAmount?.toStringAsFixed(2)} ${_vendorDiscountFormController.vendorPaymentDetails.value.balanceAmount.toString().contains('-') ? "(over payment)" : ""}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: _vendorDiscountFormController
                                .vendorPaymentDetails.value.balanceAmount
                                .toString()
                                .contains('-')
                            ? Colors.red
                            : Colors.blue),
                  ),
                ],
              )
            ],
          )),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _vendorDiscountFormController.branchSearchController,
                selectedValue: _vendorDiscountFormController.selectedBranch.value,
                options: _vendorDiscountFormController.branchDropDown.value,
                onChanged: (value) {
                  _vendorDiscountFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
