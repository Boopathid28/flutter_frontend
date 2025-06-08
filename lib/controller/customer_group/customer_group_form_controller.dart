import 'package:ausales_application/controller/customer_group/customer_group_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/customer_group/customer_group_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/customer_group/customer_group_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerGroupFormController extends GetxController {
  final CustomerGroupListController _customerGroupListController = Get.put(CustomerGroupListController());

  final customergroupFormKey = GlobalKey<FormState>();

  Rx<CustomergroupListData?> currentCustomergroup = Rx<CustomergroupListData?>(null);

  TextEditingController customergroupcontroller = TextEditingController();

  TextEditingController searchCustomergroupController = TextEditingController();


  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> userRoleDropDown = <DropdownModel>[].obs;

  @override

  Future submitCustomergroupForm(BuildContext context) async {
    if (customergroupFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateCustomerGroupPayload payload = CreateCustomerGroupPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              customerGroupName: customergroupcontroller.text
              );

          await CustomerGroupService.createCustomerGroup(context: context, payload: payload);
          _customerGroupListController.getcustomergrouplist(context);
        } else {
          final UpdateCustomerGroupPayload payload = UpdateCustomerGroupPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              customerGroupName: customergroupcontroller.text.trim(),
              id: currentCustomergroup.value?.id,
              );

          await CustomerGroupService.updateCustomerGroup(context: context, payload: payload);
          _customerGroupListController.getcustomergrouplist(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    customergroupFormKey.currentState!.reset();
    currentCustomergroup.value = null;
    fromMode("create");
  }
}
