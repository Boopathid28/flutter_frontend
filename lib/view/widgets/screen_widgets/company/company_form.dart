import 'dart:io';

import 'package:ausales_application/controller/company/company_form_controller.dart';
import 'package:ausales_application/controller/image_picker/image_picker_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyForm extends StatefulWidget {
  const CompanyForm({super.key});

  @override
  State<CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final CompanyFormController _companyFormController =
      Get.put(CompanyFormController());

  final controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Company Profile",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700)),
              SizedBox(
                            height: 20.h,
                          ),
            Responsive.isDesktop(context) ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logo(),
                SingleChildScrollView(child: details(context)),
              ]
            ) : SingleChildScrollView(
              child: Column(
                 children: [
                  logo(),
                  details(context),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding details(BuildContext context) {
    return Padding(
          padding: EdgeInsets.all(8.w),
          child: Form(
            key: _companyFormController.companyFormKey,
            child:
                Responsive.isDesktop(context) || Responsive.isTablet(context)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Text("Company Details",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700)),
                               SizedBox(
                            height: 10.h,
                          ),
                          companyName(),
                             SizedBox(
                            height: 25.h,
                          ),
                          Text("Contact Details",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700)),
                               SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            mobileNumber(),
                            SizedBox(
                              width: 5.h,
                            ),
                            email(),
                            SizedBox(
                              width: 5.h,
                            ),
                            website(),
                          ]),
                             SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              landLine(),
                              SizedBox(
                                width: 5.h,
                              ),
                              address(),
                            ],
                          ),
                          SizedBox(
                           height: 25.h,
                          ),
                          Text("Bank Details",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            gst(),
                            SizedBox(
                              width: 5.h,
                            ),
                            pan(),
                            SizedBox(
                              width: 5.h,
                            ),
                            bankName(),
                          ]),
                             SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              branchName(),
                              SizedBox(
                                width: 5.h,
                              ),
                              accountNumber(),
                              SizedBox(
                                width: 5.h,
                              ),
                              accountName(),
                            ],
                          ),
                            SizedBox(
                            height: 10.h,
                          ),
                          ifsc(),
                          SizedBox(
                            height: 5.h,
                          ),
                          actions(context)
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          companyName(),
                          mobileNumber(),
                          email(),
                          website(),
                          landLine(),
                          address(),
                          gst(),
                          pan(),
                          bankName(),
                          branchName(),
                          accountNumber(),
                          accountName(),
                          ifsc(),
                        ],
                      ),
          ),
        );
  }

  Column logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
          children: [
            circularAvatar()
          ],
        );
  }

  SizedBox circularAvatar() {
    return SizedBox(
      height: 300.h,
      width: 300.w,
      child: GestureDetector(
        onTap: () {
          controller.image(File(''));
          controller.imagePicker();
        },
        
        child: Obx(
          () =>  controller.image.value.path.isEmpty
                  ? _companyFormController.companyImageUrl.value.isNotEmpty
                    ? Image(
                        image: NetworkImage(
                            '$baseMediaUrl/${_companyFormController.companyImageUrl.value}'),
                        width: 25.w,
                      )
                    : DottedBorder(
                      borderType: BorderType.Circle,
                      dashPattern: [5, 5],
                      radius: Radius.circular(12),
                      child: Center(
                        child: Container(
                          height: 40.w,
                          width: 60.w,
                          child: Text("LOGO",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700)),
                        ),
                      ),
                    )
                  : Image.file(
                      controller.image.value,
                      fit: BoxFit.cover,
                    ),
        ),
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
                  isLoading: _companyFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _companyFormController.submitCompanyForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _companyFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _companyFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox branchName() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.branchNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: "no_validation",
            hintText: "Branch Name",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox bankName() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Bank Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.bankNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: "no_validation",
            hintText: "Bank Name",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox ifsc() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "IFSC Code"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.ifscCodeController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "IFSC Code",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox accountName() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Account Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.accountNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: "no_validation",
            hintText: "Account Name",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox accountNumber() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Account Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.accountNoController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "no_validation",
            hintText: "Account Number",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox pan() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "PAN Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            maxLength: 10,
            controller: _companyFormController.panController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "PAN Number",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox gst() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "GST Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.gstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "GST Number",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox address() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Address"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.addressController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Address",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox landLine() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Landline"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.landlineController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Landline",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox website() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Website"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.websiteController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.url,
            validator: "no_validation",
            hintText: "Website",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox email() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Email"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: "email",
            hintText: "Email",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox mobileNumber() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Mobile Number"),
          SizedBox(height: 7.h),
          CustomTextInput(
            maxLength: 10,
            controller: _companyFormController.mobileNumberController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: "no_validation",
            inputFormat: "integer",
            hintText: "Mobile Number",
            filled: true,
          ),
        ],
      ),
    );
  }

  SizedBox companyName() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Company Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _companyFormController.companyNameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Company Name",
            filled: true,
          ),
        ],
      ),
    );
  }
}
