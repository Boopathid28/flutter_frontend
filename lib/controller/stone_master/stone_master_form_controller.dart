import 'package:ausales_application/controller/stone_master/stone_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/stone_master/stone_master_model.dart';
import 'package:ausales_application/service/stone_master/stone_master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoneMasterFormController extends GetxController {
  final StoneMasterListController _stoneMasterListController = Get.put(StoneMasterListController());

  final stoneFormKey = GlobalKey<FormState>();

  Rx<StoneMasterListData?> currentStone = Rx<StoneMasterListData?>(null);

  TextEditingController stoneNameController = TextEditingController();
  TextEditingController stoneCodeController = TextEditingController();
  TextEditingController stoneRateController = TextEditingController();
  TextEditingController stoneCertificateRateController = TextEditingController();

  TextEditingController reduceWeightSearchController= TextEditingController();

  RxList<DropdownModel> reduceWeightDropDown = [DropdownModel(value: "1", label: "Yes"), DropdownModel(value: "0", label: "No")].obs;

  Rx<DropdownModel> selectedReduceWeight = DropdownModel(value: "1", label: "Yes").obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  Future submitStoneForm(BuildContext context) async {
    if (stoneFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateStonePayload payload = CreateStonePayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              stoneName: stoneNameController.text,
              stoneCode: stoneCodeController.text,
              rate: double.parse(stoneRateController.text.isEmpty ? "0.0" : stoneRateController.text),
              certificateAmount: double.parse(stoneCertificateRateController.text.isEmpty ? "0.0" : stoneCertificateRateController.text),
              reduceWeight: selectedReduceWeight.value.value == "1" ? true : false
              );

          await StoneMasterService.createStoneMaster(context: context, payload: payload);
          _stoneMasterListController.getStoneMasterList(context);
        } else {
          final UpdateStonePayload payload = UpdateStonePayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              stoneName: stoneNameController.text,
              stoneCode: stoneCodeController.text,
              rate: double.parse(stoneRateController.text.isEmpty ? "0.0" : stoneRateController.text),
              reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
              certificateAmount: double.parse(stoneCertificateRateController.text.isEmpty ? "0.0" : stoneCertificateRateController.text),
              id: currentStone.value!.id,);

          await StoneMasterService.updateStoneMaster(context: context, payload: payload);
          _stoneMasterListController.getStoneMasterList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    stoneFormKey.currentState!.reset();
    selectedReduceWeight(reduceWeightDropDown.value[0]);
    stoneRateController.clear();
    stoneCodeController.clear();
    stoneNameController.clear();
    stoneCertificateRateController.clear();
    currentStone.value = null;
    fromMode("create");
  }
}
