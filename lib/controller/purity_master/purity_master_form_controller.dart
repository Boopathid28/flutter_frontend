import 'package:ausales_application/controller/purity_master/purity_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/purity_master/purity_master_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/purity_master/purity_master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurityMasterFormController extends GetxController {
  final PurityMasterListController _purityMasterListController = Get.put(PurityMasterListController());

  final purityFormKey = GlobalKey<FormState>();

  Rx<PurityMasterListData?> currentPurity = Rx<PurityMasterListData?>(null);

  TextEditingController purityNameController = TextEditingController();
  TextEditingController purityCodeController = TextEditingController();
  TextEditingController purityPercentController = TextEditingController();

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

  Future submitPurityForm(BuildContext context) async {
    if (purityFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreatePurityPayload payload = CreatePurityPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              purityName: purityNameController.text,
              purityCode: purityCodeController.text,
              purityPercent: purityPercentController.text,
              metal: int.parse(selectedMetal.value!.value));

          await PurityMasterService.createPurityMaster(context: context, payload: payload);
          _purityMasterListController.getPurityMasterList(context);
        } else {
          final UpdatePurityPayload payload = UpdatePurityPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              purityName: purityNameController.text,
              purityCode: purityCodeController.text,
              purityPercent: purityPercentController.text,
              id: currentPurity.value!.id,
              metal: int.parse(selectedMetal.value!.value));

          await PurityMasterService.updatePurityMaster(context: context, payload: payload);
          _purityMasterListController.getPurityMasterList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    purityFormKey.currentState!.reset();
    selectedMetal.value = null;
    currentPurity.value = null;
    fromMode("create");
  }
}
