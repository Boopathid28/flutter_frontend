import 'dart:convert';
import 'dart:io';

import 'package:ausales_application/controller/image_picker/image_picker_controller.dart';
import 'package:ausales_application/core/api_endpoints/company_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class CompanyFormController extends ImagePickerController {
  final ImagePickerController _imagePickerController =
      Get.put(ImagePickerController());

  final companyFormKey = GlobalKey<FormState>();

  Rx<CompanyDetailsData?> currentCompany = Rx<CompanyDetailsData?>(null);

  RxString companyImageUrl = "".obs;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController landlineController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  ImagePickerController imagePickerController = ImagePickerController();

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  Future submitCompanyForm(BuildContext context) async {
    if (companyFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        String token = await AuthSharedPrefs.getToken();
        String sessionKey = await AuthSharedPrefs.getSessionKey();
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(companyEndPoint),
        );

        request.fields['menuId'] =
            (await HomeSharedPrefs.getCurrentMenu()).toString();
        request.fields['company_name'] = companyNameController.text;
        request.fields['mobile_number'] = mobileNumberController.text;
        request.fields['email'] = emailController.text;
        request.fields['website'] = websiteController.text;
        request.fields['landline_number'] = landlineController.text;
        request.fields['address'] = addressController.text;
        request.fields['gst_number'] = gstController.text;
        request.fields['pan_number'] = panController.text;
        request.fields['account_number'] = accountNoController.text;
        request.fields['account_name'] = accountNameController.text;
        request.fields['ifsc_code'] = ifscCodeController.text;
        request.fields['bank_name'] = bankNameController.text;
        request.fields['branch_name'] = branchNameController.text;
        if (currentCompany.value!.id != null) {
          request.fields['id'] = currentCompany.value!.id.toString();
        }
        request.fields['company_logo'] = companyImageUrl.value;
        if (_imagePickerController.image.value.path.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath(
              'company_logo', _imagePickerController.image.value!.path));
        }

        request.headers['Content-Type'] = "application/json";
        request.headers['Authorization'] = "Token ${token}";
        request.headers['session-key'] = sessionKey;

        var response = await request.send();

        // Check the response
        if (response.statusCode == 200) {
          final respStr = await response.stream.bytesToString();

          final body = await jsonDecode(respStr);

          toastification.show(
              context: context,
              type: ToastificationType.success,
              title: Text(body['message']),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);

          isFormSubmit.value = false;
          fromMode.value = "create";
        } else if (response.statusCode == 400) {
          final respStr = await response.stream.bytesToString();
          final body = await jsonDecode(respStr);

          body['data'].forEach((final String key, final value) {
            toastification.show(
                context: context,
                type: ToastificationType.error,
                title: Text(value[0].toString()),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);

            isFormSubmit.value = false;
          });
          return null;
        } else if (response.statusCode == 401) {
          navLogin();
        } else {
          final respStr = await response.stream.bytesToString();
          final body = await jsonDecode(respStr);
          toastification.show(
              context: context,
              type: ToastificationType.success,
              title: Text(body['message']),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);

          isFormSubmit.value = false;
        }
      }
    }
  }

  resetForm() {
    Get.back();
    isFormSubmit.value = false;
    companyFormKey.currentState!.reset();
    currentCompany(null);
    companyNameController.clear();
    emailController.clear();
    mobileNumberController.clear();
    websiteController.clear();
    landlineController.clear();
    addressController.clear();
    gstController.clear();
    panController.clear();
    accountNoController.clear();
    accountNameController.clear();
    ifscCodeController.clear();
    bankNameController.clear();
    branchNameController.clear();
    _imagePickerController.image.value = File('');
    fromMode("create");
  }

  Future getCompanyDetails(BuildContext context) async {
    CompanyDetailsData? data =
        await CompanyService.retrieveCompany(context: context);

    if (data != null) {
      currentCompany(data);
      companyNameController.text = data.companyName ?? "";
      emailController.text = data.email ?? "";
      mobileNumberController.text = data.mobileNumber ?? "";
      websiteController.text = data.website ?? "";
      landlineController.text = data.landlineNumber ?? "";
      addressController.text = data.address ?? "";
      gstController.text = data.gstNumber ?? "";
      panController.text = data.panNumber ?? "";
      accountNoController.text = data.accountNumber ?? "";
      accountNameController.text = data.accountName ?? "";
      ifscCodeController.text = data.ifscCode ?? "";
      bankNameController.text = data.bankName ?? "";
      branchNameController.text = data.branchName ?? "";
      companyImageUrl.value = data.companyLogo ?? "";

      fromMode("update");
    } else {
      resetForm();
    }
  }
}
