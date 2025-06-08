import 'package:ausales_application/controller/vendor_payment/vendor_payment_vendor_selection_form_controller.dart';
import 'package:ausales_application/view/screens/vendor_payment/vendor_payment_form/vendor_payment_form_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentVendorSelectionForm extends StatefulWidget {
  const VendorPaymentVendorSelectionForm({super.key});

  @override
  State<VendorPaymentVendorSelectionForm> createState() =>
      _VendorPaymentVendorSelectionFormState();
}

class _VendorPaymentVendorSelectionFormState extends State<VendorPaymentVendorSelectionForm> {

  final VendorPaymentVendorSelectionFormController _vendorPaymentVendorSelectionFormController = Get.put(VendorPaymentVendorSelectionFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Container(
        width: 300.w,
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                vendor(),
              ],
            ),
          ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 125.w,
              child: SecondaryButton(
                isLoading: false, 
                text: "Back", 
                onPressed: () {
                  _vendorPaymentVendorSelectionFormController.selectedVendor(null);
                  Get.back();
                }
              ),
            ),
            SizedBox(width: 15.w,),
            SizedBox(
              width: 125.w,
              child: Obx(() => PrimaryButton(
                isLoading: _vendorPaymentVendorSelectionFormController.isContinueLoading.value, 
                text: "Continue", 
                onPressed: () async {
                  _vendorPaymentVendorSelectionFormController.isContinueLoading(true);
                  Get.back();
                  Get.to(() => VendorPaymentFormScreen(), arguments: _vendorPaymentVendorSelectionFormController.selectedVendor.value?.value);
                  _vendorPaymentVendorSelectionFormController.isContinueLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }

  SizedBox vendor() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(height: 7.h,),
          Obx(() => CustomDropdownSearchField(
            filled: true,
                controller: _vendorPaymentVendorSelectionFormController.vendorSearchController,
                selectedValue: _vendorPaymentVendorSelectionFormController.selectedVendor.value,
                options: _vendorPaymentVendorSelectionFormController.vendorDropDown.value,
                onChanged: (value) {
                  _vendorPaymentVendorSelectionFormController.selectedVendor(value);
                },
                hintText: "Vendor",
              )),
        ],
      ),
    );
  }
  
}
