import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/suspense/suspense_models.dart';
import 'package:ausales_application/service/counter/counter_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/suspense/suspense_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class SuspenseFormController extends HeaderController {
  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;
  final SuspenseListController _suspenseListController =
      Get.put(SuspenseListController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final suspenseformkey = GlobalKey<FormState>();

  TextEditingController branchSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();

  Rx<CounterDetailsData?> currentConter = Rx<CounterDetailsData?>(null);

  Rx<DropdownModel?> selectedBranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);
  TextEditingController remarksController = TextEditingController();

  RxList<DropdownModel> branchDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;


  RxBool isFormSubmit = false.obs;
  RxBool add = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;

  RxList<ItemDetails> itemdetailsParticularList = <ItemDetails>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getCustomerList();
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

  Future getCustomerList() async {
    customerDropDown([]);
    final List<CustomerDropDownModel> tempList =
        await DropdownService.customerDropDown();
    tempList.forEach((item) {
      customerDropDown.add(
          DropdownModel(label: item.customerName!, value: item.id.toString()));
    });
  }

  Future CreateSuspense(BuildContext context) async {
    if (suspenseformkey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        if (itemdetailsParticularList.isNotEmpty) {
          CreateSuspensePayload payload = CreateSuspensePayload(
              branch: selectedBranch.value?.value,
              customerDetails: selectedCustomer.value!.value,
              itemDetails: itemdetailsParticularList,
              menuId: await HomeSharedPrefs.getCurrentMenu());

          final CreateSuspenseResponse? data=
              await SuspenseService.createSuspense(
                  payload: payload, context: context);
             if (data != null) {
            _suspenseListController.getsuspenseList(context);
            navSuspenseList();
            resetForm();

          }
        } else {
          toastification.show(
              context: context, // optional if you use ToastificationWrapper
              type: ToastificationType.info,
              title: Text("Add at least one item"),
              autoCloseDuration: notificationDuration,
              showProgressBar: false,
              pauseOnHover: false);
        }
        isFormSubmit(false);
      }
    }
  }

  Future getCounterDetails(BuildContext context, CounterListData item) async {
    final CounterDetailsData? data = await CounterService.retrieveCounter(
        context: context, counterId: item.id.toString());

    if (data != null) {
      currentConter(data);
      selectedBranch(DropdownModel(
          value: data.branch.toString(), label: data.branchName.toString()));
      fromMode("update");
    } else {
      resetForm();
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    suspenseformkey.currentState!.reset();
    currentConter.value = null;
    selectedBranch.value = null;
    selectedCustomer.value = null;
    fromMode("create");
    
  }
}
