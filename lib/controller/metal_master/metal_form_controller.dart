import 'package:ausales_application/controller/metal_master/metal_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/metal_master/metal_models.dart';
import 'package:ausales_application/service/metal_master/metal_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MetalFormController extends GetxController {
  final MetalListController _metalListController = Get.put(MetalListController());

  final metalFormKey = GlobalKey<FormState>();

  Rx<MetalListData?> currentMetal = Rx<MetalListData?>(null);

  TextEditingController metalNameController = TextEditingController();
  TextEditingController metalCodeController = TextEditingController();
  
  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  Future submitMetalForm(BuildContext context) async {
    if (metalFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        if (fromMode.value == "create") {
          final CreateMetalPayload payload = CreateMetalPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              metalName: metalNameController.text,
              metalCode: metalCodeController.text
          );

          await MetalService.createMetal(context: context, payload: payload);
          _metalListController.getMetalList(context);
        } else {
          final UpdateMetalPayload payload = UpdateMetalPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              metalName:metalNameController.text,
              metalCode:metalCodeController.text,
              id: currentMetal.value?.id,
              );

          await MetalService.updateMetal(context: context, payload: payload);
          _metalListController.getMetalList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    metalFormKey.currentState!.reset();
    currentMetal.value = null;
    fromMode("create");
  }
}
