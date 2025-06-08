import 'dart:convert';
import 'dart:developer';
import 'dart:io';
 
import 'package:ausales_application/controller/image_picker/image_picker_controller.dart';
import 'package:ausales_application/controller/image_picker_order/image_picker_order_controller.dart';
import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/core/api_endpoints/order_endpoints.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';
 
class ImageUploadController extends ImagePickerOrderController {
  final ImagePickerOrderController _imagePickerOrderController =
      Get.put(ImagePickerOrderController());
 
     
  RxList<OrderEdiImageUpload> orderUploadImage = <OrderEdiImageUpload>[].obs;
 
  final orderimageFormKey = GlobalKey<FormState>();
 
  Rx<CompanyDetailsData?> currentOrder = Rx<CompanyDetailsData?>(null);
 
  RxString orderImageUrl = "".obs;
 
  ImagePickerController imagePickerController = ImagePickerController();
 
  RxBool isFormSubmit = false.obs;
 
  RxString fromMode = "create".obs;
 
  RxList imageurl = [].obs;
  RxList<int> imageId = <int>[].obs;
 
  Rx<File?> orderImage = Rx<File?>(null);
 
  Future submitorderForm(BuildContext context, Function() imageGetter) async {
    // if (companyFormKey.currentState!.validate()) {
    if (!isFormSubmit.value) {
      isFormSubmit.value = true;
      String token = await AuthSharedPrefs.getToken();
      String sessionKey = await AuthSharedPrefs.getSessionKey();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(orderuploadimageEndPoint),
      );
 
      request.fields['menu_id'] =
          (await HomeSharedPrefs.getCurrentMenu()).toString();
      request.fields['order_item_image'] = orderImageUrl.value;
      log(orderImage.value.toString());
      if (orderImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'order_item_image', orderImage.value!.path));
      }
      request.headers['Content-Type'] = "application/json";
      request.headers['Authorization'] = "Token ${token}";
      request.headers['session-key'] = sessionKey;
 
      print(
          "Responseupdate123 ${(await HomeSharedPrefs.getCurrentMenu()).toString()}");
      var response = await request.send();
      print("Responseupdate ${response}");
      print("response.statusCode  ${response.statusCode}");
 
      // Check the response
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
 
        final body = await jsonDecode(respStr);
        log("body['status']${body['status']}");
        if (body['status'] == 200) {
          imageGetter();
          orderImage.value = null;
          print("Response11 ${body}");
          toastification.show(
              context: context,
              type: ToastificationType.success,
              title: Text(body['message']),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
 
          isFormSubmit.value = false;
          print('Data Update sent successfully! ${body}');
          imageurl.add(body['data']['order_item_image']);
          imageId.add(body['data']['id']);
 
          final OrderEdiImageUpload orderEdiImageUpload = OrderEdiImageUpload(
              id: body['data']['id'],
              orderItemImage: body['data']['order_item_image']);
 
          orderUploadImage.add(orderEdiImageUpload);
          log("imageurl%${imageurl}");
          log("imageId%${imageId}");
          fromMode.value = "create";
        } else if (body['status'] == 204) {
          // body['data'].forEach((final String key, final value) {
          toastification.show(
              context: context,
              type: ToastificationType.error,
              title: Text(body['message']),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
 
          isFormSubmit.value = false;
          // });
          return null;
        }
      }
    }
    // }
  }
 
  resetForm() {
    Get.back();
    isFormSubmit.value = false;
    _imagePickerOrderController.image.value = File('');
    imageId([]);
    imageurl([]);
  }
}