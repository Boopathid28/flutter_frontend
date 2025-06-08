import 'package:ausales_application/controller/tag_master/tag_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/tag_master/tag_master_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/tag_master/tag_master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagMasterFormController extends GetxController {
  final TagMasterListController _tagMasterListController = Get.put(TagMasterListController());

  final tagFormKey = GlobalKey<FormState>();

  Rx<TagMasterListData?> currentTag = Rx<TagMasterListData?>(null);

  TextEditingController tagNameController = TextEditingController();
  TextEditingController tagCodeController = TextEditingController();

  TextEditingController searchRoleController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    tempList.forEach((item) {
      metalDropDown
          .add(DropdownModel(label: item.metalName!, value: item.id.toString()));
    });
  }

  Future submitTagForm(BuildContext context) async {
    if (tagFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateTagPayload payload = CreateTagPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              tagName: tagNameController.text,
              tagCode: tagCodeController.text,
              metal: int.parse(selectedMetal.value!.value));

          await TagMasterService.createTagMaster(context: context, payload: payload);
          _tagMasterListController.getTagMasterList(context);
        } else {
          final UpdateTagPayload payload = UpdateTagPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              tagName: tagNameController.text,
              tagCode: tagCodeController.text,
              id: currentTag.value!.id,
              metal: int.parse(selectedMetal.value!.value));

          await TagMasterService.updateTagMaster(context: context, payload: payload);
          _tagMasterListController.getTagMasterList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    tagFormKey.currentState!.reset();
    selectedMetal.value = null;
    currentTag.value = null;
    fromMode("create");
  }
}
