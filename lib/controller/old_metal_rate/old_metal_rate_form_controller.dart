import 'package:ausales_application/controller/old_metal_rate/old_metal_rate_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/old_metal_rate/old_metal_rate_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/old_metal_rate/old_metal_rate_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OldMetalRateFormController extends GetxController {
  final OldMetalRateListController _oldMetalrateListController =
      Get.put(OldMetalRateListController());

  final oldMetalRateFormKey = GlobalKey<FormState>();


  Rx<OldMetalRateListData?> currentMetal = Rx<OldMetalRateListData?>(null);

  TextEditingController oldMetalRateController = TextEditingController();

  TextEditingController searchMetalController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);

  RxList<DropdownModel> oldMetalDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  
  Future getMetalList() async {
    oldMetalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    for (var item in tempList) {
      oldMetalDropDown
          .add(DropdownModel(label: item.metalName!, value: item.id.toString()));
    }
  }

  Future submitOldMetalrateForm(BuildContext context) async {
    if (oldMetalRateFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateOldMetalRatePayload payload = CreateOldMetalRatePayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              metalDetails:int.parse(selectedMetal.value!.value),
              oldRate:int.parse(oldMetalRateController.text),
             );

          await OldMetalRateService.createOldMetalRate(
              context: context, payload: payload);
          _oldMetalrateListController.getOldMetalRateList(context);
        } else {
          final UpdateOldMetalRatePayload payload = UpdateOldMetalRatePayload(
            id:currentMetal.value!.id,
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            metalDetails: int.parse(selectedMetal.value!.value),
            oldRate:int.parse(oldMetalRateController.text) ,
          );

          await OldMetalRateService.updateOldMetalRate(
              context: context, payload: payload);
          _oldMetalrateListController.getOldMetalRateList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    oldMetalRateFormKey.currentState!.reset();
    selectedMetal.value=null;
    oldMetalRateController.clear();
    fromMode("create");
  }
}
