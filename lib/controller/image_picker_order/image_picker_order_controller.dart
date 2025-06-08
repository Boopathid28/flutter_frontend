import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerOrderController extends GetxController {
  Rx<File?> image = Rx<File?>(null);

  Future imagePicker () async {
    try {
      final imagepick =  
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagepick == null) {
        return;
      }
      final imageTemp = File(imagepick.path);
      image.value = imageTemp;
    } on PlatformException catch (e) {
      return e;
    }
   }

  void clear() {
    image.value = null;
  }
}