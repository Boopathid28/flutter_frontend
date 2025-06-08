import 'package:ausales_application/controller/counter/counter_list_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/counter/counter_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterFormController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final CounterListController _counterListController =
      Get.put(CounterListController());

  final counterFormKey = GlobalKey<FormState>();

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController searchFloorController = TextEditingController();

  Rx<CounterDetailsData?> currentConter = Rx<CounterDetailsData?>(null);

  TextEditingController counternameController = TextEditingController();

  TextEditingController searchCounterController = TextEditingController();

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedFloor = Rx<DropdownModel?>(null);

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> floorDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;

  @override
  void onInit() async{
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    } else {
      getFloorList(null);
    }
  }

  Future getFloorList(String? branchId) async {
    floorDropDown([]);
    final List<FloorDropdownModel> tempList =
        await DropdownService.floorDropdown(
           branch: branchId);
    tempList.forEach((item) {
      floorDropDown.add(
          DropdownModel(label: item.floorName!, value: item.id.toString()));
    });
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

  Future submitCounterForm(BuildContext context) async {
    if (counterFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateCounterPayload payload = CreateCounterPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              counterName: counternameController.text,
              floordetails: selectedFloor.value!.value,
              branch: isBranchuser.value ? selectedBranch.value!.value : null);

          await CounterService.createCounter(
              context: context, payload: payload);
          _counterListController.getcounterList(context);
        } else {
          final UpdateCounterPayload payload = UpdateCounterPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            counterName: counternameController.text,
            branch: isBranchuser.value ? selectedBranch.value!.value : null,
            floordetails: selectedFloor.value!.value,
            id: currentConter.value?.id,
          );

          await CounterService.updateCounter(
              context: context, payload: payload);
          _counterListController.getcounterList(context);
        }
        resetForm();
      }
    }
  }

  Future getCounterDetails(BuildContext context, CounterListData item) async {
    final CounterDetailsData? data = await CounterService.retrieveCounter(
        context: context, counterId: item.id.toString());

    if (data != null) {
      currentConter(data);
      getFloorList(data.branch.toString());
      selectedFloor(DropdownModel(
          value: data.floorDetails.toString(),
          label: data.floorDetailsName.toString()));
      selectedBranch(DropdownModel(
          value: data.branch.toString(), label: data.branchName.toString()));

      counternameController.text = data.counterName.toString();
      fromMode("update");
    } else {
      resetForm();
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    counterFormKey.currentState!.reset();
    currentConter.value = null;
    selectedBranch.value = null;
    selectedFloor.value = null;
    fromMode("create");
  }
}
