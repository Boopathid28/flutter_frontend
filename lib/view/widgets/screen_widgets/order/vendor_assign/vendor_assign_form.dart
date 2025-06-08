import 'dart:developer';

import 'package:ausales_application/controller/order/order_vendor_assign_controller/order_vendor_form_controller.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorAssignPopup extends StatefulWidget {
  const VendorAssignPopup({super.key});

  @override
  State<VendorAssignPopup> createState() => _VendorAssignPopupState();
}

class _VendorAssignPopupState extends State<VendorAssignPopup> {
  final OrderVendorFormController _orderVendorFormController = Get.put(OrderVendorFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Vendor Assign",
            style: TextStyle(fontSize: 16.sp),
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width:300.w ,
        child: SingleChildScrollView(
          child: Form(
            key: _orderVendorFormController.ordervendorDetailsFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 20.h,
              children: [
               vendor(),
               duedate()
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
      width: 250.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 115.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _orderVendorFormController.isFormSubmit.value,
                  text: "Assign",
                  onPressed: () {
                    _orderVendorFormController.submitOrderVendorForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _orderVendorFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _orderVendorFormController.resetvendor(context);
                  }))
        ],
      ),
    );
  }

    SizedBox vendor() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _orderVendorFormController.vendorSearchController,
                selectedValue: _orderVendorFormController.selectedVendor.value,
                options: _orderVendorFormController.vendorDropDown.value,
                onChanged: (value) {
                  _orderVendorFormController.selectedVendor(value);
                },
                hintText: "Vendor",
                isValidate: true,
              ))
        ],
      ),
    );
  }



  SizedBox duedate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Due Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _orderVendorFormController.duedateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _orderVendorFormController.duedateController.clear();
              }
            },
            controller: _orderVendorFormController.duedateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Due Date",
          ),
        ],
      ),
    );
  }

 
// SizedBox duedate() {
//     return SizedBox(
//        width: 300.w,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomLabel(label: "Due Date"),
//           SizedBox(height: 7.h),
//           CustomTextInput(
//             controller: _orderVendorFormController.duedateController,
//             textInputAction: TextInputAction.next,
//             keyboardType: TextInputType.text,
//             validator: "no_validation",
//             hintText: "Due Date",
//             readOnly: true,
//             onTap: () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(1900),
//                 lastDate: DateTime.now(),
//               );
 
//               if (pickedDate != null) {
//                 _orderVendorFormController.duedateController.text =DateHelper.convertDateYearMonthDate(pickedDate.toString());
//                 log("date${DateHelper.convertDateYearMonthDate(pickedDate.toString())}");
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
}
