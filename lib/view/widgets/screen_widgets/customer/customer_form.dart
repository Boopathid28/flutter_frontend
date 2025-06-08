import 'package:ausales_application/controller/customer/customer_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerFormPopup extends StatefulWidget {
  const CustomerFormPopup({super.key});

  @override
  State<CustomerFormPopup> createState() => _CustomerFormPopupState();
}

class _CustomerFormPopupState extends State<CustomerFormPopup> {
  final CustomerFormController _customerFormController =
      Get.put(CustomerFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_customerFormController.fromMode.value.capitalize} Customer',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              iconSize: 25.sp,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _customerFormController.customerFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 20.h,
              children: [
                CustomerName(),
                Mobilenumber(),
                customergroup(),
                Email(),
                dob(),
                Marritalstatus(),
                Upiid(),
                Address(),
                Gstnumber(),
                Pannumber(),
                Aadharnumber(),
              ],
            ),
          ),
        ),
      ),
      actions: [actions(context)],
    );
  }

  IconButton closeicon() {
    return IconButton(
        onPressed: () {
          _customerFormController.resetForm();
          Get.back();
        },
        icon: Icon(Icons.close));
  }

  SizedBox customergroup() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer Group"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _customerFormController.searchCustomerController,
                selectedValue:
                    _customerFormController.selectedCustomergroup.value,
                options: _customerFormController.customergroupDropDown.value,
                onChanged: (value) {
                  _customerFormController.selectedCustomergroup(value);
                },
                hintText: "Customergroup name",
              ))
        ],
      ),
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
                  isLoading: _customerFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _customerFormController.submitCustomerForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _customerFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _customerFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox Email() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Email"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.emailcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validate",
            hintText: "Email",
          ),
        ],
      ),
    );
  }

  SizedBox Mobilenumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Mobile Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.mobilenumbercontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "phone",
            hintText: "Mobile Number",
            inputFormat: "integer",
            maxLength: 10,
          ),
        ],
      ),
    );
  }

  SizedBox CustomerName() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.customerNamecontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Customer Name",
          ),
        ],
      ),
    );
  }

  SizedBox Marritalstatus() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Marriage Status"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _customerFormController.selectedMarriageStatus.value,
                options: _customerFormController.marriageStatusDropDown.value,
                onChanged: (value) {
                  _customerFormController.selectedMarriageStatus(value);
                },
                hintText: "Marriage Status",
                isValidate: false,
              ))
        ],
      ),
    );
  }

  SizedBox dob() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "DOB"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.dobcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Dob",
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {

                _customerFormController.dobcontroller.text =DateHelper.convertDateYearMonthDate(pickedDate.toString());
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox Upiid() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Upi ID"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.upiidcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Upi Id",
          ),
        ],
      ),
    );
  }

  SizedBox Address() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Address"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.addresscontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Address",
          ),
        ],
      ),
    );
  }

  SizedBox Gstnumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gst Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.gstnumbercontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Gst Number",
          ),
        ],
      ),
    );
  }

  SizedBox Pannumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pan Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.pannumbercontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Pan Number",
          ),
        ],
      ),
    );
  }

  SizedBox Aadharnumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Aadhar Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _customerFormController.aadharnumbercontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Aadhar Number",
          ),
        ],
      ),
    );
  }
}
