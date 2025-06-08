import 'package:ausales_application/controller/floor/floor_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/floor/floor_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/floor/floor_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloorFormController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final FloorListController _floorListController =
      Get.put(FloorListController());

  final floorFormKey = GlobalKey<FormState>();

  TextEditingController branchSearchController = TextEditingController();

  Rx<FloorListData?> currentFloor = Rx<FloorListData?>(null);

  TextEditingController floornameController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;


  @override
  void onInit() async {
    super.onInit();
    bool value = await getIsBranchUser();
    if (value == true) {
      getBranchList();
    }
  }

  Future getBranchList() async {
    branchDropDown([]);
    final List<BranchDropDownModel> tempList =
        await DropdownService.branchDropDown(isFilter: noFilter.toString());
    tempList.forEach((item) {
      branchDropDown.add(
          DropdownModel(label: item.branchName!, value: item.id.toString()));
    });
  }

  Future submitFloorForm(BuildContext context) async {
    if (floorFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateFloorPayload payload = CreateFloorPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              floorName: floornameController.text,
              branch: isBranchuser.value ? selectedBranch.value?.value : null);

          await FloorService.createFloor(
              context: context, payload: payload);
          _floorListController.getfloorList(context);
        } else {
          final UpdateFloorPayload payload = UpdateFloorPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            floorName: floornameController.text,
            branch: isBranchuser.value ? selectedBranch.value?.value : null,
            id: currentFloor.value?.id,
          );

          await FloorService.updateFloor(
              context: context, payload: payload);
          _floorListController.getfloorList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    floorFormKey.currentState!.reset();
    currentFloor.value = null;
    selectedBranch.value = null;
    fromMode("create");
  }
}
