import 'package:ausales_application/controller/diamond_master/diamond_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/diamond_master/diamond_master_model.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/diamond_master/diamond_master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiamondMasterFormController extends GetxController {
  final DiamondMasterListController _diamondMasterListController = Get.put(DiamondMasterListController());

  final diamondFormKey = GlobalKey<FormState>();

  Rx<DiamondMasterListData?> currentDiamond = Rx<DiamondMasterListData?>(null);

  TextEditingController diamondNameController = TextEditingController();
  TextEditingController diamondCodeController = TextEditingController();
  TextEditingController diamondRateController = TextEditingController();
  TextEditingController diamondCertificateRateController = TextEditingController();

  TextEditingController reduceWeightSearchController= TextEditingController();

  RxList<DropdownModel> reduceWeightDropDown = [DropdownModel(value: "1", label: "Yes"), DropdownModel(value: "0", label: "No")].obs;

  Rx<DropdownModel> selectedReduceWeight = DropdownModel(value: "1", label: "Yes").obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  Future submitDiamondForm(BuildContext context) async {
    if (diamondFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateDiamondPayload payload = CreateDiamondPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              diamondName: diamondNameController.text,
              diamondCode: diamondCodeController.text,
              rate: double.parse(diamondRateController.text.isEmpty ? "0.0" : diamondRateController.text),
              certificateAmount: double.parse(diamondCertificateRateController.text.isEmpty ? "0.0" : diamondCertificateRateController.text),
              reduceWeight: selectedReduceWeight.value.value == "1" ? true : false
              );

          await DiamondMasterService.createDiamondMaster(context: context, payload: payload);
          _diamondMasterListController.getDiamondMasterList(context);
        } else {
          final UpdateDiamondPayload payload = UpdateDiamondPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              diamondName: diamondNameController.text,
              diamondCode: diamondCodeController.text,
              rate: double.parse(diamondRateController.text.isEmpty ? "0.0" : diamondRateController.text),
              certificateAmount: double.parse(diamondCertificateRateController.text.isEmpty ? "0.0" : diamondCertificateRateController.text),
              reduceWeight: selectedReduceWeight.value.value == "1" ? true : false,
              id: currentDiamond.value!.id,);

          await DiamondMasterService.updateDiamondMaster(context: context, payload: payload);
          _diamondMasterListController.getDiamondMasterList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    diamondFormKey.currentState!.reset();
    selectedReduceWeight(reduceWeightDropDown.value[0]);
    diamondCodeController.clear();
    diamondRateController.clear();
    diamondNameController.clear();
    diamondCertificateRateController.clear();
    currentDiamond.value = null;
    fromMode("create");
  }
}
