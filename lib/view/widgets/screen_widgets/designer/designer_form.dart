import 'package:ausales_application/controller/designer/designer_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DesignerForm extends StatefulWidget {
  const DesignerForm({super.key});

  @override
  State<DesignerForm> createState() => _DesignerFormState();
}

class _DesignerFormState extends State<DesignerForm> {
  final DesignerFormController _designerFormController =
      Get.put(DesignerFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_designerFormController.fromMode.value.capitalize} Vendor',
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
            key: _designerFormController.designerFormKey,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 20.h,
              children: [
                designerName(),
                designerCode(),
                mobileNumber(),
                email(),
                website(),
                landLine(),
                address(),
                gst(),
                pan(),
                accountNumber(),
                accountName(),
                ifsc(),
                remarks()
              ],
            ),
          ),
        ),
      ),
      actions: [
        actions(context)
      ],
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
                  isLoading: _designerFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _designerFormController.submitDesignerForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _designerFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _designerFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox upiId() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "UPI Id"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.upiIdController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "UPI Id",
          ),
        ],
      ),
    );
  }

  SizedBox branchName() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.branchNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: "no_validation",
            hintText: "Branch Name",
          ),
        ],
      ),
    );
  }

  SizedBox bankName() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Bank Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.bankNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: "no_validation",
            hintText: "Bank Name",
          ),
        ],
      ),
    );
  }

  SizedBox ifsc() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "IFSC Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.ifscCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "IFSC Code",
          ),
        ],
      ),
    );
  }

  SizedBox accountName() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Account Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.accountNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: "no_validation",
            hintText: "Account Name",
          ),
        ],
      ),
    );
  }

  SizedBox accountNumber() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Account Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.accountNoController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "no_validation",
            hintText: "Account Number",
          ),
        ],
      ),
    );
  }

  SizedBox pan() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "PAN Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            maxLength: 10,
            controller: _designerFormController.panController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "PAN Number",
          ),
        ],
      ),
    );
  }

  SizedBox gst() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "GST Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.gstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "GST Number",
          ),
        ],
      ),
    );
  }

  SizedBox address() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Address"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.addressController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Address",
          ),
        ],
      ),
    );
  }
  
  SizedBox landLine() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Landline"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.landlineController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Landline",
          ),
        ],
      ),
    );
  }

  SizedBox website() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Website"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.websiteController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.url,
            validator: "no_validation",
            hintText: "Website",
          ),
        ],
      ),
    );
  }

  SizedBox email() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Email"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: "no_validation",
            hintText: "Email",
          ),
        ],
      ),
    );
  }

  SizedBox mobileNumber() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Mobile Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            maxLength: 10,
            controller: _designerFormController.mobileNumberController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: "no_validation",
               inputFormat: "integer",
            hintText: "Mobile Number",
          ),
        ],
      ),
    );
  }

  SizedBox designerCode() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.designerCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Vendor Code",
          ),
        ],
      ),
    );
  }

  SizedBox designerName() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.designerNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Vendor Name",
          ),
        ],
      ),
    );
  }

   SizedBox remarks() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _designerFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }
}
