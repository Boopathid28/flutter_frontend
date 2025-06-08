import 'dart:developer';
import 'dart:io';

import 'package:ausales_application/controller/image_picker/image_picker_controller.dart';
import 'package:ausales_application/controller/image_picker_order/image_picker_order_controller.dart';
import 'package:ausales_application/controller/order/image_upload_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePopupForm extends StatefulWidget {
  const ImagePopupForm({super.key});

  @override
  State<ImagePopupForm> createState() => _ImagePopupFormState();
}

class _ImagePopupFormState extends State<ImagePopupForm> {
  final ImageUploadController _imageUploadController =
      Get.put(ImageUploadController());
  final controller = Get.put(ImagePickerOrderController());

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile1;

  void clearImage() {
    setState(() {
      _imageFile1 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Upload Image",
            style: TextStyle(fontSize: 16.sp),
          ),
          IconButton(
              onPressed: () {
                // _imageUploadController.resetForm();
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 300.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _imageUploadController.orderimageFormKey,
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 20.h,
                  children: [
                    // _imageFile1 == null
                    //     ? GestureDetector(
                    //         onTap: () {
                    //           takePhoto(ImageSource.gallery, context);
                    //         },
                    //         child: DottedBorder(
                    //           borderType: BorderType.RRect,
                    //           dashPattern: [5, 5],
                    //           radius: Radius.circular(12),
                    //           child: Container(
                    //             height: 120.w,
                    //             width: 120.w,
                    //             child: Icon(
                    //               Icons.image,
                    //               size: 30.sp,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : GestureDetector(
                    //         onTap: () {
                    //           takePhoto(ImageSource.gallery, context);
                    //         },
                    //         child: Image(
                    //             height: 120.w,
                    //             width: 120.w,
                    //             image: FileImage(File(_imageFile1!.path))),
                    //       ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              Obx(() => GridView.count(
                mainAxisSpacing: 10.w,
                crossAxisSpacing: 10.w,
                
                shrinkWrap: true,
                crossAxisCount: 2, children: List.generate(_imageUploadController.imageurl.length + 1, (index) {

                  if (index == 0) {
                    return _imageFile1 == null
                        ? GestureDetector(
                            onTap: () {
                              takePhoto(ImageSource.gallery, context);
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: [5, 5],
                              radius: Radius.circular(12),
                              child: Center(
                                child: Container(
                                  height: 60.w,
                                  width: 60.w,
                                  child: Icon(
                                    Icons.add,
                                    size: 50.sp,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              takePhoto(ImageSource.gallery, context);
                            },
                            child: Image(
                                height: 60.w,
                                width: 60.w,
                                image: FileImage(File(_imageFile1!.path))),
                          );
                  } else {

                  return Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5.r)
                          ),
                              width: 100.w,
                              height: 100.w,
                              child: Image(
                                image: NetworkImage(
                                    '$baseUrl/${_imageUploadController.imageurl[index - 1]}'),
                                width: 250.w,
                              ),
                            );
                  }
              }),))
              // SingleChildScrollView(
              //   child: Container(
              //     width: 100.w,
              //     height: 200.w,
              //     child: Obx(() => ListView.separated(
              //         shrinkWrap: true,
              //         itemCount: _imageUploadController.imageurl.length,
              //         separatorBuilder: (context, index) => SizedBox(
              //               height: 10.h,
              //             ),
              //         itemBuilder: (context, index) => Container(
              //           decoration: BoxDecoration(
              //             border: Border.all(),
              //             borderRadius: BorderRadius.circular(5.r)
              //           ),
              //               width: 100.w,
              //               height: 100.w,
              //               child: Image(
              //                 image: NetworkImage(
              //                     '$baseUrl/${_imageUploadController.imageurl[index]}'),
              //                 width: 25.w,
              //               ),
              //             ))),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      actions: [actions(context)],
    );
  }

  void takePhoto(ImageSource source, BuildContext context) async {
    final pickerFile = await _picker.pickImage(source: source);

    if (pickerFile != null) {
      setState(() {
        _imageFile1 = pickerFile;
        _imageUploadController.orderImage.value = File(pickerFile.path);
      });
    } else {
      setState(() {
        _imageFile1 = null;
        _imageUploadController.orderImage.value = null;
      });
    }
  }

  SizedBox circularAvatar() {
    return SizedBox(
      height: 150.h,
      width: 150.w,
      child: GestureDetector(
        onTap: () {
          controller.image(File(''));
          controller.imagePicker();
        },
        child: Obx(
          () => controller.image.value!.path.isEmpty
              ? _imageUploadController.orderImageUrl.value.isNotEmpty
                  ? Image(
                      image: NetworkImage(
                          '$baseMediaUrl/${_imageUploadController.orderImageUrl}'),
                      width: 25.w,
                    )
                  : DottedBorder(
                      borderType: BorderType.Circle,
                      dashPattern: [5, 5],
                      radius: Radius.circular(1),
                      child: Center(
                        child: Container(
                          height: 30.w,
                          width: 80.w,
                          child: Text("LOGO",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    )
              : Image.file(
                  controller.image.value!,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _imageUploadController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    setState(() {
                      _imageFile1 = null;
                    });
                    _imageUploadController.imageurl([]);
                  })),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _imageUploadController.isFormSubmit.value,
                  text: "Add",
                  onPressed: () {
                    _imageUploadController.submitorderForm(context, clearImage);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Done",
                  onPressed: () {
                    Get.back();
                    _imageUploadController.imageurl([]);
                  })),
        ],
      ),
    );
  }
}
